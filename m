Return-Path: <linux-kernel+bounces-762857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A5B20B79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBF22A7257
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2523D2B0;
	Mon, 11 Aug 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKlAKZAz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LOeaxHiE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229102192F8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921585; cv=fail; b=UM8VaGMO18Hl6FJogOne79DU5E82KO/YjkIEGYp9OWbnC0MfHEvitcHZyYAWkc3xHb6L+aKdPzu7epiP4XZUFOmFHtvAecP/jS9dGSp2//JjZT7QqIsf5wZPB82Vl6TM+ArZZgp3suaR/T9zR3XJLLgNdef0TaVrCzcrwpTJxIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921585; c=relaxed/simple;
	bh=H4IPp3uDAE9wC9BgOuf2fQ1Ieuc72tLKR7zCxEfQc9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMWgPJZ0ZGPSqJtQMPBIt1EDOZqVB5CyXZqRvBLPLkDtyA3209/o8XuYuHRhg0gypL7xrB/Ko8bUzZFlRghSftNAR+6DEoQZEXkvEig3COGB06F9tbKa6utqZailCxz9b5IvBWsk2sLy1/G28YpBuXsXEM5n2sY74yQfCnE3/EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKlAKZAz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LOeaxHiE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDMtIQ018252;
	Mon, 11 Aug 2025 14:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3Vnvrt3HgwzyWiBfXm
	SNdNnRgF14L6+EYt5au6+4bNs=; b=gKlAKZAzU10JgR+CPLUlE4etfn3vYKTuVL
	LxSdW3nDOLoQeYnctgnMTfq4z+HbYCkw4Yc5A4oo8Il+TcnLfCx7pjK7uTmUT+r8
	4hQ9Sd7kojZDwNgF+Vo6ram1A2qJEmODcvQjLKb+P/c5YTS3hMCEzejqFWJGo5Z2
	+vS8zjsDyjnnn9Z9lm485mclXvmCeAxeQh+/8AZhydPnhDXI++laBmBOUUsdcbAY
	I4DB9qji0OOxc3ambWHs1JTXxWsB4EhDQrOzpiEjSgi5SA9AsIaF0y3em0a9RCij
	lNHrjbvCFjdkVfBv+/24E6QoGOkohKJu8QYoRe3C7/7179CqrP4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwtm0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:12:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDuBfj006485;
	Mon, 11 Aug 2025 14:12:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8f935-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 14:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoZSJuHiBkfYdRz6sg0c0HCc198y30MZ7dfSXaI5ZMK4udbLlAyp7CmUVEIczrv6ngr/WE7ZtswqYAGZrggdKneGnkRHTcPHEwOOEr8XnKSHiqEdii9uBlQwo3q540ciYiBfgl24tSIzkuNrMzB7f4jWhdcBTMQGtRozkGpfTplXFGd2VlxvIR0rWUgCr7Hi1sc0sWKPASKZQLfATt2WRXof4qQsJJ9GdchOeuprz6ooQUwx9wbkmouTSEqK/lmADYKWaybveC50N98xNh9yOGM21iVTHIeilHj61t/slbQP/OLztI7WAKDl+HnGH0FiKgt4TTjDsp+6wVm4c6IdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vnvrt3HgwzyWiBfXmSNdNnRgF14L6+EYt5au6+4bNs=;
 b=G6khekt6KOzXUnxrqTPB1NYYpZu1E0xr5Tb57feknBM1O6Gxru72wNBtxYWmb3yoo0xcjdbCFR8Xw4w9bMtfV7Vd6bIdSVtCMIWrLKPy9abFPzxG+9GPwwOPqb0Zlnl2iHtnrr2YMuiFfSsFZxQViG63yKG4Ux6ARgXimwnXCaQDvH3FEYPt+6XSsIF07vzZTm/7L+GHuyXD6OO3sgGcLduv4FNfSZIsLuW6uMfyIKv9UZLLoUL/blxqh5dk8UMVKuoiDZPcoJS1DoirG/wSBxFkUDgnS4DZZn1X8VAD23QtjHzsT62yCTQV37A6gPXmnyZA5VjQCqWhBtJg6l0e+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vnvrt3HgwzyWiBfXmSNdNnRgF14L6+EYt5au6+4bNs=;
 b=LOeaxHiEy1Y7qtCgcXvHp/7YjAsNsrCg6Gtji16DDKFb8+XBQwx8ID/LrSHB6Zi+NYSOZNtAEHQTZTBeGLcNZgAwd/ykJRelvDStMYYrokyodChsCR64VfknQ0pdK7XMISu1WUnLn0PZWkwupyguJXRMWjDrlPULxttPcMuqlpw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:12:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 14:12:49 +0000
