Return-Path: <linux-kernel+bounces-843377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E2BBF0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965BA1899285
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FA824DD11;
	Mon,  6 Oct 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dwe51NVZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qWv0wSK1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD481D61A3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777639; cv=fail; b=Nn3lfYK9PSL8EiUWlwcagDqDs59nyGY+im8/meGvMbz+HvQm3Kyis05MsLK9GRLX2pQzJGGzvwui+vD9PPA7Qi/0VG5RYhiVR8xpu75OhabIvbeqo51fL0qanrq79gMfmAIUTSZoB6lYMM0BFtboUVARC6L5oWPMk5YfKTgWuLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777639; c=relaxed/simple;
	bh=XOE1IbxAZdwqamDfnuMZZzVR9xkxTRO9FTcMGh0l2qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MsnMedy/hQd/2Y1c1IFk3QMU8RzzPdshGRx2R4bF434/Y4aymgqdGS3/zJNzQeCXA6bUzXN3jSB3wvnbQAuzpXQFrRlefRsaZuTJIeb6ebCjK04yAQm0k70yw0dXQZjLYO++bPJ2w+q2Qx4NylsgUp6yT+oFqgGshhpOwHY5NJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dwe51NVZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qWv0wSK1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596IQv7O028892;
	Mon, 6 Oct 2025 19:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xeUHyrE9xnqMNHutYko/cs1LO74/brPwLvANIGUPrWg=; b=
	Dwe51NVZbaK6ZRtnTDJgQp5ZJJozrPQKF/Ilk5F8vui14gOsaVbd7B5AUStWbWRI
	0nBR4ri+wkCVgJsk20oeRC59DWCFx1DA5ZKxeQE9hWcblvIPgY+YMz33inORo2DQ
	y2sMICGHE3jj/9RrrUP0rWEQXArTN/dsPTH/TFWxI3jQ926h4ildKSmlnH8Au2Tk
	sbMSH0QdWaTgg9+9HvninqFf4NFu1yhBVAYtMDTOo+1lllewPukt3ZgN6/t0DOPy
	35Dtjvqp22HPAQ3qa/eKhQeeJYT8CKo5SbrnmaieUXt6xeicgDAfSWrobS5MdUeq
	YGSE4jOHa1+d/Zxy2G5FVw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mjc006h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 19:06:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 596IEpLo021267;
	Mon, 6 Oct 2025 19:06:49 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt17fwys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 19:06:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXU5kBdIs4CnQXaTjkVeBIjgwDAhcdyDHW+giyFNJdOUw7rndWy/yH4wP6M5II3Cje+LvXDm1IG3+j48nzZvHrfL9BK0teVPvmrmpxN9zGw/lX5M3ozpl34//ouAy+iZgCsLSxWpI2K1X7Hgy+5fTK+5ILK2EiXfhDWtRCsuToxmwvNZeVCnkG5O5dfV6roFcqT7ppi+q24CVjWrTOUKH0twDDZOL0L5/V2Xp48jnJaBJTSIV0MxaSayi4jNWO70Xc5ZwHlNwLBjE1/8DrGFuIVkMFoqXBjIAmfgR41h1kad0eZFZRKT8NS6R2dsRQ3rFErCIho70HrWzad3Pu0boQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeUHyrE9xnqMNHutYko/cs1LO74/brPwLvANIGUPrWg=;
 b=ps9pusTNeMOMZd6TJEB3FJZywTRgwqrtDTToe1ASoNJVgFie/gscbmn6wkT65YRaxhY2JD+e5FpoXgLytq/aLXU+Y0y1F8SEg9Xu2EMQFRGr2V0okaHTNerUdJ7/Yty+JyrsciHrCtI/ZME2L9gKyTZ3sY09XupM313PuWNjogd8wnRAQCzaW+FoB9TMzHFAcvW08LNCKBYsdLF0c270ro0tPvd9BYYlzZ/ewlTy+s2zyHVLrzaaR9pyfytIrPNazyp9k7qID1CCVM8diKLOEyL1ifAHJekZx3aR7Z91P/PZnukp6nEoxAcmdCkBEbCSxRk6D85cqn/KMEdoS68Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeUHyrE9xnqMNHutYko/cs1LO74/brPwLvANIGUPrWg=;
 b=qWv0wSK1n/+3dYU48DN7Hiw46kMllohexPRdVTrgbJthye0nFC/ptzSpFTEqOOnTeQdX+pUnybSmyLqs4EM3ZzupeXeM8w7p+dXCqeGnrKaTphk0gpN0d/sqSDV/HZu6lJkb1U+rSx3PfoghI17PiLqGW/GoQTJz4iSzvB0tlUo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB4866.namprd10.prod.outlook.com (2603:10b6:208:325::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 19:06:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 19:06:43 +0000
Date: Mon, 6 Oct 2025 15:06:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        James Houghton <jthoughton@google.com>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <cq3zcvnajs55zr7cplf5oxxjoh54fb7tvo23hehd5dmh4atvum@6274mneik6hu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Axel Rasmussen <axelrasmussen@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com>
 <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com>
 <aNw_GrZsql_M04T0@x1.local>
 <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
 <aN08NxRLz7Wx0Qh4@x1.local>
 <ad124fb6-a712-4cf5-8a7e-2abacbc2e4be@redhat.com>
 <aN_XZbQjuYx-OnFr@x1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aN_XZbQjuYx-OnFr@x1.local>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB4866:EE_
X-MS-Office365-Filtering-Correlation-Id: ecad3b36-3e9a-477e-931c-08de050b7caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xOBvFmXOKDSLnT4aditPVIeoaNaD8mXiYtjbtXg7woBAoDKmrf/7IzXrL7Rb?=
 =?us-ascii?Q?C1g/cvEECxnCP05u0wHI0EUSkvlnqJMPITiNBZQ/gh+MLX1pllO951eMDrwY?=
 =?us-ascii?Q?IwOK4HAbVAOtAzDcJkdEKArOxxVbf4VKM1xkZSUgFb6bb8YW6BCiKY0OnDp0?=
 =?us-ascii?Q?lpF2cHgNwX4snRYZDDt5+DQxpT6WS4Bt2f74He0KOwQQwJK8ACumbRpbQohw?=
 =?us-ascii?Q?YoKCPbasNWJa2xijyTw+ZYHFPDlspGm0n5lUmrEl40/v1Kd/l4dJ5O/bFFM8?=
 =?us-ascii?Q?e+S2XNCvQwa4e18kS4UM4I6FCnnXGQv8BcMUCp61oBNAZ6bw0JKbRkfmsAZs?=
 =?us-ascii?Q?gUavyxuJNgB2KMDhy9f7GDCE5UszDdrXv+3ht3djzXtLEVzc+Zn0t1RuU6os?=
 =?us-ascii?Q?8hmz5YxM45glk6eX6m4iHT/RvryAYC3HlIifkgGHMZ+W++3skEigNB7JhxcQ?=
 =?us-ascii?Q?UuKGStY3Ij0f3OE2gA2VyauLJUO1oJ/OSSWJbmnATazKL90bUMj/hWMRtSEZ?=
 =?us-ascii?Q?25CHwOLgrpKcmjiHVzfCrmEhL2zL0mmyaMBtWvM8x8rJOS6Uzo7zWzW61z36?=
 =?us-ascii?Q?gJM1MmcVAvLkylxfd5XDp6/FnsiVIN0pRzLGURl7hsYE+ArPGjYsrNIZFLlf?=
 =?us-ascii?Q?6gDWbZU1MEuLJhb80A80/8xg9eOt/zreOWV4ezmkdqYM7+GEtXmDeHrC2Rie?=
 =?us-ascii?Q?62Rr3A7XjrkihNlpIxt9+/25KCvKf64sjz0cuyjRSF3vVYaJPS7pqOo85qLr?=
 =?us-ascii?Q?gHfQ4H6aaVALsEmYJkGO/gXYvuvx7dljevSWwRWIokyOA3+7BwLPR/KtxnJF?=
 =?us-ascii?Q?865xBoChmfSxWSz8bGyYyqOi7vLKrVzMppJj8xYHdMnYXkuupN0juohZ34OS?=
 =?us-ascii?Q?ti51JEzDy9wiNZdxDCbLYjWOLfvINWH4gxAmHw9tKqu28endqr5MALY1Z4LE?=
 =?us-ascii?Q?Lo53bDtaZtcPtQ5yRqD77WCfEoXYF4r7at+h4cyojc6S1fJmB/ILIZnJ/6Kz?=
 =?us-ascii?Q?CdqLFifjwb4V5bjWtUdVlFRJu9VWXgLnSfZql9vuVCHDliHUctI+mjNjLW7i?=
 =?us-ascii?Q?p1cWf6KxwsK8xTuevkxup9PzrUcf5KUW5w32RdxsmEs6qP8pnhOwOjbajcLn?=
 =?us-ascii?Q?xq5dhPkhhr3kI2Uu4+vAIqgDyDGVcPGnS1JBtGbt6WLk12paV9ZCqxVvMdH6?=
 =?us-ascii?Q?HvW7JQzVP1MgJt6oIcWzfDF3MyhYaNq1wLX5svMic+cTjwhifQENfBW89Lbv?=
 =?us-ascii?Q?Ii+BJmJp1XFoEHETIasY3KLgTMKFPbozfT4VhdWOvNf04XkcPQpmhEoVsIcy?=
 =?us-ascii?Q?gmv9hllgqJrChFrUsOvysA22EH/EkUW41PeisrJAYRuryKDVw/ikgoI7U1hG?=
 =?us-ascii?Q?gH6b56k/aoWejbnSyQMXpIJP429ZXJ3gHRSWa762yCLaTIyrR8OV48qYScA0?=
 =?us-ascii?Q?BUHJ5iZqgV8cffWLGNindgd6u0YVn7h5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7CK4tJYmunrG/+e5jvcAmiTE5ghz9SKLYsddIp47/q6DqEvWpkDozWUpIwL?=
 =?us-ascii?Q?+hBGd+984sXBRwCVELcAp8v8z+zYClYwuSFQs4+fkp8blpDQSu9uV6tPhRCc?=
 =?us-ascii?Q?S1lFKND3vwJPYumH6ipSo3E/WjmSilO4S8+hEnExaK0vn/v3rOULL6EpYxei?=
 =?us-ascii?Q?YatVf/PaW6D+ZAy/n667V2aZdpqoJJTy3KubZhYvZIqFXruIvUIBZJFo4OPq?=
 =?us-ascii?Q?DHQ0BNmrR6dUa16bEWuftFLnfMaInWOJg2lQl41zCV+Gyj/BCv4oQyMe2DWC?=
 =?us-ascii?Q?p1TXnJHKaRzxMxbNTcRtQJJqOjD0EtrFGy7SRuwYXCHsuZUrndxDD8+Ta/ho?=
 =?us-ascii?Q?SKdsuOgf1kvIoYw9nWJfLQ2fSDkD18CgqEywsFt374zinp7dvKSb9Fdv2j6b?=
 =?us-ascii?Q?WiRM8/InaAraw/ObLcZwk0qN3BkG5XvW+cnIARDdowWXuYIRSZXxtzLAJvxV?=
 =?us-ascii?Q?TduRIWjimPEhA9OSloH9zG1SaNzxCJuDVRxXeGBnPJEHbsCAr1Zh3KVJp9oR?=
 =?us-ascii?Q?a8aLAKL0eYpC7emIIgF3XWi+x80HicdslrUPh1ldWheEqxSPmYlhVOSgat6L?=
 =?us-ascii?Q?jWAXkc5P0oU8ts/P/s+aSURcCMFiwTzIDkg85JUFfe03FnLfQiIWOZxwD5Pq?=
 =?us-ascii?Q?IeMxPlnK/tNAmeDkSfnre/F6D+1fdjikpfDb2mCYqwDe4p13BJCLkcdhlMQx?=
 =?us-ascii?Q?18mSS9INudIZNQADpuITX3sApGnE7GGOUuhKMx9fkR9YuLnV9uvH7SEh49LF?=
 =?us-ascii?Q?Tmx2cYpq1esmvKRxhDH+9zjGMgTr3A1Q0BPd7aUcuIgY4g702r3/9eNvmGun?=
 =?us-ascii?Q?df43aDk/Nrn/6gZ6cgSoKdDcUAFZnlV7V5lLvbqImQ6EoAg80SaB8PD6DfLo?=
 =?us-ascii?Q?j74WYWE4Ufi4Y8JuCCyLTkcgmQdnfd5sKpdl8sHaHOLY24dcwxwt6cDjke8y?=
 =?us-ascii?Q?sCPMw2txcV+TGL7iPBNGMSNst8nitfBnLpOiLJOlC035BSdZyc4/pJkZWq7Z?=
 =?us-ascii?Q?JvmFRASCLE04NJZMJkCmTXBjeODXhn6+XBhXYklRn3mQ78zR/i+o4k93QzHA?=
 =?us-ascii?Q?znoPHnE6Mihta43vDJTd0FuuQztbwFOtOXn7YNe3AB9sSqoNmxZP2uAmUeG0?=
 =?us-ascii?Q?AtWvNZ5glRxRCP741ZPcUVSW1wlobvJviSxB5Eyh665a45gcoDpe26Z9cAKh?=
 =?us-ascii?Q?zKnGQKegI9rGBrMIMqbCWy0O2SIjD79ksip0ECuuiug9VIx7DpbRy+o0KEZ1?=
 =?us-ascii?Q?HtaPIpI+hnDO8s+iHdRQ935IDGSZTkHHgVibToY+EfqfyE3FMjy/gKzxbW7L?=
 =?us-ascii?Q?UDJ1EPuusyEMMqvTYDWz+j2IbhyXBH1Wgci1ucY8is5lj2UbrxuljQT/TVYd?=
 =?us-ascii?Q?i/lDO/AAfMXEFC8tSnG0eCCMsTDssSQbFCGhRp1e5WyreIp1VEVukS//iaI6?=
 =?us-ascii?Q?4eyL9xDYHJtQ7wD1jy3pWkVEgNYY2jUpxp7nIrPFDnKW3VzyuFWrtm/NxHc0?=
 =?us-ascii?Q?2BUvc76KNztACycBftTpOd7cCx34OZIfPAuWF5lvTBqqiuev6zRkB9MwHKH+?=
 =?us-ascii?Q?yYhIa2T8kG8TWqanavsv2oVmN2TvhQkTfybDcdcB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rj3AzZYBgPndYWwmw1otBEQ1STsKEPR8CP3RVkY+0JMAJ1aSZZrJ6bFBVespdHhcQUVl1o/e9asgAYCoaWgYDmSDqn0ByqGu+LxPGyHkdK2p5yAKT/OeKiI+mRxnf8j891koScRU/qGD8KlxDIu2dO4nRDyLaQWRVhoyorTUsuSGB5BBmvEIexg48wRkNyxEE0swS6W2sT5dOd4en56Eyv1mNrnVSN4xpJ1ffXTnf36AqgjOdXqqGdOqk+zk2ITHPJxllLpgPwThNT/NtYKPS7mMQWsN6PIxlBq5UPgwn014WNPTHqmoqgJ0MhPIlkJ/pdVRucmvjqbf4fX4oi+c56ehNQ2yM8GmHx1mSJUgCbUVRUR+cRdA3nO0LrbdC3AGgeHxSlyQcriN3vh3PyluU/CDbx5caNh0XBoxY4swzO+gY7z6wrZsRrwoAuc1EfhIPeRHaFGQO31kBt2OeR6cxzzl9Y3s6rDpvOi+XYOWWxVG5LBbz000l6KcS667Jsl4ErXPjLg8zGgfJLh71pkOpmxiDOQ3VOardbPqyFUwrVCPgHwBIaqfK2VDupBl3sD5qod3bIe1xQDRedYhvqBtIKzE+6Qq4xVi45EVWnaLHyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecad3b36-3e9a-477e-931c-08de050b7caa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 19:06:42.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5L0W+RUfPzkt6btuKi5e6hMoKy6nExDrtuA/++te6LQaPx8MiZ4PldQleXSdzNxcFwWoiM6vDLw6JGkIKoR0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=772
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510060150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEzOSBTYWx0ZWRfX1AHDVu5kL+A9
 0ZNRidQsBIHfHUb5SDbOKyJpUGl76t7ooV5KVE5LGe15dqXOFvy5znjT1ka9mPV4Vm0qESdcoNU
 h852mge9UDegCRORExcKz19Vm5/M3TVviuBy0pKP6PJntto6kF04sL27aje9cKUD25j9E0zpVmW
 hRhSD93fcRjjUJgw1UoAfaxon95Adpnok9L43hZsly2cqO9OleLH9cJxQbIHoUarwys75omvGeG
 b2mKYrijPcbxAIYKXZZh5aBPrffzVOgTqhU6RNjY8dd47p3rQ4y7MSNe/azDn/m+QSVSd1+J1Qo
 0mJWepVqOJqet2LUCXLVHMV7TwJQgCKtvAQFxUiK72Ap8GkvrkwGHZxIXgtI2LsVS7ZjDjdEyRk
 tzvyJpyA5txr9huRkU8cS6HCvItOIw==
X-Authority-Analysis: v=2.4 cv=as+/yCZV c=1 sm=1 tr=0 ts=68e4134a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=ger4OobvzbDkkTtn2G4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: PRHKn37k1KCFN-AhReVK6j4ApumRayHz
X-Proofpoint-ORIG-GUID: PRHKn37k1KCFN-AhReVK6j4ApumRayHz

* Peter Xu <peterx@redhat.com> [251003 10:02]:
> On Wed, Oct 01, 2025 at 04:39:50PM +0200, David Hildenbrand wrote:
> > On 01.10.25 16:35, Peter Xu wrote:
> > > On Wed, Oct 01, 2025 at 03:58:14PM +0200, David Hildenbrand wrote:
> > > > > > > > I briefly wondered whether we could use actual UFFD_FEATURE=
_* here, but they
> > > > > > > > are rather unsuited for this case here (e.g., different fea=
ture flags for
> > > > > > > > hugetlb support/shmem support etc).

I think this supports the need for a code clean up before applying an
API that generalizes it?

I would expect the uffd code that needs the same uffd_feature would
logically have the same uffd flags for the uffd_ops, but that's not the
case here?

Is this because uffd_feature !=3D UFFD_FEATURE_* ... or are the internal
UFFD_FEATURE_* not the same thing?

> > > > > > > >=20
> > > > > > > > But reading "uffd_ioctls" below, can't we derive the suitab=
le vma flags from
> > > > > > > > the supported ioctls?
> > > > > > > >=20
> > > > > > > > _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
> > > > > > > > _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
> > > > > > > > _UFFDIO_CONTINUE -> VM_UFFD_MINOR
> > > > > > >=20
> > > > > > > Yes we can deduce that, but it'll be unclear then when one st=
ares at a
> > > > > > > bunch of ioctls and cannot easily digest the modes the memory=
 type
> > > > > > > supports.  Here, the modes should be the most straightforward=
 way to
> > > > > > > describe the capability of a memory type.
> > > > > >=20
> > > > > > I rather dislike the current split approach between vm-flags an=
d ioctls.
> > > > > >=20
> > > > > > I briefly thought about abstracting it for internal purposes fu=
rther and
> > > > > > just have some internal backend ("memory type") flags.
> > > > > >=20
> > > > > > UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
> > > > > > UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
> > > > > > UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
> > > > > > UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
> > > > > > UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> > > > >=20
> > > > > This layer of mapping can be helpful to some, but maybe confusing=
 to
> > > > > others.. who is familiar with existing userfaultfd definitions.
> > > > >=20
> > > >=20
> > > > Just wondering, is this confusing to you, and if so, which part?
> > > >=20
> > > > To me it makes perfect sense and cleans up this API and not have to=
 sets of
> > > > flags that are somehow interlinked.
> > >=20
> > > It adds the extra layer of mapping that will only be used in vm_uffd_=
ops
> > > and the helper that will consume it.
> >=20
> > Agreed, while making the API cleaner. I don't easily see what's confusi=
ng
> > about that, though.
>=20
> It will introduce another set of userfaultfd features, making it hard to
> say what is the difference between the new set and UFFD_FEATURE_*.

If it's not using UFFD_FEATURE_ defines, then please don't use
uffd_feature for it in the uffd_ops.  That seems like a recipe for
confusion.

>=20
> >=20
> > I think it can be done with a handful of LOC and avoid having to use VM=
_
> > flags in this API.
>=20
> I waited for a few days, unfortunately we didn't get a second opinion.

Sorry, been pretty busy here.

If we can avoid the flags/features, then I'd rather that (the derived
from uffd_ops =3D=3D NULL for support).  We can always add something else
later.

If we have to have a feature/flag setting, then please avoid using
uffd_feature unless we use it with UFFD_FEATURE_ - which I think, we've
ruled out?

Thanks,
Liam


