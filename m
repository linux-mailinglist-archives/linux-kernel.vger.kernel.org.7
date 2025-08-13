Return-Path: <linux-kernel+bounces-765987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8DB240DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD56D72681F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0023D7C7;
	Wed, 13 Aug 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYZCty5e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z90NOL5d"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BB2BE05F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064883; cv=fail; b=ad0zEN1wnnDsl5VOt3UIFQ9HI6faPkZERhtt8ze7s0MxWrfn9BPBLkccsOqQMtOwzC/nPRb0lgnFBje2A4Zg8xCNrCii6a2wqVFn0qDkVR6JgTxKoN1TWjDKN+yYZYoFgM82o6HU1uzitwAJjKQuUMmJH93BUHqsxEfHByQpoi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064883; c=relaxed/simple;
	bh=AHFgmG/gue7ElGhElZaCjQ7Af5JbDpXUBGdFBfQtsNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9m0TMP+64DkiqvrznC7CGOXexT+MFD/aEGpU+urf9QNhnAxqJy6a12GIrhAlIeCJ4D9i2JjzyTHwjHdh2szfigVfKtrH2uYgs4zLsG/7+yfIWtZLp9W1rQTCUqRPwVeOBFQahr1V4vp0yDCXA15RO3fPa3grEEzvIROwSHNogQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYZCty5e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z90NOL5d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5u0ML007696;
	Wed, 13 Aug 2025 06:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=f555qEvCs3T4DmqRIG
	pXNNkNDAvBcAv/JsYnKecUWLE=; b=fYZCty5eYHp9yvA+ZI81WEw6aj57UurrpP
	ByjkMUybL0410G5lVZwbXvFiS0htoi4XqeruStzP63hJPc2yUloxDrW1Oz3K2TfB
	BzW5eV9heYpulHyoSeFpH/Rt32GzRxjmpmF4scfIKfIl4JnIrsfZ+nQv7t9ItFaM
	5FeQQDHIsImwkd6aGwgKwX2BhvVx6quoaKPMVkA6lnGQGxv+Njd6joYplXYaF/la
	uGBklCnb4an0HG/KrWzYp82jGvk7e1eZAZp4m9lcBD1Gj4TBCEsNpu9aFa2dh99m
	qQ0aWv6igWZobHHgkI4GdTBa4hENmt7u8jJ1RTMaLle3cEULVD8w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwxd2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:01:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D5XhJl038543;
	Wed, 13 Aug 2025 06:01:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvshfmqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pItXIN+GnbdWEj5XtNdHxbyxLteBE9Ntn6eiOrPW5JlIaLFPI7oQjR6+xvAzx6BDNrd/Ta0SrJ/IH8S9Zm/x+M8t391/kBjvMERce9vi9hH3M140xUXYzY9wniqxcf1CDfmwXxbOF7gorRKEHQTf/Cm0obM8r11SuyyKj4Z1EFvVl24B5gEKdPdQLG387ev8mHG4zh8+/2YCy2IOq1e2f3izB++HyLB695H1iKehfKqpEtFUtx5JUD2sHBg/Usg7EhADfo38LvVH6ZxT2ohSBF0ZgteATp4MfYm2B6RR5BN5h4NjDCMOT/H7DOY3ifSa+KUOyCvO0DFR6yKKnIOFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f555qEvCs3T4DmqRIGpXNNkNDAvBcAv/JsYnKecUWLE=;
 b=klc416QR52YHLLan1McFcfTC7NIFNL4KLu0HkF2ZcIffVIJCHxZAsNJNdQmfcBnG0dzIIO98dgh7CQbxuBFQV/NV1QgTA45WLiTVQYvS6o0YOivHiCg4RsomWmDNOTEBIybcuveR2DFo57VpRjPXNShtR5BvCAovOJ45rjeAvGr999bbmX+py3lLmlTGZu1+xdSu8AxqQcuFweeLLV1KhR9XbWsSyB0MW3O+YElL6jNLgdT8wwF6lZxxffyXewaX1JXgLvnAuNvat7E5ybFIsy4zOrmNkcBoASRJCIHN7liKzeQUCFIDaIaN73ecTKSwhdbugJU4sQMdSCMTQcdmkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f555qEvCs3T4DmqRIGpXNNkNDAvBcAv/JsYnKecUWLE=;
 b=z90NOL5dPY5JAkZhCITeCpInIkviStzXjUBccDXfBr2m4Xe65njxfeg+Frn15sAbSF1gQX9iUQqRMzBLOXJvN1EqUivO/PzOvqRYh9wlaAkbQJSp32ZGIHA/FvxnEu7uLjDyqijCiL78XThyscpKA4Jo8pTu+gyvxq8L+Nmk47Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6642.namprd10.prod.outlook.com (2603:10b6:806:2ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Wed, 13 Aug
 2025 06:01:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 06:01:00 +0000
Date: Wed, 13 Aug 2025 07:00:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 08/15] perf: Use guard() for aux_mutex in perf_mmap()
Message-ID: <5e48ee14-118d-4183-a88e-0d68414a2c53@lucifer.local>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.246250452@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812104019.246250452@infradead.org>
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a5690d-5a78-4174-54b3-08ddda2ec775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxnSh20ELAqllRF/9h+lnaUmzmiI/iG6Ky1Y+GEvUK8WdZTRkgyP8cM8Qc1S?=
 =?us-ascii?Q?p74cypSLiWNlwqrB2ps6+AEJfKEvUfCwf7f1StfR3fXhe6ku9/emAg7RxN0o?=
 =?us-ascii?Q?+om0KlKoZSMjaN2g9/DsWV0NW2k28PnMh6US7UqEej7rBUwEybCPuTzTpMWy?=
 =?us-ascii?Q?eX4KSUu+G1J0m9ypgrWWx8t1KDypoZFAb7dYj07PfmZi2TVHXVOsdRxcoKeS?=
 =?us-ascii?Q?ailXjNGY+b7QCawkaH41tVNGy8KYpUPoIZ6NrqzRIQuZIslDXkidDtk2vyUD?=
 =?us-ascii?Q?B07pApfeUtOXi06FH8G1zGKOLLbha3aIsagr8Jp4a6ZMS7zyn+SN31BpI2Sp?=
 =?us-ascii?Q?qciYnOJxI2fnUSAzUmAfd5qYBYHJVJllC/0HYkeOhfzMV/Vmo/l2ojkQeytb?=
 =?us-ascii?Q?YARtM7JrF4F9BnDXi+PYTsNlap9d+1kIE4ui7kK/8i5SoyUMtlc9drZKSPOF?=
 =?us-ascii?Q?iq7J2xZnqJrHFy01lebDs46HW2B8vcC0xNLGF7wx8t/kT2u1CKnyUkkcP7kU?=
 =?us-ascii?Q?2qZdtE9A9BUmsC6abCjN8xIWE4M/Y3ArNv12bbgdMvAxXBcpI0qhaVQr9tW9?=
 =?us-ascii?Q?CMtinkHuyVqCX3RYqOSDnYr4gLeeEy74zaRrEjQ7kUFTirGhnEGRfLPtB6md?=
 =?us-ascii?Q?+pUnjZcI2R6QeclBInQdb6tTBYwzv1JMCg72AwX9Jcuy2bodMpfcBDiypO1z?=
 =?us-ascii?Q?5q9z9Ahlx1AW0p4uObmybmybUhT3/KrPpjgM9GreuFQYZvfj2RI/N8nGm3ux?=
 =?us-ascii?Q?WMZpQqEvOdaDWnQLZvFidL0zgQLkHZS4q6u2rwzV6b7cPq9uGldUmizIr6kY?=
 =?us-ascii?Q?j2AwmyA/JKARykbYXZYDAu+w+ER2HMG0HdvTr0iUnzyxk69s7GcP3pAM8BTP?=
 =?us-ascii?Q?tm5ShsrbDkf9HFaMGmN5LUUWtYi/bE3QezVJY/MmCX1Z73v5BUbuCP9K6OuL?=
 =?us-ascii?Q?AnktcIkM75rSttLLz2jzG3IU7eAjfrlcXPPerLNxif2iuRmUfalOwWMHegbG?=
 =?us-ascii?Q?puyIjqVxzeJEqyU8aifuYthfwy2m0eSJFgqV/QFkhNdQk9jbf8m2MxXopPtH?=
 =?us-ascii?Q?OUCok+0IOnVHp5YVOzEmI27Lg2CGCzvW4B8GtzKFNHG7DzL9M+K1OeaUz6MI?=
 =?us-ascii?Q?pckRHrkotpvDhnkwWRD9Vf660a4EtJxqE1GlMDDkLesvIhHABX7m5vSWqrqM?=
 =?us-ascii?Q?fuv79FOqubYKk1x19ImiqH7pBlE2sewo0M60Mva3ikoaaVV1rFKDEdeYNRXB?=
 =?us-ascii?Q?ZlnBsQkW+SDEl1m6MhzX8bdYK4KiCC27myfgmW+pH+kmNoHaGvwlV5+ZPcK3?=
 =?us-ascii?Q?sZO7rKuwEYkZZtVSEH72DLPAQALLolM2VkZvHzJmsneT4Id2IDvZpjDeMU6+?=
 =?us-ascii?Q?NSKtrrG3chfn/q+/P9LrBIX1rxglsLL/kFQ2aIcKlSsVIxJ+Zdi2y/srb+Bi?=
 =?us-ascii?Q?63/kSfzHTbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lJu2jiX58MMjkWe2uOAyuGvrh/L10T3EyXXK3YirAPdCJYb6hwu4wHcPUeef?=
 =?us-ascii?Q?gcWLXOJ0FgEnZ3CHCLB9FFqnCeI6QZeNpcfQXAn8+ocH29QZD4qONZYvnUV4?=
 =?us-ascii?Q?G0kKi0UD9G1Y0GJH75L2lAmg78Qsz1D/VO47zjAGLtp413DUpiZSwBaSKdcg?=
 =?us-ascii?Q?HLNXtaoA4cTcQ42zrlpcSj5+XfYKSN1uoMfGov9c+5CocCJC5Jja9tg5wYLG?=
 =?us-ascii?Q?vHTEb4TeSZ3+XK8F8wvDqdCmCYZxELafhUy05Ohk7qBMngeEvqfKS3/GCkqP?=
 =?us-ascii?Q?qb0BKqzfxz4iO21zxlawVpF14LEyGdXyT6j6DE4yMKDSIH472InuukOhrA0t?=
 =?us-ascii?Q?Fz9sfL5wzoXn1e4iFYX2CdljEFZ891TUBEbFTZlBqfhYWo+Ss7T8bjXhIDjA?=
 =?us-ascii?Q?Vfe6E+VRW7sqkJK99RtXCDLuWMa3HP/IdOEFivwh5o768MrEHl5Ly1HNRoR+?=
 =?us-ascii?Q?y8mbXANClpirrsvwQWoMlKNLgCLBa8U44BsxfrZNcxeuGp1+3yV6H4SuUIjd?=
 =?us-ascii?Q?VIJWKE5KYFAKLp9MTnHWY+ZTLl2oVVBi44/YiSmNC19WJ/iPj5X34s7Udlcs?=
 =?us-ascii?Q?TtyZMr6201mdBX2/+Dt7AdRrxBa6yfK0IS7kQZhIIJg+sdTgbAXq0+veldQ2?=
 =?us-ascii?Q?gqFEP9FP6VJW0ch3MfiDc3eQeUOz6s6govx8vyvnH7ru1c5/xt601vGDGEiu?=
 =?us-ascii?Q?GfHmQFm41bdTX0mP1E+iXR+uPjUkyEDGzFdERs0Suz3Y9R6owczOm199/LnY?=
 =?us-ascii?Q?D6YvISijhmFtSzQPKQs8gGytXO8cW5u/+zDv/A6hH2g2ocV7V11IC11Yv5ZD?=
 =?us-ascii?Q?ZZR+8kAZpCe3JOYZ+Ybzz0CYrQPZMFucVb/8OF9F971fVz76+t3F3XlI3ntI?=
 =?us-ascii?Q?PP2xb6geuKs3CYNl4RQ9VHuS+9u1s6z0iVWm9MucGx7xomab/KU62JXclgDG?=
 =?us-ascii?Q?5XWvngxrtRShl8kIGjYieIBrPfeY+BkAOvVyQWLs/lYGXW66K4mhXzIZOm2L?=
 =?us-ascii?Q?h91oT8D6nBlACRgOmy/PUzaIKSHMu+MV3iXGnfiB6vFQP1wcXg9L60kIkyEs?=
 =?us-ascii?Q?4d9f/E7MVX8AyNDeM2L7ZTWBiFGi7E12dvEAXj36G0xPOAGLcfMIvY9NFWPi?=
 =?us-ascii?Q?hizh4iBcyzbRq65GbiCi8EPomkaS403sHOpNBSabBjGOPsEY+NKlTZ0klEaB?=
 =?us-ascii?Q?GJpyb4ApDLTHD+vLf/obQzXhApDW28CliRmDaogUQLZD1G9Qr2Y2PmizgCT9?=
 =?us-ascii?Q?8CgjPmyRw50pQtPsHr912SJg9vMXMnsTkHaC1ZTrGI42PQaxC/dyWB8/Yjof?=
 =?us-ascii?Q?8vBfi9wVklENLCmYixPKRrOYNUtLFOUV64BAsPXPbWoUZYvi23Jv0XcMz7Ne?=
 =?us-ascii?Q?h0oaQ3POjtIrv1EpYvcG7jGai+Ubdha1/28r+vQYnsmVNuWiBn4gqpzNPWfw?=
 =?us-ascii?Q?VlVMKuOUPwA5M6DlCtuup4wRmb0rOykjSh1UuN1fdc7xK9hAP0V/OlJ4TmMi?=
 =?us-ascii?Q?uTx1mEUy3id/8pwgTijXEkBS2OpzgLb+g6aNdjRga1LGARoX03U0uMfbbr8f?=
 =?us-ascii?Q?ErCCIhc0hQ4K5GwWW5SYTKG/hpJrX5o8jAjswuC9I47Bvrw7z3iiX0X4zkh0?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kLQsER4FYs07tevMMpoHcCCbx4TJqig+fzwNXR1P40EjVOdL8Ff5DJoAM3TZcUIY/u1RvWl0KDXsQB1P969JAl4Hi/OkN3Uo7vUjvEPjUmQv/nxwaAthoADn3xUGbhLqCZMjOcOEahJrCttn/ZF367CzZwPi6owj8QtcdOMSOrt9mmjpORldRa097T0oxzs5bPtPj+5HCrQJglWkEXvEhryyYyhEykKEimIrghHqT3xAV97M4b05MP5T1ysuV64TXELDtpsqNqTaQHUbm7rhJNzqVnQnm1wdCVvWQ2BsLe+vnablxRCW9MDkIoGvDFKKK8vNpX+Ijd+NqZxu9UIRRVJT+Mc2nLuOwoyfpDLBfH1bPQpMnNMJfQD4i01RSa0kTb/YD995Bq5QLJiDPf7cK/2NP1XJL8nHVkyx0hEThJncqJh51yklNjLeJhKzEXg56ARa0jNumwQufLAozwAtDixqLu11o9doYVxnJkSHsvS7U2VWrw9W5XqD81ghuAlm0UHlHBVf3GpEqkJsQYyp8MkZfohpO5VoAOiwSrltogmROh1kwqy6/f4HOctDzpZTzybePG52h/VrppVewRR8lFKc5VkbmEcVkuSo3BZXCwc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a5690d-5a78-4174-54b3-08ddda2ec775
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:01:00.6836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm415bQbkDkxXLps1ak0fF9DAUxbWlG0PfxUoEjqI3586qg89Hlczj50GflBWJ60tN8B8xG1LAFnXffFzuTgWqUp7q05QAvUvUuWr5AFqYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130056
X-Proofpoint-GUID: iA0C9ULgfAlD4aV5CXbeVVbfvMWYRrhF
X-Proofpoint-ORIG-GUID: iA0C9ULgfAlD4aV5CXbeVVbfvMWYRrhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA1NyBTYWx0ZWRfXxn/y4z1hNKbo
 wduYb5LMnBSMJxV9ziLgwDp03MH/YtMDO8P6Rr7Mi5JIWOEXxcOWducs6s2qMiqN11ZJnnsDABn
 gb4jDdTCbVTn8cHhiUfZXc0IkB8uDlp2EliWDmHecD++RGyMpq7o83WDQocMPgT368qmq6Cmfqp
 TTjOBk9bztMU+OHQkLPYcsIhugeS5cP5vq7QhdsLvCwHJo3GIWZfznK5//ffp9aRfUSngRxYEPB
 YAwktAkzVBgWXcFDO6INDMtC8z0e3ht+4e5KOzVcZ/l72VgFCwh1YYOPQwStN+ojbi23sW9UMZF
 ssDltZzzTL5VeIFQ5oAMfy1KSRgEZ/5mWPVVbRYubKdGXKHAZbrKp9YGUt66ZYMz1UVQPxni4jt
 UDu+qTYEy3AUOl7UtH2Z3M33KNns2oa+vOcxS+TkObkez1AtHPFyCrdEAaRhn83E/JNK5NG/
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689c2a20 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8
 a=m2Dan1i9B2kriIa8vdgA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:12070

