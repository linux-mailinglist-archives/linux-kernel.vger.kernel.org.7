Return-Path: <linux-kernel+bounces-742785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCCB0F6B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB031CC5C53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4382F50BD;
	Wed, 23 Jul 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rxqKspxw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hfXJf9Hq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D02F270A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283159; cv=fail; b=mOojGUPyFpRJimtbyTau3ToQfkT8M//AQrjqBWyecNPbM848VajsQEiuz/M86EyTJT5mC00q+tawa5ZSrMK0jagWu8YHLhmFKW5Q2kcG4zkgibeYUIDAdWGEDn+PVqexB/PTQ6D/fLpBsnw7MG4Slxpee0AIVuLH76FbDRL6gYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283159; c=relaxed/simple;
	bh=t59r/z1IFD4SWzWi4RMaHpzc12PU+H26fGL5MVi6hTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eD0SIgTd+YYktJoVabnCYT3+5L4xBtXbqthSmrGeSi/Cr8zC93PLXlqqom3kX6fx33S23b8FIUhWb1rTdkQ4nDi3XH0EcWJlxnUToYl/3XXU2qj6OCFSdeuKbUPJ23N+YxLZBsoVE/XDdRi1u3odYmIMhGp07jO2thBTUOGJVb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rxqKspxw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hfXJf9Hq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NMuc024672;
	Wed, 23 Jul 2025 15:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HQvuKhOO5rc7j/q1de
	uU8GCxaJQDwORhMutam2xZrBs=; b=rxqKspxwvqJ1FkiU1oBC4oEJjWxCOZxsBb
	VltKOGZaBQnMOC0+lfu/0duMOiy3XCimR4dHVkPSnme193EE9kqgDE3F+zDTD+5u
	5eat8iSQoM55f/nO5OC0XkbfXEc2e5CHPiKXemqOwjiVaOCo+7HzXXgrKjAfIYG8
	UWwmtLyii/ssNdqJ8lVK9thFlQwrbfGZxsOo8gnStmEzYd/hKR6zbxDOuRJY8yry
	qxXZAHNsIwNcgvOqQ83lhyI5NB3TI33gq+qvgvtVANq5oGCO1ifnMaUYlwtFbv3t
	wOh1N2BlmY6Nvu0WAdUr60+J8no9L4ebyOtI4DGheh3Mdb4fulXw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2fqjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 15:05:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NEHvn5031357;
	Wed, 23 Jul 2025 15:05:39 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801th1fmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 15:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTLv3nqLUw25ScBU+1sRSWWQigtKfkSXznmQ6DRAQZBsyt3zZUmuMC78E0beQMcJHA5zQPqEMErn9Il55I6fH2PcuWNmB+CvJZV0dqHrcsrRXajSYPjQlaUsLjEn4zMnkaeAFoJLOfHTIDdMUWADPA3LKjmoNPL/5/KsvKviYJcJ4nSx22PtiGNSUYZ22tJsz9YjA3lfaWoWlX6InMOWgZSSOyCr/U0OE8jjRYRQWxITEkc5tIFe7cAVxUexDicGj689ShJf0+xW5FhN8NcEIL1IhhpC5f8oBoYMm0lYtIOR+Z3i3c13Uhyp5IPksMDf5xtoFvfHCM9KaKHMVu06vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQvuKhOO5rc7j/q1deuU8GCxaJQDwORhMutam2xZrBs=;
 b=vrNkZhAVzMRUXo2IV+At3MsCFGIhQ71EUVbNr+Nvm6Kz7HQ7EiF5Pol/nsErxxhYaueEcLztC0IUverhsp9NqCSteiLm2EI7K/7YkKIsfEXeMopC4R2L5+K3z8AcPPQBnLTDZlYlE9AKBHu7WBxgamMP0RuvjaJ4BNoTEjb3tF7i7pL74b3bd2NZ5oo+G0wfA1LL2dqjveAjsOKOP+Y+/KSWCuz06XKkI65ROzvctpBZMjSUJiwtLgtADNKuFyHv+RGdKesg5gVroZ9U8SP0Qiy2+Lb99l38gJnBBcpDjx6gZ1ctUGj5XfnLD9X1DhXUqoNY501B1fsw7i3eKHcyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQvuKhOO5rc7j/q1deuU8GCxaJQDwORhMutam2xZrBs=;
 b=hfXJf9HqIjS8LkgIFv/6JsHJ1TxWJpnCCAfYSPz9Uz1bdN6gION78ZWu8rxHV88cxDZyTwAxCPPM1HNL3hHvn5pvb5DRM0EQ+Gyfdx4MWVhiLxDPrnFoEGl6dyLvFOQcm9y8fH8c394wV52zq/EgrLwbxptxNIme16hyTA8ttsE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 15:05:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:05:36 +0000
