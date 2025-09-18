Return-Path: <linux-kernel+bounces-794461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F909B3E21B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36ABE3AAD95
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5D322539;
	Mon,  1 Sep 2025 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFhre+Di";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xbt8sAp5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799483218DC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727948; cv=fail; b=RQArTw5dCTmlTXnSWw3PEC5sSHudDqTUu0kzOWlzDc0o9AHJryD12yt/FdEHwCJ5e/pJeowgJaVg6iEmeFEBxuPec+tVAzpf5BdYPkMO40t+T3+fd463Xifl3Cdn7nvKBC1VX1k6cf5B5mZffPfYvYJuVEh8GaUfPHndXVXed5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727948; c=relaxed/simple;
	bh=3wOzfi1644lchlHnX2mwD627aPt8pomEERaPS42TfXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B/O8Qc4HPtUyjO6TCLe9ptu7iHyLa00WkG04s5Ylqb2SNG9pvfGZ0nfgCkKFdGRWMRFQrj2XRmIa0lpScBeQk898v6pHcmbm0k8m9xeZPz5L/dtEWkPpHlXJQF1eX7IGKDWXK1DBM1+HzO3UEXZOZWL0n8ZTIwicmUNw46guIlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AFhre+Di; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xbt8sAp5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gYk3027105;
	Mon, 1 Sep 2025 11:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6VZ2LWtta2vCENLRqD
	GJrKtY1QLM81LZW9b9R8qEa2Y=; b=AFhre+DiJnWZI+0Rky7+aBJ6+ixAFbBTlQ
	hDq+oGAPBvXgOCh8Ll8IsnDWgkWvXkIrmiwHesyLrHH92lkAEoyCXaojJ1NaKnu4
	x8fnS4LfAI//4VH4VBAzF5iX4QhGKIklNR/rE6KljkN7DX5j2VqZu5xUD3rRthCC
	tRl/F0UkKdXC3Sw+JkiaoOT6u6uuX8PJyEn7GwwEJJaBsaFg6LQdZ7efRomt54gd
	x7dV3HNs9jY1VHds5FEh+QnXRJS0c1fQpdsk4nYNZb1R9VkpAbxROa1M5/ZVS0xA
	a7KDNl9VewjD+Bz/drutkQxlsPeUxmCJOBBbN35vEhy2qap0kC9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgtak1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 11:58:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581B1URg026871;
	Mon, 1 Sep 2025 11:58:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01maqrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 11:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+MNhTXVv6dji5H70IoYuUEegDe3CXMoTThejAfiWxjGcXxWsF933MM+Jn/d1AV2N6vInsXeyKKUYjNOfgFYNMQNzshSHEIgTnEJeD6LPyX0rzxNbDT8RU95pMMktKMmey9TeTYpLVpqpKHoXrCSkbQ1gAoxRWxQNQ1M9QMiD0FPJ1tJuLw+qAMG3hgaJJIfSsfp6stVUW3ubKD/5PqNGHRzcUm1+GOmZ6Ld5kTHkrw+H0HHb38Nbotcn6ak7V+4LXUbFPEJGFe2BhGJENPN09qsDQLmv75Tnl1iyZ4yqePDvzW/Qzufqblgk9GsXwSjRyWqCzHe6fQ1UnK7RS44FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VZ2LWtta2vCENLRqDGJrKtY1QLM81LZW9b9R8qEa2Y=;
 b=AQwHOfPwV8BHCNtGC6MKZSlCEczupvEKAcW740H+dtSiNYET7W5WE5exsVC11VTkRJZ3wfU68B9+O3OBfQ+mu8BXtAALfnQBnR7Brir3gF2R02kzgWWAA2x7qigQz/j0SixYRd4nIMsnpFy+eW1ayWT8t6FHYMJpej5MGDOFTyv57bG68WVFikn0BGwIEkz9y2ZyK2PoXnLijGlxSMZZ1zbntcsQV/sAHxquELIzBZbQbii3sR2b0ofegw3pc/gB2ilc/60as/Sd5u4XntFjehdnyHib6GnY+l70mOE05+oz7nobagNO2fMNiBYwCmYFHwoHlutJmsSZ+o8en88huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VZ2LWtta2vCENLRqDGJrKtY1QLM81LZW9b9R8qEa2Y=;
 b=xbt8sAp5F6uddZO4YDDkrTMMIX1MbFU92IRBqkn+cZmEHPJFdEzXZANker+KZzAd9S7QjfDquKf3cUM7mJEgrRu8pkol5sPHyE13IDP1lQYyf7VBd+Xsjp9t2GQqoUL4QBgukMb75rsC/En5lSWP/RrjBflgIWNlScChSU+Hf24=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8732.namprd10.prod.outlook.com (2603:10b6:208:565::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:58:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 11:58:09 +0000
Date: Mon, 1 Sep 2025 12:58:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] fork: check charging success before zeroing stack
Message-ID: <61a39485-86ac-4969-b64b-9589d3ad82c8@lucifer.local>
References: <20250829-fork-cleanups-for-dynstack-v1-0-3bbaadce1f00@linaro.org>
 <20250829-fork-cleanups-for-dynstack-v1-1-3bbaadce1f00@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-fork-cleanups-for-dynstack-v1-1-3bbaadce1f00@linaro.org>
