Return-Path: <linux-kernel+bounces-728031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A216B022C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF86A453FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7312F0059;
	Fri, 11 Jul 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o6zn3sz8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LZJxmQBP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB292F0E59
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255609; cv=fail; b=SHnuWO0eBWlTK5omoBaT8msfQvaKZdu0QXu9fo5nXYCergZZGkNEvYEALFX/4TARw+A9qqVQAOzwS7+2JvaNKxxkfcbuviyS7j+qEwXQszIJ1XuQZVNhXaJeXHhBKfyOGxiEE/QizURCNcPSJcU7xp/hF3cJI3/NiXX/7VCuSM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255609; c=relaxed/simple;
	bh=B1y27xZJuFgHr5MI1VR8gPHs2hVgg+SRYn0iUl6xqe8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=QDDfddQf4xhAlqouCAoWoe/7sNQGTCcCQTpU9iT3MlmW+lrkuWfdBr47yvbQwPxMM5rgEUvAP0hcM+qkb3iCqnoVNtCLTlAP394zbCUWc+LVy5v2qlKYsVT/i+26czFTMJyKAxLXxAG+ImmlcJ6BPAwO+nNfqEBSRW8JMW95vtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o6zn3sz8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LZJxmQBP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHYvef006597;
	Fri, 11 Jul 2025 17:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=B1y27xZJuFgHr5MI1V
	R8gPHs2hVgg+SRYn0iUl6xqe8=; b=o6zn3sz8dQbSUjsOHgTwjviiN6XKbHr3W0
	li8mzu+2IjCXAuJAq5U4+zCTbr6Gkz4rQ7ZUvyfrZB0KpntnjKjHNhs1wDgslDQI
	N2WBzaJaDWdzp5rSJKPEsPKym4iF6EgD7+hphgsMYgbpk2RmNZxRQffSYvjm8+vN
	rWkF7G0C5nzEqoconZBCltGh+8hfe2ROOyYH4gOm44BmaLQpZCrTmLH6QkA1Q1/Y
	tb7gTgfEt8WMJzllsuG9oqMckf4UVpiSN28IYCAJLjYVZ2Zm6JZAyehUXewqg7Be
	rRpfP22OqUUrMgtekwi1lpQX3OMwIi8vw1O4QkG9gkeoRUqBRoIg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u6edg342-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:39:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGFeHp024391;
	Fri, 11 Jul 2025 17:39:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptge3624-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4aESgYkLbjuC7VbZr7OIWgCNqRaCRyFJNVaVmlF36aSwE9KUA+2nU1COCEuuV4VPzrMDooGTX+5ZZlKPPahhfw7e8YJ/RempDyRsV3xG4AF9JPser3EoDUnuImBDL8WrHiTXtsUuX1HF6tLuspCt4nIPVyqIpXX3te6TuKY+v0dT+dHg2TQWJ1fxY38lqqq6bYKWBYLp9Asenyfw4VbZrJcN9z8a6Vb6Duy361mPH/gwaJr5qDWb7JysS3kIlMKM1iUhA+9rMh4ZYO+vepne8U6QzponIqhMpGcprioUhaFgMz2mZGqXqqflL2KkPtla0DfBC9n8QCmY/NVC1mPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1y27xZJuFgHr5MI1VR8gPHs2hVgg+SRYn0iUl6xqe8=;
 b=dVGTv5hh4CVPIEKgSShwAj2OLYS2IT1qjjVPsIs58W0BJFsXHnC47DV48Mn6qtenFq2Cjz3MeWAsf8Y2OUMBcryxJJj9+iMHXCi3ZTA1QO3/iR05Uhw5oTzLj83ZaKijO9eN0On+OIKqe5uNJatgPfI8tlGXsO8vCUscCOLmaQCF0prJtuTXuKCfQeYbTqVdd8X4tyoyiT+Z2yMC9AfWOD1jfNTOCG5/aLRHwSTGLTokhg3X67f0UtDZs+XzDOhVgp5U4yuW2estrn2PwrTatr7XimVG1mTn47liGJJoq3XVN16cCRAmxrDi/aMZqC3tVda9pwaPy/D55nDSe+R1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1y27xZJuFgHr5MI1VR8gPHs2hVgg+SRYn0iUl6xqe8=;
 b=LZJxmQBPMwtDMGiw/xxsyXWr+GabJWbtW4bLMPqSgyEP/EL4errdh7eB8v0xKc4jfJC7xhPb5OP6u6RVBzUztdZO+6dPQ22eYT6IvCfPYqUyg+W6QijavFIeRp445yEom9zbIVOX23qIwHxLdEgLtmfhJYKg8UgBYkQpKXVHh1A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 17:39:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 17:39:41 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-14-ankur.a.arora@oracle.com>
 <4fa268f0-d56d-4b6c-aced-06e7002efd28@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 13/14] mm: memory: support clearing page-extents
