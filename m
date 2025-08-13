Return-Path: <linux-kernel+bounces-765983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47256B240D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F411885629
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B42BEFFF;
	Wed, 13 Aug 2025 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozAotBUd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uw6G78iE"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04772BE7C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064620; cv=fail; b=Oc6er9assw5IzerJg1Ta1RJ3a1hkBVZ64jWpkBz2Nd1cmA2ruR0erFLLm11xPjWq0JoIMhLHJ9w5DMQNi6AjrXlVzSRFmsfgMsTgu2+82U+N/AnpaXD5mXsHPMKGY2y4stNyuRqqu+9r8Gf4AAhWZeSv/iQNYbZBsRY2rPp4lEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064620; c=relaxed/simple;
	bh=pDVX9aWeN+0MwRChamHjaDCXg8pkjXT4bEVyJLIZvr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O59zSbIpSXtMAc2mcPoneFp8VzQMtYiCfb+NxSrO8037kbQSk/3wuTLFkKfBNCy2qSX3W++83UGWMPvRC/u7PlwiO84Kk97OGmIx6TWMOYSDZnnphK4tOWGoENvA8qeRoNgscP2PZw2hT3m3eRwHsHCwLXu9u9yf2mzuvRtuBwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozAotBUd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uw6G78iE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5u5SN002483;
	Wed, 13 Aug 2025 05:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XkhEnjye8l1QFX4K3E
	ihazTtWhPgXkql/18L47HTwBw=; b=ozAotBUdWsP2NTL2cYf7PqPHY34PZfoHap
	jtIP7P4J2CcJgLNFz52p2Y1dkCzfZGM1SyWJERo9FK4SRLUw+jq2JotD0kga0lLC
	9V+G1kM58t+at5/1zKkEIsCu4VkioAbVXkbFkXvNJ8nhzAyhxCoswvQcy0N04rrO
	oVtPcXE2xPVLqTLhw8T/6a+ninliOkT0p5gasu8IzxXWSuXTnPcD6sF0mSbDXQ/w
	gzAns7I+BRPZSxYWEPj8aCcIsGH3jAuSJt7SAC/GIPaAcd31+PL4dX5wv7scmpea
	8Vf45vg+6X3Y482l7mOx3Lgc81y8OaFeEP0HGlvhxm9IKhaPRvqA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfxem3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:56:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5LCtH006428;
	Wed, 13 Aug 2025 05:56:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsaqrh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 05:56:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM3YLGo5P2G4+J9zweJs6RdEw2NJNtexrWVmg1hZaKUTYuZ3l64h/K+rAQ7wwwJ7vsy7T1GMYQtwLSveICKs53BzivVFkRzW1R4qdzlJlrK2jbt9E0FJdgwOUXxnuzzKh7a5011rhAOOUmY0d5bDvL6R4e1kpL0ytAD3+EK6LA5Qac2cXbJ4DpNKq3P3axhLkN0K7OdqSUavO2kbzgfhWi3M3g362tIaWWJJs6VuUwZGPfHx+DIkyt3pNp90apN2a2XFjzwHamIqAa96bb8YJrmeIq8HiVnDoT90USdLrC22CFY7zykYVjNe0cKnv/OPqYfi9uHDt2qQEz2BJMg4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkhEnjye8l1QFX4K3EihazTtWhPgXkql/18L47HTwBw=;
 b=IA/NenCongRljI7HOvJYZsd0vMQqSXWCsyPov6jsChrbFpUXRcfj9HXjRBRWi4rNYEz2XUc3twBNBrix6FNkTdOro9wg07HfFBVu40GgyKqeeg/15b2QabWYRsR+DV8HkBxPaZMyQO4vw5enqyFm2BWTA6rlLBqBPDZ86+uri+FOUjxJOEpsK5Fowk+OuRw9833PCqz/Ah6ajlNjt6UwyTUWlcr2as0Si/c1HasXnCB/ptRlgX0piJSbkA6daTbs1HhHE+cIusnEQijk0aCEYweuK+cnlIC82vwSZ4FRbUfVXqhqo56rq78IeiF7+ZCYam4meLSPiNwvJFH7s4Z8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkhEnjye8l1QFX4K3EihazTtWhPgXkql/18L47HTwBw=;
 b=uw6G78iEFfC0qYCzpksVFSe6Z7jGX4SjBNMz4B/iHTl4llfV8n7a0KlXmbggDtiz9eB+RSAbRKkPFp5fPx7mW6jVQ/SDgdNb0UiNyZrWXitTt1m/h/RSB2gAwn6t1ZWrLLFO/o8iZw/Vcutr12Y3AaJrFRqfVUpMB9KFKSNrSmM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 05:56:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 05:56:46 +0000
