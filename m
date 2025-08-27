Return-Path: <linux-kernel+bounces-788172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0145B380B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24CE18987DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F4F34DCD9;
	Wed, 27 Aug 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g8zwUPUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tbBRz2It"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772334DCCA;
	Wed, 27 Aug 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293445; cv=fail; b=qELl7CDUqcGHu6erciJ7dWpTUw0HXnpUh3aDO4x1RQ+ZW2OgopkoX5UFcIwHv1xQJueqZz1H/bpwaEKR1w928hUpRS5Z/Jl0y0I4/NtSodAASVX/2HlS4Pw4L/sD1bHAcJvE956qPZIwiWNOrsPpEqzX3wozjgy0QY9xsQ4b41w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293445; c=relaxed/simple;
	bh=rQ2LAzHbg+av2Xg6AHqVLLFj6qIQ3nm7O47f01K2Htk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwpySH1jSYMkKakRPPANkkmREsd5lazTMYhjjA7labEmQfqmPJjJ9zdWAFf5ne9AtT8uqjspFHzHa8z5r434nVExCeXmAhrEQiGPK+OyRsa/Um6U1dq9esxx70OfRZRxXrmjoteo2WekFLg0twhwgWPRjKLgo5OCcynvqz2HHho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g8zwUPUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tbBRz2It; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7tqFE004233;
	Wed, 27 Aug 2025 11:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AbW87RY+tCg3wKiT43
	fqBztb+LWw41rp582LIi2fcZM=; b=g8zwUPUCivBBvmdHkFTHoOCOowFsdLndZS
	IA8MTwBo6B5C4GZsiwpp6L4UPpeCV8nFjHLj2XPvIIyQ3ON18xrjjGuKoNSwAeGI
	ZDjbrp0xhBS9IEGiimmxjx+zLbmtNS+B6l55pqx8K+vgU9KQizT2OCxQwQkQE2x9
	zkMpkBsBqm+N9RmfZHX4aiCBeRfrWLewdPQ+kMGeMzRJlxCdxMRO6WrtETbnmiYm
	h14iMo99lUHT6fbzM69DdiEy94WUpj3SuHmYUJxDqlrPYvR1RmXfxN0IjnzkhHsf
	ZWvK8wu7RgCzoLV3UbR1qN5LEA/Z6p7iOvzzqXoIfLW7LgFMXzyg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48epam2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 11:16:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RBGBH3005004;
	Wed, 27 Aug 2025 11:16:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8atmq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 11:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOnfQtj9LKPtQ9j2eBg+3Hvkq34evi+Pv0eOpLUu+6yxdBB2hKUTnjD5ozptZmEf8qUMM0XCmjs5kWEqcIJmThATjDPSOMqr/ntzhzmKuFRJDDrgOUyrThssO2w6U9WQ8NuNay/Xk/LySDBpxozvfXKWzjdInE/ia4SlZBjxCTG7TY9tAAjtAmWjySgQyzIekpii5CtJ8iSLGeXVLeofw0yJHPT/TJvaETaCph8K93CdRL5S6CK5VB9Iuo4s4nQCaDdavasE/VMKITwNyffcsdWZefGemDyNuA7lWFZ+Ti2bg2kDqXA20sXhSDSFWNcToAzwq5J5plZYKbDyqiQgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbW87RY+tCg3wKiT43fqBztb+LWw41rp582LIi2fcZM=;
 b=YrJWMi/crYaI5zwS7Qbidjx/+9w9dHCBmQnu6mo/BTGvv4yy5HebU7GvpYKJ724y2WUD2JllgCsWLiRBmcLThOZPrGyLSRXBUyJP+F3fC+oMPBAnPu/kfAR64YdZDX+A7GxHqBZYnNVsOuAv5p0v13FMVWd6ayERqMpIO2q8s1HTEbBf0f5PwNVIfvTVxlEoe0ShhzEzqOHYJ/QyhkIgpwA9928vnl3YNGxM6NvrBzcM9V5YnEQrfV9kW+YWc1o3CjLaTTXVySIRbt3m9hNLF8zxU2Ti77GGgwDT8+HNlR07w9epCXkeDfFwonuKjqHS+Id3A4irXkWWjMq+9suWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbW87RY+tCg3wKiT43fqBztb+LWw41rp582LIi2fcZM=;
 b=tbBRz2ItnRwnXS9lJGEmgwbJ2+X6sTN3HtIoWMzwvArAEb8nHrqcNK4lVwVRgXvRwA0Y8mfcJu0Qx31y11IMAHD2R1aCsfIHKmcjLUn4QRyWsSDATATypPpZsEfrVzvxJVpGKd4gejK5r4cII8yW2rhbzQNl5wHYW3JVio0wqzs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB7268.namprd10.prod.outlook.com (2603:10b6:930:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:16:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 11:16:46 +0000
Date: Wed, 27 Aug 2025 12:16:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/2] mm: document when rmap locks can be skipped when
 setting need_rmap_locks
