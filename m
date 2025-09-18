Return-Path: <linux-kernel+bounces-749401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8611FB14DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5EF189B67F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3391291C03;
	Tue, 29 Jul 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BtXy7kI5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NGlIqZwZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002F1EA91
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792933; cv=fail; b=R0H+dYum+XJ5nvT1pmqwE3RxVlwE1l5CHARayDbpxhIErsXF+ySGWfApSjxvz91KNUnEvF0bQLvoiRr2439cETb4hjK9T6CU3oiardf0QUrqBjo2eSQYPgoYvBZuXc6a+PyIUmg3OE2nyGJACvCuO0NgoxnttqMdrHbIRHETQUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792933; c=relaxed/simple;
	bh=KOzemgWWvmhshrzpN6wpu9R+Pv4tk44YIEkPYmuNF6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgNDNEz238Vt6+4j78esYlr8n0Jnn1QOryUkyKESImgMvaIBRAsrFBmJW8Gfx4HBmzp4CvAfAmDGifOuZnfvuiIWc913GIWwZSPLzALluWhmrMku+AjR0GwiB1H/a95DD5IYPxesQKPqZkaY60O+OU2bYs1Adqz7RN4ymhxkNHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BtXy7kI5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NGlIqZwZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g2Qr020968;
	Tue, 29 Jul 2025 12:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KOzemgWWvmhshrzpN6
	wpu9R+Pv4tk44YIEkPYmuNF6s=; b=BtXy7kI50+LZnm652O4TIrEQNM5UYdEyzW
	a0dE1aQPcvZ0o/2+hVlFc3aPXVHQ8wOOuouFjEPW0XdFLH3yDXMVIdhVM66eGc1T
	nojPRqybffVHeqe4qHo8C1uWlUlYThuEsllXmGQfOw72EILLwKVTfj1lCaiNzaNb
	0+sq2KNIwF7kMsjLR2taJu5GgXZdSYuxiiLGMla0LgocL0ILjh5ByoBVvfBIRcM/
	6I4TP8yDVzGY3imxBHWeo+Q4hE64gxsauIgktt73b6U78+cN0nFg4lYIHKuq4BZ0
	FtlVG/FMicFvOqryRFfl1YlNeVd+D0p2g5gtVE5CvC7ivtH6Vn7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e7npp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:41:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TAjH2e003121;
	Tue, 29 Jul 2025 12:41:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9vfcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3pNtE8RPwRtvCwXGgUe7R/FKLbKKrMMbD5GsXbNLnG8+Y1QEHP0MggKCUVI9rAzn/rx4VcwLQztpx43C2Siy4h4QiV5u3zi1LkdDFY8yBN80zSY3OLS6A13eGNMWo7dYFs9PycDL1u9Y6AUfI+ceVzPzdewQedfRxkWoUOx4J4FlRvHvnTmXWrDnhFGnKq1gujb4uo1CEabvsNSjlXFL0x3GAhxlZZExY6Hy7DceaHQTNop/rt5vnZ7vaIDkUrCGwknrD2RiiH5vUMste4fRUFDwciLppWDJWNi/5a1IGAaYBKA1olf6cZlT8w5VXxtHPwBq+ZPddeUsWUm+iUE6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOzemgWWvmhshrzpN6wpu9R+Pv4tk44YIEkPYmuNF6s=;
 b=EMM7vvR0cVrFXLM8O85F6vboh7V0ly1Pk5CZg15lM8uBZrUssaeKA+J0PNUmmL+ahQWhAzASv31fMZWDmgkBuPEeyhF7Hjhp+7tElAcW/IY/r688ImuGxuJPy18Ga2In9Z1zKt2NRIosGKsXvOZKsx/bkXteO6+9Cm4PEzau8Zfx2XkYm88SiS9U/NcRy6QUmWkS+zBsF5siXhG7yTv4KR7iwfDuQAp2QCvbDrIqGiRXJ2ZlwmupEDSilA8QKsSxsaEKRgBvEFl4e98V+1VOhXRG200Ni8B4SUqD1VfB4SJ0ukibkVptD3fZp+U43mu3Iz1IMwrV6fqPEfpLLzY6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOzemgWWvmhshrzpN6wpu9R+Pv4tk44YIEkPYmuNF6s=;
 b=NGlIqZwZsbQWorX5NXwh2JXQpQEZM/sDT/wKzg5tLwr1395W8htmin4qpEGvVZyqS98LQlxy6TrPvto7Z9dPM1xJ+4Gjlq/4xKlXUm4tr+8O7afEEaYA2eqtoUF6zbtjsV3WG7iUFBYsIM3ZaK6vG41/rK/MrOLgnLa30CwDGmU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6018.namprd10.prod.outlook.com (2603:10b6:208:3b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 12:41:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:41:49 +0000
Date: Tue, 29 Jul 2025 13:41:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm: correct type for vmalloc vm_flags fields
Message-ID: <fca36160-d0f6-4ba9-afcf-609719b63c5a@lucifer.local>
References: <20250729114906.55347-1-lorenzo.stoakes@oracle.com>
 <5sm4k5dms2ryfxzj4v5jfzfthlzwrsournupl6kakipiuyty7m@to7gbjenmfyj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5sm4k5dms2ryfxzj4v5jfzfthlzwrsournupl6kakipiuyty7m@to7gbjenmfyj>
X-ClientProxiedBy: MM0P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 68752843-5d80-4af2-3126-08ddce9d4943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLQAnBi8Y4aiCD8ejyCxDiygHqTNQuxTiui8x/A4KQvaCsQzrPr1Kn1M2sl4?=
 =?us-ascii?Q?VRPUUI1EWnq0e1VGgmXW1yo8/Ne+HVi/au8GfO4tkTsBY95Hlr4uNkUPrYcX?=
 =?us-ascii?Q?uu3nbmCl9XwXjvi1vpcJuZ/mHUzaecFzBSpHyy18DuDKrWAGLFL/nqZRixF4?=
 =?us-ascii?Q?10v/ksOcfTGqs0/6iPMQFdhSPg7p1r+f/qX5dzGp8hAwusguvUK1doYRshFX?=
 =?us-ascii?Q?ibxQ4XdOfs159UxXldY1Nbqgv0G84WfoL18w221SZRYpYhTsKdEYpPYVHx+L?=
 =?us-ascii?Q?vnT5+bfrDE5QiAzpsTAd99X7ND9ENw6LHYP7EWFTCWCxMHjW+KtXewrCNEnC?=
 =?us-ascii?Q?GW63LZSlUqH9DDzsxw7QiMHihoyKMDQSKm9NwLzV7LaIlqhUdFhYu8q83Hra?=
 =?us-ascii?Q?K/3TgaA5p3A+97an+bxMGifGPpzOWDl49vuPQUYvLB0NLfywSD+iGgMiVINA?=
 =?us-ascii?Q?V7fDY00Sgb3zF+vI8GOiuFI/hMGbewnxq+vLD/jKVfWntX4Q5tObnrfKi2DH?=
 =?us-ascii?Q?vCBhfY/NfQszlijOBXqSRFRIolw9cn41GJTz7GVduwewJ7uyE9CFbB+re7Ez?=
 =?us-ascii?Q?7pm+UDKHotOpENUbKjbT+zVmK1sGu9HWTLWBLIx7OIm4oDa6ha/qnMCd2HHZ?=
 =?us-ascii?Q?2ZqwcEl3p4v5Z5rEtjZhse8Ild2hO1sd0oI3+TbyEGtqh5lTA3T7Ezs26krf?=
 =?us-ascii?Q?svzRTr+ZwClmlTGbv8RnNZPQFlosPfPIc9zA6E2qlJ+jCBGxVFn8g1EiWd/A?=
 =?us-ascii?Q?vqC4TIiAGouTiPvIPp4rpromW+X2Tmnqv9DNIqNPCyTYy9TBZ+iGwFaCspsw?=
 =?us-ascii?Q?oc4AOauZk2svqaCv6qiudP7FheM6w26a9V/t9aIfdi4Tg5aGfY8QyfKSynDz?=
 =?us-ascii?Q?wo0H9vKmm/4H+aEmpZ7HbzFTTmMhPgetPDK0b5gfPy2sKbWGhX9rO/cpQgQz?=
 =?us-ascii?Q?N5nb589lIj1fRn86Y8Vs1Q1Y9AAmT0c+rtbCf1UMTaeakGovv2Qip8E9bFm+?=
 =?us-ascii?Q?+gX5pGEuQIP83rOEKt6ttPnWuZRIYLJgjIxtjY+Vfc5gKTnotTiz4EWvrTf0?=
 =?us-ascii?Q?mgNtbtALo9au19lHwgcebrn/3KyAVnfHaqwfKym1YxwNg8tl9vEeNVXUlEMM?=
 =?us-ascii?Q?Gs3erJdiscnOS7KfEN3bBorBPW+GrRoWXZVxWkqWdoUVvIe/QxJlqP2btMcK?=
 =?us-ascii?Q?/60dIfnJNhKyT+FW0y57dpqC0NhWwVOi07ng6Elsyo4AhSMgLpmwqXBC/sYd?=
 =?us-ascii?Q?GH94tz9GfPNV0Gp1/E4FkGzZAfGeLPaHlDme14aNIfC7EybX+3Qz4yS/XA0R?=
 =?us-ascii?Q?38Th9mx4IiAklKmT5ScXuCI5YchBoFHyFGTLt7XrNlmrlYMiJ7Sn7c/EhfKc?=
 =?us-ascii?Q?ynkCbQjdLixdD9ZwlS4N/vo2HB1id1l5noNaP3RBQdtf8EEXHjp27+sAWfC1?=
 =?us-ascii?Q?/bv/TIWXLCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sBDOSlSGOXJtqXYBXOc5PrAmXKIRbm7S3eRgJrQ00cLexfD3e4eIlIbDIRdX?=
 =?us-ascii?Q?N5ULeRekXo1cAOGnc5/a2QiyHcSwlxz7k9sBa+8rwDeTt+yqF+tjSYB/codt?=
 =?us-ascii?Q?yLRkmYeUdFOZbMpOWqPAAvasUFiImynLMooFR22iQqsUO/p6dyKKXsaC1H3O?=
 =?us-ascii?Q?GJfIAwDhUU28VzKPA8s9YGWLbhZULRjjNKeRVjtZXi7S8gmt6Yr4CJxck2o2?=
 =?us-ascii?Q?fk0X6kLRYqn1eJTOrWL89EJZ1V1NkAkNo4CI+LJ1Cp2wgEwuOfM2v8tJEujO?=
 =?us-ascii?Q?QcknXSKLMhtsHqpcyXdUS0kJIo+uZn92i9ut9/qLtX0yTFsXPGx87CtsktUg?=
 =?us-ascii?Q?N1WhDG1nAxVKzwoklwOqEBO8z5gkfyBOt85riCM4a1Z8NFeCeks0pjLoezXd?=
 =?us-ascii?Q?eqfmTQDk0LsTZXYHZEFK8sNm9LYBwb1c0nFwBLE3L/7s/cvEapt93vkqz9U0?=
 =?us-ascii?Q?5csptG1wBrHFCrMKUIDztDNtTtijxsYW/pK0xDO1rU0XUF9urylCfGhOcTk0?=
 =?us-ascii?Q?7gwGBiGEBXecia008ACtAlJSBRb4VbgiJJLiUKX28DQm2tBkbUi7tmcS/cFZ?=
 =?us-ascii?Q?p4nNPcNTFQGTazekC7iLYg46kpsjQPGIuAIlGMzOgCKL+dEiKW2WL/Ubtguq?=
 =?us-ascii?Q?6o+y1sBhWOosViqo2uJ/uezKuU8ddgunbR/DTNABuXFVaJc3NbxkmL9v5fMm?=
 =?us-ascii?Q?KVqYmzQfKyBvMEMvTHqsnNSTcIHwZBVi8TCNgkjVB+/jD5SNn0FcB+MZbkSS?=
 =?us-ascii?Q?QnuF7pO8pSfwhK5TNihDURB/C1/fl7cbqYqeZ03TiMdWH2GuzBwu2Zk2JX0K?=
 =?us-ascii?Q?Akf682igqSthveGmywwMbK1hxx1VGpZ1DO3G2o0UY9GkPHM+AMpsvBzzqvkf?=
 =?us-ascii?Q?l42JkURNenUsp7tm8JhvMqNznQnDFxilAytQmJwss7QP0B80ms3K4iSsjSoY?=
 =?us-ascii?Q?A2EVMDpVkZzUoMs1AeHfurkR+esM5S25D6ztZMMlFcdph1G6RK8mpXJSfl58?=
 =?us-ascii?Q?f38fpZEgac/A4DOwAgZNeShzMYasVZoXyM5P7Hha4dGiDggfkHt7O3CjXD4L?=
 =?us-ascii?Q?HXEcoJNDX867oJkxCtFpqIjg3w+TySD0aHXe/5GY8VXaAlO4iJGQ7L9Eb34y?=
 =?us-ascii?Q?EfkK6w+PqAzQXcUtYB4SbXV+ar16TJLgmi+SyZWESGxOuKffz8o6PG1GXuJ2?=
 =?us-ascii?Q?cF9cIybmrmmBDbGo/GjZ0bUSufFCKSb7lN5FWxUWEX4oSyg6T1X4O9O10DgC?=
 =?us-ascii?Q?Nv7kS5pUQuvHdRgTIGX91z0aUIdgszIK8OYI6UITPbQaA29RUhYirjVUwJ2m?=
 =?us-ascii?Q?w8+CnfRkkwdiVTxQ9IR4emP7p82bUj0B+RJiUO6FzmlAJW8U5i1Qidrm671N?=
 =?us-ascii?Q?Wi/e5HnQeUsvuI97mit4c7anididXIpu2ZIdUssVvDr6V3Cf6UuUbrWoTkca?=
 =?us-ascii?Q?k1ACFzDJfXIgBVzqXvbk6HGnc7a1I2q/6Bt0G8E94bzTVsEGTc5cy3/hRZj9?=
 =?us-ascii?Q?83fIhMJl09gAZ0gZglWLAFgGp0mOd76IUngIhbwumtuckNCdXsKKUodGwU6X?=
 =?us-ascii?Q?B/CKcuDhQb7sjUDpvKLC6RM0mkzS/svcPlLxyDnWzfpT3A9dguIaZstaftfT?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LTcG3HNk73k3URk70Td8aB1nRb2j1Go95VZ7WyatLlMzqtSBkAap6LbOzwKejf0/0knLrOGk+UI9bnOtin2xyvTbWpALWs11jXEJFZ0XfU29iYndeDqwkTUAn3ZZfBq7cLyc4Gp3sA9e+K5dI2r/J6hEDtSRUMX5XgaSIkrQajJu09zfUO2okUkoXD5lwwlIBo1xYINFhAb+v0ndIxbNIPK8XDvrwkKWYihp6lgxrrXl0GbDAy0XcyaipIj2vbxUKG9lFdRfSXfiycfPbBb1OJm4TvWtqp/WtsrGgOdtzmuOaXWz9xS0DnyMOtn7BnmMapDG+KZCgPjJxAdG9pGNgj0EmLkrEObeaDSXE/Vq9W+xP9f7idqUe94dD7bu0pE7hLvkBrH32l2yOO/DA0Cnl18R9N/iZOKkA/LA3S3F4oMB3w5WF9Oj5GqmxaULZO1CvDj3e68YtIbKzmgM9cyN/J/DiB/V8pJxk2EazayMwAJDQnuqdYl8F4ZKTMQWcLJApjdNcvIcvSMSyD1jRykxEtYm9kWCdJE39JQ7BIbAbl1ZGLGMVR7Hw8hTI7VTQxU/Gs+35DIcEweDYlTvziyTlPGz6YVkR8CpCmCN9G84usg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68752843-5d80-4af2-3126-08ddce9d4943
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:41:49.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k14jIxcfLKz2T03qj2O8NPi5imvrarbVmUD8ieEBsYA63Zy7oUK+ToL9FgPzLShefnBWzdIQKXd4rrZkXWjp6U5TVwxISr7a/JVIMA7mFnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290098
X-Proofpoint-ORIG-GUID: V9Pxj3LvWP92-ql6BPaPT2yP9JL6nBzj
X-Proofpoint-GUID: V9Pxj3LvWP92-ql6BPaPT2yP9JL6nBzj
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=6888c192 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=MI3zwZtf8Q0nbIKdKNAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5OSBTYWx0ZWRfX+2sbeJ0LoDrp
 NPNjDJ2CFHz/RqxT0f74ep7rBcI1UQSz8lCnEDXON9dmzOJLWjNcmM14FGShHauP9uWbdLjvnOl
 HBneGgt06tFcbtznt2ICoVwOYL4jD4gsZYTRaA5GBQ3/1EwRDQjTlczk/Dyhfx/JznYcCPV+moj
 4R9hWcCBbLxHSsAztBpJ5mLOZ64xja5smWnz9rqtGQTRHKMh58nZIf8WQ0cuD3wHTZlvlCGmKZx
 PuYfzFDjR/MSvI4avGIZFbX6MakvckFvdptxioD7NIRKGCpAh+9te10DODB7FZ4Up79q385CJA7
 l75khupbkq2h+9MIH2vOXyplGcZ3W3ExkYNsax/N5g73wXbOgDGw93AjuZEkzPSUdLFzUPL9Sxx
 e7WZbZQEn6usyjqe7cWUS6stulgFHATq1+0jZm12taKCaK/leDz3SB4uzZog5v0qMTAbnVEQ

Again to emphasise - the original series is not broken, this is just laying
the ground for a future change and fixing places where _that_ change would
be broken (and picked up then).

So there's nothing to be worried about here.

On Tue, Jul 29, 2025 at 01:28:31PM +0100, Pedro Falcato wrote:
> On Tue, Jul 29, 2025 at 12:49:06PM +0100, Lorenzo Stoakes wrote:
> > Several functions refer to the unfortunately named 'vm_flags' field when
> > referencing vmalloc flags, which happens to be the precise same name used
> > for VMA flags.
> >
> > As a result these were erroneously changed to use the vm_flags_t type
> > (which currently is a typedef equivalent to unsigned long).
> >
> > Currently this has no impact, but in future when vm_flags_t changes this
> > will result in issues, so change the type to unsigned long to account for
> > this.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Harry Yoo <harry.yoo@oracle.com>
> > Closes: https://lore.kernel.org/all/aIgSpAnU8EaIcqd9@hyeyoo/
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks.

>
> I think the existence of this mistake really tells us that we _really_ need some sort
> of type checking of this stuff, in the future.

I guess you forgot the off-list conversation in which I said I was going to
do exactly what you suggest here...

But yes, I already felt this way (as there seems no sensible way to make
static tools check carefully, and it's enormously easy to miss something),
and this is precisely what I intend to do.

