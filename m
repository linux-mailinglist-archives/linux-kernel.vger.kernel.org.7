Return-Path: <linux-kernel+bounces-893646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D97C47F17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2595D34A39F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F118280A5B;
	Mon, 10 Nov 2025 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="psR50aTw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fYLeIvbx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE128134C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792207; cv=fail; b=m2HCVI1TFVSO5sjXb2k7YermYvf24MHEfdfZiR5VshkMGC47kFJmEmXgXv+v77p5A6D/myRXw8V1aH8IT1iXhmiFhYyqSinr1xTuVmiFoTv/eCyezA99Y6m/Tnutp8/mfFerP7JMAC6Uglh6RP7fzool588Kr2I7+VbzItLnyWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792207; c=relaxed/simple;
	bh=TlhDmq+aPl79GpXvdIQJ8fRpBWSFyCNMpTKDW8LLy7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QglH8GQ6k955LCGe+4eXhiod+PaaTdtYuH4AHqD6bSTiPnJuToKDeNFJ/UgplowjpSw1U6DtZJB5SsWm/ezpp8KkOpJyKoYlV++wq5i+HnMp5KFFTKC62eAB0YrtXWSgHw66es0c7tKd3C0GEZE3l+ubFEoYlt32DlM2bTwgUh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=psR50aTw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fYLeIvbx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAEgApf004660;
	Mon, 10 Nov 2025 16:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zWWHcqDokmd5DhhrHA
	Tug+FF/gsbDY0rm1MflxbSDCo=; b=psR50aTw7DbrcqxOZeyF55/+DnCG/20ckF
	njxs5YYyzVPnQ+bx78tAOmqKNgn3dSlK2uTUcwLldGEXtRATmsIhf3l9nhnEfFL9
	hjDSfl9CGLg8OjYeSskTWVHPzK9DRoUU88Jrzs2R2U2qYMmolvCv+lr0W8CTnzDk
	cF5MTQkE8brPge9U5QcHR/jTKdyfYqfq1CiAIveEVPGXlQ0qlB2PGwHZ9RqD42bB
	5sYx8DnaUTpxE3ha5Q/cGk5Vo8Bw6/uxDHWoGuFGxhyJjMMpkWApawtQRMbM2waU
	gKqqZTjDDTVCKe1fRztoONHPWIaziIF4A3FFxt5fEEMo/CbgeA6A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abgs50fde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:29:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAEub5i007462;
	Mon, 10 Nov 2025 16:29:53 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8vswv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 16:29:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVuhZKbRCEE1AgCYAAfCTx+zGzH5gBzs+wBCZM2Nr+rczgKsg8Y0HoHMwF2ly+S4L+RPb/6m0xyRqykJu84cdZqZbWQ8TTkVAkv6r/gD3693TSzEGE74WQNk36z5DOhnNyeyAJgDNrlXtqyRWxz8Y/e2mPD3C9c8stWtesC4fvw7zxu7vuVkpp/Kua2154H1ffMFMDGOF3i1JSEG42PLH1awwoH4ABLpbJsooltagi7GY6Q6td7YoGB4VXyW2voz8+6R65HGR18tqizI8r+mAaa+473VRXFca1o6ba514Lnjm0ViLd9WeHSnVvmzs9dSJnq3eQtyYnq+MWX4fkImBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWWHcqDokmd5DhhrHATug+FF/gsbDY0rm1MflxbSDCo=;
 b=ZMm1pSGeVkXW4QuBz5kDbbfirPzoHx0I5jLzuVnlRzrxKREGYJvwcdkkqD3LTRCXivwUjffbvOdPOQ+ReyE5ixonpLEXmpdRdBzFbzKUYdnUPPPYwvaghQU1eFPgxWEWQX7hIqc5R5W8Qfu/bJkk/0Fb3h+37gUKOeHOso1WS0wGDHODrL617eJHvGfVsYF2cO3Zi6w0fs+lg8Xw086f15voZewn4BknCQVJsBrnkiHz1PQZcHwSKQm3HMSb0q6OA0FzTzJ+5WehmpykJHOz38kEebeU3EdptmOAHvwlt4Tszqk7Ux6HwFgp+/rw8qRAgPezkxcqx9uGw4wQb3+98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWWHcqDokmd5DhhrHATug+FF/gsbDY0rm1MflxbSDCo=;
 b=fYLeIvbxDtWGoddJvu+PY90meDZH+EpTULMMHcpskzDsIIixQi4MjG1R9t4X1tIz2kGraXGjH4rc4i7WT0XJJ3lR+X6zqn0ZP2gvMEeR64h/+n+3IHSQiLiffzKp9G29XY+FzJEcGLnZJH1k/0PFRyXB/gDVXJm8TcXjX2qtcas=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5082.namprd10.prod.outlook.com (2603:10b6:610:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Mon, 10 Nov
 2025 16:29:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 16:29:49 +0000
Date: Mon, 10 Nov 2025 16:29:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/madvise: allow guard page install/remove under
 VMA lock
Message-ID: <41d3da5f-70a7-4c42-b579-06cee613ef77@lucifer.local>
References: <cover.1762686301.git.lorenzo.stoakes@oracle.com>
 <d246c206e2df45cf15ccfeb33124809dafbe1eba.1762686301.git.lorenzo.stoakes@oracle.com>
 <a65dcd48-d3aa-4372-9c58-2278fc161b68@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a65dcd48-d3aa-4372-9c58-2278fc161b68@kernel.org>
X-ClientProxiedBy: LO4P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: efb3172f-7eba-42b2-32ae-08de20765e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjtk9iGtKJzZM+0yISt6i5qOSgYHoxFN8NQzqSRSPjuyKXW08UyQ7Zc7EL76?=
 =?us-ascii?Q?KoK5pKWk0pYigLAQbXkUAZ72wUhBOFy6a08qdeos2Iwz7A0GPKNOYMToqBNF?=
 =?us-ascii?Q?oY+SQZ97hVBHwmarPerNWKqUrR4zheewaJfAsrLLe0t4Q1vZTytu4UNym3Q+?=
 =?us-ascii?Q?4emptVzICsfvImdq0LSZjwwWFMWTEvj6kb2P46sJVKLwnZ4p227ax9TpNdfj?=
 =?us-ascii?Q?gjOdcle5/h9ZL1XEfSuKmC5bXqt6Q35m02n5pCQd6AY/bMfF2cJCAjJOMAU5?=
 =?us-ascii?Q?xnBJitOrPOxmd657qrtPnLnWJ8FiZKCQCK/F2mkUZAHF5TpPS+SE0CMotkwy?=
 =?us-ascii?Q?nwYbV8OSBIv0nuG8/s9klVdWrfybajLDGKT7ziY+a/tFwtfbfZKnlxXUj204?=
 =?us-ascii?Q?UGmxOhRzief/gmYvVsD0e3iX2ZSMLe0CysZB7ni++6mcyYZp0yE0iWpkrBcC?=
 =?us-ascii?Q?9624LECAgVO1TVrvTLrN3TNoUG6XASyBw+GXVfYvVMXYLL1/5a/llKlT0KDS?=
 =?us-ascii?Q?YsJn0NC2m1B5v6nSepH/joiURAh1NyyJp86YRs9cZQ4obGYAKgFCdqld/qY8?=
 =?us-ascii?Q?DhAvmx4BQG90KLurP0L1VzRlasm04FpW8DJqXFQtRiFQy56tbghukPC2g1cr?=
 =?us-ascii?Q?il+AV/fXJFLLwG3KBkQgL2CmbsunKwA9+v+J2GU5NHIZWVRCxZeZ1cUp274l?=
 =?us-ascii?Q?D8TsiKFQdoVfi3qKb8pm5hEkEhx65CIaUITlEXIalnr9e8KjuXtPi73Jfhjx?=
 =?us-ascii?Q?B0m1TNTsEcVLru9RcKbdcj+G6eiR1/nggWga+GXjIrCnYq2AAdz4GtH3enDT?=
 =?us-ascii?Q?O1pcUDxRsKOfnnsUN2mw0Sh6VxC3KHnsoOXReiHLV1Y5P2wKCZhkoFDqq1WF?=
 =?us-ascii?Q?wTcV6UX7pMo+J31daRotwisZLk0O/RsJ/pMCWL8743DlKCBTzNkdhmQfRql3?=
 =?us-ascii?Q?GUMrKHkWrRwqN2lOvEitpCGTWBsmCBDtO5MSJ6prT7tnbxMESoIdJzrHLIvv?=
 =?us-ascii?Q?UkINFQk2pZLzNUQkhgj/6uz7MdCPuvShriwfOxj4t/so861Fsw5lp0fzSfcF?=
 =?us-ascii?Q?jVOAUcfLBnhKvXI/pY5UnvTZz8Kb5w5F5I6eMeC0XDx0hmDjQhcA6gWxDGcB?=
 =?us-ascii?Q?4rUIMZXFfOhlGN9DmC7jG1DwIp8vbxr4A4zdGvfOLo2eaJo7DWc7tI955UqW?=
 =?us-ascii?Q?2rm6MjM4ZAnLpGMxO/auSDqxXJWMLu8262CeP+A4xQGZSx4tGsIGG5lWnhIh?=
 =?us-ascii?Q?pAznKISy1ZdJKMY65J1HHfbJrQnHAL/l7EpJd7z2X+uljT6sEfHErZR9HdT0?=
 =?us-ascii?Q?KoyL4xshk04PYF6J0mWh+BsBPhLS1kmWbdEevMo0wsJSkoN89gh6Dy6yU4T+?=
 =?us-ascii?Q?8+o9lhpR9HBqzQMX8iqVV24Kn4wOW3OZdkvoIzsetyVgvukyOmrI+sqyuHuq?=
 =?us-ascii?Q?7X4MxCFAHVUg00Nw/iIY8L27b+X3W21m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5BKuVhRk9r6RMOFmL97FlayrvifHr+mUVIWw33biQglDgEHpBaOihKw2vWMB?=
 =?us-ascii?Q?/dQl+SRvf+anfq+mbI+RyZHBe9cSlpIsPsQqJBPvYcrhV/TGFpcVEro+oulu?=
 =?us-ascii?Q?uE/2Cv23RBaypbxjCWUwNIUuwRvsihiO/XuNwnYUrhHByFRX7UHyMTZJHxWn?=
 =?us-ascii?Q?6iBsOMhuBDgnDiGH/k2ZKV73lokfYt4ExgpEo7BbAydoZ7NC2wpWW423B//9?=
 =?us-ascii?Q?2nlkaqKIyIUdqxh8YnlTzwSBkB4MxjSwEaezcG8HQU+V4f3KzhtImRpECEX+?=
 =?us-ascii?Q?DuiSmC3jd65qbYCH/PqBByDcONDTkLHapWVBwDMvKK4kRtF5ohy/V9y/2/8P?=
 =?us-ascii?Q?FNaZAwU3DibBmTjDhkBqZ4PQpnIMTjiAzEYOtL6WEV1Uy3fkG6Vvnl/6wZb9?=
 =?us-ascii?Q?cF1PQU1BHTx7ntkAFEqNuGp6XsFyqbc+ibjlZWd0TlzztA0Jm0o0Fxz491Wb?=
 =?us-ascii?Q?6I05SU9crhX0Lh9LA2+SWiNOnXQYMpyp9GxAfzB98rc09OWG426zw61oKf8v?=
 =?us-ascii?Q?q5IAFfRUdhenQmPy6hXAV+kGqMbCjbb4bsKHktov/nU0OvZ0Srjn7t5exn9o?=
 =?us-ascii?Q?Q7a7q5kLbRW63/D6Xj8yvKqDhXYTZ1egUbgBZYBNwsaua3rccREKZ1FB/Ju7?=
 =?us-ascii?Q?q/KJipPbRclwXt6voqUHJKtBPnkfX+6uOpgQCnGzEiK3z//p3vwIai5lT5Km?=
 =?us-ascii?Q?TQtmWUBDO8RW5TI3JxZYEIfIld3VTzJn7yL0u47M33+bU+Uy8ZS8+C/NEPsm?=
 =?us-ascii?Q?p5AfLe+MACdR36qh2QaFGwGoOJ/QVKltz9vlaTBd21cBmxhF8gcxmgKoKww8?=
 =?us-ascii?Q?rh9cK+N/fEgzZwc+VbYS2g2ZMfxBYyowgIRxNluNXqc5blEhAmJd4vlSbCq7?=
 =?us-ascii?Q?zuVEQQxNHIYjyvqDnO1GiGsiePpSoCddf+rvZn79UcLf42x5dVNbHAdcGV/j?=
 =?us-ascii?Q?NbheQvkPMvnoa3qEhBwLilwmBqzI41wDxLlrpbs9zedKv1FIJSB02zx6HNij?=
 =?us-ascii?Q?8Hqwem6k2eg2Mh8+nyfo/3UM4B/mHJagX0Hvby3H9Wf4Pd7fgpZVYKEB0adU?=
 =?us-ascii?Q?ulmRFRDOr39qh62G0GG28DD4Pe6l7Lq4el9DOwExBMDMPG4EQifVsF4/bp+R?=
 =?us-ascii?Q?7lkS0qqDDVwaAA+UnhEkFL+U/z3TudHwpkaKg7Vaybd13A8sd/hqdF2tf5h1?=
 =?us-ascii?Q?E8U86iUT2j5itHvtTweOP8NocDJURKe+SWHBihmgaykRdzRZCpakQH13FE6i?=
 =?us-ascii?Q?Wgo+ID/gPQz9uopO0D1PL4q0Qvak6eIjRd4yqZHGGpPRholIboZOoc9CqzBH?=
 =?us-ascii?Q?gaXcSRmO5Vna7XiAMsr70qkhBtoMJLqLirn5utg328qVWKUFGd0dKqE0fret?=
 =?us-ascii?Q?V6vTWzRXwFHO146VuZojLYTIRt0cnAZn33ZCWIuxyzV01TywfXZ3qJRG4npc?=
 =?us-ascii?Q?6NBISDQMDq9EG6sWXHk4OuyybvCr3BM/AjHnOzKorFFyLesnngouESwwLgOs?=
 =?us-ascii?Q?p7gHcyni2dcEAbPYDi4fvH5qQxd1b3ppUMQFlwVnpfIbflLL8iFbcxdA8MuT?=
 =?us-ascii?Q?2iZWu2EH2SLojYAEroiTTf+eDig4lRCE6JBbrQeLMZrXDEP6cX9dnaexDNDX?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6k27E2STFB9grhS6aSkgc8emPq5jU2H69FHYGQyqWauxROJ/uvcBSEZ/comZqH9Y2sRZRF01ntBzw+GJPe83cNisee/e7JfSXttQOaN3/CK5tp4/Ze7mGE9EQWeKYtMgsNmewKYBEmrvw9jUikLz6xgd4IgYbabIZmH74mMaHP1C1D2SWalrvcT0Uueo+aGtvHk9ioFM8B2gYftp6AhVLZZchGQs+4kCxYto+IB535CLF+R742QqgjWzeBvlLpsp4KAMH6zOkRwTk3bbtv6I3If+WiyyzcGmiMaGDjuFiDCyz13M4a90SpDZ8IvHie3CLSMdOzrFKEDiPQ7VY0qTpWbagMiZBK8d7MGASF36PICgy4KRqh+uQAmenOnf4oqqWvo1VQFJ92hAktwHwTAgWqL4zSx+LbxlgRCcm1ywEO3Zob0C1YmtHLmag2jm7gofJtEcdSGJyavqlP7swntuZ6tdEJ3/bpOB4Kdb8IZYD3VBPGtGAFoQQ8F3mNWFprF1Zr0fLxRR6pqokfibiNrQxPpzME4XlmL0Ocud/sxhaJXSb7jDqkDnPjhOwjS7WORtPU9ccV2qLQlfrAjq1p/+ZUkIENqHZgDveY2vvjmdUKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb3172f-7eba-42b2-32ae-08de20765e83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 16:29:49.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9+DpKt5DDWgPw/uMhNAgK9Yo4DolSLWfk8nYESooDJz+Ed2uKrAT+uri8y2LECY+11OpAsi3jerDj/Sz4/8esnkQKtukeEahXgNTdbmDJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100139
X-Proofpoint-ORIG-GUID: zzd25PJcVrQAZDOet1F8In3e1ge9pnsg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExNiBTYWx0ZWRfXzJyGxBOp1BV0
 kB6fpvMK9BkxWXiRem8m/ntCxEF/n6SY1NMw4L86jJOo6G7CYweS0pVTn0EYBZfvuSeQxqeTMV5
 R1jCm7P+IvrIXP9cHmvXVEz/vX/w07MYDQnDpU+yQTq6Lq9HOxY7wqGlLfWOQhARkRiEX/tikfM
 hKAcpEzfEfrHynzA0EyMabE5GK46f9u73RAAIyhvZD3fOIsPbLBhWdlAtVbveg/tZXOwmy7fkDU
 SItRxQgRj0rVkyeGIObW7BqSRpLo35u7mr+DuqeLduXZs8AGMRjturcdXyWJP73KtQRY4P0HrVZ
 tznXBM78n/izb7hMZDegwE+/THQg3+ixeDyHDlR/5fYmnZP0UZ2KsbNZZZsJ3g9mTURditYyKL0
 NiY3bi46k7olYo1gX5CAmz+2bfDjqA==
X-Authority-Analysis: v=2.4 cv=PtqergM3 c=1 sm=1 tr=0 ts=69121302 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=lfFO44F8Jig5ZvY1bS8A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: zzd25PJcVrQAZDOet1F8In3e1ge9pnsg

On Mon, Nov 10, 2025 at 04:44:45PM +0100, David Hildenbrand (Red Hat) wrote:
> On 09.11.25 12:16, Lorenzo Stoakes wrote:
> > We only need to keep the page table stable so we can perform this operation
> > under the VMA lock. PTE installation is stabilised via the PTE lock.
> >
> > One caveat is that, if we prepare vma->anon_vma we must hold the mmap read
> > lock. We can account for this by adapting the VMA locking logic to
> > explicitly check for this case and prevent a VMA lock from being acquired
> > should it be the case.
> >
> > This check is safe, as while we might be raced on anon_vma installation,
> > this would simply make the check conservative, there's no way for us to see
> > an anon_vma and then for it to be cleared, as doing so requires the
> > mmap/VMA write lock.
> >
> > We abstract the VMA lock validity logic to is_vma_lock_valid() for this
> > purpose, and add prepares_anon_vma() to abstract the anon_vma logic.
> >
> > In order to do this we need to have a way of installing page tables
> > explicitly for an identified VMA, so we export walk_page_range_vma() in an
> > unsafe variant - walk_page_range_vma_unsafe() and use this should the VMA
> > read lock be taken.
> >
> > We additionally update the comments in madvise_guard_install() to more
> > accurately reflect the cases in which the logic may be reattempted,
> > specifically THP huge pages being present.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
> [...]
>
> >
> > +/* Does this operation invoke anon_vma_prepare()? */
> > +static bool prepares_anon_vma(int behavior)
> > +{
> > +	switch (behavior) {
> > +	case MADV_GUARD_INSTALL:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +/*
> > + * We have acquired a VMA read lock, is the VMA valid to be madvise'd under VMA
> > + * read lock only now we have a VMA to examine?
> > + */
> > +static bool is_vma_lock_valid(struct vm_area_struct *vma,
> > +		struct madvise_behavior *madv_behavior)
>
>
> Not sure about the "valid" terminology here.
>
> Would "is_vma_lock_sufficient" be a better name, that would imply when
> "false" that another lock is required, because the VMA lock is insufficient?

OK makes sense, will change

>
>
> --
> Cheers
>
> David

Cheers, Lorenzo

