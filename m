Return-Path: <linux-kernel+bounces-745892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BBB12020
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6773B57DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7FC23A9BE;
	Fri, 25 Jul 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KHFMC3KU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j9tYgmMn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42365190472
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753453773; cv=fail; b=nxg6o5PHQ1bJ6ok44vyOaR3lngRNNXQ8aUT+OKL5oKUfZEBY4tpINT22rV3sTvAxWQ4dj/M7ajCULGLVYQf9zKbAN27CJWwC7ycOuz/vSWUjEtnsF87jnas+9g/GggNKKZoJUm62GA/wKBnMIsxTOWrRdTqkql/C1JQgD/TfYJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753453773; c=relaxed/simple;
	bh=BEaMTlax+7CCBP8jEZe/VxorPRgCf8rQp4aeLYKSFW0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GEiW0hGdpasnenfF0XDGfwQoqFx34vZfwn3uo7bslXTOUAesq+3YDVq9mnYVHQ8JjqwuegGvKeqI+1Q6rZAQryCQ8ZJ0043d7wK6UKoMbAyfPVOuYOn1iN5tvAPfHgEdeikbhgahgukOkryeQnBDeY3zuGP0JmxLRReygcsLVzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KHFMC3KU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j9tYgmMn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEJIku018821;
	Fri, 25 Jul 2025 14:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=AgsmIKTIgIZXSOkE
	Q+3uuGnGv/zXvbaybBbyWCEF0tw=; b=KHFMC3KUQbPtMD/f+lDSiKzhJlKIEmmh
	+uya0cH/uV2XMmn6XiPn7YRqE/lC4+lmy3Bs2TzyI0UkPe+y+DAGneuiGLuuTmQK
	tkZxk8vLARdcof9zOMc1ISfPr/vdVN2PxtXjxR+z3GJMeioCYZhqd5sG1eXjGYul
	VM9XMF+zfLciEZZFPKB8xdMzKlFho9NVczQQyxPigbhMeS9TJVR7R1+8rqdw9Phf
	9guAxmmiPIU+AReoFOhhw2EnOpIDP8zZpgtS/yV7AIOw+/ku7/BXauLWUcoMxLdp
	6VCw/XorE1Dlz/DwXC7o/sKpSE/QI0DHWGJ/REX+3qtQ/9OK3XWrmQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1n14kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:29:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PDCdpf005895;
	Fri, 25 Jul 2025 14:29:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801td4kms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 14:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVUUKH8uLbAlJIYkbOpZzhlvi2ThRXF1Leir+3HxwHhs1E1a4SHs4l+DmBVkLYD5YY3PCGAKnXSs5hlX0BEAR6UEYZ2e1Ob70CEOerHCuheCQ9S+jBatwgGRf8LHLusIO2crkGepx17SamIxzGg/y2oTyXo3DnNEDYdQ4gsz69wlPwXnaLI0JJeYNwJ73Y1LyKUApByoy2lYIowOrulDWtdi3ESI0rpwazpwP3dPoI5DvNw9cVoHLwIhW7R4UK10YXeNzoLtINAqWCwhOjNL3D7b6FBpahoWI5D+xsgAte7KnDhIHfx3/xKKHBdknERMKwiX+LSm2QulhUN+8J5pQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgsmIKTIgIZXSOkEQ+3uuGnGv/zXvbaybBbyWCEF0tw=;
 b=jctpN5+RvQ9HO+bNHOGTQxYmWhFLM5UxAqVCy511An0CncVo15xcxMDx92EEtDse1PMTOwkMqgNG/V20WJOLP1PQYZ9g+FWzy1IdVGT2iXHxHP0n8CXPiZI4zua5wI6GQ2p06G6TxdaIzmslXY8OZN9u/5hYE06tgHU+AX6mAnOYrog1lySWvk9cp2wa/cOqSVMDV/vZaLh8f/fPlrbj0FKqZCD7zULIvB9t9dsu3gTFeLIhjDMcMbzZHh13FSoRV/SX4482wXbg4cy3h6Nk7Jq4Nitkogj8wB745zZKwtqlb7MLqc/rEFv4wQ+hR616vlZJ0oFoJX1owv62yEFIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgsmIKTIgIZXSOkEQ+3uuGnGv/zXvbaybBbyWCEF0tw=;
 b=j9tYgmMnzn/oegZSv5Wvey7hhtbSRf+cMK+k7fgSskrDn0w5Pk+zH73ymbHey8gutj9SqM2E9DRF3MroAFqhyNXix6Jz9rWtRai2MiKKwlErrmz8aA7fEl1kxrd0Gb7E1xo9gTvA8hHEEm4F8e7eHwSQIal8B5Y+01mqhaZowPA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8470.namprd10.prod.outlook.com (2603:10b6:208:55f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 14:29:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 14:29:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: remove mm/io-mapping.c
Date: Fri, 25 Jul 2025 15:29:01 +0100
Message-ID: <20250725142901.81502-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: f666ff3e-142f-4bec-cb07-08ddcb87a06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XWzaavtDImKKUfIPKL+ReMYf57v8mxSNd6AVIks3Hqu6tLeTXXZ9rv6jeFN?=
 =?us-ascii?Q?5703n+01b/mN5UOpgTlSeuHzJ8QqlcxGF8rAzeJHMLyAIsMqStlyGJadGlDx?=
 =?us-ascii?Q?NPsUG6POEsEcb1j77vZTbpP65q9GAGibcLVVBbwlnJd5V7FaL7LxzA3XqJKm?=
 =?us-ascii?Q?rRrpOQYVUP7HJSuz+2uLwSB56sv4cm6kJyXcQECdJlQg/llj6dvG5akLN34S?=
 =?us-ascii?Q?uOt22oiX+MpCtrVLGG+0f0xTQwA1BlRb05xPTbEGK6TchcWRzjO+lMDc0ZUA?=
 =?us-ascii?Q?c0+Y+KZs/rAAlkeV+btWS5f0yDpniu5s2Fy8t6eXw6nWGSpQINQM7mlQHJ9G?=
 =?us-ascii?Q?RQ9aUbddBPt1IzdMqhil86hjh/o5IcHRbfvM282cz5hgVJHTx0ICf5wfgSYe?=
 =?us-ascii?Q?hHLmveuxld27rvz7BoLZNBPNKKJp2ZMHp6r/hEYlwr5r+EFW1jePUYDUw8fm?=
 =?us-ascii?Q?rd1+pG71lkRio1DoOwozZUbd0n/61Rwer8YQvkd6xcaHcKwvCsUIOg4kqATR?=
 =?us-ascii?Q?E/V1MIv43pkOBY0083TMkDi44p9FiH+RCchw6emMD6y+/VBA+rRsEQ9MHGg8?=
 =?us-ascii?Q?sptYXK4vxUPjZdS+FgcYC7qLzOM1YKwhXcTBOeNfx/MsN+E/a4KzWwIUL6DE?=
 =?us-ascii?Q?W839Arn6ry8AZrurCfl8vWgv0FQYop9N36HnLICXpmwyQtZW4mIJFdKYLE0o?=
 =?us-ascii?Q?15RoQjZArUqHaUgU6hnksNf/hV/2KHZohFQ9W9J8c/JWCTj2h8H9Nw+4voSy?=
 =?us-ascii?Q?STMk/J9eq43NmsOAxh3W4dJklI2s2powp2wp70RO5AzG9fzqNoBiID5mcEJh?=
 =?us-ascii?Q?Bb5uTJtzqMsTf1z1jwvWu7Yma2We7c1KX0dN9jVtAal1nyMP88QFeNafufUs?=
 =?us-ascii?Q?Mbprr09seST4kjw96ITRKKgmb9j7facXFkHubV6J5OFh3hkjxaWkTFFoOMfb?=
 =?us-ascii?Q?8JAcgw+QM0EF4m9XjnpsGeuuNSUx5l8rwDmOQ6/lV1AoJvpeSLOsmsY3xHDN?=
 =?us-ascii?Q?36QZeHeUAbey+vnoRli9kK6vO6tUx0M3YOFu5BbJgZSl+OkqIGeavzD2n9VI?=
 =?us-ascii?Q?8c7GU13CN6eWNlmYq1dfTswqlTOem4fvtWEgDtraOYDHxZZCyQf/7gh+/J2h?=
 =?us-ascii?Q?jpg2DRriS76mdoikEB7Q4KZsds8hC8OHcYz5orb9TqxakclXeRJJF1DEhJ5p?=
 =?us-ascii?Q?FnKc7BTkIXBU3QPjdBPerBlG8+Yu2l2L1Gjeow/BN7yPvUViyHNI5Mf5sDey?=
 =?us-ascii?Q?0Bu+dNpmqqeZRI7kRAhGmLlw0kXF4svL3IdUJWnrzUJWAe2CA0vW8nUnhIpC?=
 =?us-ascii?Q?sMUHY5eYJzL1CsIRY8wSDbe5ONcGabMr5YtVorbf4QAHwrHj1oQYuABo6afS?=
 =?us-ascii?Q?4g5g8Vyw7fSoOCrvJAE1F/SWewl4NoeyG8kPRERZycB+fIS+p5K7g4o+WMyK?=
 =?us-ascii?Q?+X0k6XKx+VU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+F8L6myE65qgC/ZWuPOvhjnazotsx8GaDhZLIZMP9LsZh8k7rALtEmHJiOh?=
 =?us-ascii?Q?BPsP9Lhxl7rU3q5gRKzADJ6FIhBr1ix178N9AuK7VSlhekiFZ9pgh2I09Efi?=
 =?us-ascii?Q?Z4d9yxGhEtEpy+xhLaTatPH+V3Kg0l7kMEqBOt6onKitTvf4NPsZGjAFKmxT?=
 =?us-ascii?Q?WZkDDwj6io7EpC9kAIk8Sfm4Aaf4ldm+c/qzSFH2FdHCbKQDaOLqUU2tyAAn?=
 =?us-ascii?Q?gEHiNEiP7a9sD2pbceFyc6MjBME/mbI4dtNpg5/MEYlYxIHyxmgXG6OZf09a?=
 =?us-ascii?Q?vM150Q671oFT+qTe8mAYdLfFjhwboJBIaYtQ/WztxhOFXMHzikxE1PwOh/5V?=
 =?us-ascii?Q?++m/n0Vzr5P0bFVaRiwubbyo9lP+Ug+Q+SA/6DdJ5/S8xEJ8kBvL4vVV/H04?=
 =?us-ascii?Q?pH39fiELm4PTJe1EPLuyK34CK0q80X2yuApUzWT7b8PPSfFeSGRdz1Zu+9nx?=
 =?us-ascii?Q?B2lQyX1x1w+mbzDm3OWbH5xVWtvWr90R51JHLkLqXQ4b6BC3Ia6MUnpA6UQ/?=
 =?us-ascii?Q?aJqEBgoTnpCwYC8HEOwkV+6RzH7kpzJ0yYKvWeBuSKDL6Uapu54POAEEcAAe?=
 =?us-ascii?Q?KPqd3bOqsAjwBs+JOq5nFv61N0WQzKeWdNSD/jDSlRcULZn7vz3adfkwLvOq?=
 =?us-ascii?Q?uG1eTBxl2EmCXRXdNK9gil+dGA5kKISuDT2BmR6wYBxxbTGAijjT8TdMFHUY?=
 =?us-ascii?Q?KUvMYOA3gtMKeFnXWUUzNeO4Ap3tmue15sCpWStBDOpA+c+ZEGHAby3xY9Lj?=
 =?us-ascii?Q?M+TZ6bv3PIxF1FS9qjHVwlonFW1LlD4HfznNeRbe7eOoLPr9z1RAt8Jg7EeS?=
 =?us-ascii?Q?ibYhSqVefxgoZrN2FExJFA9cGgluK0nTKQg920CcOxyGAWB3ktPrNLCQv1aC?=
 =?us-ascii?Q?uN+mYE9rs4KIWOTRS4HQF+a+u8v+XscawXIT2ViSgyFyGyDv4Br7A4hAkDwH?=
 =?us-ascii?Q?hXfOVRryyuntklxjDXCzs65nseict/rhqRbYQyS62XPAd8Hs59YiuBZNM6aO?=
 =?us-ascii?Q?S/7yDgeqbNCAmBGZPQb4isN34fVVNCwCpbsMDB/GapQeabtQF7fonpXYVcqW?=
 =?us-ascii?Q?EUHIwpkTFMf03xhZ36yW0knKeb0uI3mLVmq1lccWO5f/D+kVV9iLx5i6Qw4m?=
 =?us-ascii?Q?P+xI48KEhH+SXZugo8i1sQEnamR+afNxObfaiw27OxCbjPzlxrgzyyPvZWJj?=
 =?us-ascii?Q?D3WMyTNvBKtIMAJNG8TZYA0cwWmD0MR/55b3wJIuvpsHAGoEryMGc8QGer/0?=
 =?us-ascii?Q?pc8BpvjvI8C9rpNGTRyhE0qovufXgpuJ9OyZSdwcs8EfAO0WMWlUNsmEWsq+?=
 =?us-ascii?Q?pRjlfPqmBJv4uRRJfnRD6+xJKrn+DK1IQfPP5E7RcUfVEUOmhCuZtV/SgY7C?=
 =?us-ascii?Q?49N4N0mrzuvqAI7EcdzjzXMOHwZdhPhl1Rzky9IxkqpesJhXsM53NeKePzPN?=
 =?us-ascii?Q?aOPqgHpiCpvFWHA4XezFZYbsRANobSv1NcOVxdaQ0VVSbu2BMT5i/MQenN+0?=
 =?us-ascii?Q?W1DAoGimbi5FWoEF0dNFOeYkRCTRPivbRVShJwreD1cZ3ZByzetZl2ODDULe?=
 =?us-ascii?Q?Q8GvXJXV8gW/vJn/P2ynmtktFd9+DaY3QCMxqa2uQVUyX91S4C0F+HX6AfsK?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TAsvmgPASWqfF5mv8Uy33/6DwVIpuyROOH5EZqI11n5CZp5rqSsh+VRUn8x+gDsYpGmrcJ53+ZIt65DoQQzXhuhoR0jfpldLHUxUHlDEmU3E9BIg/Iw1K9SJ4KESs5iaB94D6HlZlZu8WvAJv5kLO89K+thiI7F4N/0G7sVVR4mSa51k8xpiQiNbK9sJc4AO6SFxXkKE/z8K7i98q4C36F3souCchG6Ze+N4hW9YKEQOs1JWHVNDTY05GBMm1gJUvTDZFf10mxEQ4uhrJaBP8fJtOfzooHCNm6csoyE6JlIABIq8/Eb33KFR2TPtkmcyo+BHDEoZ/2xqmkwUcmxI5ZHOr3irEdVxl+zUU5gn9EyXW41DPoQHUIiydnp7CeOTlpIg8GN62omAT/XRSxg9MpsM5xKy1IWz2+uHrx0XUTU8iRtOjMW8SGaQAi0Uv69hOuSkfOYtrpPHXX61mxtf8HS/rs7pzZPZ42q+wWdnBgzlagq+n4jc99FLyZa2bki1bUPBmEXljLIqL7bZdfgWNd+6LtPIPwftLRTcGVh9JmsjHln5TSha0ohWbFYxmjIW5sTCHd/CRJW7zaLLTXgG94N2JHsLn3Xpwdb57+6nByg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f666ff3e-142f-4bec-cb07-08ddcb87a06a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 14:29:12.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/Y20N3b8hUHnDmblfsM7Gb0Yan7Ys3UZWtVyus6oy24YombtdvAtlwGBf36luUlBmAVggnmdmuFCvRjuXgWj3ezCTaAt1S79RA6SCRKq/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250124
X-Authority-Analysis: v=2.4 cv=ObmYDgTY c=1 sm=1 tr=0 ts=688394bc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=ugTZ1JffylU6fGgTOswA:9
X-Proofpoint-GUID: SjnCh7o_kFvsKQAPcSKqvwT5K8sVcN2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEyMyBTYWx0ZWRfX5LIv/Fu8OmD1
 45GJYombN2pVzVR1rj4kplJELwVYIPxfg09/ySiSLNlfqmH8MQpxMVlga0xeqptvwFm8y8EfaJ+
 46tr27rxDHgyW+y5RCOATdcd/xOw/ZNN4KK6weSsd/VwIVh/ODT4JYooQ5Yhp+SFQh+1mX7+oIL
 RJE5vgt3LKUh0r/rMgIt4U/+ITRAY3kuEowjkhHoiecsExiqX8DA9t79btDsSQHgjgoKKZtO85z
 RBWDWwng3dP/q7VHWeOuDQZLroOJTA+1vbucgbLyLqZcoiKxMOI+MfKc/AIdD1dhMpKbe0QlxQe
 3Cq6//IOh5S/2JUuw65WDCFaDlUd5Rl0g1iEZSob6M6LgqkZBQtZW7y32PwTiE1sWmAB58FJWFj
 kABNKq/fMPmrVal1frQP/PqCpsnXhEmv/3PaHpJnBvzTkmSiN0V54p9RQ8KYNnK5nYbVrjZX
X-Proofpoint-ORIG-GUID: SjnCh7o_kFvsKQAPcSKqvwT5K8sVcN2D

This is dead code, which was used from commit b739f125e4eb ("i915: use
io_mapping_map_user") but reverted a month later by commit
0e4fe0c9f2f9 ("Revert "i915: use io_mapping_map_user"") back in 2021.

Since then nobody has used it, so remove it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
v2:
* Restrict ourselves to removing only the io_mapping_map_user() function :) v1
  was rushed out and zealously assumed that io-mapping.h somehow only referred
  to this, rather silly.

v1:
https://lore.kernel.org/all/20250724145313.65920-1-lorenzo.stoakes@oracle.com/

 include/linux/io-mapping.h |  3 ---
 mm/Kconfig                 |  4 ----
 mm/Makefile                |  1 -
 mm/io-mapping.c            | 30 ------------------------------
 4 files changed, 38 deletions(-)
 delete mode 100644 mm/io-mapping.c

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 7376c1df9c90..c16353cc6e3c 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -225,7 +225,4 @@ io_mapping_free(struct io_mapping *iomap)
 	kfree(iomap);
 }

-int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size);
-
 #endif /* _LINUX_IO_MAPPING_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 0287e8d94aea..b7a47bb593d6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1254,10 +1254,6 @@ config KMAP_LOCAL
 config KMAP_LOCAL_NON_LINEAR_PTE_ARRAY
 	bool

-# struct io_mapping based helper.  Selected by drivers that need them
-config IO_MAPPING
-	bool
-
 config MEMFD_CREATE
 	bool "Enable memfd_create() system call" if EXPERT

diff --git a/mm/Makefile b/mm/Makefile
index 690ddcf7d9a1..e4ab5ca755d1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -142,7 +142,6 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
-obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
diff --git a/mm/io-mapping.c b/mm/io-mapping.c
deleted file mode 100644
index d3586e95c12c..000000000000
--- a/mm/io-mapping.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include <linux/mm.h>
-#include <linux/io-mapping.h>
-
-/**
- * io_mapping_map_user - remap an I/O mapping to userspace
- * @iomap: the source io_mapping
- * @vma: user vma to map to
- * @addr: target user address to start at
- * @pfn: physical address of kernel memory
- * @size: size of map area
- *
- *  Note: this is only safe if the mm semaphore is held when called.
- */
-int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pfn, unsigned long size)
-{
-	vm_flags_t expected_flags = VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
-
-	if (WARN_ON_ONCE((vma->vm_flags & expected_flags) != expected_flags))
-		return -EINVAL;
-
-	pgprot_t remap_prot = __pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
-				       (pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK));
-
-	/* We rely on prevalidation of the io-mapping to skip pfnmap tracking. */
-	return remap_pfn_range_notrack(vma, addr, pfn, size, remap_prot);
-}
-EXPORT_SYMBOL_GPL(io_mapping_map_user);
--
2.50.1