Message-ID: <3460045b-6a33-49b4-84a1-e5603c1a2207@lucifer.local>
References: <20250826065848.346066-1-harry.yoo@oracle.com>
 <20250826065848.346066-2-harry.yoo@oracle.com>
 <6a8a32a5-95f0-4dc7-8a75-80cf639069ef@lucifer.local>
 <aK6rHBaQ-gpzgEVt@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK6rHBaQ-gpzgEVt@hyeyoo>
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: aa429931-13ab-4542-0512-08dde55b35f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9fHmvks2H5mKnp80uPFfoybciT9Q7tzeV3rl6w+3G4xIQ1Qayl9Hfp9NY2b?=
 =?us-ascii?Q?v/AMrySBolkxeoIMfdHta9Q/AQstj7MwwP4qu7P+h/J3pfU6IhGPMyyM0v5B?=
 =?us-ascii?Q?44e/is+JbmU5JRVedATa4mdav8kMpu1pB4ZiX1OX9GXoQsNIcRYT4wl/KiSF?=
 =?us-ascii?Q?3jHax76e/RaJBdTA9ovr8mtYMRkocsSrfgmc13UbYa1dSe+HY/qesW4rvXFi?=
 =?us-ascii?Q?88wzjLkmZSkvl+GoPOqiVK/Gg0VTw6xXlFv3iQi8lfuhmd7Tid7EBguvalP4?=
 =?us-ascii?Q?L3jbrCjJX4rgZzythD2lO3sQCROrSAyUFA94meN18mAFxs18iYNHep2OlB1S?=
 =?us-ascii?Q?FwZpHW61beMIKuY4cv5Zn63jwu1XE8U8bDpHJdeK4UavYDr/4iasOe/OSctG?=
 =?us-ascii?Q?KT3vVDNIAZKwXQrKjmeiZBX3Xf5XeEOo+4PGRsC4ed7qrXIF5hUu53474RtF?=
 =?us-ascii?Q?bvof6VDsfXFLl0IY90JL1cT3hOFrkOqs5TIdxgzO6qH7W0oEQ39Acwwsyl6R?=
 =?us-ascii?Q?tTDDQtECK4nQ1phfHSycGC8t/wcSacMTDh0PSY/Q6upPtQYzCZ9Dr1+OC6mP?=
 =?us-ascii?Q?DO3luURwTEbTNdchRcRd92O6ydHl33S+ctxSBKXriNqbaDAMuDn7YHUYN0Wi?=
 =?us-ascii?Q?HG7EzoNkki5pjb7xtZhd26dBXYGdRygs5SfUabXtSVq79c8Yt+J4MY9ztZvW?=
 =?us-ascii?Q?PhDS5ISZxBz241TwPVntomaWt0IjE+nS8lfjv4LPngYYnD1P8wfGLZvJOaqg?=
 =?us-ascii?Q?+0kCwr7BZoHktU/mvMhXh1cu2x+jTdQ32/CC2UPSwAB5B+vBOM0gqiGoEE9D?=
 =?us-ascii?Q?hXWOr+X09vKKLGx0S/7WkxUee0twvDLgwSwGKVYSCfu5HCw5xHVV3NH9O2oe?=
 =?us-ascii?Q?yRnaPkMQy8WnAS//FUnRLuZg3A0c6X3ynfI33JpmzPJlsmqC20owahYqaZrp?=
 =?us-ascii?Q?uiK0BvmM8Fm9qhxVTZRLk3u34XFbeMLxNj4PRElch7fJN7GRChowPmaL0UMT?=
 =?us-ascii?Q?RDfLtd92FOgeU8pnPRSnIR0pMJzmXox0eW2BjD+SJnnU+PWAORGJXgFARGe5?=
 =?us-ascii?Q?o9CMNRcE8HyrZsuYXh9pzuSp+S2PuI6lS7y6TZFBeIpOmV+6RcZkht5CpoOG?=
 =?us-ascii?Q?137oGDofRFb8rr6Io7wA+rW7TKBSSvlUQ0LpZrGToajK+DMLVqEuZEVL/Qgj?=
 =?us-ascii?Q?oLXcdUSb+esCF1ew6PBGYmMPGWNbQOFj+ayktZidTiOjA0lBA0sMTfrdXjhN?=
 =?us-ascii?Q?e14aj1sWUpyZKchheginrbVHkxzThJP00hiVwA0ou/lmamb2AJfTvu9EOcix?=
 =?us-ascii?Q?wwPIuY8DBb2bRB88cpu2el54DS+vqfB9FXgmfr0WtCYKAvrLbnOfT0lWLmQt?=
 =?us-ascii?Q?bhxLW6rJDcighlkQG0u7boDAU/kuio9djmmYHKMK+qZg+kzVPm/yCIj0DpEr?=
 =?us-ascii?Q?oKezjIOw1OQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UVqnCJva/1+S/0aFFafVbdlPIALXdYIC7f1APtUEqbI6lT4H99stxiGlr26K?=
 =?us-ascii?Q?q2UhOINAEqUhqzYv+BZ2S+wMmyi3G4QYhfyOQfDlRFCwa8RxqzHLr7G7tiMS?=
 =?us-ascii?Q?J39X5yMTUmlg0rEjGQeWxrbXUO0aEEY0cgJknQVvtZ3B5Fx8ctHN22mx4y/Y?=
 =?us-ascii?Q?HB2/HT2VUgTsVzFinVN7PkrOq7e3b2aRY2GXJPm9aK7E+qhEH7u0ZbMxOsO7?=
 =?us-ascii?Q?wmBNC5u9GG4M3FWixkeCYQZQFHqfWriTulW+lTba38Gw201es5s3ijg9y8zV?=
 =?us-ascii?Q?mCvAkdELZpqW7DymwzEpyPXtjLMEKryGBHKkB0ciTDZwAYKx2uAobJBUvmF8?=
 =?us-ascii?Q?or010ysp5940mKCchuq6YaYUFrYTNK32QvvRNEpIr7hTdiBUrAjK0bWZ+P86?=
 =?us-ascii?Q?ShdAJaL0ciflAb9ItODJLUGAE3LISMP5E4vwcVPO0IWC7aiQCuYmtj+TBVqh?=
 =?us-ascii?Q?SJKzgNR6Oy4dptj9fVwybcpShtrJtxjiIy2BcniCm6ll5Z+w2Zub75nDN5ca?=
 =?us-ascii?Q?dH4XupA/lFtGwQwScCkh77x1OFBSeGjeBE5iH3av/wUICzaq+Z1EWWIEIP0O?=
 =?us-ascii?Q?M5MHnOZBWCIRC9K7lhCkIHECKU6OJ6OuuITzACRnOvGWVjMGX9XVhSMeQX5e?=
 =?us-ascii?Q?p+4iVM1/z+u/z1/4gKMdGkQ/1t1f/DDKQvabDMuWgNENgPvDeqkLxvg2jizq?=
 =?us-ascii?Q?moeKAhpY2j4TEXxkQERT0P9EJoo5zrlf5yncoN1TQ/P2lJoEaRgWM81HgLmw?=
 =?us-ascii?Q?wOVuTnI7rIZNJWLR2mRi1phxMwQMnuuzLyOVF4Qgk2oC+14sCXgHgz84aofq?=
 =?us-ascii?Q?t0fCrEBTOfLxxjcDJLE7xxU2uo4MmQwKGx6ZW6f4WUuv63L1iKUkn1TB0Zju?=
 =?us-ascii?Q?tDHCl8CGNW6luQvYuYzfWhKv4fp9pppAj4SCT2+PVv4BVMlmkxzkD0he99ZD?=
 =?us-ascii?Q?MPIoo4K9h1uy1rQFl7vNuwBdCHImQm7H588v2tRdgJZRQtcLYi3D8T6y+QTK?=
 =?us-ascii?Q?p/pnkF/f0aGver0+utEeKeV9ipgh2s0h4nycQte7JOSZQa7h+kENrz5nFOey?=
 =?us-ascii?Q?MB1ggUw3GXNA4EkQPPXXS4CAsd7Orb9yUULt053YEMNcWOArtyd6LxlGJW9w?=
 =?us-ascii?Q?gQfy1DJmJxh8072WJBD4Ey3FOzh4PMYZQzpcTh/ryfZGwrD+uUMaghFZ6hDv?=
 =?us-ascii?Q?N5qPq+kFWWrQmg2d8NZHAhdOcQfgmB4q2D3/kHsZHUvlMmzAvMTJptVtc4me?=
 =?us-ascii?Q?zmQblRasY8FlEzz3DG2zYAkHX+2ZgRhNP1hRwgPPe6vDZI9KYyd6rwwhR+m7?=
 =?us-ascii?Q?jXMWpmrd1v4X7gUPNR0KUESeP8WH8CKSb6ilGZoYZ6UBYXgtJKwVUcVa0IGW?=
 =?us-ascii?Q?TQ0W7NLli5213U4ZFv+XwBWwHPvlj/pLfbpl8kDMFlmTxUB3AAYuL8RqG1lV?=
 =?us-ascii?Q?UEu/FFw9vTqTDX4SwINXi5/EXOCAfCJpiXScLxYNXMPkVIaO01Yj8hbwgzWK?=
 =?us-ascii?Q?5+j8Jhy8aYkBOTl6qQd/CfC/E/SCDDuVxnEAlw5hRTOO+wjXOxL6BFsXXdNS?=
 =?us-ascii?Q?jfyblvRRmYDXj6mFoRc8ILPofgi5eIPUMLOvcjb6PwiGNeSW95L0fFYKnfTe?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SjOSqF/qkO/zKs0mcr9Ay8Tb3Z71+BJSNTKYgJmH2oZghrQBdHkel086ajNkINlIbLdcWrnezGvF9VEGrqfBzAbOIEuDm2SwME8nCIca5zCQi93N5Q/u/FhLa4qScVqGCYWKn6m+dkeLiWDTfxJfxiL9xm+KWDSyaKIu6eAUKEYy6sjMMn2ixWbLOLzu4Py8aW+lDOcrYZX4T7cAxu7RkLzlo3E/Sz0e+mdv/AvmHFZs07LV0MoZ7zq5PcHe8bPCQNuqsTGC5M+Sg+WhdMfc5JGW/rXtU/gGi1tVV82YOZsa4PB4CdULPmTSSnBGhXpinKvH6tpUtftp+etT4AmIfWNfABAdscpjQwm3fooC3ZaGBZuAcb+1FKzlSRMQT1DeU6KB2wo3ezqqF/GxNXIdgQ+A1gmQkAh2cyiR/PFIPfthJ4WxZvZsjXPfDZS2eu7TBcHLrGO9517bSa8FS2J8ufi1WD3+mz9jep7pRsa8TpbznHQogst1+nSMhkmE9gRcP34hrI0HBHZ98ef6hMNmg4yklOXCvZLeFyHDaI/Pd8hS4RhePyJeKn6kAI6mJEFaj7c3GI+eftzz5YwHImTeF6OJ7w3wFLwLh2PLwxRt0to=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa429931-13ab-4542-0512-08dde55b35f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:16:46.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtBVcdOSPUZItdLJRkN/NMPSrau6fIqbtvA3w5Ev2oumjxT345/jOrG1XAbmXaceyNVb4osMOqjCeKdKvHF11kc0twlFdwiFrRfy/+4qeD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7268
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270095
X-Proofpoint-GUID: hf2Lou_H-a6RBEFUQg3tTg9dBY6cyYu8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX+Zv0BIP00pSE
 is9t6B3oVNbN1RZ1q9/mvn7u6s5v3oMQBXlzef7WeZbE2pYvVFCnhQHea/W0ArGt1yl8lWxT4Ez
 zPbVftrkwNly3BlLF6e8G4yzgufHKIzBp18764+cGGMUsZIstQu74G/fZDgIpHygAw6C0pInrOQ
 X41aWHG/5ZmlfNd16J9Jlo+yXWIX6S4WTe62XPfNqLuTeUFmt3HGBWTw9fKfULW6kL0sp/qM7x9
 zmn+GRfwbymmYrMOis3tOxYzm6895lVVbNWL8JeyUnVEUnVZqraUuo55I6RPgnHV+/KVtjwnl4S
 HiFNH9regfGy+RkUM/vqbh9Wz3/dIRH79yP3HUv97oMhOY3HD5Xp575D1RBXTdrCDA8i7UturL7
 k5GjE7gQ29xe7p8burXvWQ812f/ppA==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68aee925 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=k_dPQSbBRalo9G-zuGsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: hf2Lou_H-a6RBEFUQg3tTg9dBY6cyYu8

