Return-Path: <linux-kernel+bounces-734186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC40B07E23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B4C7B5019
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E8429B768;
	Wed, 16 Jul 2025 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVyTuemD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fRi1AnjN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29979287504
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694750; cv=fail; b=JVJEsbMR61O4p2V8UcqhgvSpvl52ANqvoFF719BXOFGSQhuf7TIeI3AiYvtxzx+fR610217P7twnZ8cEfq6bnKSq0Wf2gyJdAnY1sCxPzLM7rm1nWPZakkll3vg/aEkSkaL27dj2jKjp9izBKfu/VhR2Rd43lBJfJtWx67klKTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694750; c=relaxed/simple;
	bh=nenKVtS2t/0HU7/b6pyPq0tvu+hNOrmP+MC+zq2lxI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oezowvdd5AzJv93iYs9MSpnufg0AiJizdsvaxCST49d4tF/QXuNI94GBlQ6CGbhNZzeCzmJMaY3p5xDlT1qHvyAwvfitvCD+ad5xLzfKm6ralEKvsrR7BqfqvYc34lZgtluy5vdNjBQvAqpmmMnwgBDfNg0pvTs2gpQgQx1FPQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iVyTuemD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fRi1AnjN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHhIjw017568;
	Wed, 16 Jul 2025 19:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iuQ0lof6i0x8nmcMRY
	Fo2ms4XvNmyLwcPLHF7CWF3a0=; b=iVyTuemDpv5cjkMSpD2a5kxvqNIc+aA+O0
	PoVzFC6nxsqv15W9XQutLh3IwlewX7nOGRqwubL6LBntswK3lIa+Wm/1Ro9qrWkS
	RBAYbtuqLUc5VpHP88XpW6WuHVCYUYgbw6Xz3yGgkChNi8WSjom7JSxEjVOYk7oV
	FNpIIMbU/5ek9erpESzzzyRvqt2ceLom3yiozJjK7IC1e4+SYfIIWT6tDXDsqnPi
	4FEgAAB2jK1RsSeUloLsX50/tI7vE3/lkfcRROxEtE4/R/qinpE9wDuvsUx+JSIs
	AR44eS55iZD55Ax88XHMtdRSYjtcw0vjVY4kYh36MRm4K1rEGhkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4skmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:38:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GJWFVN024122;
	Wed, 16 Jul 2025 19:38:51 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bruwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 19:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRn5OGjI4dZUqeMcNsmkwtTzrQCSOu8oPFJtavLntqnGdSdFy2q30xVHgppqt0rK2dKsASkd+9W1DPF4wLI4U3ZIyz1795QWBCucM+ju3LoXIf3B0kzNuigJXgY15xguMBpwT4XNah1Rr8pEAwyMahwD7ihM2VoXH45VOTAH24CK/2WU9dl47oe5gRkcPoTmuXHymO3s26C30+CT+hjuTmnt1Yd5hcnCYyB9ll/NuspxZ2ZFtfPbQ4VVSHy0T0YEKAW3HezdEPsP5PjDHASeWLcl/El7z6YmLCLF/5Z7FcDQ6CfmDUTV2jLW6QCl7zfzR0r3VTMg0qtYVnomiuPsoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuQ0lof6i0x8nmcMRYFo2ms4XvNmyLwcPLHF7CWF3a0=;
 b=O9sMpz8khimR7FLJBZ9aqpG3JexxWxp08lJdSo/5sPKMJJ3RSaWlG7ibrsNke1Lgd8xdIHOyYbE11YmNWxmB6JZaORPshN84jNkDEqDViPA0cVz257pQGPAKSfwtJe3U60EBA+y6AsrqoZ49PGZTjIDQyMe9NVwa97Tr/o+Li+EAT24l4z2Vx64MqaVnKY8nGXI88JoIhT4F5S5p6jXLQ6Hf5tZ+fTwa++KmBOL1z82WchT1Cb2yCzAEVB/Y+42gzG1xVPk2xqbJvT4g2ccW3s0h/NKmCFYzNZH9Z6xsCUFxQMl5eykizNJE4Xp7FDt+89lpY3KAys29iGFhpoF5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuQ0lof6i0x8nmcMRYFo2ms4XvNmyLwcPLHF7CWF3a0=;
 b=fRi1AnjN/9Ce02cH+EWraREYAJoQJE22N5grXMbHg5YgF/6IaV4mMoQ18wXbAEgA2CmCcN6Fd2EUvcai0C+OOWcFIQ/MaXyFZN3+KyhgOz4iEdGC5uaV5jr1WzjeZ+xQQa5dYnD4MRJUXfW2DAXfGTp0Qw9a+Z42z4od0JrXYDM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 19:38:35 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8901.036; Wed, 16 Jul 2025
 19:38:35 +0000