Date: Wed, 13 Aug 2025 06:56:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 07/15] perf: Remove redundant aux_unlock label
Message-ID: <a88f4150-d75d-4412-929f-ef937019a7f9@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.131293512@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.131293512@infradead.org>
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1b17fc-e18f-4650-a99b-08ddda2e301e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3E/zTU6fy6LePc1tyafPkETZv4asmKH7/cE5LK5yk3Ym6cLZfLioGAMNbB9u?=
 =?us-ascii?Q?52hL3mkdn44F777Gg4ujmcaXq4jwfdmRZngcX52QHB8Zf/PBPCUBuFD1OdAt?=
 =?us-ascii?Q?YeQa/612VAlwQfOGwDbpQnvJQZ1zBHHgJxJl/uaTvJ2zzh14D1dheK/wcTeY?=
 =?us-ascii?Q?JbzGw0BPjxYVk9K8CWd02g4u+dk0As2zjSVqynrxlz7WNn1gnhiDa+/5rfNG?=
 =?us-ascii?Q?C+KvQOJ72ok//P+Z5E9GF3h4RwZsYnH5VNWXi55Yck9u9Bth9C/6jt10kESD?=
 =?us-ascii?Q?/I2yVk+qszb6fWiupfIGHn2C/cMIUP2w87cL3m9/B8YxXWWM04he+kb+O+jT?=
 =?us-ascii?Q?pDjAHKZiVRFyjcTt9pQugyz+PqThb6+dztUblp2j/4ocq1NSiMeiVlwmS4Qk?=
 =?us-ascii?Q?Xkp4JFro5qD62NfZZ/mkscANcrfrwueZhiY9xxoFuzCmJZgO3OjpB3iV5c1N?=
 =?us-ascii?Q?UUhCPkFzBv1fNsH+kJ2mwrMC3eKKfzaYNdyboDaJdINtu6w2CO75IIThQHZj?=
 =?us-ascii?Q?r5HjWqpHj9RPyV0YsJkRM7VShiR/uq/muCekxIhWuj4/yW/VvnQyxvIuo/Fo?=
 =?us-ascii?Q?dr0M0Mr9oGSxUjbqhh4LW3ljBpjsBKulkA/R/FYu+iDQVMrI8l1ykIWUr64F?=
 =?us-ascii?Q?qHdq+6pVVWw57lOWnTfe9dxI7xopukGwkPyw3VcE9u666sJAjDAx2sSOKV60?=
 =?us-ascii?Q?LdbZS9Y/8t4kCMcF0+QAj/He91yIraZEyrNjzLaDNaUGxsqoQhsaDl3BHWyd?=
 =?us-ascii?Q?u0UFPZAhEeCHEx8CBvpOjoHpnArH/Wp9oNRcCfeOxAguz6STqwmK+Ep/WZ13?=
 =?us-ascii?Q?4BknklKaAcgs1HptCPiKsbmEIRYGFYbewRYYohhAwy9x8UVqirD8sFjCR6FH?=
 =?us-ascii?Q?QJckRhuKthUW6dCWsPQkmrN3gtcnB77bnhORpRd3NETPUrqe8u0nIDn2Ksv/?=
 =?us-ascii?Q?2L2EZRFdIB/7W4mqtSy5xtj6/imqneqDktK6tkck/8fymaS/fOnaqHbLNdtU?=
 =?us-ascii?Q?YROhfp1UVnBIcuGuP0njXiiT8V6SySYse1YVRSHZD8lwVSrMMAuH1vxdsplq?=
 =?us-ascii?Q?EQLhUXhVk78uoFau4Z6uPIOsG3FU/uMiRTH9V67ykYC+bf5HEUNAc/t0KYcM?=
 =?us-ascii?Q?reX6Q90HwJkSuU5JgL/pbAHjNce5jbdtn8vndESFh1moZpjxhutidVcIGE5r?=
 =?us-ascii?Q?e4akC8GaTLP/EqrhTbywt23cwN0TyH5vSeSOyXoL43KzSE4FPR5IO6dhHVwF?=
 =?us-ascii?Q?HRJnrir37jtAxoSalcpMt4KsJqR6jpXDA5GRs4mGMPu/dfdiRdnZjp+ktw6K?=
 =?us-ascii?Q?qEsxLYPZzyTMyoPNGG0XwXoeyeHYTyBdllW+XQuNMkuNcXGlyClAAsthlfHv?=
 =?us-ascii?Q?PgCGHsFpMTPvbP9zitVPKOP+spi/ZqIi/T9DE7H+i/igjEZQeR1tf7A4uPn1?=
 =?us-ascii?Q?DqcGt0b1k8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnma3r8HM7e0TmC4/A2ukVCvkonBmn+4EXMGO/RIgh7vQFlX3XCbO7zBDYMF?=
 =?us-ascii?Q?7hoQwQvslIB9f34oDiVq2x+tlMtPOgdkzGS0fc7C3FesCV+N4DlRC/23RTlT?=
 =?us-ascii?Q?ZX171mSB7Sw2pC66YQ6uzkgc7hpnhwtsZzv4VSAB2FqCbuRpUOxEw7KK6xev?=
 =?us-ascii?Q?ma88y/i6i8L7RzhSvD3oIPc6WSYZnoCZctL7VoE1MvIKdfeAl4axy4ee+FtJ?=
 =?us-ascii?Q?wIv1i/C8ca1vXSpZJzu+VKSl+WAahZqN0+0/W8F/9F7icjdHmzwVlYpA53nr?=
 =?us-ascii?Q?W9Ag6UEr0YvYOToPYTYpjRPQ7wB2LmAVV6blRmmqwfgJgUmtR6w0SDx+7eMv?=
 =?us-ascii?Q?EGXsaaWTChcfK9vT7kbOXkD0cyk9gC4XCfUh1H1ujammynzifKOl5UNJv7Q5?=
 =?us-ascii?Q?Nydf5fv15cupJsdVfdqWmqYFQ3Q/HxpEITn6JlrRx2nSwDeVdgHZ+HhD5A2O?=
 =?us-ascii?Q?FNYVJCdBnSJ/CPMa+dJBPZj5ELHnTSYym0LDTB4sJaWh0XSy0vICOM58Xxlb?=
 =?us-ascii?Q?DPt9QQJb1cqmqNRlp+jIAB7Sk7zawskyTxaZQ1cToMvjsSeKioXHaIEa9KmI?=
 =?us-ascii?Q?tN9jpK1OvuV/fsOfDOIBXFbbleeYQwqul3PCtgrErRYPhyA3+pcz11YNO01S?=
 =?us-ascii?Q?ow00EEgHCg8l0syajaMA6UO0ZXGEq0WSHfAh/MZ4h48v5oXaNTh8f9Cyr7KS?=
 =?us-ascii?Q?DRIuM7SgpC58xh4A48hC4GaRanLiWgXBXiVQ49CzN0B4YHinqOO1f51QsL7W?=
 =?us-ascii?Q?KHHkrLNynnNTfrUylOLjcMFCqdy0Dh36Q1qStArd3+4swuys+h4jTZ+hq4K7?=
 =?us-ascii?Q?SzHpZ/muZIPb+yCV6f2S2/vaV5QgvcieBpFAblsnnP1UD+B16Ty28FMDiHuc?=
 =?us-ascii?Q?4DHWM037xM+OPXeZ3kHPFC1W/bD1FNAYhqiu17kU/FxHyMf0OH01uc8MQHOq?=
 =?us-ascii?Q?ksJq5i2Bxk7ifgNnwaEXwBIPQN0mTHiK/XljEuNBvVKgpghTac5glrydczup?=
 =?us-ascii?Q?Y/xsKHx2n22+Rm2O8F4EsZc+M3FWbXz/L4oxrCCR7IuYnSomqjv5aEzbCHnv?=
 =?us-ascii?Q?hO0a542/06uQfT3tlGbGW4/3aS8+x6Aap5i5MAXrSu3HlW/kIqfafT1O1JXv?=
 =?us-ascii?Q?02HrXD0W6FlTPw29qkNElBQ5y8l9AAa2hGuS+oVUBbsRPMyudDmcDlGeG82y?=
 =?us-ascii?Q?/Bu0TAulipVn5HTeJaRGpJdi2Fx8vdEXQ8vcngvdTWJhBcTbR+hlVc93TYoI?=
 =?us-ascii?Q?uLXi+3zQ2R4B8g67tkQFXYuRIVHaYLZWrouBviAi7HU6gU0ayKctyJu18Oko?=
 =?us-ascii?Q?xgIbtOdJRiNMabvl8e7UcBxggDwxVHQVMmU7YDIfGVizjBJi2Nrb1a7Q+2sg?=
 =?us-ascii?Q?SV+BxevA6JesxsOLRSyiuj03Qf9/KgjBSe0fTWq8EFwqrkqWVLD2zeQKqB0W?=
 =?us-ascii?Q?0aNEfdIoASE/YncaL+UUnOsCmiF8HgBuoELNHbffjeAQuQqu5DFDT7PF0yAD?=
 =?us-ascii?Q?qv9rbrxY0J2h5p220uO1Q1yQUzjSwFbHIuN6eR9vnLB6dFVcv1I6b1c65spg?=
 =?us-ascii?Q?lOfHHLLxTgqIsHZh8k83A4qWON9VSNEfClRYBB0sWuwOhORgJ/OE79mM6gLJ?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lOliR+MjSVzhcQLwZKV9Qw8oIa0L3WHGsMJ8fCKVw5ewKWacfyhclm4c+9vbnJN+SGa1//olB5LDShf4CKN3GywxnwoM0OL9PDCl3coEQjBfD8MKGo2FNucK9uxBmd01rD7WEybOBCOTky/CjRUMEn1wXltP4WUyJoeGgKfpKojPb8VGU+H2eV4ae5RNCbBcxKie5pyO+qygoROS7STo6If8M4I+8/hqloetaszjlNqOpN0pV23wOeFAZPaPVvlKJAPjDUx1E2HPPjgP9AzEpET5dH/dXZvyyvq54y6t/nDwUKBrRfw2UdM87wZZ9DW/T6C3q+mJVDyXvVkEdCAEkEIdXq4RuZdfZIeKVsm+73xMgI9B+l3uETaBFeMQSCEgl8/6C5028sJH8ge6P/0dvIpbFb/1Za0ref1O9wsNSnHoK1Su5CA2jvOJmdlyC9i8DBiDgTKQsHJ9RS96Gvyhw9GnISE84Y7M+YFBj8w4aVskKwGm6aQZJlSnKRnPXNYJUMOI6pJUjrpwtaS0MNUEDBoqZpCj/X8vP92pKfsAs1aN4Rl8trUNb9rOavt6ZCdTbnpC21uO1mrSxDSIUzkZOBYlkbAr7gjY5HauUByMTCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1b17fc-e18f-4650-a99b-08ddda2e301e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:56:46.7730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWgx59rGX3VLNwjKe/N4TxRE8055Jj9j6QbFD7VStPqGFRnT9c3oQxa1RK3J5a9Qzra+OglMOOU2P+TtLmv38AUHrWgn3aYwoSvrhTQn4dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130055
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689c2922 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=3VCNeIstplhwbkpd3ikA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:13600
X-Proofpoint-ORIG-GUID: ioF_WpRaAp8xafRtsnea8p1P685Xxnkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1NiBTYWx0ZWRfX5lcPb247CvHF
 GfJ0sEZOVp6aOTXtM7DAoso4MFqwC/UnxhLuRc9H+tUTqK2bcJNNaVQmRNiSm83eaB3SE27np3d
 O0Uqyf9sBSzJeYmXsWXmKbruSkVQhjJJGdieuPSQgI2cBz8qzqwzWLrP5r/vbORTxfOA96L870Z
 6Jl0/iFpVxCG8wNxHiwZg8lp6tmc5eyiaeYUNgvDVz+cO2deCPl48hrXp5AhJ8BWnqgajtQHlce
 BJPPIoGX6snlD1FRHFxVHLfA9pX/1hDgeAMsmW83vz0cKeKJyP69UsxD/+YU0kIrNtNzqHfpnIB
 qhFDSqJEutZpUpW2AEaoohEwOHJlGge6pB7JmlBNRF7JeQQMJvtDQ0bfzc4ixbQt040xrdgnnqu
 u8Cu1mLpPTwQpFnk67lRnNAyFr+BYCv6XBjFE3kRnH5ysYIXIFMRLCSVc/TVsC5eVC8QHVjy
