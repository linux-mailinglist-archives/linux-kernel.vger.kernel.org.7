Return-Path: <linux-kernel+bounces-730416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3843DB04486
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA9B7BBB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5FA25332E;
	Mon, 14 Jul 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VnATG5UU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t38TQasL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2675C25B2FA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507189; cv=fail; b=mtiKbOFLtZsPbLlCDOBfgM8QVN+bwniRTnTT81sVBIOF0q9g4Vw38BrV9v3rXCy620Tc+2sEuVY23vfQ4i18gPaDOpyK1FCkgPCoM+Vbp6h7KpiVap6cRHsBjWGC66gET7vNNZFajqdbAEnO6KE2/NSTdrMFhTwwUwa3DVuDoSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507189; c=relaxed/simple;
	bh=o7Bduz3j2UiFETWeJacyG1VhBDU2QFCHOFyY2WivA0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KmR0umXJrXRKzSX9bWcKBuJMJdHGZkVLLfHEmqHoCvcVgA7PhihQpAiTq5ieRQwQQvW4OCCxxE7hZ7iNQ1L5gVSPThSBq0sI4zWewkXf8FhX9FvJ58Y4Qt9WrNWi68yH+2shOkWGJjN9pzSKAVtdDLENDxuFFVLfbWQWlpc1+R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VnATG5UU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t38TQasL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z587019040;
	Mon, 14 Jul 2025 15:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=o7Bduz3j2UiFETWeJa
	cyG1VhBDU2QFCHOFyY2WivA0s=; b=VnATG5UUbHsLnRa3PkT3OMBoK/iqFh/VnZ
	IdgPFf098yrqc2m48d5IU9YLMzPbHnK8yIHAWbNWXUC8i+lkkYkmGWcRbx5n4Xhw
	S6AOuIYGqdXDauzNYTEzU1XcCaieAyfuXRCWlKWOGoLhUSdCE9f+qjzaNBdiRxAr
	fXaYxWBchR9G7ExMgUzNdsq0HHgslrYSG7s4B7bXzYuIlGIyLQyEAAvTlnzaJpOW
	/lpxc37Mu6t1EDhAwfeUNnVqrdPjxdBHGncS3GnsayINtGmeA94/c7phn2yAfTSI
	a317cO6E1doVhkDgNHk5kHuWodUvBnC68mAuwvtRuPVUFePia9SQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1avfqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:32:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEqVNK029568;
	Mon, 14 Jul 2025 15:32:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58ncsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfZ72Ctufn0XEX8B9kLchG5P50F5GPXBd6tPHibAnjimNMOv98dS+L77btecU9TwkPZwtaTKt1V8Qz0P296qKXmy3o9fV/k9SVG5hOWYAu6DqcODjWW2PnTayzJ3CH4iPGwTqEJ7sZ+1DcK/PivbCI1MRxJKHYreFN6lxJsvaidWCvJQJ4xwjN16e/rwz8ys7UGatB2wu2CzQu81Tz1OkfRmCJTJCH4wZJvd2uwFOOXzPNMdIcZDu8vnNpdnb/65nElNJ2TINJupj+003InIAwvn9cEo8EaqfM7N9s0ZgSV6t2QXgTauLUNgWZmjo6aXtpJv3JEE66jqixUL5QBMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7Bduz3j2UiFETWeJacyG1VhBDU2QFCHOFyY2WivA0s=;
 b=Y471lx4vwm9MgkPXkjaaXER5yB3+I4G6cZa9T7lwYUioOm5DVW3DLWSKlt+1snV6O79ePKbbFw8IDQ85Z/XSeV/P9ZoiHeWcpcSsGN0mAlfrYUOoHNbhJdz3RzzJug838vQBBmgA0eJfbs2SaBOapYGBIf3oEVSpTfTRua3kBXWDn6T3Q+t/hQ9TPfW1KAZs0HWIjveLnxxnGdq69CLLdBZZi3K9nxWsK73bDCjoqeleEedf0ZCi6tzeMWl93QqLdhWaXBdEZBqRJ9qRc37GJa/fA8vFvmRbayFGcfHYkrM+P1bvDiUi4vALyM9IwIM91g5NI0szbKHaJf5IS2t6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7Bduz3j2UiFETWeJacyG1VhBDU2QFCHOFyY2WivA0s=;
 b=t38TQasLRtNdv8uNhkHFr7MO+JfMjgQnIh518uADTCGe0pNkdUh4dTmFc3xuAtzmnT3f6ks3BSiRNojDsdAfh7NQJ+3lVbt7i5EndNc57eSp5nbtrip4M2kXXAjMb6FncPJAprT8/PsQxu8p6Dh+q9W5CNUDXr8Q/Q8NYYz1RL4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7930.namprd10.prod.outlook.com (2603:10b6:610:1c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:32:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:32:49 +0000
Date: Mon, 14 Jul 2025 16:32:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
Message-ID: <16e8ac61-d0ec-43aa-8467-17a3c2ea5962@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
 <ky2jvl6uyi75qwfmpwzmwu6qfnlwxshk2zunywe3pve2pshdxj@p2ihhzov3imx>
 <cd3516af-8481-4418-9f72-a7738a9fd024@lucifer.local>
 <d0b345c8-29be-4ca4-8243-de16583c93e2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b345c8-29be-4ca4-8243-de16583c93e2@redhat.com>
X-ClientProxiedBy: LO4P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 372ac5f2-6b25-416d-df69-08ddc2ebb0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORtosxvzHbE4aHTSxqFD6e5QfQXWBUY8Nxgj2r4JsRVkarK8nnvJhrfO5/zv?=
 =?us-ascii?Q?Ju9etFRv8FYu8ytOnp5RXF4fP/LAgOsB+j297+toXXa9W5EFnF3XRUmfpDxm?=
 =?us-ascii?Q?5RFblziFeWZDf5Ir2B8CpVJ2GXfFU7vWryh0fy7gsEgONSUKTNqrqh+OQMtc?=
 =?us-ascii?Q?XLhM/bPGcfmFwf+ovXGpCA0i9cwVEtwQRCTwcHE0/dYXXZEDCByRat8VtrMm?=
 =?us-ascii?Q?+1rYN6MjMRq5GrXEHR6DfwFJaDfXJYLlY7Mw+HAJkR10X2zYDbtqQiyF9eRo?=
 =?us-ascii?Q?LT+KHzQeFTnpTIXe42aLZonnUidG5hRb0rGLVpuwuiH1YCrMtkwE+1fxoXtw?=
 =?us-ascii?Q?CXY7wSno3AntMaDwCL/BTnUG+2R7kkvRx/37LrmUL+aa3hC22HkPKau6G0fs?=
 =?us-ascii?Q?Q5nl5QU0J+T40CoFCIs1YVoxbfUPFTeMVsffLTOZYS06BncZZ6+ZUS7muyC9?=
 =?us-ascii?Q?19lojRW82ICE+KEm74FzB76apUrT/7YRvAc1SVgSrWaGmRHYgQrL4+1WNHCM?=
 =?us-ascii?Q?FFhGq1s/9On6bN2Ob3qjegIjxGT4XtUH8Hr/wmi9J1S73K46wdxuLPbhmB4c?=
 =?us-ascii?Q?fYZjScYUV3WqDuCf5AS7Sod1KBSFnfr10OTgwTs1poI1vbqvXZjApsjaa1oz?=
 =?us-ascii?Q?Tar8YVjreTuA/e1wnSMrC1CPh9a50xP8mvFnQOeAXgykLOoSBCFY9dwdBf5s?=
 =?us-ascii?Q?XLhAqUayogTS2ldbSTbO+2BFgOsyP2I/4YQr3LGscA0GKsILZF84A/g/LtCW?=
 =?us-ascii?Q?ESW1ISYUPTU6EKBzt7I/UuVgkTA3GWfyrTy7DRdbF3WxDBjUX5VUvTCwC/hc?=
 =?us-ascii?Q?XhRNC+zpeD9OoeeAZ7FdKykcbuTt5incI48i1Ui0Ex6/oSr/rkYM9alCBpd4?=
 =?us-ascii?Q?90qR6LA5OCCpJekkLq4CoG5X7HWXVR3US7bX7mEI1ecJy6LG6hK/X+4XDaHf?=
 =?us-ascii?Q?a53KLh1SUHkVm89nv05bOD4TPs5V1iXOwTrmA11uxM34yDvDBsSv5FSmqU93?=
 =?us-ascii?Q?tOQ1A3FHj0sPJ3/YX7moplnshj3S+eISA/9v4blTdRE0/cLnMtP4cWhLwdo2?=
 =?us-ascii?Q?IptJIdlIKtppjaS1Sqd5ylJxkky5KTLiP/Ej26jIAQKBIDN3/pjRClNUh/Tj?=
 =?us-ascii?Q?osUL28tZWsL+Pb79IvU4A5vy1A+oKv+4V0/ufUgwJnvOrtkDDok1C9K6mgWV?=
 =?us-ascii?Q?+Onuzj6bArkyHdXQZ0biG+vQQY9qfhduaqdplOa1gAFjuzJb18YLa6uLJtJW?=
 =?us-ascii?Q?j36kf7tvSsPaLhIe2czK7NypaI75OktJFfdebauYMv5GP5WG0AIrvdkud2qh?=
 =?us-ascii?Q?UNMCkVUOzsYXudVOCw7kZk9JBFaqwoqX1Ay9caRZV8YAlu63MS7JcrdQ8LAZ?=
 =?us-ascii?Q?pNdQyYSRXBR1ATytKNjbauigPCeNjM9++lHXHS4yfcgzYtIcyMXi5JIeUzZV?=
 =?us-ascii?Q?z+Ml+K11Qok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSKtM71zVOyFV3+FvaqOIwopXctUTCB98k/3z85sjwm4nMQz+GhIg/KDr0LF?=
 =?us-ascii?Q?hrAFbL+/iavcolu0WSRf9I1DFICPKPlO4vRE/e3iba1xp+f+ZhVvx2ICom61?=
 =?us-ascii?Q?TR46+Z3Mhc/TxU/gJdOUjybCo2Mx3b+J0jAGQun1ZBCsKZ86dp/wj1Gc9vMs?=
 =?us-ascii?Q?6lkjuZhVvy7/Br2hRNXnWA28SjqU+wOMIaP75VaBBUavH9Somj6WuN7SpgeE?=
 =?us-ascii?Q?F4rZQSwGBMRwuLAJqhpnTWCtyecyZhAUKsjRV2H3DVPKDF0iak2CvihiueAk?=
 =?us-ascii?Q?epl6c9pPT694RZoJjnUlraZX29eyaLQFvW1ReRXjmwRRADR3C8RQJuEdLYHD?=
 =?us-ascii?Q?QYfLlyjKYtlczzUVCceoVuUaix6YVzitHQe3N2Ec8gpWVweXIlzY7cjseJFu?=
 =?us-ascii?Q?j6wQ4pzZ02NnVieLzm/th89qd+X1kKln16PtuwMR8JNr3LfLjaqOJ5HMu0g2?=
 =?us-ascii?Q?95eTeJQO6Kukrs+HTJc8ZdK39oLOnf107o57Lohe3DA2i9lImvttcFpvwptf?=
 =?us-ascii?Q?kQFzBw35Zrkep+pJACd/GxCfN4kcgqcV7mJ+l6luSBc/Tb92CwPrzvGEqIL+?=
 =?us-ascii?Q?Pru15RJ+/TR1GcI9VRv1SWxYi/HfJ92+M7btgnQX3VDcltV/0M5myYwXFg10?=
 =?us-ascii?Q?SujE11tbJNq6qEOO1EMXeARAKBKXfIo9GLSRGJOS26Eg8CrNJkO+Pao+ic1L?=
 =?us-ascii?Q?60WT/AL6tH/rV4KF/0tiM9qc3Fa7ECpp8KH85DEr3fyx+90+tlAh8oi67Nt0?=
 =?us-ascii?Q?m0BQpwFNByF29k+CaN7Z+7vtjSxwu7eYB+Z1Zt0NHCF9br/1ZdPrq0AiRdsk?=
 =?us-ascii?Q?cTmpVvWii7BLFfPQ6hf1/PJxSm3t3PMF0btozvQhgtLtPhtRM8Rj14l7RtNK?=
 =?us-ascii?Q?IVP82QsqXiz+2o8QUNZjwWcwRVygEF4K0x1VlfRO2tvZKUqN+XO6vL8lhnRk?=
 =?us-ascii?Q?WmWgoFD+auJ+KXTaWixJvW6ayeOpmSAua6imKG0DvfgLoDta8iFBSbUdaFHh?=
 =?us-ascii?Q?CsiU1hZbGyfM7n4IpxH3xcyDsXLDxPUO7DGVf32POSEy9TgZLEST1cOWQfgw?=
 =?us-ascii?Q?yZuze3uU1m4ZpGBxFgGJcYxq5cQqarVFsuNFegQd0OWI7LLWEgph8AzdQgM1?=
 =?us-ascii?Q?N4VpdZT5hOHSl0bCLurtGEJu28B//eaBnt9vUHkGVkCHi/+BrfZmO2N1Mt20?=
 =?us-ascii?Q?ryEJgi+4lqBojn3iX8ZEkzHZC67P0jNjJoLFdPpWV0pfzXRX3DTr4hiv2bFw?=
 =?us-ascii?Q?ixEd+b5NU+6Joh9N//2iOiSnQ38Ch1rfjY40RcwEwX5PdgyTegn7p25roCLC?=
 =?us-ascii?Q?WXrH7dhXXQFxix2rdR3vHn7ymDFlJdbpM8IVzzzALUR8GdsUYVVn+kp1mr11?=
 =?us-ascii?Q?tmfwBpoAodKepK7j84wQYJDvjKY9MaaM8Z6329joabUQ6rHzPbrFafpMddMh?=
 =?us-ascii?Q?vPvfKgYEU/npCTb5ruw+ldOoGfP8gH0Yf9ntJFKl55+a35sxDczRQm5pOpN6?=
 =?us-ascii?Q?NuNnKc/Ts/81vwOlklg+L7XsimTveV8FEhq2SxNV7mjKLee9IgNZ7SMAmX2G?=
 =?us-ascii?Q?+L0dZPV8AOjLxwbuVYOjCzgjmUXseJnlMJPs+NczHSTtOe4O1u4QT4HGBwMv?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dVhvSRphVI7aPnwBOk07ma9PVPa63t4eAkZaXcNNONThO9/oQNDeXhXlDXq6AClq9OUJRP9YpDgW5Xe3HRk69i4eRRiRzP6ubAIgYR13rwEdrNQOeHsLDOS4oAYEFBr19d0fK+1SfI4TyLBLsTdVc5AmNLhKPu+8guEgu4tgR2EZ0EqsBqK7SsVffA39b79nl84/HoazupeJZg/H/UjiAJOrqzPDk8JAghIP6uyVk0Mic2zREuubpCjuNd0mKQJvS76HlGYOv+juWHAEBTnQ5LPnHp+FY5NLW2S1mPHU5WSVvyvIyIQ4MFpwBPtUP6M/AHY5pWE2KzkVM7ZF5G44vOKT2h8dOxgff6BEKqK9A514WOkQ55xOwphHnqJiYrgY8KKSM0VnVC9+Il/qHvuu3IuYqKHfLKvf3xkyDjvGz1BUxQ+qqy/V8UeAilFShZP8ECH9aWnfnedhQAZy6TrMkVOX1NWWd2Tf0CR8YAhjy/ePYZk+G4B1F3yD/6BfK3fHeRWTynMXAn2hM2t1qXgvpUAG8JTV6eDYL6v6KSuKhi1mMXScqM8urqi+urXFwUJoYv+2EKULayv9zoMkEN+rTulI/vVT7rbOMbEml7SnPrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372ac5f2-6b25-416d-df69-08ddc2ebb0bf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:32:49.5706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ixq/1D4CG2ehGVOoQnGDDyPrLcOWL9SSMW/wXFdcIbKRswQVAwXoiQZky/nHJQ5eQGBzBaoB2BlEsYFn0pZ4bOh3ZJNT2pqmuNe0D7KruIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507140092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX3tYsf8OREMTR 9NLXUDjJftyWkCDq6JLw9ULQOCiGwVMEpudbuiQBKdM6KFqiYZs71E+hb520EdFM3+RcMrsWgqj wThTVmsapJqQ/LFKi5vd/Ct6zWomWQ/XbsJcZcCmafje6GiUucRwKADbEmDC9t8CZfKOOJ8fBCW
 1LksLP0C1hHWbprn+k+g3q0jw9v++klUykXj3RL9JXpnyH/wOiaKOmbw+Dp1UB/I147Ol3jby/f 44su/IDlGPJg5PkQpj8YOLDhyInixFY2WWGcQNanbgtti+SWAG+solJ+XfPrILdboRpf6Y6yby5 HMyohPmEJsmEdU05Fdb+i1+nAt0Pu+UsXebCcFLAq3r8KuMMCPUXDnYOJK/KKNgItCaX7IdJ1h6
 LUr0iwf2uSYZqfd6had0AzrdzOurKxzhtS+JsS4Y4xW98h0rYeEPZIVduP0gyQ8NAqid/qEL
X-Proofpoint-GUID: vv2VO4jwIAhf3b8c86gYBvOm8_JnZndY
X-Proofpoint-ORIG-GUID: vv2VO4jwIAhf3b8c86gYBvOm8_JnZndY
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68752327 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=FQYwlQVdQORIqknBCncA:9 a=CjuIK1q_8ugA:10

On Mon, Jul 14, 2025 at 05:25:59PM +0200, David Hildenbrand wrote:
> On 14.07.25 17:23, Lorenzo Stoakes wrote:
> > On Mon, Jul 14, 2025 at 04:17:23PM +0100, Pedro Falcato wrote:
> > > On Mon, Jul 14, 2025 at 02:00:39PM +0100, Lorenzo Stoakes wrote:
> > > > The check_mm_seal() function is doing something general - checking whether
> > > > a range contains only VMAs (or rather that it does NOT contain any unmapped
> > > > regions).
> > > >
> > > > Generalise this and put the logic in mm/vma.c - introducing
> > > > range_contains_unmapped(). Additionally we can simplify the logic, we are
> > > > simply checking whether the last vma->vm_end has either a VMA starting
> > > > after it or ends before the end parameter.
> > > >
> > >
> > > I don't like this. Unless you have any other user for this in mind,
> > > we'll proliferate this awful behavior (and add this into core vma code).
> >
> > I'm not sure how putting it in an internal-only mm file perpetuates
> > anything.
> >
> > I'm naming the function by what it does, and putting it where it belongs in
> > the VMA logic, and additionally making the function less horrible.
> >
> > Let's not please get stuck on the isues with mseal implementation which
> > will catch-22 us into not being able to refactor.
> >
> > We can do the refactoring first and it's fine to just yank this if it's not
> > used.
> >
> > I'm not having a function like this sat in mm/mseal.c when it has
> > absolutely nothing to do with mseal specifically though.
> >
> > >
> > > I have some patches locally to fully remove this upfront check, and AFAIK
> > > we're somewhat in agreement that we can simply nuke this check (for
> > > various reasons, including that we *still* don't have a man page for the
> > > syscall). I can send them for proper discussion after your series lands.
> >
> > Yes I agree this check is odd, I don't really see why on earth we're
> > concerned with whether there are gaps or not, you'd surely want to just
> > seal whatever VMAs exist in the range?
>
> Probably because GAPs cannot be sealed. So user space could assume that in
> fact, nothing in that area can change after a successful mseal, while it can
> ...
>
> Not sure, though ...

Yeah maybe a sekuriteh thing where you want to be sure the range is in fact
_all_ sealed.

I'm not sure that really makes much sense in practice honestly though, because
if another thread can fiddle with things, then surely you've already 'lost'.

if you expected to touch a VMA where in fact aa gap exists your software is
_already_ broken because you're going to segfault.

So it just seems overly theoretical to me.

I think we should error out if there's _no_ VMAs at all, but otherwise succeed.

The semantics of 'all VMAs which exist in the range are sealed' would still be
maintained.

>
> --
> Cheers,
>
> David / dhildenb
>