Date: Mon, 11 Aug 2025 15:12:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 RESEND 6/6] perf/core: Convert mmap() refcounts to
 refcount_t
Message-ID: <5d1ce4a1-aa46-49e5-9890-3551b9223551@lucifer.local>
References: <20250811123458.050061356@linutronix.de>
 <20250811123609.793328607@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811123609.793328607@linutronix.de>
X-ClientProxiedBy: MM0P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d925491-b8f7-4f03-8f06-08ddd8e12777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwxour04e1dzyXzebbb9bDJpy0YGMls7KGHKtPBxNvZxggTsOmYhpHXt5x+p?=
 =?us-ascii?Q?CQ0yl4E4hs6kghoyJX2kqamNht3jy4qcXbCFjGBsNC0LZa07xpWOASujU7kf?=
 =?us-ascii?Q?H+WAD857vBqADT+zP253gxcrFzi3XGjS5Sg56xx8I/XQhyz8CeHQ9Po+a5zo?=
 =?us-ascii?Q?ObhCS9hn4iioOMk2P8+LVsCis9fHUjB4GMqmqFYOMGM0NAt9UShlpf4+eu3f?=
 =?us-ascii?Q?4TH3Joc2XUSI2cSgWts98nXZpUGXWBJthjK6XRZd3A95xFw+Jxbq0R7SHqNj?=
 =?us-ascii?Q?5VXhTxwm28LUjWMH8eak24RnypSg4U48z2d8ET5RarQh5as0HWiPsKBiMkJf?=
 =?us-ascii?Q?FxFYZCC43tJcR+gdsI/1Ravcvl+KR3rzsSe4NgItpgLLm4Zk9LuaQnCgUZ6t?=
 =?us-ascii?Q?XxEQzsm7CpMU13vbZK+nZeKMrbShdlYiTx9YGif6h6Z2X3XpHGO+4L+SxeQd?=
 =?us-ascii?Q?zRtP6wkFG7By8zY9AJl4AyO8KBZljFWYLOFRNciuF3ngEJ0xuT5J0MTk53Qc?=
 =?us-ascii?Q?5/M7PnslM22fr2snkJoRO71/fu4cuN+8duDD+GRdPrEz/dOzNFjZbUAOQ/qD?=
 =?us-ascii?Q?TCqeSewb4Pd91XAr1NG/Qr6TA4lHT6q6wbeZFvMmaJ2KVQB4P7JTcta2d0lc?=
 =?us-ascii?Q?2RNOrgLvTusTBozYPjjqxuJ+Lsz7xlUDRbgpyM/L5B0J1gYWnivlx+ANbBlX?=
 =?us-ascii?Q?cARxJvLLBr7eiobJHuEoyUk5ttMdcdvheoO+llugMjuoprV4AUGAM2dfscpI?=
 =?us-ascii?Q?FKV1ZlqtFDvrYoOuWDjx1Y8VHEm0LswT8zknBPV5ldogqFZ+7tblNvo6Aspr?=
 =?us-ascii?Q?BFwildb4sMAe3h4nsHYYXYojBHz1v68gYRVNQg11zmOh7UEV/dB2P+7L8tN9?=
 =?us-ascii?Q?WqKes+8Kfx1yvzcXTsLSu5KvynTR8VsR3+q8raVWG0ulxsYzbrZ/Joji370v?=
 =?us-ascii?Q?y/Uxez7T6yV5qS3ywUPtvDxjxnnPle7ovsgPsXc4qEe8njpjqvVPUV0wspJ1?=
 =?us-ascii?Q?8r4jb3hGZF0MSeQXIcg7mXNKQJ8H5x2NUqPFAP4GOJJ8NVwZg2JyKZ+T0hV1?=
 =?us-ascii?Q?EJQZzBZxVX1kA40Aivscrj9cuy5Pny8mpuwOypaax56esouM8C0DFQNF4Osh?=
 =?us-ascii?Q?4Z6NUAbVZjXn71Tb24hvILk1P3OcN3nBdVEi0gpUvwtYrz02raGea+TK6bMh?=
 =?us-ascii?Q?Yj1h1IxHKZkad4WQTCVp+4XNjke5+lVs0/mi6GpTaFVNY5yo01CZuU+kr3Xo?=
 =?us-ascii?Q?DOEsSawyLBxpxPBPtA3cCTgZsrGJoPFWygyNvxMHCOLpNeYsZIvBFS+shhtT?=
 =?us-ascii?Q?R3kG9AF/6c+SjrTmD0pqctk9XwNSnnqltEB+9joPzYBlBmzNNaEmODPcJsjE?=
 =?us-ascii?Q?jZDpCHzU9XyKDeHFun+WZx/OAXcRUU8Go1C0vvSUTzSIrDQeyExO8L1DghbG?=
 =?us-ascii?Q?xmv1fXAX8N8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJ6VGk7PeXusvgThrLbYbFk1Jv9/0tLUJI/SCsQPMriCNN9+hz5iF5v9bavP?=
 =?us-ascii?Q?a3N+QCOdJIyTmaqdED3/3d+yVa2FQU4olsrcnOfHAFOR7OjPYGacbbreuusc?=
 =?us-ascii?Q?LP8Ool9/OBwY3tNLtwxjbExtk1KRXTtiLF0+7LuzHxdWc3CRPv3x5XDfiu+0?=
 =?us-ascii?Q?/aPcHjkuhufYd1QdgGfi63UKPNPKIuX6xGqtQmz549tgelrYpZLu1HT1Nvff?=
 =?us-ascii?Q?bdvv+Ds3pB+T+7/Bgu9w1lBd/VR3940jd9PqyDx4nBlHF4qEAfTta63OzuXq?=
 =?us-ascii?Q?P3OSPtoSkV0zdiZDfpxxI/MQ5iXU53a67niBkT6BR37OeH3YzDYy6Jv4oZqG?=
 =?us-ascii?Q?RRVTh0h72RkcrcpAMt0Z1htV5atWTnLfI3h6STYOrYPB4n89mXKiZC+lIv9M?=
 =?us-ascii?Q?ztG8mH967KEQPgkzsvZKRXSXZAgeZSajEAKXXLWZo1xo0PtdOZjxYa0whSJk?=
 =?us-ascii?Q?/HQybNxHMnKMQ3E60Uyxi3IBaX+1XZ/Ul6Lyx7NnAja1G57IXFkBMmps5bLl?=
 =?us-ascii?Q?gbRriwwUfDiQ4ue/f7XSZhghLgimoQq0ukMUAfLHQMZ4huFPMabX+sztCvp4?=
 =?us-ascii?Q?EJ7R+JbpRP2uPZ3SIMRXqq+Zz1vVRbN4O4YrU+pVvbXR2F53WxrIPC68UjLb?=
 =?us-ascii?Q?obQvddWurHvrdeqYSfS22ZnD6BnF8Ari1zRAbE1vJwQY2OOxKCQXHW/nkj/x?=
 =?us-ascii?Q?MgxWuPP9/nroB0bNtSYwnZqF9yf7Y5EIqFeeH6Eh2YAszRz+6gSXVs73SfEt?=
 =?us-ascii?Q?X3TR0bo1Kff5IWFvQNG0+STqy0Ke6jP6q/6raYi8pBQKX7ijM1drqlWbk/Yu?=
 =?us-ascii?Q?7kKPKLdqa4FlrulPNiBUiuCEn0ibE4e1E2owhTjpPyi0KL5rJ2978aO45Oz1?=
 =?us-ascii?Q?0OXj4I9Bpb0WbFxHypaysc/DciyiuDoSuWeZ/xS1bogm/1sAIrYHwaBuBg7T?=
 =?us-ascii?Q?ynk2i6hos3CPN89orVKObI/vuj5oZ9Pmr84Au4qlLxnFiDdmaO0K7ys7ZwMF?=
 =?us-ascii?Q?V2URJvC0yCkZEHI13T3WbvlB0L9BZ0aK97fO54smjd1rtD7Zzxjcj5jCu16W?=
 =?us-ascii?Q?9RwKVl2yW4sjWxiA3yw2O81BgjBX9MfZXDyd2norTW/bG/GGDN5LSDDclqLO?=
 =?us-ascii?Q?WBATOvlRYZMwPkQ2MdaK0cB3D2sZzcmI2aOEGLB/6LSf6rxl6UyG5jlkXTQR?=
 =?us-ascii?Q?FAq2cD0Bwjyk4AN6bVF1kngPReE5sqmeWQnDFSH3IHombhDOF5/Tkf0o3J/F?=
 =?us-ascii?Q?d4Qhj2k16P4wIE7MSBCWUs29vNs4Cl19LbuN/MUiK4ibrHHEGj+j7AH9jVS5?=
 =?us-ascii?Q?gq6d5tIhZDHsIGFx0P7hjsv0kAPijacXoaN6w6EWO5Y/VYfS1v6y0oEc3arH?=
 =?us-ascii?Q?H9IsO5/Jhq/LjCqbsSpHItinaHaHRnUaJ5oavTl0OOcEKqM6repHDttCDSdO?=
 =?us-ascii?Q?aor9FIqw4zBjEjRjEIY05wh5mwArUc/bzG+MXo9aGlOZTj68hYI9+o+jWt2Q?=
 =?us-ascii?Q?0TV9xwDF2da/CZTuDcWVf7X9cUQMZmWA4YSDZsNvgjB6nPZbA5+WWSnxusYS?=
 =?us-ascii?Q?DSRdbiEzxPg/QWqznmK7BUEmTcEVMb104uWmC0OiB+eJL0YxFkzW++5w4Wsh?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wc9KqQzLbx+Iayy7B5qX5iBDE9g5cPdXpTMsT4M+YewbAO7D13ABxkOsTC4kG/p6eQD+gzNp6NHFE4fwY+rlPToUT/ht37qiwBOh/SJHp3FQ+v/v+nMbVOO0n6r2TrItMffj3dTtwzB4nsjK1RIlYuY7t9ZlGG9qBw428kMycPKsTgXoUGELjtTld2qSRuCu8ul9hBmEJajyccHxM2tWUl5H/pWHOPTIPI1JxhVsc6UIUCYeM2clsZ7pXzIgcv8JNPfCCBrFOtYIbHq9CRs0n1pFxzci9bagChEM9tH0mSLUV3COxy1dEWbnDLMjTCS2NGHnPotr12ky02xcJNw1Mf1A5GkMlMjJYL8N9YdKRHvzZmBKo8MEu1W6UKIWX6FPqnanuvIH1v/PlmXt+bm4HBFbNhKIZNg0LjuUkved1Z4X//O0cs9NRyLT4JvrK5UKNhg/4zoq+ZQs+6NC/BWjZ5KIfYWZyDHaQ34v3WblRU1FSfsQ0Ajk5nU77rphTjtbtVFuYhUdgC+O5HJBo1711++a4A3Npg/+IQ6iV8x9APWCskaN2bxTW/xXIwRCAzJSGkif7/dWBrVBhRbQLvzp1+kzSkuvpaGw6XJV5quI8uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d925491-b8f7-4f03-8f06-08ddd8e12777
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:12:49.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu4giVRncj/dk+hCvhwypQURHPgbsmM6UgBjDaBBYFxjZYHtcWcurxipgqWuwu9nzcm4g9FWP8NjMdfZ3W9G9tH0Sks2nbYJWKWi51PvIjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110090
X-Proofpoint-GUID: vrySffnd2C1Gg2hc8iQyny4hYTqYNxAv
X-Proofpoint-ORIG-GUID: vrySffnd2C1Gg2hc8iQyny4hYTqYNxAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5MCBTYWx0ZWRfX8yIKEusZdb2l
 +58GumlYQBPrx62p7jiFBCjmJpDWLz2E6f7jaTtbBxaHEOB2jOMlngxiXVgj/NQSeXJ4MNgus0t
 ctisqPmv99I2HWmb0hFnR4KS/dF2U+/d2s6d5xYfH2vkqWGHrmwszNGIvuh35nUt48ruK+B7H2d
 LFiPNw1O8p1met+iXUcGsj/oDhaslhAwfCdwDGAKJMru6kqxHUa/ul8initlAUEj4l+P+1RGhQv
 iD+h+Tk6Mb79Q6ix9okfwOO69BfhXzNFOiWtO8TXayAv9t4YqCVwL30Nuqnm+NO2mgqFvRQ9xTl
 cwo4RY+SxaHt3xqrC84gbXq004Ch9rJtM25wGMnr3l3zrIP6yzV2I0wIb8VuXffgKRFejchDMN6
 x8FNEuM2BY6x2fsYV0Qwm6Hszsm6Qvr2O9K7YZcvtzzZDvMcn9LFYUSYXL8XDoq9GhwyKvQl
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=6899fa66 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Voe9yz9E1jMNdyWnBJsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Mon, Aug 11, 2025 at 02:36:39PM +0200, Thomas Gleixner wrote:
> The recently fixed reference count leaks could have been detected by using
> refcount_t and refcount_t would have mitigated the potential overflow at
> least.
>
> Now that the code is properly structured, convert the mmap() related
> mmap_count variants over to refcount_t.
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

