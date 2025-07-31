Return-Path: <linux-kernel+bounces-751923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B6DB16F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AAD47B032B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9DD2BDC2E;
	Thu, 31 Jul 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SB4y3OBZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6ZRRl0u"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70838C13D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957297; cv=fail; b=JrMwnmC/6M1mwR0PlFmaEcsYVbc1t8hj0URuHNvcX6p5PEoOL0TJyLmXYSmU9sL5D3QfUZ6cHX0dK4534jp6C+WszdRoLdHnfSMhu+DzTc/K0+s0lT5uM2+kZOTyIIfNxXSQroAe8gAz1ydL3MYKHSFJaK84YiCgMLaw8q9crYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957297; c=relaxed/simple;
	bh=xJXfoyNn38jKy55LtISHboFGSc0HXYTLl2llrgeH8Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B8uD81V0LCP1YXS24xWELc+3pDu70fOqBX21tEJKAK+xw5E/c1LY3ImXIYFpkOCyNLnEMqadJYds1k1+Y13+G0/Bfdv+Va35lCCWRpnuHSHs66AAvpCl0IXGa6VqaG2wZKygPQ7lrEM6VbZJw0SB1kNN3Gm1SmpaPZRsR42TD8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SB4y3OBZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6ZRRl0u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C4eC008507;
	Thu, 31 Jul 2025 10:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=DnMCMwvYdmuvkHKTYW
	eZsgtBZoZRZM0qwVtQ56ww+8g=; b=SB4y3OBZpCMeeI1Edc3DM84e53q1kfD1mD
	ZRPTKsjEHMLNv+VjURaAUSVLEBxYL/J/yTXnwbrUMTKClkZNrqhBXDqTUxoa2doR
	D2S9/rbjjb40y6sfq4sJQQL7YelhHknNxA+bnLN6PeHJIRRifM/86rzhtR0mC9Po
	UNy1PzQ4UuvjZTuhFD39bv3gRaitoJPc42RMtEgzCbevOdEW2WhM4mqJQsdVF9s1
	48nVMfccZ9U/30RZBgXybksaVtUQikxaKEMUU6Bs5aUhx6ydTtsvMzhmk1U6T2qb
	31wPTj6WqSZLdyHH2U8JZBZO12+kr3o8IEvpUZqw1Kl6I437OH3A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x3n92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 10:21:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V8hVbp038709;
	Thu, 31 Jul 2025 10:20:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfc250d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 10:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN3kd0fEfKPNOUU2YyINC1akiu3ccCvNKn//vfUZAQ0yoVTGd4T/PiNosCvdrearr34pCESYbtNVyYsxjRCjvflCOh+BvRqfBjBEddotXgx4UBB6frYoU6JFSBr0APX0c74SUA/bg1Nth3gR2hwAmtyhZvvTuOi3wtarBZqKNX1RuW1UlODKZJVwEwlMUsFFpNFV7r4DyZvXo5dmQTgwytLPiM6VwX7Wvs/HlAjIG0OoSClcSjkvJ5OTXC8MGjnh0ikHaXcSDgZ87KPVxHPpfTVk4xPENkh/FxmzdvXOidkNtTXBGNZQzp7oY8+x+cmTatyuEHkuFV63ypQpBR+X2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnMCMwvYdmuvkHKTYWeZsgtBZoZRZM0qwVtQ56ww+8g=;
 b=b2W0ZboZlPKioaUQz3byxAB9Ac3lY33CPjux4vTREAKWAfWgWdTqpIcNXuTfZgwmITeEDM9p4eg74oMyyZ4e7gdSkRji+ljqEMSTeFqipDLmltpvDp+GJpxDzML6+VR+cZPFhCN59LvUlLrWTtpX61jrN+UwHruxQEtPCHCIHk8ui8zVjFCNdiI9j9uFZtq/u+zDiIjUdXgf1OcZK9v9dNceFCkcu0J6wHFmSsRxMOw8wWSb28AlymJsIjK6ZAmNShV4tu/K8spotSY8tO8iA8VTDzsnaEaxoztrr1Wnw4Ggm00X/neTTQ9u0vn7RGDEb7g3DUukbmtBreUG9OiJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnMCMwvYdmuvkHKTYWeZsgtBZoZRZM0qwVtQ56ww+8g=;
 b=w6ZRRl0u6+ZYQnS4BIV+GpLwUdLg9tDWDOfb5J4u8fXxm4fCIdJHD+7FMQ0W7uR0X0aPRq5qF/MspTPn56PJet/c2Oi5kGyiEZQRJxoFYsfQrtnmqwmG3D526glAEemqzQqLAYbNdR0MEgI3I2iRZaDC9ublIgr/1HT6ZpCbMDY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4793.namprd10.prod.outlook.com (2603:10b6:806:110::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 10:20:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 10:20:55 +0000
Date: Thu, 31 Jul 2025 11:20:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] /dev/zero: try to align PMD_SIZE for private mapping
Message-ID: <5dd6063a-4b67-4345-bd89-32085bb5923f@lucifer.local>
References: <20250731083655.1558076-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731083655.1558076-1-zhangqilong3@huawei.com>
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 856de995-0b82-4d62-aedb-08ddd01bef6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03A+gZtui7GLZZZ6h+fzYu1r5VjT/sWPixAj78L2a0KeEfTd/sOFqNXpXH2s?=
 =?us-ascii?Q?rbLBXD72pVX6yQ3WtXF8Dlbty3+U+NDduueA+IZC8YSyCQ5zxPCKmbEor1hO?=
 =?us-ascii?Q?LWLqXbg7xF6yuIjAG3xZaNiWGg8uzRY94nwrVtiwc5s69O0Df3LjBp+tyI/O?=
 =?us-ascii?Q?EFDkN5OSx9jt2+T1vc948LekxYn7LbQTSJqr/rILGF2jKE8Wh8BDTfzT4cuE?=
 =?us-ascii?Q?o8Uw4ib3Gvz+JANO6+H7SEQyn/h2v7QGO8LYqaFI4+x3zXV5iPi8znLGA67j?=
 =?us-ascii?Q?1ny95C3YKNglVbFYntTKX+DTNpXqA+BwgkjceEtnoj9apUHd/+mfBrF/zfG/?=
 =?us-ascii?Q?cIrnpQVfgKNGp74v5KwvXecg+T8ZlZo2bMTwAmqcso8ghJ2/QGH5L8KD94/7?=
 =?us-ascii?Q?RTT2iv/a4HDssuz0dSsv5h9XKZ7Dbo9C922a+lv/i+lFBIIGMOQYWC1q3R5C?=
 =?us-ascii?Q?E2eY1IfEvNsm4AR3liozjNLCCzXQ47bQ8SKoub1P69dnYGhGms/ATeyxgpjK?=
 =?us-ascii?Q?hfcFFehOuQEOWgC5lEqh6ROhpSzcMg+RYlZK2N3sxbUqYD5elhVvzetZElwe?=
 =?us-ascii?Q?7HkQYGCCFJkiiPBwiGsQtXFTcJ6IyTivGjVfGleKrBiJNcGfCRdCXo3GxQTP?=
 =?us-ascii?Q?cXJFiq3gJ6cucKw2tjQCRQuFz+Rlbr1d1P6J+Y6vfesTrIsgAMRf+RXyYIIV?=
 =?us-ascii?Q?BvgAk1bGZQn75ocjdxGZGSUs+/rZDfOoFVIO2DXCQFCC3ZPapK9psMZuRjce?=
 =?us-ascii?Q?1BGabrtDKmYYHYzCgwLVpobuqTlOPI/qAcDITwdKMX+MQ2GKdKUJKUaNvia8?=
 =?us-ascii?Q?KtwvIrqR3G5m3fH97XnVdwjoko+lPfW6h40DSSczR93G8Zu+9NIFn0w/6WSh?=
 =?us-ascii?Q?hWK6N0Ya7MRxvrU/GlvQnYaE3+pupvmfFPntWg3114HKf0mvos5d+bgHPwky?=
 =?us-ascii?Q?6/xRnle1lRNOeLgiSKuNC53RC9XhW5kZSMfpQwpjqPyYYc9JIlR8VrYzyz6V?=
 =?us-ascii?Q?nL/V9bL1+Ek08iPQIUNZ5hOMCqfEoM8/h8mzVgb9RH8kmZ5OlKy5S8RzfJ5+?=
 =?us-ascii?Q?cRQx/TIEJbcGiPj7CcLHn7EIlukz+Rj/2acJIEdSemULBlfbLeGGMHURdZ8C?=
 =?us-ascii?Q?6QKLWCEShO6hSPjpYnO1wbaWxvv/PP7cYXRunXH/r2NuV4yuSBpD6/pHkW2I?=
 =?us-ascii?Q?c1dQVR00B3vze9PhyACcIaumRFoxMmX0vQ1slmyvCHchzXflZpERJ5gYJMDP?=
 =?us-ascii?Q?53poUdYwhTDmnlxLYGHAeMv9bniNNjd5xL0TpURBxChgF/meR9bg3c2XrJmV?=
 =?us-ascii?Q?4GWABZ8NjZ1VuWTOD1jSJIxBnBUoD2fA4mhD9HlZqMHw6ig8xYOsVEiN7Lgv?=
 =?us-ascii?Q?o13ERV0p+3YIqrvOXnZ/2+5n8auVZ+ys7R6Pg/H54VzHnY+I9oX43Wv7TCGr?=
 =?us-ascii?Q?hT2SXw6FOio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a6LQY3sEGnjEbmL/I2Ei4lUDVQ1QhGk+e1h/2gkkhkCAkWhGbjxGTPT3/vzH?=
 =?us-ascii?Q?f/iBUpRfd6A3jTjpTlnBYYzclxn5281DFuA/frMZHhYnJTv284FzTwb0rN7D?=
 =?us-ascii?Q?xdXNxZ0tF9PYPVd3oGjqbHNLG/CWbfiykIf9vU9ZLTQatnfLJ1Wk2Ad7Lin1?=
 =?us-ascii?Q?tVsLbt4eA7jJ3V7FyPpesxqfcG30Ay9FVBMUmMwIMNvyVah2K2X+Ax906pXU?=
 =?us-ascii?Q?g8FdMSAJutnNLbKyxHCj7PLr+o5UoJa2ZpsVfmRtq4qJqOLF8KT4HBxu5BwW?=
 =?us-ascii?Q?iGFplcesDd/I//BGPbgC83pD/kvs0CIFQh/cjfjeekMsbWUGJRXvm5S9PkiO?=
 =?us-ascii?Q?NVM7mVrm3uAMKsu2J+FXI3HWV+TiLvZo65tcRSpMTCpiblhRzyyKAVApxQWV?=
 =?us-ascii?Q?oG6BGyWBN4G+xD/VKHv+0Bbm3eQxYkWQ+4MvFn7sZgm+nTWSsKak3qB0oMYI?=
 =?us-ascii?Q?HdT8gZ/O9s/JgbathEvLr578BU+vg5UZnl4tzXiGzBCQk4D7Oqwj2Foyz59S?=
 =?us-ascii?Q?8cBisycVYkw6d1RbscmYFsviesxJ/CMFfVsg6O8qPCIAWSmZt9dBtmu/ekL7?=
 =?us-ascii?Q?uNwQiYx83AHDQiaTbPTGFHiXjyqpeyQGHUDhQqAewubWs/N91/LYzSJZV0Js?=
 =?us-ascii?Q?88DYk9s4kjCuZTezlsUKiSjLoZhGTaSAPlbwZYMQQuhvaSbQmzfWGaaxTrT0?=
 =?us-ascii?Q?XfVUSqwUJ/SZ4n6FiVIYqVu7C8SfgPsSRX/pd7GljmSaF+ivg+y7yc05irND?=
 =?us-ascii?Q?oq7XyLDCaL6Iatvr7br1QkpkhFdOopCb9A1FYkI6pYmtVUQsVN2W5nDMKD8c?=
 =?us-ascii?Q?gt1eqSNR6e8Z0v2OMo2Y2Yjxc8DmZWTIA6Wx4CuTB8rnZE1rkVyyDEw7G8gV?=
 =?us-ascii?Q?uQK4XG62uR9KfnRROdET3TjJAYpU8K5lIlX5wCnLJcabEkCYQE9rVwhkPTcD?=
 =?us-ascii?Q?Mj7e9OXi3gUvQsGaTHAokF3cAwP7PPz9w+REpMLCI56Bdge7EoaVASPz/1AT?=
 =?us-ascii?Q?JzlTZGvD/bwO2iBit77S7t9euLc82znSwf1AMuj7WOFeZOeq7M71lkkYv8Wp?=
 =?us-ascii?Q?lG5KdDWRDBajaxYMEX4q2+pF08R2Rastxeb/DJlXmvzvxbdQGtkgStd6uCVk?=
 =?us-ascii?Q?ZfhWo4OgtCAuNAwnpoQ+SvaUqsSlVpki9N7Nx9LDwtKt+MlDTLFByliK9It4?=
 =?us-ascii?Q?3glhE4FAbE9kX9VAq+YYun1qX5TQSrS3cEz2KIR/7KykMA97Y8aoKv+AQsmq?=
 =?us-ascii?Q?cR7PgU5XsBcRAl/HhcpP6g492Kzn/zr/CnaNGmS1egjwr0vDZd7WZHmTphlX?=
 =?us-ascii?Q?RRIiKTrmZbvd1ZsP/AWQmo55VDxnm3Wgn3v9HE7wVwtYLsbiTCPscz0I75Xo?=
 =?us-ascii?Q?4MISJBRSGL+3K1jERUxaMTphu6A9gDm1GPDiF1Cz+6pF4cpee+MH6s5pbGYZ?=
 =?us-ascii?Q?VjzY2po/JaJJvtAlqr9rKncQpDKxCCjmHEfbCUQLNyYkezVstjb4IeCM0NdL?=
 =?us-ascii?Q?AtISVcu+cenppedyqdaA3HiGtT21nx7iQUakXtapTF+xpUBiejS8nQGy6FYI?=
 =?us-ascii?Q?gouXUnzmWMvrtB+Niit2Fa2HkTqxpbQ9nu9DAlLCEibTQ5gxkEAdxbl7+Glt?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TIlSRkbiD0qHDJmdtzYzP66U6rsCgSy1zQyWaT+HBIt+D2gKgLtD10IPo/O640/uvp/N5buTlBpi7/6DtEcG4S8Vh34gMgvl/X5Xev4h38jFSJV5/ZnSc9DuHkvQdsYgRsYd8SBuLcTgOGWy78mLuJfeT75NZBoIBcTn+aAkCm1SQs2N86+frKdwaymEjp9sYw9G/nCIR3Obz0jFSn72gGV86W+bDanbqQFBIbPf3VnL+Lg5RRcObhDZRZj1SOT8SXf/9uSv+4pE++v4Nq3LUvDDdJkO2OWlIrExD7OhMAzrhuUSPZmbroIPrqE6MF8XYPw7WJJyktci6WtA9e95pi11I6mj4g37655vM+SJ7SAuWZf8dE2sbioxm9KzC82i44HGM3czPKuuIyUco3FPVJce8WfLENTXrw9p07MSKkBD3f0Imji+OXnav6tK6I3beOpF7uj3BqQeLA3jFaxhI7L/RaGsKI9bHUwr/p4FdUIq+Y8acEPdwI2hnLB5JWfdqV76Ss9XtkvZaMq3sr4AV/apDlGjrKHMOd+kBa3zo3LPYfwzAt3L6z0nBlSH4GZE85Cr3g4VINiZdHQue2XH3FPh/I+T9nCBrK6lel8JhRE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856de995-0b82-4d62-aedb-08ddd01bef6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 10:20:55.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f918CiXgMeONzcdNh1GmsK5ctkJLck8pQLkXq7hnn9+PZNd2mRNXvY1PnQLH1TYkHqEFnv+WL969Xg1Pou9CuWNZpDS6b5mLbwrd6JcZhGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310070
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688b4394 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8
 a=yPCof4ZbAAAA:8 a=GchUzKuH8IJvYVf1HKYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: g_0wJNSZzqEyjCqQ3mvYfIk-Lpa2Jc-S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA3MSBTYWx0ZWRfX4qvThrWZruH3
 wsyJipQy0Y6uZh2Ci+rofpbSElF3xHYbyAlzlMK5yKLf5N3HgAB9cOGsm1T3p1KUrWXl4/zWpkR
 1pKl99S68yeAzJHwrVlGxjCv1QTKcA3/Zq8eZVm1Ou2Fjf0x9/FK/L4Tb45b/AuQl+vXqun189d
 b2OBxNSxJyl+BNbqIzJjeNGNZua9zoNX0mUW2iTDNNNy6ZYSMVijXgBBJRZQL3j9VkbtujTS7Jg
 gNferdRIzbJegzdTKGOlYbvZwrzeQ6z6QuOJnXuNfuq7vUPyx3GpmqB/BoC7LoaPp+iMdw9Yitj
 LJx+LXFewWJ9GDrptYzzMVFksNwtMl2ZxRtrd8LX8w39B21z8Gqw7TTQNjiLV5XBWAwqsG4WXFa
 yL4k5Rom+izAX0mihDUN4ogCMqaRzzSuveW8TYtHd5ZW8NwfBvRb5hQ+awm+A/aeHLgscsob
