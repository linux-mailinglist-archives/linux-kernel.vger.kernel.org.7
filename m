Return-Path: <linux-kernel+bounces-737019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D2AB0A6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3A5A2BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF3D1ACEDD;
	Fri, 18 Jul 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d1Kokoiw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZHd9UG09"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAF52F50
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850555; cv=fail; b=VxDby4us2k+b5NXxuRg9M66BGqbn35D3y0TQF7uJ0Tdq29OQIx4PQ+3tGzs0Hg23/dkY7GmfXyk0qbCeTk6Me9kOHvugNZ52hVwe6NasI/6TTk132EkXjmvMW1rEveAh1+0c/I4PdKrcPyzPrPZYrTTzkUeXiebYAu8/RCqEVLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850555; c=relaxed/simple;
	bh=yIvNANIQwK5g9qMDCgTUBgTgrqFw2SDoN49q+fYaBks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dA/XB2J9AWg0OKYWuEEZ4PN0CFhA62znA4pzvURfsMkTiRtgsugPLV/26c8sgugmHYUDWbLqn4Y5Mz8FERp0/g9BxM5S2BxyBsR6QMVTh77MMzxgGxDU58uB/I9vySx3hF1rSRmdULB7vgCbVrNwnRQrOZodqy3e9UIWh1HBDzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d1Kokoiw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZHd9UG09; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8ffL5022800;
	Fri, 18 Jul 2025 14:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=chywWKwA9+tHZIFarH
	8GFMPtpPla/e5VsItzqq+Ztgw=; b=d1Kokoiw0Lz51JyFeArTiFDW/rVr+WW2qv
	ivnvadd6YeW/G4g8XnEGLJlMph+rAhNbWV3fLXjJx5+pLPNSTOgwtlQKULgkdubW
	PlRyxqoOw/6cl7e/zjwINmT0Y+4O6O81mrQxR5W5n2sK7b7mzqBbHWMcbaHXNH+E
	2Dc0NRiTtHA1H/1Tw5ynGWV2swVMxNALnF/GAJCHIsWP05lhxu+tYUFKJtn3XaqQ
	/36avJvEQ3owYR/WI3mWLpyvBfXGRpq1pCehmyjzWQzZYEIBexCcyqaTHIv1YyGa
	ls5mnn2qbt7r8/ZP3G7ltjUefm0JC+VPwzPdm+eI4vu5l//F/kRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx85e3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:55:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56IDY3iw029672;
	Fri, 18 Jul 2025 14:55:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5e3w2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 14:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMEemJWdjJnTBTt0VQCMu8g6CO3HZx5sQz/V6eg8eyB3JuLU+ctXxrvNLCLKr2IUpaPAADiiDNXxSeK3UBpNL5HZQ0/ikHHQPm3L1BDHv3OXb/vn5A2gHg+K87/IEZWwgvErkmQ/pNABfxRw25lJeg3/DbEw44S9gtDIZkT+GxKe0HRYMHJXnGgsXA91jnNRTQxdqUgCtq2J/ruRL4NHtv8c3Dr7KfhnRAOIwCfSMeFOrqnaVg5bzYe0Ij44sjjMtd/nEDi7dk3Fv1aY/+8WNtgKouaMeQjN/EkOMN0UTnbCUmJVnz5ZvKQtIOyxDx6ihfHE28fxvOlcmqe6YscHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chywWKwA9+tHZIFarH8GFMPtpPla/e5VsItzqq+Ztgw=;
 b=stciLKD1nSrkHZM0JWw4ZnoS2BLQvDZ1qOjjaWPmvU9AOghwxCdkA3o6qmqybtz4yqlqa1NRyc5stALhuC0mmhbt9l9OchFfBQ1HRq0rjyoSpSMCqGRpZrZzk50b8EG2wCCgLLOn4z+45Cajkz3oSF6rJlrNOxeerp/v7WDpQxzXd6LRm6nPpzXK6BbfNZ6vsqlECnweECGWHEFSOcqEtAB8tuqt0wfuYsOPFNL2B7K925jBy/zs5aKuyS0C+qyuai7SzqZ7keH5nW3f2TcvJyF7Dsq9hEJwVhWHfDc/tZJiX3gbNewTBUU6St6krz30iin31u1NoaJF3WnVCHhgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chywWKwA9+tHZIFarH8GFMPtpPla/e5VsItzqq+Ztgw=;
 b=ZHd9UG09p51SoupBXze1oLRt+MIpIv8IqyZzDG0jtiwfoKEJbjay0U4wKwhW1/wujSSPdIqCfzFTazIPZft6+HFnAGI+J6lAK5kBBcq3g9E3ohgNc3Neof06/eOE8UZWMQGpQtoEv9/oTnplrUxCiy8y3My2CrVioRulnPxVhgc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4675.namprd10.prod.outlook.com (2603:10b6:303:93::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 14:55:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:55:26 +0000
Date: Fri, 18 Jul 2025 15:55:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Shutemov <k.shutemov@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Balbir Singh <balbirs@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
Message-ID: <90268505-bb86-4359-b2ed-0309aebd9ba9@lucifer.local>
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-2-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718023000.4044406-2-ziy@nvidia.com>
X-ClientProxiedBy: LO2P265CA0446.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: b427439b-9717-4f26-b699-08ddc60b21a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FgeHTbu2BCIJOaITKPw1ZZ3HV1X7wxIWAYXU2IxtEQagqv7noQtijuSR335X?=
 =?us-ascii?Q?fFb5KE0C8FRJnL1qtqYKxkJERjB/QSr50v/ShvSHEdcPoRIVk9a64yFPCcb8?=
 =?us-ascii?Q?Dtbinwc1yCYGLfdHwaCHWEJcUa/phQNvHyaUZYNrgxpAvGyruEuA+84xz2wo?=
 =?us-ascii?Q?TkAOlIobhjpPNpYRci8Q+/bw0lIzSs0j36P1OZ/C4qrPcEQ/AtPqbt7VnKKS?=
 =?us-ascii?Q?2XSuxjTsXHaRcbehn96oEeM+jAUlKhgRlzQm9owVOZACPuyIJd2nOACwA4qa?=
 =?us-ascii?Q?uysaWthEKs0KCWuk5WCQeSQFsARyzpXXfWwEl6RV0JHeY/u3vG9Xd+y3HreB?=
 =?us-ascii?Q?vIkJsZz7ir8mOdk4YOFPXKp7wgOi03IsXYLLFpNSOSE75boi6xyKWXXhr8or?=
 =?us-ascii?Q?P028cRfM3+l+ehWBJjKWiGa443EYnP5lDvrzuKXQsB3iH5OyDuVz7PvKvlJc?=
 =?us-ascii?Q?LEw+2aHL4Plmo5v2jA5crK83C/rph1RUcgTbH2r2A+o0csOZoEWkjUJlAVCt?=
 =?us-ascii?Q?xu/hmLuue+dZH4iDWYt18IvfMDho+OcMD2n2zidkPALwlawCffJvk0EIoGi2?=
 =?us-ascii?Q?l44CocWewTJ1PlOsi8t/pE7z4oDJyb1rmxMuA/UgYS1Fb2AlCWFalvVPOvh+?=
 =?us-ascii?Q?uF0ufRzevS61tSFSjJpiNMeR2ibr6yyjV/+Tpm2/P8oojCfHa59G0mVhz4xM?=
 =?us-ascii?Q?F2+FzuFN6qgtx82j+0obv6IkKfLqCk7BAXfgbyzGcWcyZACu2urIZFmnLORL?=
 =?us-ascii?Q?yh25cIe/6199oP4Qk3nG7qBi7j/ANA9Msphp7zMUjbT7cYcUKRUBS5ehFPQK?=
 =?us-ascii?Q?HQtKis8dU9vZ0h6mLBTo08+WBQRNJK5hz0RcJsl4daxfU+C6NNr9gT0k/Fyp?=
 =?us-ascii?Q?LSi1Z53shsX+DQno0C5oDKEK2pli15o4Xm0fWPTCy+gCqFujPXKWDlVnd1h9?=
 =?us-ascii?Q?K/YQ4FuairWKzBFgkqERqVvfuG1LdEVO0FhuZILr7a65UDGvom2MdO7cNH/q?=
 =?us-ascii?Q?KPCr1RKvmHCTmAdQniCl2VGB+r39LjVoGqk2/cc1YOS4gEawp+wgqngmn/zr?=
 =?us-ascii?Q?8i/XkR2mjUpEXpA5mr3LKs+qWIugsuMHRIGJ2i8SYv8J+NwNLvzV3qHUWD4E?=
 =?us-ascii?Q?chZ3/wNqQnAcHWTIHUbmSY3FxfvO/ERp++IRKqn2kV2RKICoDIXW1qj/UbkA?=
 =?us-ascii?Q?A42Xa2hTbyMjCiFjKfTeLi+WSib7xlOmm7mRHBSOn8i89LpExpc7ag/0bjFs?=
 =?us-ascii?Q?vUTkGsRuX0aRQmobfx0hMvpLXyj8oYBj41lWcukAubyXkubNKpIPbTamSNyo?=
 =?us-ascii?Q?OyJMEZrkcIC5k3AIUDGCLZ8pDipnQ7cbH796/w0I3Z1NyUJzkbJFFI6a5Baj?=
 =?us-ascii?Q?jZIEIg/M/75Xhmp1r5RR+G7VtCGTIdqKIrQv8IfAnnGgqtSvEJE+sMZgAZMo?=
 =?us-ascii?Q?5G1miGM2/nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9pnrSlyfX02kk41h3Q7cZJMFxEnyHsdXhT+c1puoGwbVd8ZLR/t+tY6TMhY?=
 =?us-ascii?Q?3pAzMw+VzldHm2dS4SIcpfEZ2bs1QWiqXzlyEc+V5otWpyCngY4k2TzaFgk1?=
 =?us-ascii?Q?iP6yA55e64HDlbiuN0nGV1YIbn7+XRB/zzZ4O9pvxN45M0bHnzG7R980kTed?=
 =?us-ascii?Q?P0m9ALOgjja/weYw91EXDXXJttLugpTV0g+K879az3xlI26V/JuX3w90VOYr?=
 =?us-ascii?Q?i+ZNMovt93Y7ch8BMRmtLFA5iCioAFsFgf1b1Y1bCPsaBisKxe/mkldjTIDt?=
 =?us-ascii?Q?6n+YEgpUbMLzDBt9NbGNhIXlPDH0AKhmL+tbAic7UrLDONlnW2KzbNh1kOvK?=
 =?us-ascii?Q?8R9zOvk76aq/jZ9k/bqmjfS815jp7ioBq8V3NE2N+EIo2X05CupBf7CHiZOU?=
 =?us-ascii?Q?yFj5KXNWnkhAKkqZNachxAkabVK45PQTMki8xLiDjz3G6LZw5/iE6xohtikr?=
 =?us-ascii?Q?ci5d3NuhaAFjHHY4xxTDbxLau+L+LsUlrjmZzfDWKK55T20OjEN6uEINxRC1?=
 =?us-ascii?Q?qaLHvErDf+Ve28kP+hpu80+dq8kerFLyPXtAPJLPcGz30jAU7pf65aMLxMCa?=
 =?us-ascii?Q?cn++akkaV4UlTY1ulWNL1JsWmRMgIwqXkIpyrU7F1lUbgs9pJAFSqNX6gk9S?=
 =?us-ascii?Q?zXUfwoBqsKM79kinfQ/OQ5SxFui16GiTjtIhPiMJESWYfi6sBamObNQLZ+1G?=
 =?us-ascii?Q?qB0jb6XhdKKOyCELThW3ruSKBDTPJNT/+D8YLUadINhBNRSklSuYgRIaK0vY?=
 =?us-ascii?Q?GQ2Jptj19UnlgJ6ZJAy3/uvfqA/SQQDGjvvR+7kGGPe9XZ30Vr+p8yimkxs2?=
 =?us-ascii?Q?Ol9DB0RH+k9i1y+PdUODdNrNxRw9oD0BvmOmoog+BQH2LNNYhz87lys3h5JI?=
 =?us-ascii?Q?ADxHFzlZ48fZNpSn3H2SQUteViDA4SBltcGB2QWmW00o0CYJSacCdFv9DjXF?=
 =?us-ascii?Q?ucqvUgd9kg5IQ86vuKmcetQBB67rL5prCxHoMMSEF3dw+ocoMeliOxot6T1j?=
 =?us-ascii?Q?BQnZAd61gJoBNMozJZODiIDqcYfv5MX2OlyWqBxiWYeuN36mYUptiCDKaN6x?=
 =?us-ascii?Q?5EvJPor3ESVGg+wD8f7K+/Yw2gvE+/l+n0v0JKvnu+DcGVVm96/R67QOzdZy?=
 =?us-ascii?Q?wWpqu+GMoGI5RNpmw8X0HRhy2HVas6fK74iARsIh38r+GfaqZhuAFU1CWkup?=
 =?us-ascii?Q?bI2zU6lsX+7OdZ/kwdICcKnRn/XTA4xeuFfJzEpBt/DyOZAY0eyXR+JRs7k3?=
 =?us-ascii?Q?X3OyaKGqqrRaw8e0I/d4DW+M1QURmkzdjcxXp1XEL0rx0rrMfL7Sdh7CS/J7?=
 =?us-ascii?Q?5ptbml3EO2MbFcXQmOwXm1kanlckmAt2r2TgHTtWq3OOK1MC//DXqRFmzfrj?=
 =?us-ascii?Q?AhbA7mWSUeUvhTrW0C/6lkMMUMAPAFUEW2mNjrqFPyFZ67u54G8UDLLBupD2?=
 =?us-ascii?Q?n8TMRu/JF14ri60xSmnl3V7S+L/tK0akRIKWzmTQcEvUTPYCmX7vAJWACh79?=
 =?us-ascii?Q?IKIu2NtC97UFVvaK6cVMZ8k98N3VvIq4jxfH9UxRLuzINeXJZseaniLccncc?=
 =?us-ascii?Q?xf+feJoIAKWLOw+yhYHq2D6YR9DkVWR36dmZoLYoaMZtMKQ2nH7ZEHDUQ5g2?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nkpZfkTJLYfxQ7sJHOb6SH1vXtItwWUG6/twnfZTTmZmJcMZ+Cluy77NdQRPBsAki0Zxcp9DB1X/hsMgAOm2O7g5Ct6AD+VPEQrsUJdf2+Nl3s4HO0s32N/8s0v5zu/P+SzA7e5LRISGMybBfAOwU6+rT9X/d9Oi2yQA2Vk/dMSqx0pSdItT6qIyjBvBnouVrGsHFa+6ySkbw2i3V5hg2dDAvtXH4+L9Igk5b7tB/Q8GDokP9Rgqqo4Rhc5Jj4K0SvoG2deZc7CPvV14t/Jl45ahkk/WcS7RL8AMF4XYwSeMym24Tg8zoCr87khdv57W3GZAbBj9DhRmIobeTXswcanANkwH2QmRamkNAO8KRBPVA/S4ffzpLyIbn2PKuUFXq16yzCMzL3JiHyo1gMdsAxd3ZALqlQUd5AkIgIKaZvW/OUH336mnfdIclyKTS7QX0DPVHXpe3mK/yo5+wNBDEBbrqfwaGIZSIlqh2wjbOUz+pXVkJq1PD70TjIyPSFqV3uMb4QcOEf5zYVHLhBv+D53naO2GOp8+nl8xjUbO0IPNGMjZjSZWZ8/eiX7gHRHK3D3wxb1nL2eXtknm99klkVCakhV/xxjNwK5CYlv9aeg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b427439b-9717-4f26-b699-08ddc60b21a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:55:26.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dN1wBcjLQ/vvX4mWcqGFQL6wi6R1Lw+TNTVzm7VSnnXmIXPFgwiz4WDvfGEJTp8is7xJuhtxpePwHx3LduHeaqb0+OEvEcnUupYUwCsAjc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507180114
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=687a6063 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=danPQwyK7wZkV9oBReQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: nvKprdgT6ok6zwiFUYAaq5Xh8dCdyBeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDExNCBTYWx0ZWRfX4jPmC9bCWpY2 KzRA4nPRZjDwUasPVl3BfbWAH98/aaBuwc9FbkVfJZeZ0akmiY/q/EFC9RlnxhCSVXNnMXn7/hD JkOZbb4VerTmbP8JR6OCLWCI6Zt/iEDl5neQX3hxysFHmdyau+eS9m/axZIf01Zyz6lAX5zk/Xg
 MJ3anfldPd48Y82COleN7leGqAZgvTFanSk5kqcUlWB/k078Niw01bxp5dOx1KLKDa/cVZ052hH P5ZcMquLQZ41DUi2OAOaHXpzwiLMhAP256zy9ZG+T81Z7HtnDgXEKZT6f99cyuWHnG8Qu8122nI cIRyhzRMVm9sJvuXJ6FDo1DUj75TziIqwspbcWnLA7+t4LAIe2OVsmtUb6z6ccKxeYUdQM1oErQ
 kv9/jbdXRQlU2e7maUG10EG9aexkHoo5YH5YJZib07z2lxP8j0KPmYO4uY1tmRHGQtUEwSTu
X-Proofpoint-GUID: nvKprdgT6ok6zwiFUYAaq5Xh8dCdyBeD

On Thu, Jul 17, 2025 at 10:29:55PM -0400, Zi Yan wrote:
> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> splitting unmapped folio operations. Move them out to __folio_split() so
> that __split_unmapped_folio() only handles unmapped folio splits. This
> makes __split_unmapped_folio() reusable.
>
> Remove the swapcache folio split check code before __split_unmapped_folio()
> call, since it is already checked at the beginning of __folio_split() in
> uniform_split_supported() and non_uniform_split_supported().
>
> Along with the code move, there are some variable renames:
>
> 1. release is renamed to new_folio,
> 2. origin_folio is now folio, since __folio_split() has folio pointing to
>    the original folio already.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

OK, have had a careful look through and LGTM. Thanks very much for address
prior review! So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c | 270 +++++++++++++++++++++++------------------------
>  1 file changed, 133 insertions(+), 137 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ce130225a8e5..63eebca07628 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3385,10 +3385,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   *             order - 1 to new_order).
>   * @split_at: in buddy allocator like split, the folio containing @split_at
>   *            will be split until its order becomes @new_order.
> - * @lock_at: the folio containing @lock_at is left locked for caller.
> - * @list: the after split folios will be added to @list if it is not NULL,
> - *        otherwise to LRU lists.
> - * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
>   * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
>   * @mapping: @folio->mapping
>   * @uniform_split: if the split is uniform or not (buddy allocator like split)
> @@ -3414,52 +3410,26 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   *    @page, which is split in next for loop.
>   *
>   * After splitting, the caller's folio reference will be transferred to the
> - * folio containing @page. The other folios may be freed if they are not mapped.
> - *
> - * In terms of locking, after splitting,
> - * 1. uniform split leaves @page (or the folio contains it) locked;
> - * 2. buddy allocator like (non-uniform) split leaves @folio locked.
> - *
> + * folio containing @page. The caller needs to unlock and/or free after-split
> + * folios if necessary.
>   *
>   * For !uniform_split, when -ENOMEM is returned, the original folio might be
>   * split. The caller needs to check the input folio.
>   */
>  static int __split_unmapped_folio(struct folio *folio, int new_order,
> -		struct page *split_at, struct page *lock_at,
> -		struct list_head *list, pgoff_t end,
> -		struct xa_state *xas, struct address_space *mapping,
> -		bool uniform_split)
> +		struct page *split_at, struct xa_state *xas,
> +		struct address_space *mapping, bool uniform_split)
>  {
> -	struct lruvec *lruvec;
> -	struct address_space *swap_cache = NULL;
> -	struct folio *origin_folio = folio;
> -	struct folio *next_folio = folio_next(folio);
> -	struct folio *new_folio;
> -	struct folio *next;
>  	int order = folio_order(folio);
> -	int split_order;
>  	int start_order = uniform_split ? new_order : order - 1;
> -	int nr_dropped = 0;
> -	int ret = 0;
>  	bool stop_split = false;
> -
> -	if (folio_test_swapcache(folio)) {
> -		VM_BUG_ON(mapping);
> -
> -		/* a swapcache folio can only be uniformly split to order-0 */
> -		if (!uniform_split || new_order != 0)
> -			return -EINVAL;
> -
> -		swap_cache = swap_address_space(folio->swap);
> -		xa_lock(&swap_cache->i_pages);
> -	}
> +	struct folio *next;
> +	int split_order;
> +	int ret = 0;
>
>  	if (folio_test_anon(folio))
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>
> -	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> -	lruvec = folio_lruvec_lock(folio);
> -
>  	folio_clear_has_hwpoisoned(folio);
>
>  	/*
> @@ -3469,9 +3439,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  	for (split_order = start_order;
>  	     split_order >= new_order && !stop_split;
>  	     split_order--) {
> -		int old_order = folio_order(folio);
> -		struct folio *release;
>  		struct folio *end_folio = folio_next(folio);
> +		int old_order = folio_order(folio);
> +		struct folio *new_folio;
>
>  		/* order-1 anonymous folio is not supported */
>  		if (folio_test_anon(folio) && split_order == 1)
> @@ -3506,113 +3476,32 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>
>  after_split:
>  		/*
> -		 * Iterate through after-split folios and perform related
> -		 * operations. But in buddy allocator like split, the folio
> +		 * Iterate through after-split folios and update folio stats.
> +		 * But in buddy allocator like split, the folio
>  		 * containing the specified page is skipped until its order
>  		 * is new_order, since the folio will be worked on in next
>  		 * iteration.
>  		 */
> -		for (release = folio; release != end_folio; release = next) {
> -			next = folio_next(release);
> +		for (new_folio = folio; new_folio != end_folio; new_folio = next) {
> +			next = folio_next(new_folio);
>  			/*
> -			 * for buddy allocator like split, the folio containing
> -			 * page will be split next and should not be released,
> -			 * until the folio's order is new_order or stop_split
> -			 * is set to true by the above xas_split() failure.
> +			 * for buddy allocator like split, new_folio containing
> +			 * @split_at page could be split again, thus do not
> +			 * change stats yet. Wait until new_folio's order is
> +			 * @new_order or stop_split is set to true by the above
> +			 * xas_split() failure.
>  			 */
> -			if (release == page_folio(split_at)) {
> -				folio = release;
> +			if (new_folio == page_folio(split_at)) {
> +				folio = new_folio;
>  				if (split_order != new_order && !stop_split)
>  					continue;
>  			}
> -			if (folio_test_anon(release)) {
> -				mod_mthp_stat(folio_order(release),
> -						MTHP_STAT_NR_ANON, 1);
> -			}
> -
> -			/*
> -			 * origin_folio should be kept frozon until page cache
> -			 * entries are updated with all the other after-split
> -			 * folios to prevent others seeing stale page cache
> -			 * entries.
> -			 */
> -			if (release == origin_folio)
> -				continue;
> -
> -			folio_ref_unfreeze(release, 1 +
> -					((mapping || swap_cache) ?
> -						folio_nr_pages(release) : 0));
> -
> -			lru_add_split_folio(origin_folio, release, lruvec,
> -					list);
> -
> -			/* Some pages can be beyond EOF: drop them from cache */
> -			if (release->index >= end) {
> -				if (shmem_mapping(mapping))
> -					nr_dropped += folio_nr_pages(release);
> -				else if (folio_test_clear_dirty(release))
> -					folio_account_cleaned(release,
> -						inode_to_wb(mapping->host));
> -				__filemap_remove_folio(release, NULL);
> -				folio_put_refs(release, folio_nr_pages(release));
> -			} else if (mapping) {
> -				__xa_store(&mapping->i_pages,
> -						release->index, release, 0);
> -			} else if (swap_cache) {
> -				__xa_store(&swap_cache->i_pages,
> -						swap_cache_index(release->swap),
> -						release, 0);
> -			}
> +			if (folio_test_anon(new_folio))
> +				mod_mthp_stat(folio_order(new_folio),
> +					      MTHP_STAT_NR_ANON, 1);
>  		}
>  	}
>
> -	/*
> -	 * Unfreeze origin_folio only after all page cache entries, which used
> -	 * to point to it, have been updated with new folios. Otherwise,
> -	 * a parallel folio_try_get() can grab origin_folio and its caller can
> -	 * see stale page cache entries.
> -	 */
> -	folio_ref_unfreeze(origin_folio, 1 +
> -		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
> -
> -	unlock_page_lruvec(lruvec);
> -
> -	if (swap_cache)
> -		xa_unlock(&swap_cache->i_pages);
> -	if (mapping)
> -		xa_unlock(&mapping->i_pages);
> -
> -	/* Caller disabled irqs, so they are still disabled here */
> -	local_irq_enable();
> -
> -	if (nr_dropped)
> -		shmem_uncharge(mapping->host, nr_dropped);
> -
> -	remap_page(origin_folio, 1 << order,
> -			folio_test_anon(origin_folio) ?
> -				RMP_USE_SHARED_ZEROPAGE : 0);
> -
> -	/*
> -	 * At this point, folio should contain the specified page.
> -	 * For uniform split, it is left for caller to unlock.
> -	 * For buddy allocator like split, the first after-split folio is left
> -	 * for caller to unlock.
> -	 */
> -	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
> -		next = folio_next(new_folio);
> -		if (new_folio == page_folio(lock_at))
> -			continue;
> -
> -		folio_unlock(new_folio);
> -		/*
> -		 * Subpages may be freed if there wasn't any mapping
> -		 * like if add_to_swap() is running on a lru page that
> -		 * had its mapping zapped. And freeing these pages
> -		 * requires taking the lru_lock so we do the put_page
> -		 * of the tail pages after the split is complete.
> -		 */
> -		free_folio_and_swap_cache(new_folio);
> -	}
>  	return ret;
>  }
>
> @@ -3686,6 +3575,11 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>   * It is in charge of checking whether the split is supported or not and
>   * preparing @folio for __split_unmapped_folio().
>   *
> + * After splitting, the after-split folio containing @lock_at remains locked
> + * and others are unlocked:
> + * 1. for uniform split, @lock_at points to one of @folio's subpages;
> + * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
> + *
>   * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
>   * split but not to @new_order, the caller needs to check)
>   */
> @@ -3695,10 +3589,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  {
>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> +	struct folio *end_folio = folio_next(folio);
>  	bool is_anon = folio_test_anon(folio);
>  	struct address_space *mapping = NULL;
>  	struct anon_vma *anon_vma = NULL;
>  	int order = folio_order(folio);
> +	struct folio *new_folio, *next;
>  	int extra_pins, ret;
>  	pgoff_t end;
>  	bool is_hzp;
> @@ -3829,6 +3725,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	/* Prevent deferred_split_scan() touching ->_refcount */
>  	spin_lock(&ds_queue->split_queue_lock);
>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
> +		struct address_space *swap_cache = NULL;
> +		int nr_dropped = 0;
> +		struct lruvec *lruvec;
> +
>  		if (folio_order(folio) > 1 &&
>  		    !list_empty(&folio->_deferred_list)) {
>  			ds_queue->split_queue_len--;
> @@ -3862,9 +3762,105 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  			}
>  		}
>
> -		ret = __split_unmapped_folio(folio, new_order,
> -				split_at, lock_at, list, end, &xas, mapping,
> -				uniform_split);
> +		if (folio_test_swapcache(folio)) {
> +			VM_BUG_ON(mapping);
> +
> +			swap_cache = swap_address_space(folio->swap);
> +			xa_lock(&swap_cache->i_pages);
> +		}
> +
> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> +		lruvec = folio_lruvec_lock(folio);
> +
> +		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
> +					     mapping, uniform_split);
> +
> +		/*
> +		 * Unfreeze after-split folios and put them back to the right
> +		 * list. @folio should be kept frozon until page cache
> +		 * entries are updated with all the other after-split folios
> +		 * to prevent others seeing stale page cache entries.
> +		 * As a result, new_folio starts from the next folio of
> +		 * @folio.
> +		 */
> +		for (new_folio = folio_next(folio); new_folio != end_folio;
> +		     new_folio = next) {
> +			next = folio_next(new_folio);
> +
> +			folio_ref_unfreeze(
> +				new_folio,
> +				1 + ((mapping || swap_cache) ?
> +					     folio_nr_pages(new_folio) :
> +					     0));
> +
> +			lru_add_split_folio(folio, new_folio, lruvec, list);
> +
> +			/* Some pages can be beyond EOF: drop them from cache */
> +			if (new_folio->index >= end) {
> +				if (shmem_mapping(mapping))
> +					nr_dropped += folio_nr_pages(new_folio);
> +				else if (folio_test_clear_dirty(new_folio))
> +					folio_account_cleaned(
> +						new_folio,
> +						inode_to_wb(mapping->host));
> +				__filemap_remove_folio(new_folio, NULL);
> +				folio_put_refs(new_folio,
> +					       folio_nr_pages(new_folio));
> +			} else if (mapping) {
> +				__xa_store(&mapping->i_pages, new_folio->index,
> +					   new_folio, 0);
> +			} else if (swap_cache) {
> +				__xa_store(&swap_cache->i_pages,
> +					   swap_cache_index(new_folio->swap),
> +					   new_folio, 0);
> +			}
> +		}
> +		/*
> +		 * Unfreeze @folio only after all page cache entries, which
> +		 * used to point to it, have been updated with new folios.
> +		 * Otherwise, a parallel folio_try_get() can grab @folio
> +		 * and its caller can see stale page cache entries.
> +		 */
> +		folio_ref_unfreeze(folio, 1 +
> +			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
> +
> +		unlock_page_lruvec(lruvec);
> +
> +		if (swap_cache)
> +			xa_unlock(&swap_cache->i_pages);
> +		if (mapping)
> +			xas_unlock(&xas);
> +
> +		local_irq_enable();
> +
> +		if (nr_dropped)
> +			shmem_uncharge(mapping->host, nr_dropped);
> +
> +		remap_page(folio, 1 << order,
> +			   !ret && folio_test_anon(folio) ?
> +				   RMP_USE_SHARED_ZEROPAGE :
> +				   0);
> +
> +		/*
> +		 * Unlock all after-split folios except the one containing
> +		 * @lock_at page. If @folio is not split, it will be kept locked.
> +		 */
> +		for (new_folio = folio; new_folio != end_folio;
> +		     new_folio = next) {
> +			next = folio_next(new_folio);
> +			if (new_folio == page_folio(lock_at))
> +				continue;
> +
> +			folio_unlock(new_folio);
> +			/*
> +			 * Subpages may be freed if there wasn't any mapping
> +			 * like if add_to_swap() is running on a lru page that
> +			 * had its mapping zapped. And freeing these pages
> +			 * requires taking the lru_lock so we do the put_page
> +			 * of the tail pages after the split is complete.
> +			 */
> +			free_folio_and_swap_cache(new_folio);
> +		}
>  	} else {
>  		spin_unlock(&ds_queue->split_queue_lock);
>  fail:
> --
> 2.47.2
>

