Return-Path: <linux-kernel+bounces-747866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8444B13946
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408993B8815
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA038254876;
	Mon, 28 Jul 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFOaMG2p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X5+k2/9k"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4C22F74B;
	Mon, 28 Jul 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699986; cv=fail; b=kiUALfgs2E50VCBRuC/ZdTrfzmu8hz2aw7BODvp4R2f4s44PXYBz5rwkz3G5koO3ZM5mthRLKRiNKv7qKEw7wIlCpuVxBHuB4N01e1d087hlyyvARZ4amvnryox+SyH/QFjLvOulRUp2DtyT75Pl5I0hdwY6OAXs4dQIbQ6TquI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699986; c=relaxed/simple;
	bh=xhyQ1bUz1NkcfPu0xa0Yo6+FX2cY1Po9NBOK5ZNNziU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6UFhMcahqTZ4u8uCUT771qtkbGN768YIjUozV+XrGo868NhzcLNeDQ7QCIoy5CKxF8QzHLl4MRFvznTvhf28e+L4PJQ/vYvJbhXmLfm1MZpCzBeTkHAHlYe5r/n+oegUMHVmuJputxjBGghwXt/qSl9hzM2WWuaBs3M96uDPrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jFOaMG2p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X5+k2/9k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S7g18a015299;
	Mon, 28 Jul 2025 10:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2Wul1zJ6wPku1hDH7c
	TrHB8oNvIQvytr4LWtcaHLIr8=; b=jFOaMG2p7LzKY34k6Qx892vbldx1cjeQ4Q
	Yam0Q7sa9FSo5rpu7jzMKnlspernPPkoi1+9DP8zrWnTkXdn67PCZ3JgfR7P+3V9
	GwNdRaBrHyabML88l9/P/o8z+V0iynYsWj1I0WaB/xtphVqzrYdtO5bgYGuPZAD3
	e4JS2wCgq9qNcuJzXvUw4NonP1egKxIV5WCOFVLMV91PUqSVuos/aPsH1G0usd3w
	RtQf8TEf5lYhYaveGaAV38HWf+qM899iGl/Nk75dDcyRXnB6cqDZ03IcuaVGZ0m3
	mS2xEypTsy3Knjf/KXyBKnfdYgleEDce2jqzESU6j6JN85NFXM8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yaxhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 10:52:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAGPmK010491;
	Mon, 28 Jul 2025 10:52:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nf85099-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 10:52:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzFAeDnc0w/iyKe8k7IXqnHfggXK3iX9BpMRfX+uoHnSDBZVwsExHCWjI352qOebbKH8zcGNgFmmV0r4rEl2r/TrEtQlM7PEDKwCLvsVNWY0aS1YuINaW6NaPIRf7iTchRUDzghVCNE1BC2UqhyoAK1wlgz2EedG2n1/+JVokz0uyRqr2Gp/BvFjBB5siejQ7KNNooRQ+X2Mt2b2E9Cu4JyFMdr0F89zHNP22GpBlyP2A6Ynv2dAVydrCx47tbTlF/joiHdsML8J82IZKy4YcFy/5osLXyoblh6vd/u6XGM6PFwDSrvbLOz0p1ExY6LP5IeFhu9VDeYpVCudqR6paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wul1zJ6wPku1hDH7cTrHB8oNvIQvytr4LWtcaHLIr8=;
 b=SQ1Md5i03W6wGDUjkY2lQ0xoogTO1H79l6PFUefBIvZeMFx50aXQSyc6hyjzrIbLlaInrnbjWn316/e75u2qYMARPdMF8i4UkuYQonmPJ2NvJel/kmsfnssLhvwDBViq9sRfczeYFCJLckK0tMR5rn2nBV2AoHJBFpl4FVi0O7+JGmECITxWBbOpIPnCD1HtNKB4Z1a7fjstrT2dXQxi3KbErMjJ06gCcCVSuFR10ELdjx3rkCunbrbraaNe7lH43Yg+Cf9DSfsVfp2gg3HQyfJFCi0vlnS1W/3oeWJiXl+1Tfnhbph8H4901zQYdBEzssCxRD9xsz1wO1HoBNPY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wul1zJ6wPku1hDH7cTrHB8oNvIQvytr4LWtcaHLIr8=;
 b=X5+k2/9k8TsEzr2rKv/Dqrw1TmYUqfie7E/5o9/8/W0aLZ7W00pLVTl7v/WdM3GmS17L0c5U5Yq+58Pr1gAjlkxKyJMg5amLtwrGD4LYIyNf1lLqsPz95f5UruEzuvahK2XGWTRZAjGTmlhwLxTyr5CGhGdIq+spF2qbbwt8eNk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 10:52:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 10:52:52 +0000
Date: Mon, 28 Jul 2025 11:52:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
        konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072854-earthen-velcro-8b32@gregkh>