X-Proofpoint-ORIG-GUID: g_0wJNSZzqEyjCqQ3mvYfIk-Lpa2Jc-S

On Thu, Jul 31, 2025 at 04:36:55PM +0800, Zhang Qilong wrote:
> Attempt to map aligned to huge page size for private mapping which
> could achieve performance gains, the mprot_tw4m in libMicro average
> execution time on arm64:
>   - Test case:        mprot_tw4m
>   - Before the patch:   22 us
>   - After the patch:    17 us
>
> If THP config is not set, we fall back to system page size mappings.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I did some rudimentary testing on this with a simple MAP_PRIVATE thing
which caused no issues and I observed a 20 MB mapping getting aligned and
thus benefitting from 10 x huge PMD mappings vs. mainline benefitting from
9 due to misalignment.

So feel free to add:

Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Cheers, Lorenzo

> ---
> v3:
> - collect Acked-by
> - factor out the #ifdef CONFIG_MMU in get_unmapped_area_zero(), per Lorenzo
> - explicitly use #ifdef CONFIG_TRANSPARENT_HUGEPAGE, per Lorenzo and Matthew
>
> v2:
> - add comments on code suggested by Lorenzo
> - use IS_ENABLED to check THP config
>
>  drivers/char/mem.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..b7c4dbe4d2c1 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -510,31 +510,44 @@ static int mmap_zero(struct file *file, struct vm_area_struct *vma)
>  		return shmem_zero_setup(vma);
>  	vma_set_anonymous(vma);
>  	return 0;
>  }
>
> +#ifndef CONFIG_MMU

