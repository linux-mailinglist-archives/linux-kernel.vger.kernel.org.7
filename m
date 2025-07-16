Return-Path: <linux-kernel+bounces-734030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A529B07C30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0161784EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC72F6F92;
	Wed, 16 Jul 2025 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BwnfTk+Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2RP9Zie"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F272F49E5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687529; cv=fail; b=DWtriVr2uv0mwbuttvhxWgqM9TuFaahJiO85+rmgmGYinvw7XfeJpCcVk1EIN6iqPwufcYC+AZCtwCTsZ6zN41m+69SRzgwSm3Eflzrj95pv5NSteIfUchHwtcOJDut2b4jsHSq+jsy7sdSZLrP9+zK63vAxTYYja5KSWbcyEK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687529; c=relaxed/simple;
	bh=RCjMQAbvYSE0EApZO0Gc4dNFV8tViy9tFQSMa0lQJHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfgOfITGp7PB5vjFt5OG5B/afkIgs/jlYHK3hPPxm6lo8H/maWtsR/IAFPNTRli7d6FJRJ4+c+UykZ7iAHmHCe1YD7JR1gLQxUcO0th1i/xHSbD4nMd1CgA6YCIBJJL+mQb6twbzaBB1YOOcrbXfSWE5A8yBoxvPUlrByq2LOFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BwnfTk+Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2RP9Zie; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqcTF007289;
	Wed, 16 Jul 2025 17:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WNpQsodzm6myiZ5UM/t5ly6fyLLkvwno58txn13/cBc=; b=
	BwnfTk+ZeJ2ZvCGGlpUBOl7xI/Hpm3E98Uij72Ad24FH4yfwuy1MX/KrvpmLWJco
	pXLqV+MOzzGwldvmS1sJrrH/SzYT9hTwP7vpao8V47ubGaHY6N82q6bn2pstott7
	Cv8tcBIIrDdFG4zCI3hBm95gjATUxGUL4n13RrcG+uQFUTf/hJ5QEReUcOkQm1vu
	sLeeNObqJ+BPbfCXA99Lg8N/8wW1XAmoxdgm99ELS+EBTIVgodGdvrJs7Pa4rfCe
	l1n/EVD2ABJuu3VZ0IPvdQk+xtrwq86hvgy2de+06yZNysbelsRYmswS48o6e7oY
	ytJd9WAU1yhRI4UGfOlHmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr11bmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGjssc029769;
	Wed, 16 Jul 2025 17:38:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bcnq0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 17:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8GiQpKANu6lR8JhLqdXAMROuAH0u+tomAoZk50d83g9v5DcIpLT9O0R66hiDP0VgspwYyjo9irK+aq1POAled49otiDca35/MvN3RxESfNIqEXjpokhGtrSlxDx96oBO1Pj1Kv8tHB9W/j0GTOAJxeOy/NwEMFCG4eGAuehzIBGqETqE6IqAWWf7prbRkj7R3iF+8Yt3oAhtPtzdH6iz+o6vpD2C6HRJR1ZlH7762sHKYbxtKu6P/vOkAxwb16SFdX8jY5VY9QBD4ZnTlvbJhv4AnBjQhKXJscKyAtNYJ9SbY2Fbu2oBnUhXdAgpWcItDWghgx1jznFvHe/Dw+mAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNpQsodzm6myiZ5UM/t5ly6fyLLkvwno58txn13/cBc=;
 b=msHggOrC81z1FH7NU05qAoLscaQGc3xU0RGAVCmBvDMoV3HMIUt3yVmmFgAGq+PCuIPsVAx6DWt4iBGTwGdEEkRS3zU8gKrO5fCmTluQhcPjP0nhmMoCun4eYcvsBrrTK++89JN1Mn0A6TJz6dQ06DsxjxPOBuQtJny8MMZDj+V5QZ+Xk02MuoTGCO7/+mMIKkTLZM2+VQ2CpY2Xk+H8P2fftxs5omugjU/pkwSU/bYtfGlVcj6Mo2A64Xx9iW1hySu9fxOkSFyVhUuty3uDLDwhewC+oIVzodv48YhYl2+j9vizbMeieRrdtLeu+bApPWmKivkKxFk0OSeg07Vh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNpQsodzm6myiZ5UM/t5ly6fyLLkvwno58txn13/cBc=;
 b=u2RP9ZiejbPa6Uw1h0TqhnoEideaAoeVqpNtdRg7x8eBn3U8Vi7Lu+tJ71oY/4LgmHc8Ol6nuXerngFRR1RBnXKg/9Tl8jQF5NZpUbNDMPmCk9Unkz3XAaOniU2vr4+CSpP0ajYbyRJPcrjb6E1EBGizKJ35a+1Qj7B8Kpyz03E=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB7683.namprd10.prod.outlook.com (2603:10b6:806:386::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 16 Jul
 2025 17:38:22 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 17:38:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 2/5] mm/mseal: update madvise() logic