X-Proofpoint-GUID: ioF_WpRaAp8xafRtsnea8p1P685Xxnkw

On Tue, Aug 12, 2025 at 12:39:05PM +0200, Peter Zijlstra wrote:
> unlock and aux_unlock are now identical, remove the aux_unlock one.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

And in classic fashion, of course you addressed my comment from the last
patch in the very next one :P

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7095,7 +7095,7 @@ static int perf_mmap(struct file *file,
>
>  		rb = event->rb;
>  		if (!rb)
> -			goto aux_unlock;
> +			goto unlock;
>
>  		aux_mutex = &rb->aux_mutex;
>  		mutex_lock(aux_mutex);
> @@ -7104,27 +7104,27 @@ static int perf_mmap(struct file *file,
>  		aux_size = READ_ONCE(rb->user_page->aux_size);
>
>  		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
> -			goto aux_unlock;
> +			goto unlock;
>
>  		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
> -			goto aux_unlock;
> +			goto unlock;
>
>  		/* already mapped with a different offset */
>  		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
> -			goto aux_unlock;
> +			goto unlock;
>
>  		if (aux_size != nr_pages * PAGE_SIZE)
> -			goto aux_unlock;
> +			goto unlock;
>
>  		/* already mapped with a different size */
>  		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
> -			goto aux_unlock;
> +			goto unlock;
>
>  		if (!is_power_of_2(nr_pages))
> -			goto aux_unlock;
> +			goto unlock;
>
>  		if (!atomic_inc_not_zero(&rb->mmap_count))
> -			goto aux_unlock;
> +			goto unlock;
>
>  		if (rb_has_aux(rb)) {
>  			atomic_inc(&rb->aux_mmap_count);
> @@ -7158,7 +7158,6 @@ static int perf_mmap(struct file *file,
>  	}
>
>  unlock:
> -aux_unlock:
>  	if (aux_mutex)
>  		mutex_unlock(aux_mutex);
>  	mutex_unlock(&event->mmap_mutex);
>
>