In-reply-to: <4fa268f0-d56d-4b6c-aced-06e7002efd28@redhat.com>
Date: Fri, 11 Jul 2025 10:39:39 -0700
Message-ID: <87bjpqocdg.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:303:b5::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: ebda52c4-4e6b-45f9-f9ac-08ddc0a1ea5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cnh5OtjgYGIk0PwAT34Si32K0G0VXY6slHoEXIM+tvyFmC/1O1+aSUqeC6RA?=
 =?us-ascii?Q?7nJdYFRhKhMNjBcq7weH2Qo2kXapRbz1A9p/ELKwrjzfgdxga3Y7J2GxWs4s?=
 =?us-ascii?Q?GP8MUOcIdhcvBhxrIgfmUC1quXdlxlJ0zV9TaKnfXqQq/6gBCUPyDxnmEpFn?=
 =?us-ascii?Q?MCUPpbArpf6ZMFtVJPKGDth5NcHboyBteY6pYWdGjcBJhSqLyov2JVvH1Bmu?=
 =?us-ascii?Q?8+SjBaDaUg5cIzVY0GQZPb0W1iU6MQK1Z1N9PO/Oe/MM42iyTFncX3g6ohki?=
 =?us-ascii?Q?+fph7tYTWtxkZogfMaXuwlvYv79CE1ri5C4HIo+Luif7bskCrD4Ct9VLCfb1?=
 =?us-ascii?Q?o8tZ3sG7I87mGbCm6blTYkCLO6utzmZNSVBwC/BtGUOjrYYe7/AScqIvSRto?=
 =?us-ascii?Q?exRl0UPk4ytYFNfWNGS001jYru5H0n0ax6EH1aGKW3wzbs0Wgs9MJfieDbeo?=
 =?us-ascii?Q?Szscc4zdqDk06mxGEK3TxwA53Pp72UHgsbYyVQFdJOJmYADR5ECPdjHIAcAQ?=
 =?us-ascii?Q?Hr10uxpQfASy8rt25kEPkOjegBZAdgS9Uhox3BC23Nl/HnqrX7j/ME+abWd2?=
 =?us-ascii?Q?ybXM3TLjya4mTxs7VxKpkLNrv8gocMI6wcXIBBLNk0iNkrVpCpgVMlrFkz+i?=
 =?us-ascii?Q?JUFUu+M/DRIXwdEOwymZipZVDtYqdPpOWxeBKYO6VGBLEOQdDH3mvRCXE27m?=
 =?us-ascii?Q?ix3+E7OjRxTT58ybtmp+QYdZTBX6Z52UjAM8TMC1GKsSyXTYvIRGoL7OUfc5?=
 =?us-ascii?Q?SOEwmTOBevFA1NHpRkBJd/tca2WmBQRM+F4KdyoDZZ4tGk5EfYzOZdRWlsIf?=
 =?us-ascii?Q?ycppRkg9j/Zj5ZfEd5IU+TDW+RJOmTGN6q11fNLqt/rx9DG2TMu41jHWPAem?=
 =?us-ascii?Q?EXKkIkFmE4+GYxkRiRhvgyLJPyjR2CjBjcr8nH/XKQTOgLNkhBz71lAhhvRB?=
 =?us-ascii?Q?z2tvbAU+kYFvLhKwQ4eiZGJ85GVU+YxQ6OI1jhdSxsjf6xhq6NCzDWJaa1SN?=
 =?us-ascii?Q?faZLhNJb8IXncrkBt+y3A8StwImf+BEYsT2aVJH+gKpkqqLOLK9NKt4O5EPs?=
 =?us-ascii?Q?Y0AiX1h9T82aJVT8XkKttWdt5g6JqTflqQE7J2Ui3ab9FhqG4mSeywwc9nWH?=
 =?us-ascii?Q?BrdugZgYdZu2DV5902sOh96L3yEDwT0NVg1V5NMmfggyeDNp6aDgXBPCjNoW?=
 =?us-ascii?Q?L5czD1B0GXREuuUXzgFyEz3oOYlJ+bTDay3mz6K9uwU3AcaJ4zT1D+HCwm4/?=
 =?us-ascii?Q?YXOH7vp8oT7fONGZrmc5ou6uj0DxwPBSVtyJFBqROejhhV5WV866hY/wYQdd?=
 =?us-ascii?Q?zKDohKINpTQBoYwsXzFR8GlXH7qGiruNV+KFMQXXbMNOVAtrcN4YHdff0kcj?=
 =?us-ascii?Q?Gtn2PwYCheQqjcOVmegANjk0/KVzSe30OAukNlfjjnenz7BTflb24oZYRtiv?=
 =?us-ascii?Q?v8DLfekH7o0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYtiOjKVME+QjMnEo+BMaLuKf9wtPkZfqXcICLt20DZyF6oI/IKJxdEul//T?=
 =?us-ascii?Q?FwW7N5+dYexejZy9ckSw4VZUdFuWMa3dTXLvhX0HfRGSRxUkIo4We+whcTN+?=
 =?us-ascii?Q?rG0Ei7qvcGIbZgSTmx4Oh2le75b40zLeBMH+E+HAL2o7CTNXSqwx8k+bCpXC?=
 =?us-ascii?Q?Nxw59oc00QblXpg7F+c8PmO53S5K3rQzV/UAkP6XnPlHAp25gC+l4bZd9juo?=
 =?us-ascii?Q?qpNrsmIgLASKAR3dqQGPAUux9JH9mWZBw3MnSV6J7r/+HzgVfkYiy9jNEecv?=
 =?us-ascii?Q?rQPTU8KwrF6FbduKVnWCkx/wtrJAmAwpj0u64+m8B/bQoR6VpQVXrtiJhXQy?=
 =?us-ascii?Q?N6pA8EaHG1jAwAN3K3pdoGQPNTH2gtBwQhMocZN/txHxPuqBtIO9WRhgj2Pv?=
 =?us-ascii?Q?OABhks7xGw4I9PK6/vyJKG5IxdKXe1x8r1uFEdfTKRHDCJAxvcy1iesMyoRX?=
 =?us-ascii?Q?uUeEmuhaKl1sf32i5xEpi7ILGl6uvXpIffcVIF7CVRSKl5JgVxxwJWuP5t1R?=
 =?us-ascii?Q?aj4+VBiJH+4yF4Wq/kPPIg0jhMG93B+RAKK5gtr1isBvVDZabnvwJRKvqmjU?=
 =?us-ascii?Q?KyRefkEThEIDl4SInrj+xUX3CewKdVIiR8bE0ut2TdZu2c9opCmp/ecmFvlm?=
 =?us-ascii?Q?du1Acg9qROrYD6VLPj6SYoH4Q0KjOc4Dv7XnpdzbWLvbC1MaIGnL0wVGcCRa?=
 =?us-ascii?Q?kR5jJeJb+Fklz5AS0yH/E/0+dmd1xN/MhN/nsO/CfXWFBMZlYpVhOJjGr45x?=
 =?us-ascii?Q?xiRof+ayd+4dd7IQSLj4+317MDXCgTgsXNmHInk5isVQbO1dSOIBO2NgV56z?=
 =?us-ascii?Q?m5h2cHXr8wAgBoMtPMmTT7pFjXUTIlQUg9+/scPQi0Sy2cWXAJxkftbUf6v5?=
 =?us-ascii?Q?ziM+p1w/80h2DKrO5U0z2TITSDsARTGGp6icC8vZfAoGDvHIQf/5D65VIPBi?=
 =?us-ascii?Q?5R10ZfyEkkduKOiAtFKCeIaTlYpaO+dmOy5bJX5Wo6nf/P565QHMHlBnOfjV?=
 =?us-ascii?Q?COg14eISK7afHSESACP6+mO613NCQcBv+fXhZt0J9b4tVOGtJTkFncxnViAu?=
 =?us-ascii?Q?cPVd1g+4aQc1Akk/vlz+LogV5Tsnt5EhdhXW+RrjoaE9o0K3qUvIPYb0kSgh?=
 =?us-ascii?Q?RgECjZ6+Mp2XgcoHsycIYE4YUdGCFPSEZrEV0V16oIoMpTeWu9H5CRJqf1G+?=
 =?us-ascii?Q?NijMZBXNo6lwuFv5z4PC9+z+2qX9ZGeS6k6JXovMCO3NAh6QQFbMPNBP3q/x?=
 =?us-ascii?Q?0gyRvshjZ6L4FwFijy/HlNsIutzSZceEMvsDVYfG5qsTthRyDaggPfEej03s?=
 =?us-ascii?Q?QP17wRzKlAMwaoH6PrmPrmsTMUS1YJ124ut777cspvNU+DqhfBJ6pNq9HQG0?=
 =?us-ascii?Q?65Q2IG8ZZjWzgaIwt/aj6AVTiKuFavBa2k7yrfEVJiW2tAkIM7l7oGkPa4Vz?=
 =?us-ascii?Q?FK+vjSDrnJixtiQ7NbLPTlpFRsEebyArY/WQqQPeqPtHhEunP/Y6WJ6dwe14?=
 =?us-ascii?Q?IixTWL5WnAdR1oG5DGAEPoQy10nfMz9VheXTazOwIkt8viHag2VhYRR2LDed?=
 =?us-ascii?Q?Kt40iKL3ibPu7nKTXE9fNb5NJ1z4SqSyaiDkZG3Jem3VQQ3lRbqfCuKo3cWr?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DjGiwy41aLx3FuhyGt6I528viUG6KYe5DVM5Gt0qbsJ/f7FDoGdanvpr34aV+Db069zc/d0t0E74spmgU1YsMlu27Ju/VntvF6bmlUw7re0qtdtdtrVc/K1bV2txAOIgBThQRhhyX9m1bS4uOspD3QKGHKz3da88uzTSd94s/aOU1LCceh5Q/Ab84a7zeznTXIaWUUbN08kAPINtFALg+6ecRAVIrIFMTu8802ocNDz9T6+15FX/XsMmxGGY3wgX+IGzBb7sL9IG1VUaKGu06NaA/TOvfvJjuDRnjFVR1rOFgtV0DenLJ0DKuGOZkSisQd0VR6bBJz7eKa3JYt9Q78uDiL+2ckQsf7MiMSm0YBz8OxVNARJr39RaL9b3EzYRYRwrmub3oQO+5f71EcIW2ev23ft288lfW5NDBALQy7Yvy64fa2SlWF+HWjMrx+i/x/YrJWUMFMDUS0FnJOMPvO7ktQ29ZN6EvZ449nriWIj7P5C9hL+97diZOF/Wwl/PZSGTTdFQbK5IHOM9dSpk5VvhwrOjR+YtYFgzaYBppR5gNE7EOgz6QPrVjvopwkuWvT01lJ9b/G/8Np4mQ3Xpm8KG0PG6BsVyHIRLlvKdwiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebda52c4-4e6b-45f9-f9ac-08ddc0a1ea5a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:39:41.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nTedB9ClgkzYqMjUOD3Y0XMFyPPJxHgk5EWKgqUDxlGh4mr9+H7UXade3zO7gdlLH+wiLIZK/Gh7R2i4zn1vycW1hL1+3GWu8K+Y+Dc+Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110130