OK, the convention in this file is to invert this check so this is fine.

> +static unsigned long get_unmapped_area_zero(struct file *file,
> +				unsigned long addr, unsigned long len,
> +				unsigned long pgoff, unsigned long flags)
> +{
> +	return -ENOSYS;
> +}
> +#else
>  static unsigned long get_unmapped_area_zero(struct file *file,
>  				unsigned long addr, unsigned long len,
>  				unsigned long pgoff, unsigned long flags)
>  {
> -#ifdef CONFIG_MMU
>  	if (flags & MAP_SHARED) {
>  		/*
>  		 * mmap_zero() will call shmem_zero_setup() to create a file,
>  		 * so use shmem's get_unmapped_area in case it can be huge;
>  		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
>  		 * so as not to confuse shmem with our handle on "/dev/zero".
>  		 */
>  		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
>  	}
>
> -	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
> -	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
> +	/*
> +	 * Otherwise flags & MAP_PRIVATE: with no shmem object beneath it,
> +	 * attempt to map aligned to huge page size if possible, otherwise we
> +	 * fall back to system page size mappings.
> +	 */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	return thp_get_unmapped_area(file, addr, len, pgoff, flags);
>  #else
> -	return -ENOSYS;
> +	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
>  #endif
>  }
> +#endif

Nit, but can we add a /* CONFIG_MMU */ here please since we have a bunch of
ifdef's and it's noisy.

>
>  static ssize_t write_full(struct file *file, const char __user *buf,
>  			  size_t count, loff_t *ppos)
>  {
>  	return -ENOSPC;
> --
> 2.43.0
>

