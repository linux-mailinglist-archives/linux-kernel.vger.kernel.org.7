Return-Path: <linux-kernel+bounces-753232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC1CB18058
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE537B2DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2D23536A;
	Fri,  1 Aug 2025 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OYO/16y0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rJs565L9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701ADDC3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045023; cv=fail; b=bDpVvVozLw67f8Gp8TgqlBP5jIU0UdkQG4/5euvDkxviICOk+vhSB83V9b0UPkRu9gDxmYyJ5SxVvPiWMLvO5GbJG+LYYlBEmOS3gQ49Igmn6TKy0uotnqaH0CiwKnaNgDwnPLVa2+lYfFWkj2XUEqgfyK4TTXjgHCPMu5YiLIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045023; c=relaxed/simple;
	bh=lNXWw3OCsmsKoxAy4ZfPbK6ZX2ds0rLupYOyQKrjhAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KWngN72p8bbkYu9rGgAj8uEsxMvD09Bsw/3TyByZkwUKBbIwwRtw/hxThGAIWT30n7uMLWpdm/E6vRmhp0TYBIQdqjJmYJ28wU57CntpXiHPiZ5nvXqkP0BQGFKBz1ydRySUOSsoQiru65UyCywJw71xJeJK1AvcEN3sxC6p6c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OYO/16y0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rJs565L9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5717C0L4030735;
	Fri, 1 Aug 2025 10:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lNXWw3OCsmsKoxAy4ZfPbK6ZX2ds0rLupYOyQKrjhAI=; b=
	OYO/16y0Z1pOm1d8RngVnmcbuN569gtQcvROwS+JPbBkIpM2PCLvvKsxsevlOm8s
	iUn407rCcpfXdQzprGISv5uebuGTbA6m6KPLSjxysE6eY2Gzq17r6dwucvsYwFe1
	u0iPiv2uK+OsIWh3u2PJz3Fr/64Cb+0obPjzGV+VBMiCPfApVGyk0dOtBvIXxKpW
	VsjSbgRZcTSCIjpBkdAxT3a8dHZXKoXzRA+EgcjTQPZ3fzWToqtpa4evyolWAdQm
	aQzdsx+L2iDSdkhsmMdo+svBt/W8BS4Wr7zHGSxXo2pFj00ljPD+IGAb2WTx0PQ0
	GPswy0WLY0MYJxpaPM8VdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q73624a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 10:43:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5719igNn038464;
	Fri, 1 Aug 2025 10:43:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdctp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 10:43:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ira8/Y1tAHkY6qC84GjzzxBUS6qd2T4lyxOt+9yPyA2Fv4qhuWM+tgZY+3us8mI4a5NvFd2YmDiO7zlimd8DdHIBklzo7E/GEBW/Gewh/EhxmErB0lxLr5j1VwGdoNEnD/OIEpL4G+XpekovIxAt3zg59WgAemCnNbkeuaz1pZFrXoyxnAtW/1j6aTg2yaUxLsNr0ymnULKyDVvK+xKQZTZXYAqhIEjlDwS9nVNk+4N9NjT7smavLtV6N5KgRrIAbk1ccQJ6bZJwjYShGTNv5RfExYiYhAi1/SAesAo7hz2vwFNxuPqPe/hd9YUtz/Zh20mbtCBQlRIH01SJICFujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNXWw3OCsmsKoxAy4ZfPbK6ZX2ds0rLupYOyQKrjhAI=;
 b=simwcNcmIKELM6kkZzo5brr+V3n9/gpq5PngSC9SkcXzjkVFR3u75zriD7ijooDpZANqLZ9x9tjxRu5lyhx8nGt2ierHHvgTsDNRZyaVpmwuvqn5uHpH6Xu2D6340Z9RsHbFJYB8juiGIvqyprkHiygv+SGFZpI3Vzzr7kXcGicW+yP+broRVbigno3Pg/R97YCiV0fR8E7gMGYpr3pPdVDrXv1PMaiVgM47vtakLZEUDIU3uocVBQ/k9jwOogXb09QdIEsy/vXG/yX7HzUCVvty1tRdYbq36ioQJK1P/I3K9ookzkq8tW158jLn7hid5crrDS65LT85vzyULV4KMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNXWw3OCsmsKoxAy4ZfPbK6ZX2ds0rLupYOyQKrjhAI=;
 b=rJs565L9PhPohuwhYib0o2iLuY5h3Cp8vsO/uFGCSUPaWasSP5e2vSfVTO9Q98HhZUAsebfQfW3r8SKP4bnpBQzqXe7yOzplPO45LXDP1Nel5iQinyuA34UlnVkrgnNAyp3J4BxDb2VOd1dZTwqhw2LAVlX4ApQ5UpllRzA9kj0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW6PR10MB7616.namprd10.prod.outlook.com (2603:10b6:303:249::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 10:43:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 10:43:28 +0000
Date: Fri, 1 Aug 2025 11:43:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: limit the scope of vma_start_read()
Message-ID: <a53a539c-f159-4bee-88c2-c55b0621b99f@lucifer.local>
References: <20250731151919.212829-1-surenb@google.com>
 <CAJuCfpHghvnWWvF6JN+DHbD8Vv7zPVC0BZcTmW6HcrWrxo=KWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHghvnWWvF6JN+DHbD8Vv7zPVC0BZcTmW6HcrWrxo=KWw@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0060.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW6PR10MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ae686a-0524-420d-2ac0-08ddd0e84013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWM2cmhrWTUrYks5am9wbmxNWm5FaWRveUU2bG9ySEl1SVFHdE1nNlFWazNu?=
 =?utf-8?B?b0xGM1pMNU9sVng2TVduWSt5M0RGaUhRTmlLNzlnaUpWUi81SDRqdzllRmZJ?=
 =?utf-8?B?a2pqeDRnQUxNSGk1VzJkd1FwaHkzd1o4OW0yYUc5a3BuRzhYTzRnU2x0U3NN?=
 =?utf-8?B?UGJEeE4zK2ZVQ1Fxb2pVbktmdjk0TnFKMFUyNzN2Y2pjU0NFM21XLzQrMjVV?=
 =?utf-8?B?TUp1cDRnZm9HR29vUGpIVTdqMHBoNHdzaU8zVWZ1RENvWlBLb014ek9ZOVVl?=
 =?utf-8?B?Q093SEJkQVUwc1hnVkpudEtpV3lYZGhVTGUwMGlqTVZBaVhkV2NPa0tnTith?=
 =?utf-8?B?aDFKdllMMFVqUUluZEJhSWZJazR6MWlpNE1VTmY3dGVvTWhZVEoxa2NHSG90?=
 =?utf-8?B?SEl2VTBpY0FyY0dwWENJVDU2NWZrbUl0T2ZRN1VvQkNYeTZKSnZGblZJTTZp?=
 =?utf-8?B?dVM0U2llNEVqbVN2Q1NWMmFBeGlXOWRJTWMrSk10QXYyR1ZPY3pZV3I2SG1C?=
 =?utf-8?B?VS9lUzY1NWMzejZQWGN5WWVzZGhkc2xwTHJOSDdxZEp6V3p2Zk51SDUwaHd6?=
 =?utf-8?B?aG9KS2Q0QzZSbDMwZE8xend6RWlGd1lmZ1FJdzBFZnVheUd0TDdxYWRYZmZJ?=
 =?utf-8?B?YWtPQVdQOXhicE93STZHMExndWliSi9CaFdiZ2VDRk9YRXlRVTg3T0JjUGth?=
 =?utf-8?B?a0NRVzJnc20vakVpR092cDhWYVR5RzRJRkt4ZnRObGhZU05qcDdpd2FFR2Iz?=
 =?utf-8?B?OWI5aExxTjhvRkxhK1ZIZjhkTjlFZVU2YmRPUVJWeEdaU0tJSmN4ZkVNTFBW?=
 =?utf-8?B?TEQ1TlFSMGRNTVVMMXdVTVlNQndwTDdvYTNEWFVRVDhBSVdNTXVwTkFCUGs2?=
 =?utf-8?B?cjZrbzk4dk8rYnNQLzU3bVVIR2ZPZUlIRDB5SS85NktsZ0NIc01xMnlBUXRB?=
 =?utf-8?B?eTBwYStqemluaUoxTjFPOXM1bGlnNjVGOUkzNXVyYWRQZkRWQ29zSDZDcGhr?=
 =?utf-8?B?V1NVQ2dRZHVlL0tLR1c0R3BNcGl2V25WSDBCYWliMEU0d3FaOUtYb3NzeW50?=
 =?utf-8?B?dWdFc0VYZFZJczJxQmZJZ09RZTNzaUZMOUpJU2lZcHBycURDbjJXbGRxUDlq?=
 =?utf-8?B?d2tGYndYYVJhemxSUEY1aVI1Q2VTTnFsM2xDNCtBWTZZZTdzSnpMQ1g3WVdM?=
 =?utf-8?B?bXNvcTU3d2kvNnQ0U09DdExRbHRYL3lZS1NjalBFZHZiZTJ4Sk5USTBISXU2?=
 =?utf-8?B?VFZmTEwyRkppcUZPb1hnb3BEakNaanFGK0NwcnN4Z050UUI1RmpUQ3ZBU3RI?=
 =?utf-8?B?YS9hZGlvRmt2WXZtbVNnekVENTY2cFV6Vk9SV2QwUnF5Y3ozTk5oOEt5UGxw?=
 =?utf-8?B?NzhSbDF4OXZuSFhFTkNFcUd1b1hoNGlMeVQyR0duTnpqSnhMNzJWS3AveFlZ?=
 =?utf-8?B?OHIrV0lPdm03bU93SXlScDNmck5nWmpUZHVsKzJBZmRnSjVORFErNzFJRGJE?=
 =?utf-8?B?eHZjN1FDd2ppZXk3YjVqQU5nTEUzai9FalhKdWQydFY2eGNzd3lKVmRYZStP?=
 =?utf-8?B?V2p2VklwV3pQSm5CcCtRdmFkWlJSOGh4WmNuTXErTFdNTEhhTDBzVFhPeTdQ?=
 =?utf-8?B?TVJnQ3R6Tm1manRDTFA2a01TZXRzVGpiaVN5aVlPK1NsSEZobWVSK2tZbUVU?=
 =?utf-8?B?YTN4amdXY3VFejJWSTQ4MWY1Tlp0WGIyNUZBWXRkMjB1NGxuZytQMVFJc1N6?=
 =?utf-8?B?LzNHVGtucXpLZGMrd21nTE1YcHMvLzR6QUdwK1VESkRxZXIvRGxqNkl4M3pn?=
 =?utf-8?B?SnIwbVBvcGdlNTY1eENMdlJkZ1U5M2I1Q3pLOHJrNmVpdFp4enJvbHd2enRv?=
 =?utf-8?B?NmFTRVVOb1lvNlJtZThaUFhQdkZ6eTYzOFhkV25HUWh3aVdENmZNYjhUcnQ1?=
 =?utf-8?Q?5uhHgq5BFzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3d2QzB1ZVNBOWUrK1pQVmdoL3pDVFNLb1VRNExLQVd0MXMvWE5CQjVSR1dX?=
 =?utf-8?B?YTBNUUFhbXUrMXdsM3U0Qk0wOFBpQ1RNdTZNQWF5cC9aMFd6MjdkV1p5VzdE?=
 =?utf-8?B?Y2RvQUIvTnV3MFZzeXA1bGtML0IyMzhMU2dBTCttNlU2dXNLSk5NQmdSUFha?=
 =?utf-8?B?blJVT0gxdWVTUmFwbGpVV2FTTU1YSDJxc3pWZnUzZGROL0FpVjhxNGVTaFFU?=
 =?utf-8?B?OEJLVlRhQUczRk94RktZQW45azk5blRzWXFOMjd4S1Naa2RXSDdmWXJ3ckF0?=
 =?utf-8?B?K3hUcDlKa2NORDVhZng3VkxiUkpnYVp1VUl4TCtJc0ExNmZpZ2JuL2MvdEIr?=
 =?utf-8?B?K0t2N254STJOdGdJWjJoQUc3NzRGTU5ZTHdBVmNUWFJJbHJRSkk1NHdJTXJC?=
 =?utf-8?B?dkJmbGFjaTFFdjdKUTFsS3Q0TmdoWkg3NEFjRzM5WExlL2JNd3JaUVZGVFhu?=
 =?utf-8?B?U3ZjblhFZkdnMkE1K2Z6d2U3VE5laEcvcDRxblNySVh6T1VneTVKRGU4Mncz?=
 =?utf-8?B?U1NtUTJTeFhBaTQraHJYUGRmd0h5alZwL3prUCthWGNMZmZpaFMyS2lrUnNP?=
 =?utf-8?B?L1FXcWJTdW1VamU0VUxMT0tQZjFsWVFROHF4SXBHK2JESWdFSlZXL0VBOW1u?=
 =?utf-8?B?L0ZUVTRMVjROa3JvRTVDVkJ1UzBEdlpqaGdPVUtMOWtiMFdDTEpIekh5STNy?=
 =?utf-8?B?SkRLVE1OTllhYm1FRHVHR0g2cTh5blBQZEZ2WEl4QXZjRTU5OFdMQkdnSlE5?=
 =?utf-8?B?M0VMMmRWczRiQkRVU2cxYUxFbkdXbkRWZnNGSnU2VzUyVUFNcUNiRElvNWk2?=
 =?utf-8?B?MWdmYllXYXhpQy9mTWI3UGd5R3FZZHEra3ZSR2lYU2ZNUVRrTmRLSzZxSGRR?=
 =?utf-8?B?aFFMNHNwOE5jZ05MV2hSdU9YdHkxK2pVWkU0cU96MXJIUEhIQ3ZFM2VlZ3ps?=
 =?utf-8?B?aDZuL25tMUl3ODNaMHdWbTFmbGsxR1VRcG1IV2RkMHhIYmVJaTNVNUhqcnFT?=
 =?utf-8?B?WTd3TTlzeThueHJnOHBQMmIzbWpka0Y3TlY1T24ybjJrNFh5SVZZM3ArbzNN?=
 =?utf-8?B?SnpVdjFoeFlFdS9obHlLQ0tod1krZC9kWEVFZEdabldDbENYRUZZL3lrL0FM?=
 =?utf-8?B?VXRRaW5CUlhWNmVrQ3B4SjIzTlRtZldNZFNmMFdienR2cnBzYXdGY3h2ZVZ0?=
 =?utf-8?B?MWRsaVI5aVRCRVpKaWw1UlFtODlTMmhKaFRIL2U3RTZjYjdQcC91Slp4YjVy?=
 =?utf-8?B?andLY0JLbmhwQWlMa0hqcGpyS3FEM1hpc2Q1STg3RmlMcC9JWlRzOWtMU2VW?=
 =?utf-8?B?UFdEQTI5ODVmbmQyTGZxbi93Y1B6WTFqeW5HRUY0YjlxaHZJV0poTjROai81?=
 =?utf-8?B?VDQ4Sk5NTTdxaUpzYWcybWlZMUwySWsvMDltYmwwSjh4cDVlTWxlTFdicUxP?=
 =?utf-8?B?QmxXaWY0Y3UxM2doSGVGbjBjdGpQemZiM3dWSU9KU3kwZ0xHeTZmSWcvVEtP?=
 =?utf-8?B?Ykx6WGxqck8wUTNZa0xDVnRYVVZpYUdGNnJBbGhnNk4reTgrdzJITmh3aFgy?=
 =?utf-8?B?Y1NlUitoSzJYL1hpSkV4V29oaGIxV092cDE4ZFg5VWFNSkJTVWkvRHhEU21H?=
 =?utf-8?B?ckh1MXhuclB0K2Y2K0NPdHRhOGN2Mlo5MTJoQngyWkNzQnhqTTVSZVhyV1BL?=
 =?utf-8?B?a2gvZDl3dDJ6NEtGRGJTZ0QzdDdIODVFSDZhcXhxVHJ3dVg4VkEvYktIdkRR?=
 =?utf-8?B?ZHQvSWFQRWdBRkJYWE9DdjBuZkNiSGRta3lYeGVwbkE5VWtraU5jdFQwNG54?=
 =?utf-8?B?dkJqZjhxaXZxbkZyYURMQTF4WE1jeEtkUDEwQ0ZhV3MwbktLS0hkVEJvY3la?=
 =?utf-8?B?SFBnUzRiNVhJQ0tEVGN2WXVVbHVkQlBpRnloMzZ5b3lZSFB3QmpBTlZxdkVo?=
 =?utf-8?B?cXhXMXdXVUdrbUR3TG04UUVxaTlzaktES1laOUErS1pDSFY5YlVGSzgxVkE1?=
 =?utf-8?B?d3JZdGxqVUptUmZ3WEFIaW1BMFdJWHZ4REJPc2VNQm1KckNqaDFnQTQ1d2Z5?=
 =?utf-8?B?WHZsZ0w0Y2NydGIwUVUyU0NoQzRrS1dXMUFFLzlzSTQxekI2MVd3ajFJVWFa?=
 =?utf-8?B?YVFEVFBraXhENGhta1lYVnlDVUZaelJ6T0p6Q01XYXoxVUlKNDNQbm5DbVVj?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+ZHd7o+RwDd8UKcFG5O6RkhUv3Fkr/vldpw4sjW6/OmL9/H8vpM2oq8PJ+AE3X5KOGEDLNhHYNqdfHloRniiOdX5fnRQxKaijQhB3pWjNO50PWqdy8l/elHjWHeYatNGmzN7sfYWaQexbVL/DmA5zKqt7o7HIsbldMfe1tLrfN4PddXx8ddWdjQSbJb7OmrajgnO1jqSbENb94jIAi7mDm6cN5yibmF9AVgcKjjV7S9Sb0vpomuoLZUmQTsFQwcbyzDKOIMV+/BL8W+LbgTFbgY9RQRzA/5e+sUd2RD5ztxIZ8KnpgYGL3erTOnJQRXhlYmqOYyQvMoN61vw2FgMxCsnMZ9sFpCKfyGtgtVWGtw7kJh25ISNcVmkN5jlTZCnrF4PfLB+JZhNczoml9pfHFChqL7mlqT5nZPM5CQcE6DiMa6OJGS0UHGe+mt136I4Huqs626su1RIdDGj7SDkxfavuNyJw7ONLHIPOkxxACOfcN0GsgVs1xuE8Cy66WAEiN9eu7+K7ol6mAdiXDgd6SMw4YHk+Yn2sW3WqJeLgd0NIGDlIyK0fRBu3IiCBCQ+bq7EFqUVPJuL8o5PKTaqSMOXXK4U91YVOlMo7hgpXlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae686a-0524-420d-2ac0-08ddd0e84013
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:43:28.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XwoxqWcfeyrjK71PzUdCYEPoJs+1Ti4yftQLAbbUocGAYym9APbdkGPDaNm90HWJG5+9RzGEVO64ytRv8MC5plcaehVHM/yx7Pfz3+FrSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=931 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508010079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OSBTYWx0ZWRfX1awSBQ7SHYkj
 UAsd6nbDd2WFAIVwNqRM6HEHSCOfmpFkP+D3NzZ6b6FdGFntaflGpopMHKG5DXle2pbl+mIiiNt
 7A6w1GRYZgAlJmJ+HADII7ICJ71YZgWjYJyR4ykmJv1GpBKJ8jktpryuqHBdzAe7fRjRW57I3IH
 kclOVNe0uRJzV/YgDfu2KUYfs44j0OAwsLYYgBVpuHcHkuT92BZ3UA8iRveeS2mejzsNpxEjPBq
 +q0LZfpvDUcywwOU5xpB2ZtvusxPMUB/keZ+bOh6JN3PinFHXdrjm1Q7LGJE9KFFR8D9UnNtw05
 8ds8vRQww9WvE1GYE+bu2ff2EGg9lFRj3smhx36mJ5BXvzNKnx9L5wbq/XY7sqK2Kt1TJ+pzEfS
 RuAFh0JzjUOPt4uByGjo7iyHCgS8IsbhdS/uAOXYu2b+VICxoroxtlxdPaHzH62XGks5iqLc
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688c9a54 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=z-zyjLM9Pc1ZBy-HkOQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HVHROzVmzMIDhZz_U7TAaSre3_I592Wf
X-Proofpoint-ORIG-GUID: HVHROzVmzMIDhZz_U7TAaSre3_I592Wf

On Thu, Jul 31, 2025 at 08:20:37AM -0700, Suren Baghdasaryan wrote:
> On Thu, Jul 31, 2025 at 8:19 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > Limit the scope of vma_start_read() as it is used only as a helper for
> > higher-level locking functions implemented inside mmap_lock.c and we are
> > about to introduce more complex RCU rules for this function.
> > The change is pure code refactoring and has no functional changes.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Forgot to add Lorenzo's
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks!

:>)