On Wed, Aug 27, 2025 at 03:52:12PM +0900, Harry Yoo wrote:
> On Tue, Aug 26, 2025 at 10:46:24AM +0100, Lorenzo Stoakes wrote:
> > On Tue, Aug 26, 2025 at 03:58:48PM +0900, Harry Yoo wrote:
> > > While move_ptes() explains when rmap locks can be skipped, when reading
> > > the code setting pmc.need_rmap_locks it is not immediately obvious when
> > > need_rmap_locks can be false. Add a brief explanation in copy_vma() and
> > > relocate_vma_down(), and add a pointer to the comment in move_ptes().
> > >
> > > Meanwhile, fix and improve the comment in move_ptes().
> > >
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >
> > This is great thanks! :)
>
> You're welcome!
>
> > > ---
> > >  mm/mremap.c   | 4 +++-
> > >  mm/vma.c      | 7 +++++++
> > >  mm/vma_exec.c | 5 +++++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > index e618a706aff5..86adb872bea0 100644
> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -218,8 +218,10 @@ static int move_ptes(struct pagetable_move_control *pmc,
> > >  	 * When need_rmap_locks is false, we use other ways to avoid
> > >  	 * such races:
> > >  	 *
> > > -	 * - During exec() shift_arg_pages(), we use a specially tagged vma
> > > +	 * - During exec() relocate_vma_down(), we use a specially tagged vma
> > >  	 *   which rmap call sites look for using vma_is_temporary_stack().
> > > +	 *   Folios mapped in the temporary stack vma cannot be migrated until
> > > +	 *   the relocation is complete.
> >
> > Can we actually move this comment over to move_page_tables()? As this is
> > relevant to the whole operation.
>
> Sounds good, will do.
>
> > Also could you put a comment referencing this
> > comment in copy_vma_and_data() as this is where we actually determine whether
> > this is the case or not in _most cases_.
> >
> > Let's just get all the 'need rmap locks' and 'corner cases where it's fine
> > anyway' in one place that is logical :)
>
> Will do.
>
> > Also could you put a comment in copy_vma() over in mm/vma.c saying 'see the
> > comment in mm/mremap.c' or even risk mentioning the function name (risky as code
> > changes but still :P) e.g. 'see comment in move_page_tables()' or something.
>
> Will take a risk and do "See the comment in move_page_tables()" :)
>
> > I'm confused by the 'folios mapped' and 'migrate' bits - and I think people will
> > be confused by that.
> >
> > I think better to say 'page tables for the temporary stack cannot be adjusted
> > until the relocation is complete'.
>
> But is that correct?
>
> Out of all rmap users, only try_to_migrate() cares about
> VM_STACK_INCOMPLETE_SETUP via invalid_migration_vma().

