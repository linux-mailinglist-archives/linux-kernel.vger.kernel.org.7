Return-Path: <linux-kernel+bounces-730434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F2B0447E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A490C1A6232A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32700267701;
	Mon, 14 Jul 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DdZVtW7m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h1GD6ciP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6A26136D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507475; cv=fail; b=ZHtj9B4q184c7ykXPAID7Qakz6c96vZMBW040h2UwOpR7iWlvsptaZ4QaL2Egfij0HZ3F10NBjRrFpa3/krPh6SZreUk0PrcdfYUfcn3MicSw+pUIHIRcdFL9T3In+ODXZ4xqEap7GwTncQsFeqddC7Lr/VXgT01YMp5Eh6oxyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507475; c=relaxed/simple;
	bh=ZpMaEAVfFaCewlzQn3p1d/WuMulhKvzuhb2TQW++muw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NzXaROBoKa2StqUPaRiC1+9wWR58Bn6Vba/7NI++6Uwc0yxAjiN9NzKwMJ5sgstAqgdX3y/VfHrUUWfXJIQgWswjbFq+7khqMWH6lmzxNvR4tEan+vSAK+HnYPOg/J48ZAVX1Urv7nzO0Rykua5MtVTJLkQ3FuET7NQ1yUs0Sp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DdZVtW7m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h1GD6ciP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z3SX004520;
	Mon, 14 Jul 2025 15:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZpMaEAVfFaCewlzQn3
	p1d/WuMulhKvzuhb2TQW++muw=; b=DdZVtW7mCuSM3k+r11ezJhEAFC0oqfN+3v
	pkBT4qtfi7H0ArVsgiv7BxLcHftclp2Y7YwAS2vDl9IuQ/NsFg8PyvSSq002cFqt
	Mz7fr+HG4iE1f8uC8pFfxJ509t/9fUK2cI0SbuL7VS6AJSlwlV4lThdf3NXWTiZw
	yO+DRSbP796Ucuhh1G0A6RwL7/t5u2msTUbb+JnAy6ObLzw+GXLmn8AgSls/w3ad
	e+X1QSXRvzRXv30YQqTo/d4QEih4xrkS9/31j7cWHxNxGRO3BdMa8PFhSQ3hm20B
	oAYT8MTXybssZQWHqIwSa3MeIbnJwbkLzFb5928bAAjuTk251Q2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7vpq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:37:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EELU5J030328;
	Mon, 14 Jul 2025 15:37:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58ng76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQr8l8hFCXM4lRabsA7CMQQWCFnfmOLQG62KGM/wwALiCq/qllTe3a8bsEV82XQka5oIFEE7rKRjeNaTv4p4oKEjaT/01wUifdZWEboriZo729n8RhQGDWt3AolnIYoam4eSyLXGz5plDOrrf0hhREDiS14mSjC+FHMorRt1cJbdBk4ag38f2oTk/4eNs7BUdTyCNdQ1J0gpvsVDDsGYXEEQtO9mW7Jz8UN3lRtcudBnCVPnR9Tw9zCjchUYgtEiPaum7jUEHOptAAXKovSmWofy/oO0sTjrpQE1KJzIUZTaMAHbl7T5XKOZl2WNN7lNY/gs70OYLWza2VSgZAyBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpMaEAVfFaCewlzQn3p1d/WuMulhKvzuhb2TQW++muw=;
 b=Gb04/Ada5gNeHN62K3cMe+MOjBvVW0MNRXoXG4t9QO6TOrDefCSz2bL823M/jaZMqY5OYtgyw0/W5K5Xa0iiuEXXhvMPu4XOF5En03IDaNUwjQut2uqVOXjvIgoG/fstMqaOrEoPfaR66d/rVjkASYI2x12eXHf/eu6cY4Z85+MY8kPUaxNvQXANoWm4VHcE3rd921+5LHLu39Qb8HwphEewTHFiqjG7xZqjTZpGagtEm/h83aunD0RUQWAAFmYRoKgz+/stLlrfc9qUfRizFJkE8pdOtT1GxhgYFAP3R7ENK+RhuLDgND7WZ++RTX5rp9AKxsaeKgA4j8ayVBPKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpMaEAVfFaCewlzQn3p1d/WuMulhKvzuhb2TQW++muw=;
 b=h1GD6ciP0RBLxBD4Z0VikavJoX9ksvMnETr1KcmGo8fUypYUSfJMT/wWrpHJ1IBtelg2yvk6fkKRRP0+/7HqUvDNx+QPkp6bbX7cG36bzx/TTU1TzhMQYlyTp5S6V4a+e1YW0E5ajWDegOiP5SLoHTa/PW86zbefkiV8OMa605E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6137.namprd10.prod.outlook.com (2603:10b6:208:3b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 15:37:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 15:37:35 +0000
Date: Mon, 14 Jul 2025 16:37:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
Message-ID: <26a1fc6d-d0c5-4f5c-9669-0593a9a6b59c@lucifer.local>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
 <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
 <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nnm4cmygbeyzwxfwqduo5lq3d5cthuic5irof2l3tb5x43n2hz@mmjklktcfk2o>
X-ClientProxiedBy: LO2P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ab57ef-7103-4cd8-4305-08ddc2ec5ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzZQJz+9ExWgD3I9IysTQUWSB0Q/uR4XN8Eo8l+zSHDEH2lActvubmpH2/fd?=
 =?us-ascii?Q?aQUT8n9ISl2sTImm2KAYlQoJbSOb9caB6OQ0t59W7huVSDKpKD2JrIGLRL40?=
 =?us-ascii?Q?ajJ8KbpzAOM0H6gwGVAbUjSuLT3meq4kwtO3HDq7oDLXwe6hVcGABlS5orkE?=
 =?us-ascii?Q?sM8N5V0j+O+uhkzo/QMufh7ybrwrY1HRSj9vMbapLAnufoftKyg0LHsjQIDe?=
 =?us-ascii?Q?MCxd9xPf9XjZZ6e4B2sZkxB7nPrbK236HegigzXQtYmi0wOtjG/85eM/Uqsr?=
 =?us-ascii?Q?7L4yfzjiupnDhsI74EmKNRiQXKPuGvjdjuguoC3gZ19zdJrNcAno2YdrbMWH?=
 =?us-ascii?Q?iRM2oY1MyhdH+nv6bejO0n7556EB/xGOUllUb5HgDk5V/JMeZinF9WiQrg9W?=
 =?us-ascii?Q?dRtDnR8oCF6/kSBKNjlAoYXJXjDzAAEnBtiOWwKk7NpKyXE/tvwMvacv3ZGx?=
 =?us-ascii?Q?R8XkOUbFO+BZrliwvF2WUd3A4KJVuSdSTyCU2z3jUiWAUgihxdt7/7wmD2LM?=
 =?us-ascii?Q?HfpuZZO5kJXjtjwFJUMYTYsuuu6Dbtb7Ec8LYicGPMvJzkaP5EDbYwbMl/zF?=
 =?us-ascii?Q?I7eUv5BFVDbkaf30d6x3EZNNg8PlWWcEtUrfE0HWhzle6sAA4TlD/pr4SFyq?=
 =?us-ascii?Q?oxohCtkRTTpHIhO2lhSHj2Yn7ydIAS7ra88QwkuQSiqWHBt+eMIlZDF3aa/y?=
 =?us-ascii?Q?my2YEJBj2zypkvrb8MTPW34i1BMh++J9WdrBLMtawd7LKfJ7t1U5kc/UODxO?=
 =?us-ascii?Q?FpWm3n5NcYcEE5uNlf0cD5wVncnSIjElw5nLqJRMAPVUT9k57PFE4ZKhQZkH?=
 =?us-ascii?Q?XkSGa/XR3gBXn5ZsTcDCVTgto3r6Wkv4HNTkpI+/bgMXmRj/fe1YnTr/pAev?=
 =?us-ascii?Q?6iBcVqZjSlkiRsAkQuMeigS7uDk9/HrZORueL7s+OS4e6+gyH47uitu6I3aY?=
 =?us-ascii?Q?pblLmgBeYIKyjbWsWhrge0iWLZVVNMUKZLkoo59iSDqyDMNo4NAC+A0x7+8n?=
 =?us-ascii?Q?RIoGGqScht77qAyOhibiN0Pf/p1kiN0Eypq/ZJfZBtrFLSxiZbyaXMPT/mDA?=
 =?us-ascii?Q?d0KJ0Orp8GJ6E+xTUUG+4MlOOelHZxXhk3G5nHrWPamVcD2FdwlJO4tnl8qB?=
 =?us-ascii?Q?kJkDujl+k8P6uYX/D3h6DPHO43fcrp50Mb2WAmgGG3PUIwW1mBnzA/uGxO41?=
 =?us-ascii?Q?T3pyvBIPsSGrgTtMipxY8cnHzuYWwQDWOY0sCdirl1tuItPNHkLOqTScFv1a?=
 =?us-ascii?Q?ee5rNlQOVZIJP+0XRaL2w0z0EOBralJf+ShZ3mEkGmTeWAPHeRbrtCPH3SZC?=
 =?us-ascii?Q?E6LXAmFlXnk9ovBJIKkA14i3uawZPn/BCNdfCwMQ87yaC/hCsXPQuzNgVKpX?=
 =?us-ascii?Q?2xMsNlJRs5l6tyvOo8nZKqMz/cU2CSiPuqCiE0rR1XwHY6KEeC+9h9C6mkw9?=
 =?us-ascii?Q?7Rzk+tKeCsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nO9GCfSd5CQmnIf2FbB9mppF4avJaTFA0nTFfyRqcp7j8IWeEu+YAimTyVeX?=
 =?us-ascii?Q?InGdVMV32skYYvwqQTiw+j+ZrLxzuAajrkxZZIYrGrx5OPNPgoXm4OtME130?=
 =?us-ascii?Q?zZYk+lEyK7Pm4SFtq6wqXT3pdW2F/R4XQWijSfVCSGPUYnKtq9ymshEG4Ng9?=
 =?us-ascii?Q?vgkPIisSa+8CNT4+NFjQ8SCTmk2mp/JNpRjR4cO0Af1S5Ym6c+/V4VqZBcKY?=
 =?us-ascii?Q?RhJLpuUW62Ipo1JS2mp8A6qeXxVHU0Jo7uza3jVYMM8YataB7QGxUO3/hpq1?=
 =?us-ascii?Q?Hlnz2LYzkVDD5TRnzKPIuobj4qjv65Vf2MPfrmgtQGMvuIGP9PmCXT0OwWQF?=
 =?us-ascii?Q?A8gT4nEaM3gu7NkHaqznYIVU/St1MzJHR3BWczxT/5sSqAmJB8Oufh+hFiFj?=
 =?us-ascii?Q?UOv5jM8+oO9bS2CW6HHv+RYikDesQ+61+p7D+NqYQp+jJBNVfWD9cEdcYrrs?=
 =?us-ascii?Q?pkxfTnTPPVGyd2IaGzn8cTPPlPgwMs/Cd8tQpmk7TP8bKKeHrEzq8C91a4IF?=
 =?us-ascii?Q?R5DK5tSmgjpz4IDZIyaxORkUS8tQiw8CLkUwA6yVjFJdkuYb1Ck81OhUd9XJ?=
 =?us-ascii?Q?X13SScYr5ASFJ7mg4tlD8+i8jRgrnERr6/BHyTMRcW0TxW6ReoJn8ZG3i/EI?=
 =?us-ascii?Q?ynqEeSzrd9g+VIjB7csFUVbPM8EQJX9DjSiwof6GKJPIKlEg+uL1SqDlL7bt?=
 =?us-ascii?Q?bc70DBcc/xiDnAKdi/VOgjPdSWJh+8BMBR6g3yqBwnQa3ajO6UKEApN4W0+P?=
 =?us-ascii?Q?O/hVr5B4foggBn6wVYrIS6oD/sd+aX61MF9nksZ8v+5f2ywjy8l/cQiDjU0s?=
 =?us-ascii?Q?Cb+Je0yrhXEBAhDAuzyvxSOtWVVs1EcBOMBHP8hivOUvBW3OF99ALSjP1m1X?=
 =?us-ascii?Q?+vn65oC/DxR5/elt6xh9wM9SpSKABzw4tW2ExKym+l2ljVyJPAfSRWRZYZgf?=
 =?us-ascii?Q?zwmvjwOEvIj6DQUV+93oVrzLqMt1nEfKYNIg7RuFHJyH5wwvaZxHptk8YDdK?=
 =?us-ascii?Q?gGv7lESS8DCwaDSbejRUiJBYDAv4MNNtbTY93tY64hTtTOSdhcLtLCzdcUGx?=
 =?us-ascii?Q?J6uh/ZcFVoZVloMSndxlbXElIuOPuph6EDXAiYJ6zM7gCJm2UewM4WRDugdV?=
 =?us-ascii?Q?D0PliMOzsMusvPBtjfVRFF4l7xe0ZkGb9DnoJJvjlne7AwDL51FK4IFw+nr2?=
 =?us-ascii?Q?8xnOV++nOrDS3wneYVgMiHw0+YTZ4fMRbpBVfVm8Y74e30+FmKx5qtp13sWm?=
 =?us-ascii?Q?orBGJaVslgJ1TRmcSqYvD8tw2xEqgUHpeZkKRwjxx/IgWg177bUc/KGH20qx?=
 =?us-ascii?Q?tBqMetRPnh4ZVumKpKpGI6mXt4X5rl8eGA4GnyQZYc2lI6sgEd5s1QCgZ1T+?=
 =?us-ascii?Q?wg+4DV8E5uL9oayPo50oZ9afk/pM61w8/De3H/dq8/1c5oMM8Q4GqHJDuS1l?=
 =?us-ascii?Q?+uWJwt2zl0BWV1mRtFW9EAaQGljWPQ2fm8wL+JR2VSI7tnBuGT8Yr1f6UmSM?=
 =?us-ascii?Q?Cwk+xoPC3vbCu497eGboOuv7dh0zenOxfQjKMZSDg45biKXCLN8RzpPOPI0+?=
 =?us-ascii?Q?Mhov1x9i6RzuTr1QzSslEUNgMsN3LRvdeHALAZkT/UWtT48ZiJDTP0dWaPjx?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Nc1Bie8izyHr/8eiDfZTLZGOkvxd6MYjrLwjL3iEvCmTTaDKzWluuRmpo6Epcgyq9CYHjEADe1mpfuYu1tLfHJFFs0GJXU6NvMKVGMW5C5pjyDtfnNkq6LsBrjrmQHoVaQLVJ+OA5eQdCRGz+65hmpoDxQLEW1fT2TuIBRiyQ1oMNjKCVKQ99BhtvYJMIgcNpt0v8q/yJr1ZzTW5YeGBjZ9V5KXW4Rnx4xKVKcqkrMz+usDFqsUXhgXrquX6dCpA4CYFKGBZw22YQcKtPZtjhRTB3kqdZIDHmbp2IrbEghfgH0STNoEVIlv34PANkkrP3NiarelG9OdFultNwC2On0GVKileiXDKTXnR/75oL8ZvCaXiIVYtM5oRVJryh2dJZ+OY2UE/W43AAtPlbb/h/L4JkhxmH/65WnCZTQoGXNmx9zwoHFIAofA+WcMH2e8b+gpv3PoSsgCEScS5IolCVftGLkmwT6mXhKWIvVySyOZM4GNdtsBnjjMKvmkci9y4XGtbkOEnpejkPXrMVuf8SQ1XHVqYov5ytqFjwPdrdSppeAQBX+HiABmIP2rLsN8A1pxrFbh18MhlWEAMtXLHJgv7m1oLEjHbytbveZBYJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ab57ef-7103-4cd8-4305-08ddc2ec5ae7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:37:35.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFDoXVyTqnbcGwmHoF+1Hy4A6RA+9vuRf4vbxJ44DdLWpWYTiBpT5sDiKkzpF703pu46pRePVhcuyyXYInv3ZYsCpjosep8lD2/tIOkSmhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=829
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507140093
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68752446 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=JiLavFP1bYptASvMQm4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: PalRXj77JLcyLRuooDzfKLbc1OTM8JD8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MyBTYWx0ZWRfX180vUXLdpFJC spbXvU1MQStnlmpqUsOKdrxlALci53xu7GussNq+9hHqbx+QYXIDuFGF90lS+liRdmtjJzh4Y9d Wj8KWY9vXvz2hBVkep0qVrLMMxlal4HV5Y76vu3t1qrP3XRNJ0AWM+tc6U03EBmII06fvLxLKpa
 UljBUDM0F5nAiVOLXqbsC+R6bT1txZ9JlL20wm2n+82reRnp+WaniEKLX2F6sVxSKBeGXBSmp+7 bfjb+8dqAbiVXPmKgULlLXqmuURXa2z9QTWGf1pFz3LlP7w+YU2rcxmFOJIN3mknx2OM1rkvSVB j/DX63ifYrBOYnTXzqV2mMIXsln2Av9YKhZGs2yulzRe4liglcD1fp2FzT4mzrTOOuurwEIhuUB
 JMFqF+VNqEG6XCxdo12GaN1Sp/N6KDS6SNFTk4DSuye+vBsRqITfTtkf4REq8gK1RLHlXJUQ
X-Proofpoint-GUID: PalRXj77JLcyLRuooDzfKLbc1OTM8JD8

On Mon, Jul 14, 2025 at 04:31:59PM +0100, Pedro Falcato wrote:
> On Mon, Jul 14, 2025 at 05:03:03PM +0200, David Hildenbrand wrote:
> > [...]
> >
> > But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE file
> > mapping?
>
> IIRC this was originally suggested by Linus, on one of the versions introducing
> mseal. But the gist is that discarding pages is okay if you could already zero
> them manually, using e.g memset. Hence the writeability checks.

Right, and if it's read-only and MAP_PRIVATE it doesn't really matter. In which
case we needn't worry.

I wonder if we need to check for VM_MAYWRITE though...

>
> --
> Pedro