OK, this LGTM on basis that the _inc() -> _set() change mentioned is all good,
so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> ---
>  include/linux/perf_event.h  |    2 +-
>  kernel/events/core.c        |   40 ++++++++++++++++++++--------------------
>  kernel/events/internal.h    |    4 ++--
>  kernel/events/ring_buffer.c |    2 +-
>  4 files changed, 24 insertions(+), 24 deletions(-)
>
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -859,7 +859,7 @@ struct perf_event {
>
>  	/* mmap bits */
>  	struct mutex			mmap_mutex;
> -	atomic_t			mmap_count;
> +	refcount_t			mmap_count;
>
>  	struct perf_buffer		*rb;
>  	struct list_head		rb_entry;
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3968,7 +3968,7 @@ static noinline int visit_groups_merge(s
>   */
>  static inline bool event_update_userpage(struct perf_event *event)
>  {
> -	if (likely(!atomic_read(&event->mmap_count)))
> +	if (likely(!refcount_read(&event->mmap_count)))
>  		return false;
>
>  	perf_event_update_time(event);
> @@ -6704,11 +6704,11 @@ static void perf_mmap_open(struct vm_are
>  	struct perf_event *event = vma->vm_file->private_data;
>  	mapped_f mapped = get_mapped(event, event_mapped);
>
> -	atomic_inc(&event->mmap_count);
> -	atomic_inc(&event->rb->mmap_count);
> +	refcount_inc(&event->mmap_count);
> +	refcount_inc(&event->rb->mmap_count);
>
>  	if (vma->vm_pgoff)
> -		atomic_inc(&event->rb->aux_mmap_count);
> +		refcount_inc(&event->rb->aux_mmap_count);
>
>  	if (mapped)
>  		mapped(event, vma->vm_mm);
> @@ -6743,7 +6743,7 @@ static void perf_mmap_close(struct vm_ar
>  	 * to avoid complications.
>  	 */
>  	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
> -	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
> +	    refcount_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
>  		/*
>  		 * Stop all AUX events that are writing to this buffer,
>  		 * so that we can free its AUX pages and corresponding PMU
> @@ -6763,10 +6763,10 @@ static void perf_mmap_close(struct vm_ar
>  		mutex_unlock(&rb->aux_mutex);
>  	}
>
> -	if (atomic_dec_and_test(&rb->mmap_count))
> +	if (refcount_dec_and_test(&rb->mmap_count))
>  		detach_rest = true;
>
> -	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> +	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
>  		goto out_put;
>
>  	ring_buffer_attach(event, NULL);
> @@ -6991,17 +6991,17 @@ static int perf_mmap_rb(struct vm_area_s
>  		if (data_page_nr(rb) != nr_pages)
>  			return -EINVAL;
>
> -		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
> +		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
>  			/*
>  			 * Success -- managed to mmap() the same buffer
>  			 * multiple times.
>  			 */
> -			atomic_inc(&event->mmap_count);
> +			refcount_inc(&event->mmap_count);
>  			return 0;
>  		}
>  		/*
>  		 * Raced against perf_mmap_close()'s
> -		 * atomic_dec_and_mutex_lock() remove the event and
> +		 * refcount_dec_and_mutex_lock() remove the event and
>  		 * continue as if !event->rb
>  		 */
>  		ring_buffer_attach(event, NULL);
> @@ -7019,7 +7019,7 @@ static int perf_mmap_rb(struct vm_area_s
>  	if (!rb)
>  		return -ENOMEM;
>
> -	atomic_set(&rb->mmap_count, 1);
> +	refcount_set(&rb->mmap_count, 1);
>  	rb->mmap_user = get_current_user();
>  	rb->mmap_locked = extra;
>
> @@ -7030,7 +7030,7 @@ static int perf_mmap_rb(struct vm_area_s
>  	perf_event_update_userpage(event);
>
>  	perf_mmap_account(vma, user_extra, extra);
> -	atomic_set(&event->mmap_count, 1);
> +	refcount_set(&event->mmap_count, 1);

This is the really pertinent change - with this now a _set (asked about on 5/6
just to confirm this is all good) - the refcount doesn't think there's a UAF and
we're all good.

>  	return 0;
>  }
>
> @@ -7071,17 +7071,17 @@ static int perf_mmap_aux(struct vm_area_
>  		return -EINVAL;
>
>  	/* If this succeeds, subsequent failures have to undo it */
> -	if (!atomic_inc_not_zero(&rb->mmap_count))
> +	if (!refcount_inc_not_zero(&rb->mmap_count))
>  		return -EINVAL;
>
>  	/* If mapped, attach to it */
>  	if (rb_has_aux(rb)) {
> -		atomic_inc(&rb->aux_mmap_count);
> +		refcount_inc(&rb->aux_mmap_count);
>  		return 0;
>  	}
>
>  	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
> -		atomic_dec(&rb->mmap_count);
> +		refcount_dec(&rb->mmap_count);
>  		return -EPERM;
>  	}
>
> @@ -7091,14 +7091,14 @@ static int perf_mmap_aux(struct vm_area_
>  	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
>  			   event->attr.aux_watermark, rb_flags);
>  	if (ret) {
> -		atomic_dec(&rb->mmap_count);
> +		refcount_dec(&rb->mmap_count);
>  		return ret;
>  	}
>
> -	atomic_set(&rb->aux_mmap_count, 1);
> +	refcount_set(&rb->aux_mmap_count, 1);
>  	rb->aux_mmap_locked = extra;
>  	perf_mmap_account(vma, user_extra, extra);
> -	atomic_inc(&event->mmap_count);
> +	refcount_inc(&event->mmap_count);
>  	return 0;
>  }
>
> @@ -13247,7 +13247,7 @@ perf_event_set_output(struct perf_event
>  	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
>  set:
>  	/* Can't redirect output if we've got an active mmap() */
> -	if (atomic_read(&event->mmap_count))
> +	if (refcount_read(&event->mmap_count))
>  		goto unlock;
>
>  	if (output_event) {
> @@ -13260,7 +13260,7 @@ perf_event_set_output(struct perf_event
>  			goto unlock;
>
>  		/* did we race against perf_mmap_close() */
> -		if (!atomic_read(&rb->mmap_count)) {
> +		if (!refcount_read(&rb->mmap_count)) {
>  			ring_buffer_put(rb);
>  			goto unlock;
>  		}
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -35,7 +35,7 @@ struct perf_buffer {
>  	spinlock_t			event_lock;
>  	struct list_head		event_list;
>
> -	atomic_t			mmap_count;
> +	refcount_t			mmap_count;
>  	unsigned long			mmap_locked;
>  	struct user_struct		*mmap_user;
>
> @@ -47,7 +47,7 @@ struct perf_buffer {
>  	unsigned long			aux_pgoff;
>  	int				aux_nr_pages;
>  	int				aux_overwrite;
> -	atomic_t			aux_mmap_count;
> +	refcount_t			aux_mmap_count;
>  	unsigned long			aux_mmap_locked;
>  	void				(*free_aux)(void *);
>  	refcount_t			aux_refcount;
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -400,7 +400,7 @@ void *perf_aux_output_begin(struct perf_
>  	 * the same order, see perf_mmap_close. Otherwise we end up freeing
>  	 * aux pages in this path, which is a bug, because in_atomic().
>  	 */
> -	if (!atomic_read(&rb->aux_mmap_count))
> +	if (!refcount_read(&rb->aux_mmap_count))
>  		goto err;
>
>  	if (!refcount_inc_not_zero(&rb->aux_refcount))
>