Date: Wed, 16 Jul 2025 18:38:03 +0100
Message-ID: <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: ef18fa52-88c1-4514-bee1-08ddc48f8f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bUgy7AZNlR5vfP2Jogwca4o6QYvE2TSC6IxsBx5/2bTYxwCWqCzZiibzbJIS?=
 =?us-ascii?Q?HGIWh2GEqPFsAlLkFadH9N4j41MgdFRkpo4Ln+bifS183kTSoiNP+GbBXAyS?=
 =?us-ascii?Q?1kUEWzB+lMT2gdoxxIFcnHJDhmyI27pTuClDasM7pjZQBBTiXRDvtPTHQWY3?=
 =?us-ascii?Q?4LNeKvQyG5kD/PD9sowpIwDXTICkYy4TMaXweBZdON4Tac7pAxMaIGXu5czp?=
 =?us-ascii?Q?SwGBclcWh1KO3UuZujQ98/Ft99W+Xo8X4PLH+RqpoFDlTb4IbVIdEa6ntz0R?=
 =?us-ascii?Q?gQMwF5BN57XBfUmrEGCYtoHslZw6wO6GSCBMdQCl9L7i0+S2yFV5rUckSXK1?=
 =?us-ascii?Q?ba5GaPlZh94qCazYTIfEq4vfWsygCspzynR2HYqyU78/pl5QNuZxsQU0dHGR?=
 =?us-ascii?Q?ven8/I9e3ziyJ6O3k/xOr+6Mlk5cPoJlogWgq0Al9QvhJblHarb9wFdA1G2O?=
 =?us-ascii?Q?j/91I1xIPfGOdkonuiMVJDIcaxJuZNpcdZMWE0i7IajlYI2vheZWztXRbLa8?=
 =?us-ascii?Q?LJ5+pLuAppV90gnjL0YHoRDLhGF/L4ijbi/y+Y/uy8wyxGg9rMTc6nS2lenV?=
 =?us-ascii?Q?w/Frt1gm8rCuWXUBnBgt/M3fNEC4xgSJFPr52XI3QT0TxXCBJzF5UFbR6t2U?=
 =?us-ascii?Q?4ygNB9hPEq0wsPKnptkFv/gFo94zHi1WnRF8Kp58jxO0RVGbR9QA5mBagKrW?=
 =?us-ascii?Q?koY24JFNldrlhiRgf9E2/AvZ8a0IfTtN9oYiGnsPTVGYlga6Q254M9OJlLVL?=
 =?us-ascii?Q?TGo83MIRtJ8Br8SFhxsFizNLyWIwWg0fa9kfBsV4fXnndUvzBJMYtK2PrYlI?=
 =?us-ascii?Q?BT18qk+07VCel2gKZDR1LXNFyuPom1WCOVUiwB4Zapt1krK0tkoV3xH1ljGk?=
 =?us-ascii?Q?PJ93Njbk9KBcV36IYi9aPhwXiYHO1IFi4eaUVBlroMKg5qstKOfwz1xQJuOd?=
 =?us-ascii?Q?EreUDzaq60fX0XQl1ICUprrKDDL3N0sDiB++IVeE5+xKfslnJsmEbECMsui+?=
 =?us-ascii?Q?Z2mvwdvzsUDiu7swjPS+rkT2X0k/icjRWlo6mvvJFXYjPo1yPyT4lO2yIvpa?=
 =?us-ascii?Q?yuqzJT5xlbcB4xzqFB6G+2ySoJy9+nKacIzXfnejdIg0C1huxiAhcN1rRvSm?=
 =?us-ascii?Q?hd45stH3PhopA8aig9OgvyiaX7FbO9/Aa4Z3H2TMg9qFGDvuhAOSMGY3YrGD?=
 =?us-ascii?Q?KMp6ZSC/qWIWfgqnWAMKPDrGWj3RDSyiKlbfdh5ksayUhdH8tY9yybZSNNWn?=
 =?us-ascii?Q?nrtArKNo8zCQpfgegEez2EEpmVZ6AjlxFpVWaKtBXZjn9zYDp15JMzfHWaJ6?=
 =?us-ascii?Q?BponoU7+yr3U8R1nIaLoJX6YJS+bLlTu/R+Mog6CFt4qV7rjNvP4bpVLbAJC?=
 =?us-ascii?Q?HaNMeSTQyjn09iLMiw3QAA8nnizfXwlLEhKfq14JtPbsMqdFcP5ZBp4wLqDh?=
 =?us-ascii?Q?/S9NPcUUpUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8tP43tFB10r9bvxRQOXi8x5+Vk3zdyTcY6OUl4cResqTgk8C9WargX5VK09x?=
 =?us-ascii?Q?mRInCC3h5t5HF7Xg1pWhMZb2SPanrKmAZX+sOEarZC1Et1JCMIePx79ortac?=
 =?us-ascii?Q?0I+FEnCGVd7NVXamkxcQzLh+4xtKPQEKWYtnfCWPKa0FOH31FRtGvTUK90OO?=
 =?us-ascii?Q?TlI3runQ0mlaBdz5FiuArfhWSf0JD0+5lKNl12yq9eNd+4+3SDmN6qVHtxP8?=
 =?us-ascii?Q?g8+zaM7PvWbEuQcw9nffZZoXQvK8z4dkW2SOaT37k2TtluY0PMq1xgsGC+8G?=
 =?us-ascii?Q?eDmkSW74Ghdn6Sjzo4nqxq6letPhiIrNa23EEB2sW/G621xr6lX1XUnTbRQP?=
 =?us-ascii?Q?4VeIN09Zl/GA75uj9CGEx3MQ9hZL/rwEdChrROfVQV6DGTjCE9oLdHifw2kQ?=
 =?us-ascii?Q?LUIc/6J71byQ3uyXrBjBvDnjsVMdinjMvuKRIMkT2j4TzNBt0jUswA513o7c?=
 =?us-ascii?Q?w7D+rym03iAGGOxxM3eTenza/yjpKUc+5HMv2W0uPE2KZ1L1lQ+tBn0MV6Sf?=
 =?us-ascii?Q?7JWvt5dFNuEJXj1nEvRhXKr9wnEX+CnJ4s96ak+wmYaqGQ1jpLsiSQ8VE69U?=
 =?us-ascii?Q?+AR7zBEtT6yLYDjiKCedKvIG6TBips42haumSqAuBXzUJbD8wKsPIEP/hQvu?=
 =?us-ascii?Q?3He+mkciOr9PMwOkAcwWoOIlOkf6EWqPhLa33hOT6QQkzPERXwfeuN+sER1B?=
 =?us-ascii?Q?ebr3K2c8v7AbverZNrtFeQnrbmte/3fWNGJTlUJXuomsUXo4VVB+MNEygKMl?=
 =?us-ascii?Q?DfwNt4/1J6mfUp0Gsk1pNje/gpOOCjd5lDdmSx8NT9kOlvydAoPcPRszV1YI?=
 =?us-ascii?Q?ZDhbBYigUQIwyDmwbxj1yN39t2PNQN6gTde5vjglIdbOY93rSbU4dN12gort?=
 =?us-ascii?Q?YijJhbJLel3yAMbg0/tGKagRAj8OvRCLErmQB2Qpwm72rfHIcj68X1YZD3ZG?=
 =?us-ascii?Q?V6SI/EWW94wHnkol+NToOFjI0vovVG69p0L7SoRna7ZO+DiLAw8D1+nVx+Td?=
 =?us-ascii?Q?8yLMKmmI2B4XZZmy7i5SaMCOtTvAMlorlbL2xI6Co5IHkZBpDKEVVxbqJOVx?=
 =?us-ascii?Q?U+4oMLLfTvN1EKDb12XeWoieJ5aZ5FTwdzwJR6tBwak3RF9xChdUjn3PR+Wn?=
 =?us-ascii?Q?ySWaWYUEcpgtibi/fGhe8ZwcP9nHmZwUdu0NibH1/AHoBGZWMdPnPagI4Epa?=
 =?us-ascii?Q?7ceBlJGovImTluaKjZDyVoAW7rv/4cQWOVrBoeYNNuhtZQLB7j3qh0jNfT6T?=
 =?us-ascii?Q?p/LHQoPi1aAX/+Z/013VVA90zR/HNwgYCn+XrSEG3QeGW95cHFjxYoehF6P0?=
 =?us-ascii?Q?1rg+6XssFNGUel7dPKOiLaNxpaD3Rmbrs9eyCMel0XvEKuaqj5uIfQBlWcjn?=
 =?us-ascii?Q?J5lzBatpF+r2AFFzHZifWZhrQvy5vi8UXA1KVt6kj1w39sEF30IXhx4kht/2?=
 =?us-ascii?Q?DMnnN85UNrcknOtsKYFZXHDih24pZnKWqcInj3Pk03nQQuqgOMEkVypf5q60?=
 =?us-ascii?Q?m5SGk9UWplJln2T9Ye7RG94vkKfMBY962B3hCsuBh4q5sanIbBJcWDBI/L8+?=
 =?us-ascii?Q?M6mKaf/iOwXXqALFHady5DjMvWB79b8SfYjre0YAWiXyWuYTM/ZJRr9WzIeP?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	20B6Yn7KMxEOXKWACGqwtYqhTZWtkXmD4cCfpc93YKaaXFFnYLMuXvfIeEsXZTzgpAkGiKajcwiy498LOBGvs1y/aNuJ7AoFStqHziwquR4/0nL87HIYehyOf0CMmZPQbAt3gLpEGS46+sK7muHBSl1N6AdoiCUSfm6v5FlWuxdjaFNmrnsvqb/j3xZtAas3P0khpKOmgwZSmu0b9oR/4ECgDO1m3MHBMlVwxRCP40eDWpyYl5c3urg448TR+mVoWOVjtU1PW9ojJpJGPXU8mz5/xKfwpI1J/ahqpzx+AavUf0MKButmRVOahU23xkkOAdQL2yfN3wMyTxEkb3SNTc8r6LhTWFads3wSosWKVRsCzvENAFaWFkJ1AvUuShBLDR40+eHKhUKkHi1iQrBZ6vM5yDAzGcGAlI0zHUJB0jFhzvGgolgOXKW27pWkPE7g/3nr0S0/2eMq18K3VDNuXUewX1KZeX53XIT0LrYSNlt1YjALgASpSnxePyRbm6Qzxnw11168sojUEr7PwXopZ+SLltiIVwc0qCBv5hjxlBwmtg39qG82PQ6cGkRI16fKU27XnKiU077plycs63Hc/1xREgOTemyqk/1qyz/i4kE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef18fa52-88c1-4514-bee1-08ddc48f8f9c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:38:22.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6eQw5LVsJ44HVG/MkHekyZ05RJLrnFk6vDpLfJMifVzALuMjIxr5+tGC042hsJO7OPHaVFXn1sWsRK6V8yAtysFYTOKE+Emz7pDcHrXvWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160159
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6877e39d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=2PFmxa78D7MNR3FRbQQA:9
X-Proofpoint-ORIG-GUID: JCmjwyYEHGNrVlSoJeEGJPaYBnPTJztJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1OSBTYWx0ZWRfX9uGPS16kAPg5 NoFa0ryxvM08KqZebofeJ61w6B4e/po3HDK7q9M9Wme1gus/jE6nl1++i47InCPcbwyJ7oFAuZ+ jTElU5SHfUmw2JeoxFfBvTqOM4UuyXYtQJG0G7dZfO0GzMtj3erwpYbzbiLAnZklcWtynHIP28I
 hXM8gym52ana3m5mYzAkBwab9xIm7ZU+gbtefvnfx2N/UUJ5xuRGpcYmQ8SLJZYALWCM5zB/Rr1 55ssopZql3d+tcJFNYT96aE/c9P8tPPxUuCWIXB2cBk8uVsk29oGGUhY5EmzEbwUUcsy7Tu2nM2 fdszjPNiLAovjm/zhgdWbs7EiFB05UBfSvBk2L9hTtJwLVSDCgqHhucfHTKFjZPyNEQ5Tjk9LEh
 GP9FVijlI/Brt++xXToG3d6ZNRNCSE0EJJBTmw+dvcHRETgxAADt33a/pBpi4FyzAtDz+ApC