Date: Wed, 16 Jul 2025 20:38:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <986db0e1-bc7c-47a5-9d8d-28dbaa3c1a1a@lucifer.local>
References: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
 <11538f64-3444-4427-a167-f3c7301fff74@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11538f64-3444-4427-a167-f3c7301fff74@lucifer.local>
X-ClientProxiedBy: LO2P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: b9576557-99e2-4d9a-84e9-08ddc4a05a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWU/1Ao6SaMPiCZr95BvsLuQns8lcPwXNJLSy42z/W5OABraxVj2qzCBJD6W?=
 =?us-ascii?Q?PbZgdVhn9uhG45zXeQjgIUuU6omokEAug8tYg+uJ5t3Ah/myOANC1BW5vkP9?=
 =?us-ascii?Q?zOPKLA20m3Fu6pC95rBtCsNWqZXCNKx4TmunDf56vECPuL1fd2pugZcd+Pg9?=
 =?us-ascii?Q?5jZL8HaaAxbq+3GfOoJdDE9zsazugPPiTi/Y+cVNhfKdonkVtBMip4ZooWz9?=
 =?us-ascii?Q?5FzHMXdZNEgc2c37DvuU3sT2Qxu3Iz3y+RRhuQ5kH1Dm8NMBpOHvOLZHzxMz?=
 =?us-ascii?Q?XL/5KsiEJ+WBM5GOzWuc3N+XlrHpxHNejhJX43YTnWl+PEFHNjL6uNrIUVVx?=
 =?us-ascii?Q?Ymp3JJsQ8z1XEsEIbRv81zs+V/yJ4uJDmTBSJRYryyesHySBz7calUx49LeJ?=
 =?us-ascii?Q?atFieaqHY4338vwSSoOcaVZCa0BRe5QRA73O80VDpzErnOgh/N/ktRHXQ9zE?=
 =?us-ascii?Q?Sjb1tYZsV7pSumJIYTcKzioNykfvDbba9dPOtCA/OpHc37NF6id5Mf3jIO7C?=
 =?us-ascii?Q?ii2aMdmdf0fyTpr8/DHav7UKxvI3ns3E92Atytdj0/chCR/AuYrWNImfyRoG?=
 =?us-ascii?Q?w+ZNVspqEr1TUwS8OGbFbmVtehWdBqQtzMibmNjIakDMx54Xq1Y1eEI6kgIo?=
 =?us-ascii?Q?PF9EUpUhKcOW+FOLIzsOuQmQe3K2D3bVcMVI7vZ1VZS0Wglw1sa+El2aO32e?=
 =?us-ascii?Q?EbqHBcWI11dADAP/x3r4VU5CjCR7pZNFpCeGzVkE/5uSaJrvjn6IP3TQpOZQ?=
 =?us-ascii?Q?w2h5UEuPIANIE7lCXZTa1h3FR2O5s3DD1MI+I2y2+bUxsdKp5EBaDyI0IMab?=
 =?us-ascii?Q?Pe7yf/22mdw8Wboe/CKJ+oof7/nSBzgG2yLM3HfKrFt9rY2BUwj/ynVIE2Uj?=
 =?us-ascii?Q?msaGQ7VZWMz89uWlZNh+sLDzvmYs6gSJm7Gy4SrP8wZYUKvQK0CWxFZg32GZ?=
 =?us-ascii?Q?6bhJbaCj7wU0U2Wb3HHoqUdadQ3RSlnPbF9ZFldiqPUTFTo5hRIisX6HEI8u?=
 =?us-ascii?Q?2j0bXtrBSgMRN7r2q4MBgL0QmtYsn58r8H+LnVVld8NWUfzQdbQoSM0VYK5V?=
 =?us-ascii?Q?+Fy1Wk7IGUwRKQLyAPE/LbfwUcYdZVJP5g2Gv0QC+J/i9HaONgoHd7MX+iIW?=
 =?us-ascii?Q?FKGi9uglmWOl0Qyjjo8ifcg3ofsFbnPUSS9/ZaT8sUgM716EOv8mykKqLPBl?=
 =?us-ascii?Q?gb+DMZ0F5AqTLIyHmjOw4jN/ngMbpWTpWMZ3QP7CVClNkVqQt/lrC1wa0yIS?=
 =?us-ascii?Q?pgPGCZ8us0DwGHq6TPTMvmvf4m5W6Cjj5kAYR+Ki9okwjk2tY9i1ZLnJxRkt?=
 =?us-ascii?Q?swMvCFD0N/Gzj6Q4oDv//Y2sW9JOblO9ekdkFGUbSVtcX4dPskz3mE/+/1tc?=
 =?us-ascii?Q?YRuLFJGoJ8ulYlGt7fy6wQGFjsbB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClYLq4emZUt+0uyhyu81EP5c2QLVh8xYLNzfIqRpTDLYvq6568uQsP+Ou1Ck?=
 =?us-ascii?Q?BrO9ZKYf6v4N+5bj5FGzROBY9HkoMSD4A8dq0fxFy5ppsCEUcjpaFdd7/CSP?=
 =?us-ascii?Q?EpKfUd6itljvtgsCNMKbDWqH6ySDFiTlOLyyM4aLp4MsksTr7yON2NsDygpv?=
 =?us-ascii?Q?nqDZ8Tx2TJLFNgkztk5zLQ0DMNv9yqttMytVeQmASEV0iKuFwlLeZkjG26yh?=
 =?us-ascii?Q?Sy57ij9Yr1fpQhZmLEGxEm/VZ8lnstw3uWTY1TTIB8LgIqqzBAPyOjQ4Q4tH?=
 =?us-ascii?Q?FS8flng537eI8BV7coEKibUbp6aNx6eIJyBqvCoakR20uiBXoiHD1SNiYfsZ?=
 =?us-ascii?Q?Fk15w5kssxdEGN+H9PKQknktfSeYQ9agWWlbNki1Ny9EoNQF7oGOSiGXJV7c?=
 =?us-ascii?Q?Qc94svrSDIHLOMCa+JWvTeg2fDpZV1e4AcuUN60QEj9N2IFwY72OVaSS7SJw?=
 =?us-ascii?Q?YA+YPmYrZw1ABfCCSc0z5CG/Fy13V4O8TFEGnEgH1K2UedFihjjqbHXHNldI?=
 =?us-ascii?Q?L5uJJ7umhj2YZT7ozvEaVusdJbG/YMzcEOrCGzo6Aoi+jb+DpYzuC7s2WiYt?=
 =?us-ascii?Q?ijQsRzkHwV5gmTLgCoGB9BZ1Y6ChZjlkTcYlutffnNZ6aD9FEEZcGVE+1MWK?=
 =?us-ascii?Q?tyjbUNq9z77zdZUK12vmlUWN08JvebbJIMiw50lTcXiwKBAyro67mdN6S0dK?=
 =?us-ascii?Q?c82FGX5Fot83sG1bTHnJMS0vu9hYNE/hrRkCpmsfYug3rUfQlSD6+u9pHE7n?=
 =?us-ascii?Q?3fKHN/XNIQK/JaI41FI0Rz3nEDL9ztZLwcjhEODUks26sMQ4WAkkt7xuZNjd?=
 =?us-ascii?Q?F4jgHz+ACzxEqJFkyxeWOaMG6YEkeWQ5XTRFfIsseDvrMQCP0txK8phCnZ0H?=
 =?us-ascii?Q?bmWWTpThVuXiJAw9LT9AjbpfNL/jtn5fKStnbqgsJc8GOL0AWLVJH9Co6Kkf?=
 =?us-ascii?Q?+V1Hd5oJ0R004zmqsDsiRf40PR8S5Z2SFukM3ICR4sHkfyOYL0IqJUaPZwP4?=
 =?us-ascii?Q?uIYEHRKEAafONm58gDWtWEGcVt/9WSK0XH5+wImufhHVDYpBc+F+U8Btliqd?=
 =?us-ascii?Q?lJGx9UAqqGxosXPOxAEz2s46ayo90tH+sopdjRXKMJnm+xK18cba/ERX5ure?=
 =?us-ascii?Q?Q7ZXQb8p4374qN3cLOJdTtc54bjGbvKLG35hMg6ONPsXOtP3cWLKjsy3EAAX?=
 =?us-ascii?Q?MHBQ+MAIvd7tjCFScUQQZHBRUvLVwoMN2x1xeKV4blVrq1dl5DTziNj6Deu+?=
 =?us-ascii?Q?lIFGacdWAJ7kIR8veCawtSP8pQE1nx2uRRPcY80dZ5zawGf3Bw1fH/N1XfZK?=
 =?us-ascii?Q?P/Rm1vuGsEk9rTOQUQeSNiIggfhK5LA67K/3K5GZLYHhKZ7cHxUdhOyYZ668?=
 =?us-ascii?Q?/PBLryiOZmewqaERD7YRH0aNfP+DpLmUnauXsW0hljbKMpDSF0q6ymj0YgEd?=
 =?us-ascii?Q?OTgy3uA7QT6YE7Lcx7Rhhm0LHTtpNGiVFZi2LwulYJd9GdaO4+9UyynFVJQn?=
 =?us-ascii?Q?rhAW7r3qtPPMJ5XYj6ptrnRWv2nrkQ233rM3TQqyHtl+N4HubjWb7moZbjN1?=
 =?us-ascii?Q?6mwVSetI46BCClba8f9F77M1qBDn9l2rVMhJbLjQ20EU63T7G7iKEYyFO2dp?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eykDPofXIz/65AQ9sjj7wZ1r7tVXs8HQseRrPpk7MJGSBmiKLTpQoiTd94t+qYxpqV/mmtTDQKWWKaoASwf8KQm9AdN0yz2hLySsBHfSF1FRHDx31L+ap8B/qcTaCFsmAN5Ou99HaTxUzVOV/SotnYyfNlPIUVrGQfUBavwvlKvkHA7tasARaa+N+2mpAHr+TjzQyYTS9XVITA4OuHFraP7uESQw7GzVIUdmkcWStxp13iJN5FkMEnX9/IlG4HQDVr//pbSxmMk/kR8YdJUHniCa2qct6lILhb09DSc76qSE8Hb09UARK3XiSNAvpUTLwnHDmuAuvcLM5VDu/kOOVbueR8a6GO+cpL9QuUgVJS01X3COQoCavWoKrKz2c2oWfrPmw3BaCW2E5lhX9VJqZhOvdTDp3IIhxeROePAgb/Pn9+db925abu73f1X7ujp43mAZ1jdw+qkvF5+xaH+gloDLjNhwKInUKemKMXbfEuviUVNwMZMDnAlZU6UIQ92SUwBter79ykUYhV+/JeObNg1ZlIgA71Ev5g2xDD/GSCnXTYxVuX8siSgFc3qCohOvZxowvnbZkfe1FWx0kWDLeJ89riyHis+opjbRheLdTCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9576557-99e2-4d9a-84e9-08ddc4a05a82
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:38:35.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysUok3nZx5S6fp+7d8cNRgHmzfod5/4b+xCgaixq5Ra7WXhpfzP1Gvkuql5lRAAYqugVwQCFIrgO3+2jNmCl03McdGnw5z4DMuxyPm4sVtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160177
X-Proofpoint-ORIG-GUID: hYa7sqQm712qXHj15KieSD2_t0z668oa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE3NiBTYWx0ZWRfX8Sl+tKdTfvGe Zv74yjna6ofDN0APziVZ+qG0QYyqemKk/7h47kZfTWhhdFabOx4THkD2u+FXwIz57oX6oZ3w+r5 QPXTo1LZPbdllqOV9Rs4TSiKaPPUeDUR30dIe4CVFicufrIPJh8sWGcYu+z7wRaNbof7avlJ+Ha
 sciVPKag/VX7WlniYrwPhfgOwSu2Jmpua8B4txXuG4h0JiK8Mwy8cTc7tXoB6Vy3Pc/ODq/oeje Ix4dcAL/E40Y52hcV5c9Nvi7UoZPrRs4ofV9gr7CWcyOD1Wd45Pk+O+nuV0Wqau9S61yGlVyswQ h5upJaiuss1nZePngW2shaW8jktPZW3bIMMKwJN2nXC6Bp6bzPiAgMaSPktwPrmxIFOw8dfPen4
 HkuqO+Q1ZtffPVxxsFgGMmjY/a2lesDpbE30O7WhXHv2btvvsagQRENrv1rkWWuhxi5HXYQD
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6877ffcc b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=4RBUngkUAAAA:8 a=2HEMRAN9aLBdS-ab8KQA:9
 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=CjuIK1q_8ugA:10 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22