Right, I think you are being too succinct here then :) as observed in my reading
it this way, I think reasonably somebody might be confused by this also.

Let's make this whole comment clearer.

So what's going on here USUALLY for mremap (not the relocate_vma_down() case
which we will get on to) is really that (assuming new VMA case for now):

1. We create a new VMA at destination.
2. The rmap clones its mappings to the new VMA _as well as_ the old.

Therefore, an rmap traversal will encounter BOTH sets of page tables when
traversing from the folio up the rmap.

Note that the mentioned cloning happens in anon_vma_clone() for anon and/or
vma_link() -> vma_link_file() -> (under i mmap write lock obv.)
__vma_link_file().

The original VMA will only be detached after the operation is complete.

If we unmap say, and say the new VMA is before the old VMA, meaning we dont' get
saved by traversal order, then all that will happen is the try_to_unmap() will
not be able to unmap and the mapcount will stay >0 and all is fine.

All rmap operations are best effort.

The only cases in which we set rmap locks like this are:

- self-merge
- higher order page table moves (see should_take_rmap_locks())

So really all this should talk about the self-merge case, rather than broadly
'why we don't care'.

So the comment's already a mess as it is I think.

So we can self-merge if we mremap() to a place immediately adjacent to the
existing VMA.

In that case, we'll simply change the range of the VMA, without doing any
cloning etc, and move page tables 'internally' within the same VMA.