X-Proofpoint-GUID: JCmjwyYEHGNrVlSoJeEGJPaYBnPTJztJ

The madvise() logic is inexplicably performed in mm/mseal.c - this ought
to be located in mm/madvise.c.

Additionally can_modify_vma_madv() is inconsistently named and, in
combination with is_ro_anon(), is very confusing logic.

Put a static function in mm/madvise.c instead - can_madvise_modify() -
that spells out exactly what's happening.  Also explicitly check for an
anon VMA.

Also add commentary to explain what's going on.

Essentially - we disallow discarding of data in mseal()'d mappings in
instances where the user couldn't otherwise write to that data.

Shared mappings are always backed, so no discard will actually truly
discard the data.  Read-only anonymous and MAP_PRIVATE file-backed
mappings are the ones we are interested in.

We make a change to the logic here to correct a mistake - we must disallow
discard of read-only MAP_PRIVATE file-backed mappings, which previously we
were not.

The justification for this change is to account for the case where:

1. A MAP_PRIVATE R/W file-backed mapping is established.
2. The mapping is written to, which backs it with anonymous memory.
3. The mapping is mprotect()'d read-only.
4. The mapping is mseal()'d.

If we were to now allow discard of this data, it would mean mseal() would
not prevent the unrecoverable discarding of data and it was thus violate
the semantics of sealed VMAs.