X-ClientProxiedBy: MM0P280CA0019.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: f423bda9-f4c1-4e4d-85c3-08ddcdc4e681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/NCYXtfIWyv6DgjGZn5RHI3glU7DaxNKB5wNX/goSqi0mtQLm9TqjesyyN1/?=
 =?us-ascii?Q?ESm2snrZSwAw4F2D2NF/Qu0DFNdIfjyM+XcpgKwtgZRmhKi7eXGJK43MWoHZ?=
 =?us-ascii?Q?KN8Q8+dsg9z4ldoCEyNewYMx+ehZq0A9cb3QUVc/QT4794TJvopfpkbauUeW?=
 =?us-ascii?Q?RK3R2WwSyrzrRo9gU6B+pCY9/2K2EAu3DAnJwTVyYT8ewuR97Mc/6Hb8YKQA?=
 =?us-ascii?Q?EWKoEvY03Gu/wzRJxZadDTa4G0Rw8K/GL+VOxFqFvCcdEvhizW99Kj+i0Ouq?=
 =?us-ascii?Q?wVWnwm6LN0fZagk59ZuTO4yI4tvG30Dw9tqj2eEFi0Mx4YjJGGyySePsBBK7?=
 =?us-ascii?Q?OzNDMpb4FgKo7EG9pPa0ELTyWJQEl7HMDtR2b+jPuEu2pGL1g2Nf+iaz77PC?=
 =?us-ascii?Q?m9idK7wushCzvfZqeH+pg5WsXCK1ajBDrvWGveIX8uhb8+yXga+s3qI0nqlk?=
 =?us-ascii?Q?rLnsCdbQ3ZIZyMusIm4Z6rXtmZ8t8x99Kd3O+KXbiTeNLGOpHum17NbrkjIt?=
 =?us-ascii?Q?qs+lT2x8o4G5yFCkI/kwJDmoaK6esFLwhxvG3Zc+U5+QumpsBiAgRE/Oz4LU?=
 =?us-ascii?Q?PaEvm1iAF0H3Xl35izVRa/cT9IE27Zvjev0Os3SdvuJ8VEIrS5V9hHEZiefM?=
 =?us-ascii?Q?+Q8AsFDXC4aEEYJWflIeUXwvGq5q9JQSf6PWtnNWsHgOx4zj+UO8AJzYvvJw?=
 =?us-ascii?Q?ndTaWYTbke7ax0YLY5xiksyU72NGstsKamVQgl/juNPVZCHg/ztpstpBvxi3?=
 =?us-ascii?Q?YY/H0RyYw5ALUCTm7IB0IyfkBzdaSKNRPAR04A0XdgymX40qnYeJHTQoUEyJ?=
 =?us-ascii?Q?+Zo0GuBOnLFQZyPGCIoVEckPsp7NZZ5l3dvCYZPQmXy+RKrpHjl72qPpMV+d?=
 =?us-ascii?Q?8io9i2jmNeB1yZ3SFr5OoZmPASCnRiO6eb1B/hdHN1uhacdwARzMzbwLIa0o?=
 =?us-ascii?Q?gOlr59QXd4LkqnsKb930HI1YGGZ2Y3ytZr2NyZXSeLLKVd0nx28SATnw/xoz?=
 =?us-ascii?Q?iTYPkbXmbUqw9kKKg/34l11U+pYCZPYvfTVpIhUSYNGJN8J9qDBbtyAMPcvO?=
 =?us-ascii?Q?Sriyn5Eq9c3b3GLuZ7yJ78/8bWtH4Bjk9/Pd3f6dvVdMia9JHMLif+o9fJPX?=
 =?us-ascii?Q?TUAL+CGGZNMOpBaWv2zko+GHr6q+xmsPcBdH/Kf2q3Z2zmjdt7LssXKthTmR?=
 =?us-ascii?Q?u0vDgcdi3kyc8d8UtLXQRMCbl/ixwwMpnsKgRf/SCjqgJs0fwUSMewpInsVX?=
 =?us-ascii?Q?+nqmvwbEf5pyMcbds/pQ1ONxB62prL+KCuMtlphrOEKnZ+Go1gqiXYJGf6hC?=
 =?us-ascii?Q?yIV6dhn1yyBsLOCnIxEOidzd5wTXSS6+b3LQj0OW5KLxtGed2wWsFefq5+cV?=
 =?us-ascii?Q?tg++8chzX1ehWJh9TBgXk4j+PRFXt3J0CsUL3awpb415IS62CGL6MjLTpGIx?=
 =?us-ascii?Q?NLmVgqz2+aI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?laW/vl3fen+aZdpfbPi9Y3BtItS/iNhPg+4RX0GH4h8gtaDPaF8p4qZlE5Wj?=
 =?us-ascii?Q?gljnKKXvDMowiM8EAhGbUY1fbt009aZGCkXs1F27kixzixrCHSdrtf2GyVYQ?=
 =?us-ascii?Q?6Ftrnyxt2ixK/9MIQEVUcG3YXCxdPSaqC92ytQYS4M4u+3uPcWDLZd3U8oSv?=
 =?us-ascii?Q?nC+J+xF7XwxXfA9Xxkpv88mQf3Ibcp9nERnwJloR0FqpStUgZi1tIaUz6yWP?=
 =?us-ascii?Q?XYh+XIDjlSkLxTBcIjL/H+E86KKZNVQftU+JsIgQutPS5+BeAQ/bK626kut4?=
 =?us-ascii?Q?6xS5xJJdvX5DAytts9UlmKUIjvJrheBllk7G70aBKPgDLa25Z5KUXlkyaBBc?=
 =?us-ascii?Q?/Omqy4T1etyEASlN83XJJ2d4gOh0L+03Vzjf+P9/Ucytirnwsd15dwT9P9jR?=
 =?us-ascii?Q?HdnEMNjCL/s4AuY4jkkthClyFd55UNsd4Xg6A35Q8RxI8WVNh/wLWdVrnvmj?=
 =?us-ascii?Q?NhINnU0c6dgI0vRAXmryqBzAesx2p3JFDWnLHIL12S8GMrwfV7tTvEUGMjJA?=
 =?us-ascii?Q?KkXYG6HmeGuz2C/Ac7bABSjxkwGh9K+5HtKJ5m7MHsRoiukN+8UK99qbut96?=
 =?us-ascii?Q?woMtYtGgCl8CBRT/lN6qGwj6Y41faPqvm1AuXrP/lzAR1i7h5rbMRgtovtiM?=
 =?us-ascii?Q?71FjV0HxKlUD8DfB1R7Hgl6TcSJP0d0kl6Um41iGrNm83LzPvX9TUe46qaPY?=
 =?us-ascii?Q?bnCfCcme0q1W77i6LlTXR/oQj/XRSloJDw+SbVvITOxDqUMP0IpeEvN8LGmF?=
 =?us-ascii?Q?SgUbtCkqjT6ioNMP1vZEneVx22u45pxsCAV3ovp378W3xGgVNEo0cRlY8YCM?=
 =?us-ascii?Q?8D/DaD9yN6dKN92Ed8MQZedxePrHa/1T/QK1qZ2NZQGck/kXFe9nqXtwDVsW?=
 =?us-ascii?Q?igKwEDLdaidTFN4Ll+oa0TCFk/fsuBSpppMLZ86RvDB5bDT8x/NV7r5BCOY4?=
 =?us-ascii?Q?eJFtuOJ6X/Fy0UjTCWGWJze1fdcpzq4Tf6OA4bMoyWEhnzzJBDvfoe2EYO1b?=
 =?us-ascii?Q?vTnaUiUHAHLhoySmXpYZTPkKKH9tZERSR0O5j8oh3x7rt5qSfH6aM7138Xtk?=
 =?us-ascii?Q?nRTCmJochHVO6Ur/Xqe4vuZ+NIedrc1TiQT/e2UZHdZ8m5ofNonXrPpBpnKj?=
 =?us-ascii?Q?A6iI39uowYy/rn+P7BEz1iiAORVfK+VGiSKrYJKMsLig9GkkRJNfBiasgJam?=
 =?us-ascii?Q?/8uCOBdJEfov4oxqMnpamkS+gID9BJ5ypbdUqrWWSUE31/HGxEbFAnT8uvr4?=
 =?us-ascii?Q?bWmxxs26ijQctgPE5eWczAhAx/H5PfoZtwp9sBqlrsfAoAvMI8TM3m+fl0Mw?=
 =?us-ascii?Q?juSYgUn9NVcedFxDbBc4uW9d5oYgRm7YtbF1AxVLPoSRdgkKlphS9nR+07H8?=
 =?us-ascii?Q?NNeLqiN5uDXfmGcUYOK07YW4bSUCzXdD1BIsp1v8y/Z8/9e/2sr0ERleoFjS?=
 =?us-ascii?Q?t4vuHVKmQLNr390B9pOZTZZHByfAf67W/zzK0bmaYSv9c8czD6valjfvsuD6?=
 =?us-ascii?Q?gVBy11BkYbZXwPR85IoTIZQ4ScKseWCV9GguD8FBPn0kSIuvMfzvgS33AXI8?=
 =?us-ascii?Q?y4vzcSHkUh0PGzFXBY2qhCua1qL9rGVGCJtkFwRLt4kghPiH6e7iSDtZJXJa?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HPwEotDDfnIi+yhAcB8SrFLdxridLmwr7GcANCFwEj/8WQjMxwDxJObqrzHXLBRczPsgtqETgQFMw+uEtnkB66/Nbu3ZPJw9OnMVa+RSpshffZN/fWQhptzd/6KZ2CKICSlHaR+y1dtSqtOAfrHzACh2l2qOCFJfJ+jKk7vaCd1lkAX//S6QomBPzVIHWV7CjrxWdUlIAK7thg3CfhfxNle1Kp7Ib744wBFrlBdHa/6NTK1llR2HEawwqgf2B9oF7ShZYK2hEaRzXUZ0ser4Q8CVBnDKfDd1eZ7fLUGz9lj6U8I/ET7jNx84npU//K3fhI4PZh88gYKR8P18FROAlasvQxBkNsEn8HuRuvOkErjwPWF5acG6sKoRv8HswSKLQQi+osO1oKzvvcUt0EC0r1BULV7X1yH/gUcHBc/FYCNfLAoEoXFNZ7a+B+agSjZaI6al5/Plna+y9lbFV6PVCTv0TNZC8sHzcRK/1VUtd7x7z6Eqd1G4SHuMBCA8LqEZvN6Ey4v/633j/efALrxLf9Jizfvia9NXuB9P0L7Ce/CBVvJGu9ltYXHJqZiU9FqEO8udjdsCpPEdaxxCAd0tzndey1uLLaUnG8DrxgSTfIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f423bda9-f4c1-4e4d-85c3-08ddcdc4e681
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 10:52:52.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HG88tUepGCcOEcMntWL+DDiuWtTneBIOrUNsorRCNqU+cO57+YAoEPEWw+cfksTlUlmySQCjh9UJVEWbMe8KFj+z3ixeD2RjsIQ/ABv4oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280079
X-Proofpoint-GUID: ij6Jl20dR4kFd_n-fhJPqlJiBMg5c7ED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA4MCBTYWx0ZWRfXyXsharp3OkLA
 du0Bc0rgseuJ0ebwQmH6KkT8tS4jOY6aXmPkYtHpcSFXzBNYH63CRIMitGGvQlpfNqTsPnhmtZF
 /eBcOpYC2poihb+L1jl/1ZZkiMnYbdD2j9Z1kMz4XOZKb+Pf1VcEWJ2rwH+kBm39+lZBsMwtWay
 dZOVtBApZhcithOK7HuDTFuVxBePD7Ww1lb1DV5BALzkZzjt9/5YqRAvNcKyKv+CxsJm3xkRLZw
 U9N+yTEWhe/jhzD+J+3o/aTlEta+ZJFW39++9GtFZ5kLRGzpksqWpdRoPUm/baueVY56UNr3hVl
 ph3zFgbVEV5vpWFuhkISFC1uqO59g9wqZKTEt56YrChk90VQopFUk2BcUoMgYczbb4avBT+ve6J
 kp5q1KpYmN5UoBgoJm7/R97NOqOM5d6B/vpskHna8xrS8NrvXB5zNhC1Vt3VqgDfqaLrLwbP
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=68875688 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yYb74XyXo8kRV01AmWYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: ij6Jl20dR4kFd_n-fhJPqlJiBMg5c7ED