X-Proofpoint-GUID: hYa7sqQm712qXHj15KieSD2_t0z668oa

On Wed, Jul 16, 2025 at 08:04:03PM +0100, Lorenzo Stoakes wrote:
> OK looks very much like the removal in v2 of the resets on unmap were a mistake.
>
> Working on a fix for this.

Fix at https://lore.kernel.org/linux-mm/4fbf4271-6ab9-49c0-b30f-c8716bf19f09@lucifer.local/

This will get squashed into the commit so I didn't include the tags below as
they'd be eliminated anyway.

Note that I was able to make the reproducer more reliable by introducing an
rcu_barrier() after unmap, as suggested by Liam.

Cheers, Lorenzo

>
> On Wed, Jul 16, 2025 at 10:55:35AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a7d4580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/13b5be5048fe/disk-0be23810.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3d2b3b2ceddf/vmlinux-0be23810.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c7e5fbf3efa6/bzImage-0be23810.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in ma_dead_node lib/maple_tree.c:575 [inline]
> > BUG: KASAN: slab-use-after-free in mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
> > BUG: KASAN: slab-use-after-free in mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
> > Read of size 8 at addr ffff8880755dc600 by task syz.0.656/6830
> >
> > CPU: 1 UID: 0 PID: 6830 Comm: syz.0.656 Not tainted 6.16.0-rc6-next-20250714-syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xca/0x230 mm/kasan/report.c:480
> >  kasan_report+0x118/0x150 mm/kasan/report.c:593
> >  ma_dead_node lib/maple_tree.c:575 [inline]
> >  mas_rewalk_if_dead lib/maple_tree.c:4415 [inline]
> >  mas_next_slot+0x185/0xcf0 lib/maple_tree.c:4697
> >  mas_find+0xb0e/0xd30 lib/maple_tree.c:6062
> >  vma_find include/linux/mm.h:855 [inline]
> >  remap_move mm/mremap.c:1819 [inline]
> >  do_mremap mm/mremap.c:1904 [inline]
> >  __do_sys_mremap mm/mremap.c:1968 [inline]
> >  __se_sys_mremap+0xaff/0xef0 mm/mremap.c:1936
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f4fecf8e929
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff93ea4718 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> > RAX: ffffffffffffffda RBX: 00007f4fed1b5fa0 RCX: 00007f4fecf8e929
> > RDX: 0000000000600002 RSI: 0000000000600002 RDI: 0000200000000000
> > RBP: 00007f4fed010b39 R08: 0000200000a00000 R09: 0000000000000000
> > R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f4fed1b5fa0 R14: 00007f4fed1b5fa0 R15: 0000000000000005
> >  </TASK>
> >
> > Allocated by task 6830:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  unpoison_slab_object mm/kasan/common.c:319 [inline]
> >  __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4180 [inline]
> >  slab_alloc_node mm/slub.c:4229 [inline]
> >  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
> >  mt_alloc_one lib/maple_tree.c:176 [inline]
> >  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
> >  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
> >  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
> >  vma_iter_prealloc mm/vma.h:463 [inline]
> >  __split_vma+0x2fa/0xa00 mm/vma.c:528
> >  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
> >  __mmap_prepare mm/vma.c:2361 [inline]
> >  __mmap_region mm/vma.c:2653 [inline]
> >  mmap_region+0x724/0x20c0 mm/vma.c:2741
> >  do_mmap+0xc45/0x10d0 mm/mmap.c:561
> >  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 23:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> >  kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
> >  poison_slab_object mm/kasan/common.c:247 [inline]
> >  __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
> >  kasan_slab_free include/linux/kasan.h:233 [inline]
> >  slab_free_hook mm/slub.c:2417 [inline]
> >  slab_free mm/slub.c:4680 [inline]
> >  kmem_cache_free+0x18f/0x400 mm/slub.c:4782
> >  rcu_do_batch kernel/rcu/tree.c:2584 [inline]
> >  rcu_core+0xca8/0x1710 kernel/rcu/tree.c:2840
> >  handle_softirqs+0x283/0x870 kernel/softirq.c:579
> >  run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
> >  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
> >  kthread+0x70e/0x8a0 kernel/kthread.c:463
> >  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >
> > Last potentially related work creation:
> >  kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
> >  kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
> >  __call_rcu_common kernel/rcu/tree.c:3102 [inline]
> >  call_rcu+0x157/0x9c0 kernel/rcu/tree.c:3222
> >  mas_wr_node_store lib/maple_tree.c:3893 [inline]
> >  mas_wr_store_entry+0x1f1b/0x25b0 lib/maple_tree.c:4104
> >  mas_store_prealloc+0xb00/0xf60 lib/maple_tree.c:5510
> >  vma_iter_store_new mm/vma.h:509 [inline]
> >  vma_complete+0x224/0xae0 mm/vma.c:354
> >  __split_vma+0x8a6/0xa00 mm/vma.c:568
> >  vms_gather_munmap_vmas+0x2de/0x12b0 mm/vma.c:1359
> >  do_vmi_align_munmap+0x25d/0x420 mm/vma.c:1527
> >  do_vmi_munmap+0x253/0x2e0 mm/vma.c:1584
> >  do_munmap+0xe1/0x140 mm/mmap.c:1071
> >  mremap_to+0x304/0x7b0 mm/mremap.c:1367
> >  remap_move mm/mremap.c:1861 [inline]
> >  do_mremap mm/mremap.c:1904 [inline]
> >  __do_sys_mremap mm/mremap.c:1968 [inline]
> >  __se_sys_mremap+0xa0b/0xef0 mm/mremap.c:1936
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff8880755dc600
> >  which belongs to the cache maple_node of size 256
> > The buggy address is located 0 bytes inside of
> >  freed 256-byte region [ffff8880755dc600, ffff8880755dc700)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x755dc
> > head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> > raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> > head: 00fff00000000040 ffff88801a491000 dead000000000122 0000000000000000
> > head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
> > head: 00fff00000000001 ffffea0001d57701 00000000ffffffff 00000000ffffffff
> > head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6828, tgid 6828 (cmp), ts 120765032919, free_ts 112542256570
> >  set_page_owner include/linux/page_owner.h:32 [inline]
> >  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
> >  prep_new_page mm/page_alloc.c:1859 [inline]
> >  get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
> >  __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
> >  alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
> >  alloc_slab_page mm/slub.c:2487 [inline]
> >  allocate_slab+0x8a/0x370 mm/slub.c:2655
> >  new_slab mm/slub.c:2709 [inline]
> >  ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
> >  __slab_alloc mm/slub.c:3981 [inline]
> >  __slab_alloc_node mm/slub.c:4056 [inline]
> >  slab_alloc_node mm/slub.c:4217 [inline]
> >  kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
> >  mt_alloc_one lib/maple_tree.c:176 [inline]
> >  mas_alloc_nodes+0x2e9/0x8e0 lib/maple_tree.c:1255
> >  mas_node_count_gfp lib/maple_tree.c:1337 [inline]
> >  mas_preallocate+0x3ad/0x6f0 lib/maple_tree.c:5537
> >  vma_iter_prealloc mm/vma.h:463 [inline]
> >  commit_merge+0x1fd/0x700 mm/vma.c:753
> >  vma_expand+0x40c/0x7e0 mm/vma.c:1158
> >  vma_merge_new_range+0x6a3/0x860 mm/vma.c:1095
> >  __mmap_region mm/vma.c:2666 [inline]
> >  mmap_region+0xd46/0x20c0 mm/vma.c:2741
> >  do_mmap+0xc45/0x10d0 mm/mmap.c:561
> >  vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:579
> >  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
> > page last free pid 5955 tgid 5955 stack trace:
> >  reset_page_owner include/linux/page_owner.h:25 [inline]
> >  free_pages_prepare mm/page_alloc.c:1395 [inline]
> >  __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
> >  __slab_free+0x303/0x3c0 mm/slub.c:4591
> >  qlink_free mm/kasan/quarantine.c:163 [inline]
> >  qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
> >  kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
> >  __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
> >  kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >  slab_post_alloc_hook mm/slub.c:4180 [inline]
> >  slab_alloc_node mm/slub.c:4229 [inline]
> >  kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
> >  getname_flags+0xb8/0x540 fs/namei.c:146
> >  getname include/linux/fs.h:2914 [inline]
> >  do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
> >  do_sys_open fs/open.c:1450 [inline]
> >  __do_sys_openat fs/open.c:1466 [inline]
> >  __se_sys_openat fs/open.c:1461 [inline]
> >  __x64_sys_openat+0x138/0x170 fs/open.c:1461
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Memory state around the buggy address:
> >  ffff8880755dc500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff8880755dc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >ffff8880755dc600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                    ^
> >  ffff8880755dc680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8880755dc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup

