Return-Path: <linux-kernel+bounces-789147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4202B391A6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6743AA86C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805E1DF268;
	Thu, 28 Aug 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VLQ4y6M7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OucFcW7E"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5330CD8E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347651; cv=fail; b=koacpW8u0NFnoDRQHAgmVgsy1f4HQKzbMBTzu/5uG2YWPoGhwEBdMQ9Da7s92DuSTv9yqR+t2vNCkbz0jw9/zIo+8Lu4zHlg949BAOn1scg3V8+DmrWJflPIn5V1GJEU7KtFj/OA8acvlpuBf8tj0DM9qcNQ5MoNb6XT8imi/2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347651; c=relaxed/simple;
	bh=bwe3WXaUqWZarUWk/F0xY3R5qqeThLBGSwTOrUxKeHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cLbE0t/hjiCusL6IJ7Dkxr9pLK2eAiKmW8ztz87RtfO8GJHi1fyL/OrRYZ7DNuNz84oWY67CdkXtoH4GHNoT6M8BjK+o8bzvkLMCVh185GDznGdRXYmG9Midz3O5F8+eYSdWq1vv8tX/HECvnYkQzbnm/ECeLO1qKUg9hr4BWwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VLQ4y6M7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OucFcW7E; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLHMA2017536;
	Thu, 28 Aug 2025 02:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6fzJyKQcKmV4r1wq8O
	zRcHGRZsltJNFrZsQtWZ+kpls=; b=VLQ4y6M78HFPP/GkuOZES693ULWBMUX2XC
	0YqmnIijm7MNqaN9t6ZdiQF7g1fPS9gio/tuktR1klf2XlOYlIxwnp655Zbnb3pO
	BCzUTHDOT0G6Ywwp71kKYUahEabEjWR/M+ztkWIHXQ7jb6fmv/nlHMnwC+z1scCe
	l017qhQT65rBKsHDWJi1eS56oYl8z6YxrMOrlnPdEoEXvLAcYqNSwhhMDPq/oQsZ
	VxJaVprDDvRXrRi0IXomskoTYwPtMOg5fFnlj0EzjI4FXiIGf395lY8HzB4z1Y1H
	NMJO44nAMZtIUE3Tni2CqtRv8MsXGcuT1K4G46gezhfp1H6eFSzA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48eqq5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 02:20:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNv4JC012234;
	Thu, 28 Aug 2025 02:20:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b9rfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 02:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL8nu30PeYAXtCZ+7SkFz5/1YrrQC5XvBfJIT4mr5cgnUqLDYosesbMTUc7mnp5W+K4qjGkx069MKFaBJSdVLcfvnbxGcX2bI/cX5F6ve/tXEhEsrA5n+qtlXx9fl0pKbwpQGipiGJDazqnkZqtv5BYYM0PsjArLS8swGst5bIpTyrANM3wu+6TaeIvth5MIvqTNlZKPt7j28HHqKmGk6YZLmVOGIAD3Q+ee7kToG8CQzGvyajA124pErUs9vAO6LFbhqnI3VnAAAGaHBsfO1lxepVVqJ13HccNqO+TNdRTh0BBu9Tm8oi45wa8n40TT4BdgEtMWN2+wlbun8qSDIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fzJyKQcKmV4r1wq8OzRcHGRZsltJNFrZsQtWZ+kpls=;
 b=V27cVFfpyRt1fR/s/cX0bW2MHYowseg6DPl93SAdHr3XPzG4PfcSltvrsYX8MaQB/WANk7iQ9rna8XIivOdIxemo8l1nMOqQZH0CweL7HGhfZ1uDvgZUeeSBIqheY0CbMGbHTv0Yq6XUPMGhUS2yK8MCD6DCbKeu9ZFo43YI4pngd6vvbiDgkPqkTscM2m2iXyxKkGovrjgtgeX/c9HZCzG55k9VsNiFzyKTxQOrzpsLmggkInehzOn3LtX2QSOMREoCJ3tZPi2LJMr2G6wdGZ3cX/boFlAr8Md+rlO+Meeq0fk6gxO98qi3bQZE6UYTcyeS46gm1GCBJsotHfesFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fzJyKQcKmV4r1wq8OzRcHGRZsltJNFrZsQtWZ+kpls=;
 b=OucFcW7ELESSrBjXULPdzsFr1DJA4FrK1APuV/kDyG8Q5OeIcu454aArkoJbNIglidjcYx77L742BPz1ot91j37n0x13wxbUfRyy3G6hxBbSkMLUaeSEVWhBB5s2N1xE1rcajX2qpVc85LplrHoN48P1EpggZEhLZTUgcROp4MM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA6PR10MB8088.namprd10.prod.outlook.com (2603:10b6:806:43f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 02:20:32 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 02:20:32 +0000
Date: Wed, 27 Aug 2025 22:20:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_munmap (2)
Message-ID: <zfqc3duhgtcevsjaulyn23ckgg5oyuiyprruichcbthhqtknqa@vgfjpy6dyu7k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, pfalcato@suse.de, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <68a7eee9.a00a0220.33401d.0168.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a7eee9.a00a0220.33401d.0168.GAE@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA6PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ce934a-f267-4687-9243-08dde5d976c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mh/N6nxG9LwMaLUCPmlJa2WPL6FsL9o7Dd4gnbTDlX9wIlifBhqUidO11ezX?=
 =?us-ascii?Q?ytvGEvXV3ZQyi98UazhAFrcgMVAK32a2Jvh7Ak2vA43SV1K3nbqLPruKUWRb?=
 =?us-ascii?Q?NP4OL22B95Xw0kOGeKk+rUbK0QDU5QabD96tzTUtQ2YFgaxdo1hv5kLj24X9?=
 =?us-ascii?Q?cb1/tQibZnV2yYql0AbIN50cD3jIjz+tJ77rnWTn9hOr3KZSfkqaOMlOcCEB?=
 =?us-ascii?Q?NFsnrs8Y6E3mMK1K+Y2wPxtDmnCWFpT3jrhbuwnj83MNzJNioiZGAghtcOHP?=
 =?us-ascii?Q?HG6CijoX7xo8/CJIVXIlqIcuaXu7LwoDaTmwr3Hx4ZQQOhefPEN1jad64q8y?=
 =?us-ascii?Q?NkibdkOs+dnPlO+tBjTo8RCf4X4ZK2IcgRp1tNiDMRFvSBDXgD2LqRqXe9nk?=
 =?us-ascii?Q?7xdJS4ExgoF7oMyT5Ii9agN2cYnhq/Qz4CISzNPRAhTOYMg1xdnzrDWVNGZZ?=
 =?us-ascii?Q?LlqTufyaZq3y0nNsr0jiJbzr1tLdvO1dqmo9Wq9Y2NJ4HbW06YkmL4HhlF6P?=
 =?us-ascii?Q?S3B1NnhXaRItxIUIOUX3+v7EDIt1ztyUMdF6B2ZYr1WNE9K4RwPbZXeUBhfP?=
 =?us-ascii?Q?g+d9KYaHiyOCw+aD5nobD3/MsuehexBwwF+EPv6JBUKE5/T1C61HR/CgH1bH?=
 =?us-ascii?Q?0OiOLAZ/pqQleTy1QEQdXUZh5lHYtgIVXr1QnLSO+sFC6cwk2RTF8OZ9C+hZ?=
 =?us-ascii?Q?2MjhjhGEJ1hxkZrvlvdD5/gyIEEaXi1fLxUG01CyaSFMmdpc99mEedzw24oc?=
 =?us-ascii?Q?nMdtGJGfXccPdE27IoSZmsNpyab7cZddfwzG2uksoky3YpXcdrZ2xvQjQZto?=
 =?us-ascii?Q?3IcjjpsEFzmS9uWC4U9RyIpkYhenI5QNaD22DQkV0cCPnNyVIGegX6G9+NFp?=
 =?us-ascii?Q?LFMoXaukRCXWUpz8lIWgNv7FDlqYCQ6mHlr5inF1Y1kwPL+K7+/or0soa4fB?=
 =?us-ascii?Q?gJ/JQ3SLEPWFyMhGXNIVwprfpmqezZUnEN+zSGozZqebupmWU32EeeagisZG?=
 =?us-ascii?Q?ygV5g0fXHyotj7nc4CG0zntJGFBFxvXS+di16KpeEw8fn/Ew9yFK5RNGgwvO?=
 =?us-ascii?Q?6kCv3Q68uFJC1WqZTbWPK3OdJtqUpriH2MjRIDV/hCT6MRIc4PtHWoWAEWLZ?=
 =?us-ascii?Q?669qAnOd6ZEs6TTPFivnJ49q4d7zGMf9gei0uwrrCxrcqfsLIFS2QHW9VMby?=
 =?us-ascii?Q?O7rkW7oDnPgAtFykAv0zEA2gBQ73EhgnKP/9Hm91e+BW0KxPoCAHBoAFyc9S?=
 =?us-ascii?Q?GLT1JoeG4nxRtL0+Kob/z1D532jXamHEsmjuZ3f3KXUIrBEb0iYaweI636PE?=
 =?us-ascii?Q?17vX+egNIv1f5swOfaVe13UOcf/qZ3Sfs0mv0sY2Ucm7je5GyHszoWLmIm59?=
 =?us-ascii?Q?/y+kaoxafgiLAmOooE0OUImm6iqb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spQc3TnVtKmFIaif5DG/9JqANcQVy+gDP/Grxz7NkFLjxkbznfyb90/c8nHo?=
 =?us-ascii?Q?TNdqDBRDiwbLH0EDd7zXjRke3rN+yqfW135K7LZEualNHXXcgfnpktyBo8fc?=
 =?us-ascii?Q?FmfMxSTr9L9gXrGyvYk9NtxsjFs3Q/Pb9Co2TofzRUarIjloQ15I13hLStDu?=
 =?us-ascii?Q?OHTxOdgpv4DYmx46Ny6TSFL3H3narn5QxG+Q/msiwHYHgNOYcTZJMfjIc7Gh?=
 =?us-ascii?Q?hERHEmQHne071J3pJj5SvvhW3TPdWfHsuo99neTVBVWhw4E+gcibRrySQeAA?=
 =?us-ascii?Q?c5AldR/bnxh67O3VpqJo19hSQI4GuNQUFChw3J74MmZNghiXmhkFC4t3+kKU?=
 =?us-ascii?Q?1i/udX++RH5EIgsB/3FmkLKBEwpmJrulY68C+m8KmrFH0Q1kcl6tioFy07OY?=
 =?us-ascii?Q?TYWvCur9NfGGnL1xdfF/M9OmnaWUtN3a1sYWIYFun8e4EySrAbezyzwhxM23?=
 =?us-ascii?Q?DrSMYgMqVt+LZcefkmM86FGs9c5Pdnzk8QP46CfAWBsuwPpqeLvVcrZRo6Do?=
 =?us-ascii?Q?k0H9lz/yZtL1bLLz0U0PX1rMNVwE0asFbJIcU1E9y9VkgjunFUHJNrdB6GMO?=
 =?us-ascii?Q?eMLKw+/U27qCMZGOAtH1B1yr9R1/30WXdy49RtI2w3dJ6OMLZNEO2QOSS3RF?=
 =?us-ascii?Q?6kD1JeIhdiNT5T8VPOw8CQZy/OmxyvbLvhDA89ErQC7U4pyfV6qEx8A0K1Qw?=
 =?us-ascii?Q?MtrwlYlT6r3C/weId7VVmbMpPfm+BtxRO0ClOUNF4TQt6as6+UEbTg0vpPwV?=
 =?us-ascii?Q?79eKef9SuA2eWMO1n7+wzIbza2+Q0pXzf0yPxwQkNLv33G6WYxU0KKnQWcSM?=
 =?us-ascii?Q?qSljih5b4qTPU5iFznptfA/joCPnrxOkG/0zzX4rcPnlYkqCdOLEqpDUTq32?=
 =?us-ascii?Q?sk3eLcQYc1jDXumDqGDvZoH0lXCrEw4Hmjkepi9lez8m7bXok9uPPClj1Yx7?=
 =?us-ascii?Q?j0v2q3CQRUgSiip3BhMtEFRF4zgI1MqwkDRH3iJtitKJQN4ud813DzHKIMzZ?=
 =?us-ascii?Q?ILUztcYsRtIsP0yYZQQTYcyTpN5a7JLjILgfD3u3+EKVjGabCKavZ0Y1UUwL?=
 =?us-ascii?Q?2iDeS0opoCGbjJl2yIOuFMF8TiURozKMDof8dlLhyTF2Dtgfgfr/KzqPA+Rc?=
 =?us-ascii?Q?/ndtvJP485LEBeRQW7I4YZvq8EVqTmz5cbFs/ypDmuUA7L26musXiUmXR5nD?=
 =?us-ascii?Q?M6FFCqkM5UTHeN3s6w4RjP90LKCYGOxkHXJxelvl3AiyhPIQZfqfrWe4krtt?=
 =?us-ascii?Q?wkZzEhMygG4itwpRtJoR47Cpg4PUXznd+aSEcxc4e3FbydxUVgaIWDhRSiXz?=
 =?us-ascii?Q?5DDmXOLVOFbEkEOkZeQRVVeaXKH9sn9zOlDHzMBBpcjmDezBEF2Twsf6x4j+?=
 =?us-ascii?Q?gYbwFSXDNLNbvx/MLg6SGqBItN0vQVYPUJu862xLBkT7n5XrIh6f/KYDuHGx?=
 =?us-ascii?Q?SPeOYWEuo2yImxTx3PcNTsZisYATz+6t5oIyjPBmh1YY1m3TOXkKRSPXJBJg?=
 =?us-ascii?Q?C8BkHuQNmyQUgLIwkH02n2Kyu9E9xL6p4q4WHhq7jArz+O1851EmdHrs1mbw?=
 =?us-ascii?Q?GNzD8maZ5cgocy19E7ILxhLzoW9FZ6+USCUFoRt69TUJ5iO4trpsX68LBKfP?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C34jBh/vfeW9BjfJ6StvpCPOfUblW7JNki8Y2iXhVGOOcIl69+LUG/O1YTurkLtffNMcpMIoUJiiPMjv9muhNZIDpPCzOY4w+wi6FqCE/0hmO7WSRingP5BdwENyQaMaJ+NXwj/B/SWWchH2VCaKoV8J1Ul6nEGKNJuoVpmu7pq4eIxLSI8fpQNyv3YG3bgT64ublT7RXja/HA0IrIO3/CQO1WAicZaEh/osY72Vu65KFnvhdt2TiUPPc3b+n/m+6Mt01fP5zJbD3UBBhpjpU379F30fIB44LDE05xblDq13deXlkjmFGCA9diPOHdaFTgdyFsxeXOHR0yxjTzOwKHLBPnRPMHtRLmMRgoieTHOp+plt8S709QUAysm3UKThzeuDdu+AY5n+CLvP00ljhpPQJEV0iuAATHPFwLj4ciiCIHTc0hoPs3pAOCV6WILuhoYzRJZM7NgLj7N1R287gD6FC2uroFQ/kD4xzrf4W/dEXm3WI6QVPOjC8C9+3UO7mhfXveuU0vArXLJyvWvcTI2OV/VWpcJg9CGTRVtOazOaKkCCjRfkk4PffKAP0xyvV+R+JgvUOD74AX3Val4cLCZhhrUyXRYcFd+chbU82O0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce934a-f267-4687-9243-08dde5d976c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 02:20:32.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sogsK25yPRiU9JHwJj/TBjqXewtKAG7S9UfgbbeYsoH9yCCVDN1wIYjHuCCyhgkpL/vbhkjTDoGf+EWLpiFGSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280018
X-Proofpoint-GUID: QvEflGEIPQILSXlloHuR-Rjl75XycTFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXxmoOqbB4RDi9
 d1kjKMGhjftZIGSWrX6UZ9TYpbrlOW3iRpj3oGxxDN3du4byLIGfrtcH+FT2wmkbUfbvStWrVYk
 7GU3BrNA+BLQZpavUPa+oHxaAd7+TXnQ0mFJ5NyafbUBu3AO+stqoLm1qV+lvs2yPbbb0pGEFw+
 lZVYddxKhvG+29XcTPiwFCdoHDQJX8JxfAKiKK0H/1agO0pFTmVbPZY6fTK9zrs7uciIM3mgpJu
 ns+enhIt/m4cm5swmTzgrn9ZqLGs90zGArzx7nz3YwYENgfrty2LCDpsx5v93o09FnegaoMYwvo
 YDcZ9dPtomvndCV9/NZnIJjatdHWDybohOcpbOaVl4ZdRSwMlyoUDIh4984+S8wkD3Mf+DptQA+
 UHOVGhC6SnXjzmfLXTYM6LKuff5RLg==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68afbcf3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=3g80flMcAAAA:8
 a=oHvirCaBAAAA:8 a=hSkVLCK3AAAA:8 a=JfrnYn6hAAAA:8 a=4RBUngkUAAAA:8
 a=DSZvekaDx0hFhfe1CyEA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=CjuIK1q_8ugA:10
 a=slFVYn995OdndYK6izCD:22 a=DcSpbTIhAlouE1Uv7lRv:22 a=3urWGuTZa-U-TZ_dHwj2:22
 a=cQPPKAXgyycSBL8etih5:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_sbA2Q-Kp09kWB8D3iXc:22
 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: QvEflGEIPQILSXlloHuR-Rjl75XycTFx

* syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com> [250822 00:15]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136dfba2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=142508fb116c212f
> dashboard link: https://syzkaller.appspot.com/bug?extid=8785aaf121cfb2141e0d
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107a43bc580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/24fd400c6842/disk-be48bcf0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/59146305635d/vmlinux-be48bcf0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b3e5f65cbcc8/bzImage-be48bcf0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com

Apparently I have no idea how to do this.. let's try again.

v6.17-rc2 + skipping validate_mm().

#syz test git://git.infradead.org/users/jedix/linux-maple.git no_validate

> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6029/1:b..l P1208/1:b..l P6031/3:b..l P6030/1:b..l
> rcu: 	(detected by 1, t=10502 jiffies, g=6285, q=421 ncpus=2)
> task:dhcpcd          state:R  running task     stack:28896 pid:6030  tgid:6030  ppid:5513   task_flags:0x400040 flags:0x00004002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
>  preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
>  irqentry_exit+0x36/0x90 kernel/entry/common.c:197
>  asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
> RIP: 0010:unwind_next_frame+0xfe7/0x20a0 arch/x86/kernel/unwind_orc.c:664
> Code: 85 80 0c 00 00 49 89 6d 40 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e 56 10 00 00 <41> 39 5d 00 0f 84 10 06 00 00 bd 01 00 00 00 e9 de f3 ff ff 48 b8
> RSP: 0018:ffffc90003cdf6a8 EFLAGS: 00000246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90003ce0000
> RDX: 1ffff9200079bee3 RSI: ffffc90003cdfa70 RDI: ffffc90003cdf758
> RBP: ffffc90003cdfae0 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc90003cdf718 R11: 00000000000121e6 R12: ffffc90003cdf768
> R13: ffffc90003cdf718 R14: ffffc90003cdfa80 R15: ffffc90003cdf74c
>  arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:548
>  slab_free_hook mm/slub.c:2378 [inline]
>  slab_free mm/slub.c:4680 [inline]
>  kmem_cache_free+0x15a/0x4d0 mm/slub.c:4782
>  vms_complete_munmap_vmas+0x573/0x970 mm/vma.c:1293
>  do_vmi_align_munmap+0x43b/0x7d0 mm/vma.c:1536
>  do_vmi_munmap+0x204/0x3e0 mm/vma.c:1584
>  __vm_munmap+0x19a/0x390 mm/vma.c:3155
>  __do_sys_munmap mm/mmap.c:1080 [inline]
>  __se_sys_munmap mm/mmap.c:1077 [inline]
>  __x64_sys_munmap+0x59/0x80 mm/mmap.c:1077
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb13ec2f2e7
> RSP: 002b:00007fffe10fae78 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000562bd1443510 RCX: 00007fb13ec2f2e7
> RDX: 0000000000000002 RSI: 0000000000004028 RDI: 00007fb13ea1b000
> RBP: 00007fffe10faf80 R08: 0000562bd1432470 R09: 0000000000000001
> R10: 00007fffe10fadb0 R11: 0000000000000206 R12: 00007fffe10faea0
> R13: 00007fb13ec42000 R14: 0000562bd1443510 R15: 0000000000000000
>  </TASK>
> task:syz-executor    state:R  running task     stack:27632 pid:6031  tgid:6031  ppid:5870   task_flags:0x400000 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
>  preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:7145
>  preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
>  __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
>  _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
>  spin_unlock include/linux/spinlock.h:391 [inline]
>  filemap_map_pages+0xe15/0x1670 mm/filemap.c:3791
>  do_fault_around mm/memory.c:5531 [inline]
>  do_read_fault mm/memory.c:5564 [inline]
>  do_fault mm/memory.c:5707 [inline]
>  do_pte_missing+0xe39/0x3ba0 mm/memory.c:4234
>  handle_pte_fault mm/memory.c:6052 [inline]
>  __handle_mm_fault+0x152a/0x2a50 mm/memory.c:6195
>  handle_mm_fault+0x589/0xd10 mm/memory.c:6364
>  do_user_addr_fault+0x60c/0x1370 arch/x86/mm/fault.c:1336
>  handle_page_fault arch/x86/mm/fault.c:1476 [inline]
>  exc_page_fault+0x5c/0xb0 arch/x86/mm/fault.c:1532
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> RIP: 0033:0x7f54cd7177c7
> RSP: 002b:00007fffb79a5b40 EFLAGS: 00010246
> RAX: 00007f54ce525000 RBX: 0000000000000000 RCX: 0000000000000064
> RDX: 00007fffb79a5de9 RSI: 0000000000000002 RDI: 00007fffb79a5dd8
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> R13: 00007fffb79a5c48 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> task:kworker/0:3     state:R  running task     stack:25368 pid:1208  tgid:1208  ppid:2      task_flags:0x4208060 flags:0x00004000
> Workqueue: events_power_efficient gc_worker
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
>  preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
>  irqentry_exit+0x36/0x90 kernel/entry/common.c:197
>  asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
> RIP: 0010:write_comp_data+0x0/0x90 kernel/kcov.c:240
> Code: 48 8b 05 db b4 1a 12 48 8b 80 30 16 00 00 e9 97 05 db 09 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <49> 89 d2 49 89 f8 49 89 f1 65 48 8b 15 a7 b4 1a 12 65 8b 05 b8 b4
> RSP: 0018:ffffc9000441fb50 EFLAGS: 00000293
> RAX: 0000000000000000 RBX: 0000000000040000 RCX: ffffffff89ba2a52
> RDX: 0000000000040000 RSI: 0000000000000433 RDI: 0000000000000004
> RBP: ffffffff9b2c41ec R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff9b030610 R12: ffff888031800000
> R13: 0000000000000433 R14: dffffc0000000000 R15: 0000000000001770
>  gc_worker+0x342/0x16e0 net/netfilter/nf_conntrack_core.c:1549
>  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> task:dhcpcd          state:R  running task     stack:26072 pid:6029  tgid:6029  ppid:5513   task_flags:0x400040 flags:0x00004002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
>  preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7288
>  irqentry_exit+0x36/0x90 kernel/entry/common.c:197
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:orc_ip arch/x86/kernel/unwind_orc.c:80 [inline]
> RIP: 0010:__orc_find+0x7e/0xf0 arch/x86/kernel/unwind_orc.c:102
> Code: ea 3f 48 c1 fe 02 48 01 f2 48 d1 fa 48 8d 5c 95 00 48 89 da 48 c1 ea 03 0f b6 34 0a 48 89 da 83 e2 07 83 c2 03 40 38 f2 7c 05 <40> 84 f6 75 4b 48 63 13 48 01 da 49 39 d5 73 af 4c 8d 63 fc 49 39
> RSP: 0018:ffffc90003337648 EFLAGS: 00000202
> RAX: ffffffff914e0dd8 RBX: ffffffff90c5215c RCX: dffffc0000000000
> RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffffffff90c52148
> RBP: ffffffff90c52148 R08: ffffffff914e0e1a R09: 0000000000000000
> R10: ffffc900033376f8 R11: 0000000000011271 R12: ffffffff90c52170
> R13: ffffffff82127173 R14: ffffffff90c52148 R15: ffffffff90c52148
>  orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
>  unwind_next_frame+0x2ec/0x20a0 arch/x86/kernel/unwind_orc.c:494
>  arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
>  kmalloc_noprof include/linux/slab.h:905 [inline]
>  slab_free_hook mm/slub.c:2369 [inline]
>  slab_free mm/slub.c:4680 [inline]
>  kmem_cache_free+0x142/0x4d0 mm/slub.c:4782
>  vms_complete_munmap_vmas+0x573/0x970 mm/vma.c:1293
>  do_vmi_align_munmap+0x43b/0x7d0 mm/vma.c:1536
>  do_vmi_munmap+0x204/0x3e0 mm/vma.c:1584
>  __vm_munmap+0x19a/0x390 mm/vma.c:3155
>  __do_sys_munmap mm/mmap.c:1080 [inline]
>  __se_sys_munmap mm/mmap.c:1077 [inline]
>  __x64_sys_munmap+0x59/0x80 mm/mmap.c:1077
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb13ec2f2e7
> RSP: 002b:00007fffe10fae78 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000562bd1443f00 RCX: 00007fb13ec2f2e7
> RDX: 0000000000000001 RSI: 000000000002f6d0 RDI: 00007fb13e9c1000
> RBP: 00007fffe10faf80 R08: 00000000000004f0 R09: 0000000000000002
> R10: 00007fffe10fadb0 R11: 0000000000000202 R12: 00007fffe10faec0
> R13: 00007fb13ec42000 R14: 0000562bd1443f00 R15: 0000000000000000
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