On Mon, Jul 28, 2025 at 12:35:02PM +0200, Greg KH wrote:
> > So to me:
> >
> > - We should establish an official kernel AI policy document.
>
> Steven Rostedt is working on this right now, hopefully he has something
> "soon".

Great! Thanks for looking at that Steve.

I think a key element here has to be maintainer opt-in.

>
> > - This should be discussed at the maintainers summit before proceeding.
>
> Sounds reasonable as well.

Thanks.

>
> But I think that Kees and my earlier points of "the documentation should
> be all that an agent needs" might aleviate many of these concerns, if
> our documentation can be tweaked in a way to make it easier for
> everyone, humans and bots, to understand.  That should cut down on the
> "size" of this patch series a lot overall.

That'd be ideal, but I think either way we need to be clear to the humans
running these things what the rules are.

One thing to note is that I struggled to get an LLM to read MAINTAINERS
properly recently (it assured me, with absolute confidence, that the SLAB
ALLOCATOR section was in fact 'SLAB ALLOCATORS' + provided me with
completely incorrect contents, and told me that if I didn't believe it I
should go check :)

So at all times I think ensuring the human element is aware that they need
to do some kind of checking/filtering is key.

But that can be handled by a carefully worded policy document.

>
> > In addition, it's concerning that we're explicitly adding configs for
> > specific, commercial, products. This might be seen as an endorsement
> > whether intended or not.
>
> Don't we already have that for a few things already, like .editorconfig?

Right, but I think it's a whole other level when it's a subscription
service. I realise we have to be practical, but it's just something to be
aware of.

Perhaps an entry in the AI doc along the lines of 'provision of
configuration for a service is not advocating for that service, it is
simply provided for convenience' or similar might help.

Thanks, Lorenzo