Date: Wed, 23 Jul 2025 16:05:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] MAINTAINERS: add MM MISC section, add missing files
 to MISC and CORE
Message-ID: <abbaed17-955a-44cc-9593-10c1afa4c6a3@lucifer.local>
References: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a6d96c-f5ab-488f-b0cd-08ddc9fa60c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GZKCVPxuE9b9VddRptCAafwMp3CUCJzBx8b6LzJX8VjlJqKpJjyX/hrkNSQG?=
 =?us-ascii?Q?tL6sMwY0MyoSGRDBDbyy2VOjQ/ljiHW3jQk9in/ecIghmAHbuiWGSC8lUWdf?=
 =?us-ascii?Q?Oa6a4MScRqt0/mUSqk57SNzwenI90adeAzvO6LRGm0uUIyvkSxMWORmYShi7?=
 =?us-ascii?Q?YiXMRMe5PHkdE9/23FIqrrpGFgWHE+DQfs1ZnN+gip+KQEUvDprBQCrDWCn1?=
 =?us-ascii?Q?MHpfYsY8aWnqxfihC3WG/N2EMJSnGypGajzps84yl9xkK/ULDkYZjoQp1CLR?=
 =?us-ascii?Q?F/nYGa17XTsHQmti3IjptHcXQU3v2tzx8/oX33tZxWPgeiKK5TCw/lN+aYM+?=
 =?us-ascii?Q?V+9bOaEDm2RBZ8QUCRN3AUVrByB0PRBFM7ZdUxi5YDfPENzW0Qb48O21relY?=
 =?us-ascii?Q?gJzYNsHXcVnLK0XayuIh5HdenI6d5+8tnMlbAho5xQYDBO1rgrMODs4l1kwk?=
 =?us-ascii?Q?4i0R84VMlYQzgwTPoyKYAwvwBdwgZ/Txi1C1bLK1is5fAuoT5s4OAp4qSnrS?=
 =?us-ascii?Q?rIlQNvgLYfWZfM7Qa6HlDgQexzGptKrn6TpfwqPuqCIflLhb7L63v86JzJRG?=
 =?us-ascii?Q?NAjp0xez8hmZUeugOjbGXZ28Rm5WMTT9iMhHpIft3JaKB9dO0T3F9l0lVtFL?=
 =?us-ascii?Q?FoT2CBjWr8KKQrYTPgvawzoJNX1nS71kDscc8YsZCmEEgNRulJLD5cJZwbZH?=
 =?us-ascii?Q?LMF98UIK1GKWt90SKxMd/E2M8woHPji3WwUPbJc0QNMtKSnXJ92wFkhJazOB?=
 =?us-ascii?Q?MfZ1TGGSRkumMmxntilAY3kWiO3RTOpGfctcG6P5vJV5R2ABEkltdLb8Dcpw?=
 =?us-ascii?Q?oFikzWbvYTaOj9GiPHU6S45IRVtRLSVHwhA9Zh98bFlkJ3SjX/YMLoucQl9A?=
 =?us-ascii?Q?miCuX36z0h30wBLnfYcIlOShHtaYbXngSNqqEHywuTFOxKIuKVmO00RBuNMV?=
 =?us-ascii?Q?/P9A8FE+ZAyViK9ppz6Vfa0+867MagxaVrjKvVo4Os6fzZnf2QKRs6WfnWy0?=
 =?us-ascii?Q?AZbF1sFeqpocTPpbb8seo4KyLtwa5q143DIiP+057XViHTekDclBeu43700B?=
 =?us-ascii?Q?e56KmPyc5Q/3qpchPsNzjrBkRZgbvMP3dB1Z67QKyj5KVdWjSmDMUuaQOElv?=
 =?us-ascii?Q?W5nb12OuX3+yAHmtWylagXpNljbUe1WdXejq2cAN9xkMEMbvUk9OsDakV29p?=
 =?us-ascii?Q?huMFpbH4cvQj9psIiQkdap91oNDm8T29YFaHVetHn1yzaTtfNcafQjs7PNsy?=
 =?us-ascii?Q?td1JKrTBgMLLytzRAgxqm2uVFi2w20xtE+6lhsxD4CAA3soV7bV2vi5cw35n?=
 =?us-ascii?Q?H2VPr7l5uJohIq6Q6rc4sWLm8Hwtm1y83KwWDBu/wST+dTNfwyI0hcPn7sLW?=
 =?us-ascii?Q?Aq1J8s8/EDusR1KPXujIWpG6ILlqtPAbUdD3ciHhmNCfViYojUoodOO/FRAi?=
 =?us-ascii?Q?UeBK7HAHDpU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5azr1//s0PmuMcnvlY/MhFxwtC9+zomSpW7vSg4MTDRAqQEAQKI1AQ5xeux?=
 =?us-ascii?Q?R7yfc/dl7fwDm9m0Dglf/U/Opkpkjb/X+HgKmsL8Lw9Tft9Wm6MqetUhBWqC?=
 =?us-ascii?Q?odd5Fx705J6pop8TGManF1UdrIXIoWA/EMg66AYB43InJOQnrk5PKyphJRn0?=
 =?us-ascii?Q?jyvIQc871lRX0DTyJROkDVDYg2NmNarceX/uZqa3JQ0S/0Zg1Y1TukaUM+Ff?=
 =?us-ascii?Q?1ishR7VLUORDjwhGUcbvlFDLLK0lor8zZ8okE1H3DI9G+Mezig++spd1Dief?=
 =?us-ascii?Q?h4x50bxyHX/Wr+gtnr+9u44AZMp5vKwf4QndBjOE00mwh23vhSoCuxRVvVHC?=
 =?us-ascii?Q?+gU0Fn/RVO39F1MFyeVW8pN/VtrNZ591QB1qIK6Ovy5QHQCGEEjV9tY0lQj/?=
 =?us-ascii?Q?GumrOii9ibqQOiXmyNzGdcjKj4Ce0yRCAvdsN9G7vk4yp7wGLe4aDXQigt1J?=
 =?us-ascii?Q?2Tusm/78ZOwigXU4K+OYmlPXB1yjYIbRvwVrjaEsv2VoK0UECf8SqMPOrtXG?=
 =?us-ascii?Q?iqxX9YxVNYVQTfAvq1g6Vul/uFeEsLltQpcTak9wYHAJwW0iRttTHc3uiqBn?=
 =?us-ascii?Q?n8ZXBGXxSk98MXl7PgmRiTRoQJC97JPeGRgoRkcMfQHWhp+Ubx7Ax8ybNZf/?=
 =?us-ascii?Q?uvZp39uCxRE3pIUscStP08EKF9sxxXju9RCznuqrPmlQuY+aK07DvNbNcY9I?=
 =?us-ascii?Q?Rla86Rif7hEPUpi4bnk5S0bMwgOq1xoohoUZ1qBHBNpBD5IF6C6DpdBIbEvF?=
 =?us-ascii?Q?SuFB578DT3Qw01SeDve23Gc3+QcU0H+QTMwBsVxOfYpzYrQPY68KcJ+0XNbO?=
 =?us-ascii?Q?xOyxB/6NwfoQtCzx7LPE4JYNqXgltycjoUeFwcfSyAlbuXXa5x3fHxfPb935?=
 =?us-ascii?Q?2OmjEh582T2EYgFX1PHWG0+MGV90k4etopC0iio8iE0FyCoWQwWS1kNoYW69?=
 =?us-ascii?Q?INWc1UeYTPxeESnJq4FoG/lrq2GW1gFuiHHehTMnAnQ8qt9+pnDp//KPt0Z4?=
 =?us-ascii?Q?vaZ9wahn3PXPTIQ/4G7y5BtZYPqRu5Lujx2H/5uVvk0Dgaa2A5vZEC4dlh3b?=
 =?us-ascii?Q?iqV+xi9EWSr1PB7cA7rBZlzGQ1QS3EGudg6UYv6u8KZWLpf0YVrn+HYVE5cy?=
 =?us-ascii?Q?EUgvv9LH3ommpZtq+O7OfGaFS/S1dYTLWNyoV6fK42DUlyq6kUy0bqxNmMFm?=
 =?us-ascii?Q?4jE7JEuNMvnR3H5ja6e2eCPtX7m+62IJP5TIFRPqs6js9laXOnhik8GH+3AA?=
 =?us-ascii?Q?e0V7fFzAy+fCBs09UG0kgoMN3o9ZHD7yAGmddrZnx5hpfzEbn2JBhTZWcJo4?=
 =?us-ascii?Q?/+NTFQ0nW4a7K+VvIDkZSF7fWDVvBZHJk6c3oPuynGI0X8TBeotA08Ij1f3w?=
 =?us-ascii?Q?65jvGlEZuJWyXxlLT1Df9hz6lGrYmmJ0TnsFDWFfs7bJcOpCN3CZqAEDOOBa?=
 =?us-ascii?Q?0lxIieZaNN5PnXaN2HJc0MnGvKihox8tMWZeYcS6pCRjrCN4ol9FMFGiRtJK?=
 =?us-ascii?Q?j3IH59wH40YTyWHEsqJvX/FMIjbYCn5W+efKBzcSLMhGmr5Cc6LFTnzJar7U?=
 =?us-ascii?Q?H8BvZWb7ip9/Di3TglcjMlNTKWfnwscSTil4pwMW87kdmYz86ZD4bK+ZrI9P?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NEs+9/ULeQXb+L3vEdpFExLR+69FKR44QME1ZSBFTEKYyJZLS53DI5qlVUMUef3Br6Qpz6yWhI/LTAuls+BhL8zqzawc8WXtIjst6BVSqF+MBr9uzdgbnaiFpHJPXvaZeEvjzYY+eSM2I5y+91A5oy/8YzN3dACQ2zwrBVG3/KfpTtX0rjnMFwzqRCznBeuuvAgf5U5jpuGib/a965wieiPxzwmuzs+VDoug8//wa3zee5/09mxacluo/Pl/a8RJXwhemkgnKSvOm3tEMIo8Duzl2DpMa+kCA/ZrstmOHG4juildHIxh2surn/vUn3zuQKw2G+YvYZ5xKPiaTZLljlKT7Mqh2u62NT6ZliLvpbZ7sPqZ7Q7QZcpU+TiBmSC2Ich5yVEoudbOuxZMwRciYzMPtrOwDM5WgIJxLd9JBpT0rK3bJa23Twsqpn+Eaq9W5Jw7UIc/WFKONIRJDqr8ATRGkZ85FVkgpguWitJkddDLN0tiNAtkwpN2upG126V0tlJOko0U/tFlJtWv6wyIW7YgSBmIgbme6b46fvCNXTU10lgT4U+UhoA9HiIrVnb8e31pUcdy4IbYMMr9PUGkbnyc1ytASyJKfa/y/byJSMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6d96c-f5ab-488f-b0cd-08ddc9fa60c6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:05:36.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i63S0XhCpJBYv6pbM995vxffg25ljjA0N63bfHJyPEiqP87fatIHNnAbeyhjmoO8JrWJhtSkW/SkA0z/V4aqNItW02TqeRjxeXDhMrhIQa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230130
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=6880fa43 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ImBynb0gwWMiUKTohI0A:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13600
X-Proofpoint-GUID: rvXMf5UDq9is6u-UIed02-0tcA9CthWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDEzMCBTYWx0ZWRfXwbD4jbKIp7Mw
 HrZ+NeWsdMXJgSo3SbtcsvvxJ/zu6Fb3IV5NmavLLJFYU5+EWpzbvMy5+CvjF5UljUf4Rv9FVSI
 wH6z2X9rqZcf+L/1pfsfI3iIcPdQNTM/UT20VGaugyEKc33BmUZBIqKuqNXfr/GhRh2CphuDJtE
 NoKqT8pcIYX/g2KAWzQi8qARD6aDh+DzH8+E21bC8duyD+1aL71WMzcM7c4gmSPkyrMQSCUZTD7
 GSw0q1XXdA7ZcoVrXxn6BwyugQTwC5YbZsWUWE+IJfoSMRZdE1cDpoR3orvfDicVJY74QDbAUqI
 b3IkRCWZz0Wv4+6uT6EB1PtY2bL3k2ygoJJsdjW+g52lpcRG3Gqw1yFp+nOde+cw2TyWIEvXXwP
 vqQrJWrmaX4L/DwHOQRb5/W4q9/reCjJNP0TP4L0q18AuDuzeKUgxm8rSMBeK+hRq8E9V5Vf
X-Proofpoint-ORIG-GUID: rvXMf5UDq9is6u-UIed02-0tcA9CthWy

Hi Andrew,

Please apply the attached fix-patch removing duplicated header files
accidentally included in the MEMORY MANAGEMENT - MISC section, as pointed
out by David.

Thanks, Lorenzo

----8<----
From 9a94ef4511f6d0cb39f5edcc963b2aadc11febed Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 23 Jul 2025 16:02:27 +0100
Subject: [PATCH] MAINTAINERS: remove duplicated header files from mm misc
 section

These are present in other sections already, so remove them.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a9d4c57add4..5a6cb44635a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15860,11 +15860,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	Documentation/admin-guide/mm/
 F:	Documentation/mm/
 F:	include/linux/memory-tiers.h
-F:	include/linux/mempolicy.h
 F:	include/linux/mempool.h
-F:	include/linux/memremap.h
 F:	include/linux/mmu_notifier.h
-F:	include/trace/events/ksm.h
 F:	mm/backing-dev.c
 F:	mm/cma.c
 F:	mm/cma_debug.c
--
2.50.1