X-ClientProxiedBy: LO4P123CA0180.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 247dc970-1cd4-4d82-bde0-08dde94ed222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ejiy1x0OFLzUoUuhPezBDdyXfXi9uny+qcxl6aK9PKV0J3sq0gvIEp52mQlw?=
 =?us-ascii?Q?24PukCMtVBQ3HPuLLo9ya24uiv9DRye3aQbojaalTBLwmPVQvXW2yEXbTPtf?=
 =?us-ascii?Q?LVb4gODcMdoi1s5guvNJJCH2rzZ7XuoVbO/bjoAz8C0zE3FpUa3dMjKsvneR?=
 =?us-ascii?Q?60b/0rUIldFIc7OTcXO287TDyyFceGewtofziAPMNEKbd31/R8qJAUUI7f+M?=
 =?us-ascii?Q?bBpZtmy7g4HKr5PrhXcZChdpjK8vvrak/nO6i2FYG31i3eaeSgXtIjFmjkDf?=
 =?us-ascii?Q?yRA6VQS7oUxPVK+TYt3MyeAk+c5Zw481F/SnSzAtJ7D23s2eiFt16g3pvU2t?=
 =?us-ascii?Q?lEqrbzaT98SRvFaLTwcsVGsFBhHjS77yPYZVSURd6/0pEH/jVddZzdwh2/42?=
 =?us-ascii?Q?EWF9fLaJ+1pQHQy4qoRGD/EaHrl8ttfcDmY3LCDzNe93KIOqSFpUdfAt/ANC?=
 =?us-ascii?Q?QXCuQLuM4vjOd5LTXKBbZLHKyree71mLYb/AYnFYIFSsmVQuzNKgXkNAXZoi?=
 =?us-ascii?Q?UkU5JHqMckkPRFBoc+lxd+uPcfOatAZRxadhZmGG9hOhvjV/EiU+IyTRJ20q?=
 =?us-ascii?Q?DQSzLQbOM1FKmTsnm1osFBWN5xMSxy0HwmusuRcO8CztLhpHFickKsXuQ3zr?=
 =?us-ascii?Q?jFKiZhqiDusqv1wayk7o5IcCbF39zdmKPC5ZQFMJ+xqAI5BGM14VZz8eVP3h?=
 =?us-ascii?Q?v6vFmH5xS3B4shz/sn5cv0eQKije221CwqNdOopkD4CmUfMaXjpnE+EQMfG3?=
 =?us-ascii?Q?2c4yvIGckZYIEw6xQw1p/YQPE80noejFXSOkwm0r3FbQCCzfFeelG+lVUPyD?=
 =?us-ascii?Q?Xqvvtmgm4iOpvqoqqeujHrexQX5R7aDrcvzkMIIrIduKv8QyB9kb6xwslEei?=
 =?us-ascii?Q?i3/5GCHXJ6esDR6yGhkP377pE2KJBWwuSyChA8A9evi6GVTqr/eLWL52yClA?=
 =?us-ascii?Q?QKP9iVDkZuwirzenrZ+V91JBGllAXvYsNvfr8r/rfHR6fIITAHnJYlP2zlct?=
 =?us-ascii?Q?vEO900qjXzGNcmvkeQccKm8eAcOQ4eXmve1LAYX/+/iy6Z9igEEv2qcAtVTU?=
 =?us-ascii?Q?RZF+yc1LQ87lDmbJg4mAlYuvErXd8b6cOJxJ7/piUK3WDmQt/hG4HR7qxozA?=
 =?us-ascii?Q?QM8NnQsbZIKiXynV/Cb/E80pWR/wI7Me88Nx9002aXBvRvCXDW+TgvlzMuaR?=
 =?us-ascii?Q?pqTkHh2BW24+5ERAzsTBwGQmWN1B1zSVpZXcz8F3qGsjfuRh1sO6XKh3bLIm?=
 =?us-ascii?Q?T65RiMGZ1TbQ8rswHSekakjgY3cjrdmqRcweDEX4Kk8CYW4HMJSkgRWHMaRv?=
 =?us-ascii?Q?WUGY/1h4U0n7wb1MPTap6U+LzZSiXet86VtqbM69y3N0G2oeFJlhVb3OOjhn?=
 =?us-ascii?Q?sKrb8DBkPlJdi7rG3IKG/FTfNZynOpmrQ6DKHAo2EwPtRDAeXNaeRCUbToDX?=
 =?us-ascii?Q?LtmEbXXqLvE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LNxyubR+N+0eLoeHeTmGVinKoSk5D6CLMkU2ic0PDWvygCgW+rjdTwZ/gSwC?=
 =?us-ascii?Q?1Q+gDuNTmRdp7G89S28bUUVu1MDsme5L+MMtb+T+RBIANqyFpThewhIjh4LV?=
 =?us-ascii?Q?yXgIHdEQux0veke2Kk9i/AndRwmtqFz7R/MOMe+urBkLpXfgzoqu4tptcbhB?=
 =?us-ascii?Q?eeAzQ2bzOFDQWEBX/Os8EpDInGEjlXPCor5bFmM1i3Dazl2nOj9RdILRJAPX?=
 =?us-ascii?Q?kXqyzXFzS4/Ipla2Z8IXjDTKw+pwP0QMNn2Db2exc93ximUmOb3CBXa6B5yi?=
 =?us-ascii?Q?vEh1+5vkO5h0Lb493Oyz+uaTg32MIjqeKk24jcEoEiIjdIu6wgVIVencIiZ0?=
 =?us-ascii?Q?h3/VEpp8tBWdRAZU9vVa4+jkaWstS1HKDaVDfL11RIiyjbYK+o/JI5ewWEsf?=
 =?us-ascii?Q?O3v4qST78xuhXDmTvNGAlS/Pok2SoF+4rm3cbwmy4+RBbTTkS9UroUsvaKeC?=
 =?us-ascii?Q?56gIwHCFyNaRUxMUeV/Gl8BqrFYCN6h2yEylQDkxSJqv6DQHgqwEf46k5XAc?=
 =?us-ascii?Q?n1tGAaqapFjSoLVtr0ihtGESla1XymiWa76RBgUs6OHKpdwnWn1QPweNDzKM?=
 =?us-ascii?Q?/0x7Fpo2fE1bT+JFOeo8J80H6+qXfdvuU/UmIHK6TL+GpfnblmA6hy7Tq1nq?=
 =?us-ascii?Q?a/QNU6b1nWvZO+l8VPR8MPoJVL6YIN2Q3qdJ3K6T0pmP72EX2RnRS4HQ+Hyj?=
 =?us-ascii?Q?4UtGTmYEct9ia22nvWiVxMxSSatNnRDXjBdaGNQGK3MFvld9+2dXpBRpXVN3?=
 =?us-ascii?Q?rQFyYn5iojgkd+9NI5N+Z23HwH/3GUg5L0oJVtc3mdI5brHUvZMmA4hzS1Db?=
 =?us-ascii?Q?JMh+lj/NLoWyKoLDdUlXd3z2RGRkgCgCqv9CawzX3eCwNl2USWQG9j3h1nrs?=
 =?us-ascii?Q?rbH3fmFRtuTX3TH7xiNqVHUBqeygIF8UnOz3BfDxPqnzm99RfzAfk1MpxDv3?=
 =?us-ascii?Q?r7mwFCXYzrjFj4FztekpWckEATlkPpLtLFs125JP+7uCPlGoBcmkhpUNwm/x?=
 =?us-ascii?Q?27HExU6Zle+4GiZNMBaJ4uIp2lzP2biJCMhxJsjG5FhlV0JDfZ5lO+1Q/xTC?=
 =?us-ascii?Q?Stz/1SSBQoAeq0LGBcGJKOL0hlmdX/8HNgnofhbE4XOhtWdXB8L6/9hSGgFB?=
 =?us-ascii?Q?xKfqk4Vjd14JRBeeoM+Ebpu8jcK1nzD+asJEPDLiiOXFJ3PnxJUCRZZSserz?=
 =?us-ascii?Q?cEBW4AcW5UuwGogdDfftggplGebaGLtPlnmmu4y5EAtiRvWgnANbuzk8AVN2?=
 =?us-ascii?Q?aG7L8Ni8HtDsny14QIvtWujIxujjyOX47jGJFGt01R0hXokw+neeZCXkl0N8?=
 =?us-ascii?Q?L7CITwUFj6QaEYQRRzrB+3hMlnSpHyYx+VL6O1jMmmWUwPhSBHkLOkRYrAzN?=
 =?us-ascii?Q?/2cG6yYSfNDQMOhgLyZs637toRXc0wLFSUFQeuXaZIC+Pvvd/eA+RTzIMB2y?=
 =?us-ascii?Q?6VVnFrI10UlQdDpr+XVyWDp+wAheS3B3UXeYlq0FpV8HK1BvudXEdvbyrf56?=
 =?us-ascii?Q?wfd9ZRrX+mKN/bdYU1n+Nc0VnNCP4+4jMwFFcZ7xqbHUqkpwd2bs130OfVuW?=
 =?us-ascii?Q?PUVULWaBeBz2UNnA/kcARKNE3YJy6MT9NndUGhhGaB05aBz+LS49iroTsiFr?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m/nJEg4N0yykHzmVd2bAxAcMV5TvSh/LNv7UApK9OXcpMM1Rb2gw5fRx2XMZeKp8EPAFHcFIYc5uaAltY1qOo+6bHrVGpv8Cb5Z5riHL9PFSh290FqLuIZJsO06Rogz9fQ9kYYGQYI4snqDe0jxcyZOCO6T8XvwgC0e87jdRnv77q84TR9CFuBC6Tgy625/efIfVum6BsVd7f7LZReO/5fgXT0Sxv61HoYmm+ZnBqRWDP0ULuLa1R1zNeUSBES8hXMRzoODBFiCajBuBL37Kvj3aRldsB0M8tV1XnBNZjoyCBUmby5PvmGcE5K4bHSfiasz1JvFY0qwISv/6tXruXGJF6Yh78dNZ+bV6czGqH6OgKOXNCb68FTPS+qy6fBmvXIajq6QHHe2GDc2yn5sykMPyjyFX5WNYpIyNHt5sjL9het7QWTgt0+3Lz/djJo/HrFQKEM4I8q/8iQFVSOaSppUsMKdWKUYTNqWHb1Tg7Sbc/fdZIaW/esobksyZ6frwdulaYNr5AnvHANbbji7+sfWBGj2joRFvY/sr+SynCTknDyZ/1ihPYgi9ws/5/4yM0GL4dFbitNBVTDuZyeztfr7BMxqPW3zVOyFo9We3N2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247dc970-1cd4-4d82-bde0-08dde94ed222
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:58:09.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QecV2zaWo23ikKqC2kq0r806sbmxtX80Cy2b0lTNmdqMnlJ+/2nT06mS3/sD00c7eFF6yBOoGp0xtZ73NqDdpciz6UeVSfbXZ677DwmCP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010128
X-Proofpoint-ORIG-GUID: nqLdUlcYgSjj5yBAo5E3O0qyDiIWNkvn
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b58a5e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7ipKWUHlAAAA:8
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=ARK5rXCyTOkyzjaVnfIA:9 a=CjuIK1q_8ugA:10
 a=gpc5p9EgBqZVLdJeV_V1:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXx3/UyhhRS0Zd
 qya0Kgoow2JZvEYo+SH2NelEtqXXZfE/dEVEIxO0fP0Xxe/5oPaIqb6sEGNe9dpWXGKVTemtDpK
 hhymkgieIc6zwTW4ZY/VKZPuB2hZNYQMjGDxAw27zPGOam1LiKxCsqrhdVaJc5Au40bjua0fcuZ
 um4g7zA0hvH5QjrRXDYMCAXKjwbVNqxD083qEm2is9Bhufow9S3L8hmZtJKmUo8Bl25c9d/vIQc
 wL8dtW+oP3TDZ3q572FQy0Y24vPCRie9ix97Ep4OcXTYVYwSL/jhpFxRGHnQFJCBeS7q8hfgV+g
 OjREufEq0XUWhdBPWkqb+YEuzchmqF1wRFtu834kdczinuxGq7NNDhDz0dVawoZAEpV51OG8L2G
 LBG25nq4