The rmap traversal order guarantees that racing rmap operations are fine when
you self-merge _after_ a VMA, because we're serialised by PTE PTL, and if you
'miss' an entry in the page tables, you'll 'catch' it again when you traverse
later in the range.

HOWEVER, things are a problem if you self-merge _before_ a VMA.

Examining the relevant bit in copy_vma():

An aside about vma pointer changing...:

		new_vma = vma_merge_new_range(&vmg);

		if (new_vma) {
	Merged---------^


	We have firstly to consider whether we get a merge that will change the
	actual VMA pointer - this can only be the case (+ in anon case) if:

	1. The old VMA is not faulted in yet (otherwise we'd need to keep the
	   same vma->vm_pgoff) meaning we can change this to make the merge even
	   possible.

	2. There was a VMA prior to the location in which we move that will be
	   expanded to fill the range.

	This means it ha to be _before_ the old VMA for this to happen, e.g.:

			if (unlikely(vma_start >= new_vma->vm_start &&
				     vma_start < new_vma->vm_end)) {

		new_vma will be the _merged_ VMA, with vma_start the _old_ VMA's
		start. So for this condition to be true we must have:

	 vs = vma_start (old VMA ->vm_start)
	 ve = old VMA ->vm_end

	 nvs = new_vma->vm_start = addr
	 nve = new_vma->vm_end

	mremap():

	                 vs        ve
		         |---------|
		         |         |
	                 |---------|

	      addr  addr + len
		|--------|
		|        |
	        |--------|

	Leads to merge:

	       nvs                nve
	                vs        ve
		|--------.---------|
		|        .         |
	        |--------.---------|

				*vmap = vma = new_vma;
	Therefore reset VMA--------------^


OK, but if we merge _at all_, we _also_ have to consider the 'before' case, and
pertinent to the rmap lock discussion, this is any case where we get a merge
where _what the rmap indexes on_ would be traversed in a way that could lead to
'seeing' the destination before the source when there is only a single VMA in
play.

Phew.

See how complicated this is? :)

So the pertinent code for this is:

	if (new_vma) {
		...
		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
	} ...

The 'before' is the ->vm_pgoff of the new and old VMA's.

Note that we've covered off the case of the VMA changing, so we don't get a UAF
above, and in that case vma == new_vma and thus vm_pgoff will match.

But if that occurred, for the merge to succeed, the vm_pgoff would _have_ to be
prior in the traversal order, so it's correct to then take rmap locks.

Otherwise, in other merge cases, where there is no 3-way merge with a prior VMA
causing the VMA pointer to change, we simple take rmap locks in the case where
the traversal order would not save us.

So yeah given all the above, I do not think the existing comment is very
helpful.

It's _only_ in this case where we need to care.

So I thinkt he conflated thing here is this edge case of the damn horrible
initial stack relocation.

It's the _only place_ where we invoke move_page_tables() outside of mremap.

And of course we don't take any rmap locks, so in comes the explanation about
why that's ok.

We obviously also _don't apply the copy_vma()_ logic there.

We are vma_expand()'ing so it's a single VMA, which is problematic.

Therefore we are handling this with the vma_is_temporary_stack() check.

I think try_to_unmap() is ok to race, as if you race and don't find the page
table entries, you won't get to the folio + thus won't get to update the
mapcount so it's fine.

I think migration is very much NOT fine, because suddenly you have migration
entries that might get left behind as per a8bef8ff6ea1.

OK phew.

I am going to leave it to you to find a way to write the above up :)