Finally, update the mseal tests, which were asserting previously that a
read-only MAP_PRIVATE file-backed mapping could be discarded.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/madvise.c                            | 63 ++++++++++++++++++++++++-
 mm/mseal.c                              | 49 -------------------
 mm/vma.h                                |  7 ---
 tools/testing/selftests/mm/mseal_test.c |  3 +-
 4 files changed, 63 insertions(+), 59 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 2bf80989d5b6..dc3d8497b0f4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/mmu_context.h>
 #include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
@@ -1255,6 +1256,66 @@ static long madvise_guard_remove(struct madvise_behavior *madv_behavior)
 			       &guard_remove_walk_ops, NULL);
 }
 
+#ifdef CONFIG_64BIT
+/* Does the madvise operation result in discarding of mapped data? */
+static bool is_discard(int behavior)
+{
+	switch (behavior) {
+	case MADV_FREE:
+	case MADV_DONTNEED:
+	case MADV_DONTNEED_LOCKED:
+	case MADV_REMOVE:
+	case MADV_DONTFORK:
+	case MADV_WIPEONFORK:
+	case MADV_GUARD_INSTALL:
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
+ * circumstances - discarding of data from read-only anonymous SEALED mappings.
+ *
+ * This is because users cannot trivally discard data from these VMAs, and may
+ * only do so via an appropriate madvise() call.
+ */
+static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
+{
+	struct vm_area_struct *vma = madv_behavior->vma;
+
+	/* If the VMA isn't sealed we're good. */
+	if (can_modify_vma(vma))
+		return true;
+
+	/* For a sealed VMA, we only care about discard operations. */
+	if (!is_discard(madv_behavior->behavior))
+		return true;
+
+	/*
+	 * But shared mappings are fine, as dirty pages will be written to a
+	 * backing store regardless of discard.
+	 */
+	if (vma->vm_flags & VM_SHARED)
+		return true;
+
+	/* If the user could write to the mapping anyway, then this is fine. */
+	if ((vma->vm_flags & VM_WRITE) &&
+	    arch_vma_access_permitted(vma, /* write= */ true,
+			/* execute= */ false, /* foreign= */ false))
+		return true;
+
+	/* Otherwise, we are not permitted to perform this operation. */
+	return false;
+}
+#else
+static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
+{
+	return true;
+}
+#endif
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1268,7 +1329,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	struct madvise_behavior_range *range = &madv_behavior->range;
 	int error;
 
-	if (unlikely(!can_modify_vma_madv(madv_behavior->vma, behavior)))
+	if (unlikely(!can_madvise_modify(madv_behavior)))
 		return -EPERM;
 
 	switch (behavior) {
diff --git a/mm/mseal.c b/mm/mseal.c
index c27197ac04e8..1308e88ab184 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -11,7 +11,6 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/mmu_context.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include "internal.h"
@@ -21,54 +20,6 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_SEALED);
 }
 
-static bool is_madv_discard(int behavior)
-{
-	switch (behavior) {
-	case MADV_FREE:
-	case MADV_DONTNEED:
-	case MADV_DONTNEED_LOCKED:
-	case MADV_REMOVE:
-	case MADV_DONTFORK:
-	case MADV_WIPEONFORK:
-	case MADV_GUARD_INSTALL:
-		return true;
-	}
-
-	return false;
-}
-
-static bool is_ro_anon(struct vm_area_struct *vma)
-{
-	/* check anonymous mapping. */
-	if (vma->vm_file || vma->vm_flags & VM_SHARED)
-		return false;
-
-	/*
-	 * check for non-writable:
-	 * PROT=RO or PKRU is not writeable.
-	 */
-	if (!(vma->vm_flags & VM_WRITE) ||
-		!arch_vma_access_permitted(vma, true, false, false))
-		return true;
-
-	return false;
-}
-
-/*
- * Check if a vma is allowed to be modified by madvise.
- */
-bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
-{
-	if (!is_madv_discard(behavior))
-		return true;
-
-	if (unlikely(!can_modify_vma(vma) && is_ro_anon(vma)))
-		return false;
-
-	/* Allow by default. */
-	return true;
-}
-
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
 		unsigned long end, vm_flags_t newflags)
diff --git a/mm/vma.h b/mm/vma.h
index acdcc515c459..85db5e880fcc 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -577,8 +577,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }
 
-bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior);
-
 #else
 
 static inline bool can_modify_vma(struct vm_area_struct *vma)
@@ -586,11 +584,6 @@ static inline bool can_modify_vma(struct vm_area_struct *vma)
 	return true;
 }
 
-static inline bool can_modify_vma_madv(struct vm_area_struct *vma, int behavior)
-{
-	return true;
-}
-
 #endif
 
 #if defined(CONFIG_STACK_GROWSUP)
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 005f29c86484..34c042da4de2 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1712,7 +1712,6 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 	unsigned long size = 4 * page_size;
 	int ret;
 	int fd;
-	unsigned long mapflags = MAP_PRIVATE;
 
 	fd = memfd_create("test", 0);
 	FAIL_TEST_IF_FALSE(fd > 0);
@@ -1720,7 +1719,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 	ret = fallocate(fd, 0, 0, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	ptr = mmap(NULL, size, PROT_READ, mapflags, fd, 0);
+	ptr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
 	FAIL_TEST_IF_FALSE(ptr != MAP_FAILED);
 
 	if (seal) {
-- 
2.50.1