X-Proofpoint-GUID: nqLdUlcYgSjj5yBAo5E3O0qyDiIWNkvn

On Fri, Aug 29, 2025 at 01:44:40PM +0200, Linus Walleij wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> No need to do zero cached stack if memcg charge fails, so move the
> charging attempt before the memset operation.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Link: https://lore.kernel.org/20240311164638.2015063-6-pasha.tatashin@soleen.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/fork.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index af673856499dcaa35e135a9e8042ef28d5c5370d..2a5b7a5fa09b1f3a42473cf44a1316ec8b3b31d0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -290,6 +290,11 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		if (!vm_area)
>  			continue;
>
> +		if (memcg_charge_kernel_stack(vm_area)) {
> +			vfree(vm_area->addr);
> +			return -ENOMEM;
> +		}
> +
>  		/* Reset stack metadata. */
>  		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
>
> @@ -298,11 +303,6 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		/* Clear stale pointers from reused stack. */
>  		memset(stack, 0, THREAD_SIZE);
>
> -		if (memcg_charge_kernel_stack(vm_area)) {
> -			vfree(vm_area->addr);
> -			return -ENOMEM;
> -		}
> -
>  		tsk->stack_vm_area = vm_area;
>  		tsk->stack = stack;
>  		return 0;
>
> --
> 2.50.1
>