X-Authority-Analysis: v=2.4 cv=RNezH5i+ c=1 sm=1 tr=0 ts=68714c61 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=-neEspRJciLK-S42Fh8A:9
X-Proofpoint-GUID: tm0BqLViHbWqSVWtu2ETE4iXi-x47TCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyOSBTYWx0ZWRfX7b1xy8voSO85 gwTQsMlV5+/8tyLjZrpZ/Jn8zJwlCsBlcWNJfeyvmt9Oy9LKQScSyWHrWhBKxkE8dz8uFMJrSdI zyj3mZo7wdZYR+qZ0Tn3ppaDHV9Fw2u8z/kHRMlxRtmK62x7edKPIJf8rjw6ErwEZ2FRz1TOeFF
 Ti/dTloduGBHHrcVFEb2kK5LSssOHBPuipHjGVM0Uo1Nsd3fNyxZgcnCle/ggf4Er5oTeFJIKVm KCgwMSaxo4bNONnetrRkhTxlkwlDT6nigDZ73oKKHuzFVtWcMy4PrkILB08hqaWjanXBtTjnAVJ 6J1cLaN9Dn2iqqNYcCBdNZpG/DLDJSvCty9xCStIUu3n0TZVJi8i2pmdAjiWoojRone1nFNO/f/
 MLNjF7ipfO1EpTqr98X11WKKvCL7EhVWzNKKk6qjhX0Po/aH36Fkbc2r51wRyTI3AThEA8GD
