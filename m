Return-Path: <linux-kernel+bounces-731574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4739B056A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823D73A3107
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5D2D8394;
	Tue, 15 Jul 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jQTb8U26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9izoZGd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD92DE6EB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572074; cv=fail; b=Q23zvIs3DhdnjcT4t6+czE93pr7xqKjmdNvd+zTXdoKJh5Bc+Kmej41qTstUvF/8tEhKSYoyKOVJLWlXyo4r99pVHrsUhEdniDpvG7lnrM3tmDp7VDplCtCM7g+I37ABWP3b/reUfT/hPi47jfDvqczcLMIkZAAdjIp6oQbqmx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572074; c=relaxed/simple;
	bh=RczgmfSVX3XFR9ds40p3/wuAFEusGm4XkSrONGPiqGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jb8rgQrILpF2iab0XYpMF4Gqum0bbjt+8Irt1pY4AKvjWYQkCnTOHFUtLeCmkKqbLgPfFW8KwTIOiffJiELjE6GzKYcksHqtpimYernM8V/V8IgihKpH/F9KxTmT4kUC/cXhz3tIGvN0xt9x9110F3fVmf25TYn2zMngnVziK5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jQTb8U26; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9izoZGd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F1YxxE000698;
	Tue, 15 Jul 2025 09:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PihMYTA/DW9vtaxzI3
	xMZ5v6kAGKXV3twpXBBn/kJkY=; b=jQTb8U26Crd8tZ/q9jmIoyzDT36NFET9ob
	6hMjwGukbyvRIbWCEz83P68t7xiKfoS5iCcUwxEVOnWeAJTZE0mV3tCxG7c6FsfB
	YMOGpD4ZBCpy6/j63Cx6rdfj6iR5jXYRfXINQw3wFpIDHjWXfxVrthIgcAaBHS/i
	qpjuaysReBAUr3g3IWRgNAyASPcl4wAc2i++B8BaPskr503atSkJgR+tR72n0kgD
	A+AHqWQLOcdHKzc+IHg4cZpm4ZvnF/VJfijqLVDQG0XRKLj/yxVaOWHekOj0LVdh
	Yi8c8dpOu/0RYRZWbbJ7Hxv71gHjYsXcDhinsGwP+SAIkOOIgEig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66x1vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:34:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8bvwW023974;
	Tue, 15 Jul 2025 09:34:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59qruc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:34:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKjBtrPz/z2Sxq3gcQqOVcNFUStPGhvNnlMVi1+ZNktB3YARwsZdmbxKadmRhQoYZ3BIjOKNraL7meZjwPqDL2wHVzW7osrR19MPz3GAEUlTc8sUQwze2uh+Qbxdei0N6X/Kgi+5Vk/JtZDhYljBJ0WQyFNSAwM/B6pMo0zrQAQTKirqNG+vQXjFcdHyzJAkAvnvxpHL8savy6W0/VzBgKnnqZutw7lUO2M777i7+4lWTWq31MBo1cj+RMua44BIQz+og7+nSuipQZ0pF9WfmsSuQctZ3PbbXOQy13B25ZtARLJkYq0SmFSwkOZzVBY50pNisjO6SCNqsSxlLkmzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PihMYTA/DW9vtaxzI3xMZ5v6kAGKXV3twpXBBn/kJkY=;
 b=rUhppJDg4Bg+clDKwl9HcEJsna9NX8PO7BBUPTvhZKuiCU4moeEw6gpdoVDmuNfpcFCGShgBX5MWY4+WnlU5zqHj0VYjAF4/34pgq+M82/77lfNFa4GciAswc/5cRGLYNnp+HshjmExHBeIOFvVjhTnQ7wH9RHN/ZM5pU8mU/RETL+MgR9hlz7iMceytlltUF4GMY9hbsoc8IIVhwsODFQy7oKODAN1qu2VagljfexB+YXITwj/DLQpV41ug5Grp/UWO1mhDy8MUOrDVRVTaDAL5X+jDGbq6Aa88rSya5YJ0p32qMIEUugt+s6R3xESeJNuAEH+fkWB5zW3HuHVvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PihMYTA/DW9vtaxzI3xMZ5v6kAGKXV3twpXBBn/kJkY=;
 b=k9izoZGdlttvXGbEkHJ4n3/aK0EopdqK8LxXhxxZ66tS6FMV2Jmbd0rL3XLAod2bc2WvqmSJkD73DXp225AEROO6SBRjOmP1u6uHDoRD8ZUwKgvedMYMPkkfVzUfP4gRlK6ITKAe3O9YOcL2xvwj8FN2zz1MxIUzPjxQ7kMgnZU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6440.namprd10.prod.outlook.com (2603:10b6:303:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:34:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 09:34:00 +0000
Date: Tue, 15 Jul 2025 10:33:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shakeel.butt@linux.dev, surenb@google.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
Message-ID: <f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local>
References: <6871f94b.a00a0220.26a83e.0070.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6871f94b.a00a0220.26a83e.0070.GAE@google.com>
X-ClientProxiedBy: LNXP265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca05afe-5402-4d06-c379-08ddc382bac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AP0THna9oe7fFHCF8roGZmWb9cFTTz45kt7VnDYRRmsZWC23rP0AfKEA+yXO?=
 =?us-ascii?Q?LLhT793nu/UzrIKo+tzQm0KioTE2DgGIIDW9lQm2826+BeuYpB4z3J38S28u?=
 =?us-ascii?Q?/wQVQFiOVBwWJBGxiMLCTpkN5e2TG3ENwnB4hjp25RoPPcYLCcyNQO6aikqz?=
 =?us-ascii?Q?TS0JxBWQe0kp30dl91c4W+9YgYFXjtvwr2hKOmyKDGQo0y2n2xiZecAYpObf?=
 =?us-ascii?Q?wIk1Vo+iTnwgc2UMH9zbxmzfk/zgkKIKzyXNbd507efDMuPt7KItyQ0yIlRB?=
 =?us-ascii?Q?hd+61Yl69V0DZiCcitXvcDpn+SUaofYkPqbdLyvTYOBsNIaHU8Wk/p7G6uUE?=
 =?us-ascii?Q?klrlnlml83klea2NM7lc1UJqynGl1rcsCLo9xfZmNcodjSQ+mmA5FZ2U4IP0?=
 =?us-ascii?Q?GW1TGa5zljLolRVUHIRBbjUPqNOhzL93dkaskU2SDQJIffBkTgPzPeGDCCs/?=
 =?us-ascii?Q?d0GVU8ymEmzDYyOVgjRXDPbJVKdChs5IfHWUFSNvWw8g69sJEl7sPrE9bt6p?=
 =?us-ascii?Q?UpAG3f9Oj0B7YKkIU+Pm3CnrJpPuaZ0iBhdwqiRbMhNU4DIYgunCqoJRVGTB?=
 =?us-ascii?Q?/1fvPlX3yaLl9HTWCKoUIvs3Jh3jcVMkjrN76UEoK+V9BplYbriASSHir6k8?=
 =?us-ascii?Q?d6Xweqn1l6PzVHDCAvP+ri/ST+gR5DoBMehsGQzwA9n7O7JsnFovfa1ahHze?=
 =?us-ascii?Q?xbc7F7XCttaGBwrgD+hyjoIOwlgwhXtGTMNRbd6zg6Szps/Y+3b7af9KKvk+?=
 =?us-ascii?Q?EjYBSy/E7cv6pl8AHu3Z6eoz+UJtC8WNnhu66484DksCpx94cqV3f9NdenHv?=
 =?us-ascii?Q?/hQ3wYSaMehYZyuTn89gbfFgcZfTFz5kXRItyQomxaRs6vmgEk2rraMgts3d?=
 =?us-ascii?Q?fR19pEutNnAwIQMjHIWnihtemSeuvVJOj1cDY4YsaVy3tjDY/zWnXwL8CxHj?=
 =?us-ascii?Q?82rOetINxoWhr/GUrNR0itRDBFL7GEjH5PfttNFcKnZNcUW+71PlacVGTkFG?=
 =?us-ascii?Q?IT/BmWDlpwA3IZp2XG/vpe5by2O0t29nziJnGoqYrU1/GA38K6h/KHoPx/ok?=
 =?us-ascii?Q?7eMs8RYJ/gTHcV6I8u/uaAh0yesiRi2kFPMrEkOJgj+n5BUsgHuhTIbnGZ1c?=
 =?us-ascii?Q?0PQV1nkcmNGmsCjHt/xP2qvCGci8q1PIiJhFizjTq3OKyDSA23jklnXsChUD?=
 =?us-ascii?Q?hMEvj+yl5S/mrvEzfLRKY46vUPop7dbjIkt/k1IZu2FAZYkGC0uEq012Zoq2?=
 =?us-ascii?Q?jOjz2eAv0DAORANKK9Sri5cq0iPlKc8rLG7LLzA8RIhaauJyhv27SR6qm+Xy?=
 =?us-ascii?Q?HdDD2QMhAhjBllFlrpX2dvq7O3mumbPq8tT16r/P5+PBzDoBPLge5cYA9Y4b?=
 =?us-ascii?Q?6uRdMtAv2UeG6gDbfT/emVbSdqgU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGF5lbJh4bcZGnA6htUFES51C4YVFR2ZmO8Ro4DqlJvDp00nQIsfCELgw+/y?=
 =?us-ascii?Q?FanZiGFdH8KnckKrzw0W1T4T7nSDC4itiINSIWbhwxVS3VDE8lZJo9+P+Sr/?=
 =?us-ascii?Q?BYTX+S/Z5E2fBbacuwkgKbtOJVa3g6AmGQXCZEREILU8PyB97h6WSV+5Y6iP?=
 =?us-ascii?Q?9k+Eg45p5BrRKXxqg+oTxm9m7uUe21ULjSVGaXtTfc3wBFo/ETbJMcmLMDHb?=
 =?us-ascii?Q?5+9eScyvF0xBCe7oO/CjfspRe7WsJ62x0KML3boST76Nj91sGUIw90zdxWr3?=
 =?us-ascii?Q?RtLs6vC/VlUreMVBgGGpuwtTEKxQ2XuTvfbGXObCeAn5paxjPNrD3ZLK/sW2?=
 =?us-ascii?Q?6TX9pgIvAfDENBcuAqgbD52PQj6wwDOgQ1xmOjh1w41NmkkTyGEQ8/dgdnQ/?=
 =?us-ascii?Q?I0vNMM0EXjoxRwA5K13+kfyTr2JzJcyw3XL7rOti+Bn8myy6YdEOkVohdfVC?=
 =?us-ascii?Q?BPCyMoi/I2yjZb0y5TUa21HtPDrU3dZQIrc+AeDCgmFYJU+YmekCXts6INQ0?=
 =?us-ascii?Q?W1SqCCMpHEtlhWRx3OqY3DXxBB8sZNAxZsA3DUeryuRKBMEjcuzSMn3un9jI?=
 =?us-ascii?Q?uJ8LkOpkqM2CeazfaOv7BzLlL592DcSEkFtwaI+mL90mS1OuhgTkDFolUWHx?=
 =?us-ascii?Q?wVrbCw0DhF4flAZYS7pGaQHsKd0Q0e/hWCd56CyOCe/ZvJS2MZbHwsWaDTcx?=
 =?us-ascii?Q?KV0PLg4JpP3gQKdLttnGSjmtaYc9pSPrJmU0idNoeXVFeowKdUjKoETv6vmB?=
 =?us-ascii?Q?Lzp6hYdci3iAbGKqgiUnjN1ANJjCkP4XI0VNNWxaRPeDt+K2yjixPuZgyaYv?=
 =?us-ascii?Q?4dF2lp/lu4ujj74mzOeD8VeVuiogeTUKN0T7kKwCvL4ETs5DaSc2v+GW2QqS?=
 =?us-ascii?Q?m64GDplF1dcw9S4ZCOPbx+hJTA9xQxFZWk51ragddjmFI/y9xMi037n9+gBX?=
 =?us-ascii?Q?QmOs2EcE8ezk4xGKMbF+UWxyktCf1VZPiUrrRY+QrFcvQ8OogH+GPOR+cQZc?=
 =?us-ascii?Q?hMT7PNCEZv/gpn+VWkufBTxYGUEN3icjM1N6P8RabAcwAFOJtRC0n233/dG6?=
 =?us-ascii?Q?OcI+mHKeOuRJQSgH/lG1q1VnD866Pog+5zC52k+rH4pj/NIY8g6RCpGn0VUR?=
 =?us-ascii?Q?Bk5qi9l0uzNYlpMJEZQe3Ukyo81is64435+74+tEXg/kcx2OMp29cAhXPcrm?=
 =?us-ascii?Q?ffCGmcb+rdcg6A4QJDH+DrEbCF8ZPDQ5eG+PSsnNZz8Cfr5+GHtDc79NJnLi?=
 =?us-ascii?Q?WDMScCssQMt1HQ/OwNnL7ug4wSYYn2XiE1+AjF8xM25iqAj+wMJIdCNjZlph?=
 =?us-ascii?Q?8dSychYq6W+VTTH65dRUnNXu9rEsWSMJ/zdgQ2OwEuFwZqxt4O1wxCC725vZ?=
 =?us-ascii?Q?9R615HE3RtwWwyIIYGkm5tF8uGyYsrXMz+TmKJ+frrNLr61Ahkw1/FaV9msK?=
 =?us-ascii?Q?6OlOvKyBVb8PFAgDWc35URYKMbXI5WCEV+U1KXeQqE/bNMh4Tuyufgf4fm95?=
 =?us-ascii?Q?Rg1LqLf94pcbMHEpwA0dcQx8jS3OxgtKjgnGrsv9t4jPZRZfLnYYBJObBqQi?=
 =?us-ascii?Q?gPZiJgc3SFg22x176l07XVWD6a8FHKR/MIDHuRpDTSb1o0eEZivZVZU/WnLs?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T1RpNHD87OQSD/q8zKciKB5iDhqv6+3v0Ae8Sz9HQMeJWqPNgnuMtF5voMpw9GceIlzum+eBwUVHEZaA4OSE18zUpFfZWd6RLcYW45w7VPvlVmpIlYEPVGrpUVSd7X/L+oCMH1nej9JAFrSoFGEjbWB5yrnurk632jp2YhnyjegY3L6DPH8NDjmAhkOLRJbzNbT+/WL42kRa0a3zHbdEH8ERehvDSZ41sFbmwPy0DugF+9tuBwNyQaNtvsjYtDYfQhOihe4XysVaOOoYhu+JVEXT57G4aSnQP5EMUioJ0HeRC3qZFJV1jHgutrKSaVWCdBIjr6ILAEaHKhrDoK//3t6wNaKM8+2dSH2TxVzJcRAAAxET/vDmixeIMJC5tXc5uV/RNZngzYqUoo2rBRbrNufTZ5+xAAfVRQw8npuiR7CLnXCqOAQEv0+albV99XU16Gi+2p+Hi9Gm9S+UvbKTXIhaxJAw12J/ep/5PXRa2e8qNnPtXSP15ifTpE0lN2cijQRrTlbXVRp3bqHge3CfhY4mw35TyBmUXRbkjhl5DOT6j8KuARvKyyvrSe8A4Ym/EF8iV1p6B7dfr7ANVXW+eJiCtnskpgD35aYrfWr2skU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca05afe-5402-4d06-c379-08ddc382bac8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:34:00.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4NZvYwXNhu2gIhfhsYGhQFrRzkem0gomR351Yimh7O+kj6FIfnbaB3jACOb3bq65uOSb/vmTolOQG8vYTbMk6L7Brvgq4qZUbz3mGuzLd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150086
X-Proofpoint-ORIG-GUID: f1AXXTFbASQt4KLTykdmHLWf7rl72KtJ
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=6876208d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=OEu9Thw_nZ-Kv9wTCloA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19
 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NiBTYWx0ZWRfX0v3pzCJBN+jv 2I5mAwq2QZtTa5ptbLuwcJxWzjHnpdcjI0i54t4FVIINcT1YkJ5QtnVKUxou5msCYXJoLyW0r7B swgNu/IXR1fu5HtouzMlpdprS+XVu8l2Wvjzv17Z4wNjm3j3jkrIyGNgHrfXHjMS2RUuXseeVn9
 IwejUEEI2I4W8fPRzDpjdsQ+WEjECOpqtAeHmoTBzZ2ytF4RkxLcJ1wVixbcwqTuZRcQljdn7DX zP4BDS1JgoYiS725ubfx4R9oxmMn9U1sH8QAIyg2e+Tztb5IhtBDcW/N8FkRB/O53Ys0KBsRj39 3Wlqkvdg66L7hszRP0bbNmp0tB6HuwG+vDiMmy98ZbPo+vuJBil/370KEnFGQsYpoZmLpEarwo3
 FXjlK6jhvQAdhj8UxvFX2eEeGI1DCDGyQQfDsvQDo97eacqRdz7GiHtjCEMIi9WdhH76NR+u
X-Proofpoint-GUID: f1AXXTFbASQt4KLTykdmHLWf7rl72KtJ

So (as mentioned by others elsewhere also) this seems to all be a product of
ioctl()'s not being synchronised at all, and so when proc_maps_open() is called,
we set up the struct proc_maps_private structure.

Then in procfs_procmap_ioctl():

	struct seq_file *seq = file->private_data;
	struct proc_maps_private *priv = seq->private;

And that'll be the same proc_maps_private for all threads running ioctl's...

So both:

struct proc_maps_private {
	...
	bool mmap_locked;
	struct vm_area_struct *locked_vma;
	...
};

Fields are problematic here - these implicitly assume that it's one fd per
operation... and ioctl()'s make this not the case.

So you'll get the imbalanced VMA locking you're seeing here, as well as NULL
pointer derefs in particular because of:

static void unlock_vma(struct proc_maps_private *priv)
{
	if (priv->locked_vma) {
		vma_end_read(priv->locked_vma);
		priv->locked_vma = NULL;
	}
}

Which will just race on setting this field to NULL then something else touches
it and kaboom.

A stack I observed locally (the repro is super reproducible) was:

[access NULL vma->vm_mm -> boom]
vma_refcount_put()
unlock_vma()
get_next_vma()
query_vma_find_by_addr()
query_matching_vma()
do_procmap_query()

Racing with query_vma_teardown() it seemed.

So I think either we need to:

a. Acquire a lock before invoking do_procmap_query()
b. Find some other means of storing per-ioctl state.

The problem reported here afaict as a result relates only to "fs/proc/task_mmu:
execute PROCMAP_QUERY ioctl under per-vma locks".

Any issues that might/might not relate to the previous commit will have to be
considerated separately :P

On Fri, Jul 11, 2025 at 10:57:31PM -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d4df70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e4f88512ae53408
> dashboard link: https://syzkaller.appspot.com/bug?extid=159a3ef1894076a6a6e9
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/disk-26ffb3d6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinux-26ffb3d6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/bzImage-26ffb3d6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+159a3ef1894076a6a6e9@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.4.1737/14243 is trying to acquire lock:
> ffff88807634d1e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
> ffff88807634d1e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
> ffff88807634d1e0 (&mm->mmap_lock){++++}-{4:4}, at: lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
>
> but task is already holding lock:
> ffff888020b36a88 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (vm_lock){++++}-{0:0}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>        __vma_enter_locked+0x182/0x380 mm/mmap_lock.c:63
>        __vma_start_write+0x1e/0x120 mm/mmap_lock.c:87
>        vma_start_write include/linux/mmap_lock.h:267 [inline]
>        mprotect_fixup+0x571/0x9b0 mm/mprotect.c:670
>        setup_arg_pages+0x53a/0xaa0 fs/exec.c:670
>        load_elf_binary+0xb9f/0x2730 fs/binfmt_elf.c:1013
>        search_binary_handler fs/exec.c:1670 [inline]
>        exec_binprm fs/exec.c:1702 [inline]
>        bprm_execve+0x99c/0x1450 fs/exec.c:1754
>        kernel_execve+0x8f0/0x9f0 fs/exec.c:1920
>        try_to_run_init_process+0x13/0x60 init/main.c:1397
>        kernel_init+0xad/0x1d0 init/main.c:1525
>        ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #0 (&mm->mmap_lock){++++}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3168 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>        down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
>        mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
>        lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
>        lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
>        get_next_vma fs/proc/task_mmu.c:182 [inline]
>        query_vma_find_by_addr fs/proc/task_mmu.c:516 [inline]
>        query_matching_vma+0x28f/0x4b0 fs/proc/task_mmu.c:545
>        do_procmap_query fs/proc/task_mmu.c:637 [inline]
>        procfs_procmap_ioctl+0x406/0xce0 fs/proc/task_mmu.c:748
>        vfs_ioctl fs/ioctl.c:51 [inline]
>        __do_sys_ioctl fs/ioctl.c:598 [inline]
>        __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   rlock(vm_lock);
>                                lock(&mm->mmap_lock);
>                                lock(vm_lock);
>   rlock(&mm->mmap_lock);
>
>  *** DEADLOCK ***
>
> 2 locks held by syz.4.1737/14243:
>  #0: ffff888020b36e48 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220
>  #1: ffff888020b36a88 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc0 mm/mmap_lock.c:220
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 14243 Comm: syz.4.1737 Not tainted 6.16.0-rc4-next-20250704-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
>  check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
>  check_prev_add kernel/locking/lockdep.c:3168 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>  validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>  down_read_killable+0x50/0x350 kernel/locking/rwsem.c:1547
>  mmap_read_lock_killable include/linux/mmap_lock.h:432 [inline]
>  lock_vma_under_mmap_lock mm/mmap_lock.c:189 [inline]
>  lock_next_vma+0x802/0xdc0 mm/mmap_lock.c:264
>  get_next_vma fs/proc/task_mmu.c:182 [inline]
>  query_vma_find_by_addr fs/proc/task_mmu.c:516 [inline]
>  query_matching_vma+0x28f/0x4b0 fs/proc/task_mmu.c:545
>  do_procmap_query fs/proc/task_mmu.c:637 [inline]
>  procfs_procmap_ioctl+0x406/0xce0 fs/proc/task_mmu.c:748
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:598 [inline]
>  __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:584
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f79bc78e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f79bd5c8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f79bc9b6080 RCX: 00007f79bc78e929
> RDX: 0000200000000180 RSI: 00000000c0686611 RDI: 0000000000000006
> RBP: 00007f79bc810b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f79bc9b6080 R15: 00007ffcdd82ae18
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