On Tue, Aug 12, 2025 at 12:39:06PM +0200, Peter Zijlstra wrote:
> After duplicating the common code into the rb/aux branches is it
> possible to use a simple guard() for the aux_mutex. Making the aux
> branch self-contained.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

LGTM, I really am going to look into how we can use guards in mm to
simplify things... :)

So:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  kernel/events/core.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6975,7 +6975,6 @@ static int perf_mmap(struct file *file,
>  	struct perf_event *event = file->private_data;
>  	unsigned long vma_size, nr_pages;
>  	long user_extra = 0, extra = 0;
> -	struct mutex *aux_mutex = NULL;
>  	struct perf_buffer *rb = NULL;
>  	int ret, flags = 0;
>  	mapped_f mapped;
> @@ -7098,8 +7097,7 @@ static int perf_mmap(struct file *file,
>  		if (!rb)
>  			goto unlock;
>
> -		aux_mutex = &rb->aux_mutex;
> -		mutex_lock(aux_mutex);
> +		guard(mutex)(&rb->aux_mutex);
>
>  		aux_offset = READ_ONCE(rb->user_page->aux_offset);
>  		aux_size = READ_ONCE(rb->user_page->aux_size);
> @@ -7159,8 +7157,6 @@ static int perf_mmap(struct file *file,
>  	}
>
>  unlock:
> -	if (aux_mutex)
> -		mutex_unlock(aux_mutex);
>  	mutex_unlock(&event->mmap_mutex);
>
>  	if (ret)
>
>