X-Proofpoint-ORIG-GUID: tm0BqLViHbWqSVWtu2ETE4iXi-x47TCG


David Hildenbrand <david@redhat.com> writes:

> On 10.07.25 02:59, Ankur Arora wrote:
>> folio_zero_user() is constrained to clear in a page-at-a-time
>> fashion because it supports CONFIG_HIGHMEM which means that kernel
>> mappings for pages in a folio are not guaranteed to be contiguous.
>> We don't have this problem when running under configurations with
>> CONFIG_CLEAR_PAGE_EXTENT (implies !CONFIG_HIGHMEM), so zero in
>> longer page-extents.
>> This is expected to be faster because the processor can now optimize
>> the clearing based on the knowledge of the extent.
>>
>
> I'm curious: how did we end up "page extent" terminology? :)

After trying all the others! I tried multi-page and contig_clear_pages
and finally decided to go with page-extent since clear_pages()
essentially takes a page-extent as an argument.

> "CONFIG_CLEAR_CONTIG_PAGES" or sth. like that would be a bit clearer (pun
> intended), at least to me.

Oddly enough I tried CONFIG_CONTIG_CLEAR_PAGES and
CONFIG_CLEAR_PAGES_CONTIG but those read a little awkwardly.

CONFIG_CLEAR_CONTIG_PAGES reads better. Should have tried moving the
CONTIG to the middle as well :D.

> We use "CONTIG" pages already in different MM context.
>
> "page extent" reminds of "page_ext", which is "page extension" ...

Yeah I see that in the Kconfig now. Will switch to this one.

Thanks

--
ankur