Also please reflect, as far as is sensible, in the docs.


A sort of vague beginning might be something like:

	 * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
	 * locks to ensure that rmap will always observe either the old or the
	 * new ptes. This is the easiest way to avoid races with
	 * truncate_pagecache(), page migration, etc...

->

	When dealing with racing rmap operations, we must be careful, as the
	purpose of an rmap walk operation is to traverse from a folio to linked
	VMAs, and then typically back down again through the page tables
	mapping them.

	Since we are manipulating page tables here, we may interfere with an
	rmap operation if we are not careful about locking.

	The only case where this is meaningful is a self-merge... blah

etc. etc. etc. :)



>
> I'm not sure what prevents from try_to_unmap() from unmapping it while
> it's relocated?

See above.

>
> Looks like it's always been like this since a8bef8ff6ea1 ("mm: migration:
> avoid race between shift_arg_pages() and rmap_walk() during migration by
> not migrating temporary stacks")
>
> > >  	 *
> > >  	 * - During mremap(), new_vma is often known to be placed after vma
> > >  	 *   in rmap traversal order. This ensures rmap will always observe
> >
> > This whole bit after could really do with some ASCII diagrams btw :)) ;) but you
> > know maybe out of scope here.
> >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 3b12c7579831..3da49f79e9ba 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -1842,6 +1842,11 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> > >  	vmg.next = vma_iter_next_rewind(&vmi, NULL);
> > >  	new_vma = vma_merge_new_range(&vmg);
> > >
> > > +	/*
> > > +	 * rmap locks can be skipped as long as new_vma is traversed
> > > +	 * after vma during rmap walk (new_vma->vm_pgoff >= vma->vm_pgoff).
> > > +	 * See the comment in move_ptes().
> > > +	 */
> >
> > Obv. would prefer this to say 'move_page_tables()' as mentioned above :P
>
> Will do.
>
> > >  	if (new_vma) {
> > >  		/*
> > >  		 * Source vma may have been merged into new_vma
> > > @@ -1879,6 +1884,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> > >  			new_vma->vm_ops->open(new_vma);
> > >  		if (vma_link(mm, new_vma))
> > >  			goto out_vma_link;
> > > +
> > > +		/* new_vma->pg_off is always >= vma->pg_off if not merged */
> >
> > Err, new_vma is NULL? :) I'm not sure this comment is too useful.
>
> Sometimes the line between "worth commenting" and "too much comment" is
> vague to me :) I'll remove it. Thanks.

It's fine :) instinct to comment more is nice :)

>
> > >  		*need_rmap_locks = false;
> > >  	}
> > >  	return new_vma;
> > > diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> > > index 922ee51747a6..a895dd39ac46 100644
> > > --- a/mm/vma_exec.c
> > > +++ b/mm/vma_exec.c
> > > @@ -63,6 +63,11 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
> > >  	 * process cleanup to remove whatever mess we made.
> > >  	 */
> > >  	pmc.for_stack = true;
> > > +	/*
> > > +	 * pmc.need_rmap_locks is false since rmap locks can be safely skipped
> > > +	 * because migration is disabled for this vma during relocation.
> > > +	 * See the comment in move_ptes().
> > > +	 */
> >
> > Let's reword this also, people will get confused about migration here.
> >
> > 'pmc.need_rmap_locks is false since rmap explicitly checks for
> > vma_is_temporary_stack() and thus extra care does not need to be taken here
> > during stack relocation. See the comment in move_page_tables().'
>
> This looks good! except for one thing, not all rmap users check for
> vma_is_temporary_stack().

Yup see above!

>
> > >  	if (length != move_page_tables(&pmc))
> > >  		return -ENOMEM;
> > >
> > > --
> > > 2.43.0
> > >
> >
> > Cheers, Lorenzo
>
> --
> Cheers,
> Harry / Hyeonggon

Cheers, Lorenzo

