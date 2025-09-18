Return-Path: <linux-kernel+bounces-757579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42958B1C3D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2F53A84D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFAD257458;
	Wed,  6 Aug 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASxaEVSn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pQGDqmXk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269922904
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473931; cv=fail; b=VY1xdRIga9JeX9ADBkBKgT+sj7N/AoRiYJz7cnYlfeg0vrAI9Cp9j0SvhJH9taKWWXEgN7ef0KtYZR65bUi5X5uLQKPgdixUorUmJIjyc7RfRDO97+/5Sn5zxe4k+evbqEDOTx3owDb6eaUj1kmYc89E574WyhIcSoykwh6guYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473931; c=relaxed/simple;
	bh=sVzD43Ib6t0O2VxnUQ9GA47hnqizEds3mIrS0OTKYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TSr4+Lg4qm+vLuHyuTpZcyfWOnQYb9QCGhAZHCEySRi96M3lS75Ur4mS4E4rQ7R7YvrQiB9KaCe93w/EDfSBwpvfrw6bHVjwiY2pA8g7VcComAu6YGAEmB0Con/a6MqvFlZy5/Fmz3un1Dc829yeeRjZRaG3VByGbEGBCrjdnv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASxaEVSn; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pQGDqmXk reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768RZHS002490;
	Wed, 6 Aug 2025 09:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sVzD43Ib6t0O2VxnUQ9GA47hnqizEds3mIrS0OTKYuU=; b=
	ASxaEVSnHdNiM1xuhYk0wl9HsZ9dUgCp97ONlFIIWWaWQKQIgBm5306GFxlByQC+
	JZ5g/jKL4F8rTAhPpo9pdNW+lR+qmoYNYIZK1dprnaMMNbtYRkDps3PdG64E0sJf
	tvsTY8Y5b1l3sYc0IOtdydd2Dey7d6rUneArPeJeoVRi+ZEdZCDME6WGuVj75nd8
	80PXmUAZF3rMDpZ68n4OvA8bxluzGqBKqD0jyV80XxvuWv4djMErrYaXA05JGu7K
	h29ovhFvvGs2j91ijISBS5W6QeYoFzUK8Xy/pcWv1IATxHuYwgLAIjAEQFMpbMhB
	+uswIFQZvDf/KUzG7+TvsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjs75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 09:51:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5769VSe8032038;
	Wed, 6 Aug 2025 09:51:07 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012032.outbound.protection.outlook.com [40.93.200.32])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqac9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 09:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D60L6EAtRYt9B02yDQd4eBBKRqIArn/DokOfWH9Js9bBuCUZumEkCan9uWDvX71q8xWZA2IU/i6wiKbvfX6eCrhItR69d4xY3CThj0svVEM+C5oyOAVFWIkvD6eeak62ldRpzVoeRbZKwybpMF496HEOMGNHmsX/mAmXCEjxrXbiMJqgWJ/noiLHUK582FGgH3ySKJkxgWFXgirpFK+NTa+aGBZ3pk2ssx1+0SCqUpU8IzYCycu6UxN7f3F81kAkX8kA6e4bM6kNH8wSVPqkdfi3TSTPSPi8T6EJOV9JJCFrxgR5ooNJC5NM2ovF1s2d6Y/YslGeNbA+7l6V+sMO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68YZqsjj469etaWY7OGyfBwu1Rcb3Lve4Qx1s6aw+lg=;
 b=ntmmg0+96+9SCWV6SaFuhx5QUIQJH3S0atjXX7zMJUVl/WnDgfw+gKkWSNqbyRDJTXFZ2e78Jnxl9l3X4IiW79q+onmvmUuvKw0SZ/n2F9RDz6v1rdVjbaN51GrRre1dXdjDevsyx1a1pQD/NKLREEoJKXvfbbRLl+A4QpTmYV4rgrEjz/UD4s3svxVswlRQN3ph5kKU5AOx0ewf6NUSNwgU/rXtoRK1VGSC/x/g5kuPeFwrigUKJls8HBBl8b518EPCPgm4mXcfLbRRSCypSdEfvILz8Bi1qDEf5hee4VtEbw+ibvtS7tZMOgexGHTH5fUp7yRUPaP/ZFDKRsJnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68YZqsjj469etaWY7OGyfBwu1Rcb3Lve4Qx1s6aw+lg=;
 b=pQGDqmXkdrtT6vgdTGyRul2XGH/8+wJYhMzBOriu5W6y6/EC+vh8XuaADzcN0wbCv1n22Ozgf9KILUQMfYQm75SOQjoMlmTLPAf4WgLuTEGFZHEHORix42pqZlZBoosxI61tEQV+u2I/2eYt5Ktu/tKVZPLREA/SUPSiM8OLRPo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 09:51:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:51:03 +0000
Date: Wed, 6 Aug 2025 10:50:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
        ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
        quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
        yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
Message-ID: <9cbe9c6a-0013-4239-9347-bf5d43021fe3@lucifer.local>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
 <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
 <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: c708c98d-fbe5-4e52-919d-08ddd4cec18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FXIbir67Li3c0Orlxfp3SrN8ODTUqhDhmF1bOTrDgdXsrUzUEItSNdl3jI?=
 =?iso-8859-1?Q?j7JmSMAjhGu5f3yQUzSixBvzU9ez3A+9DGnHTWi6p9JB1JSKAB1aiCUNuR?=
 =?iso-8859-1?Q?PyhLVdpxhc1lTVe/m12SR/+qcraE26sElGIeiJcALcWWB/wD7UF+m7HCnG?=
 =?iso-8859-1?Q?RZO5RSj6PJi4iCS7VmIHCn8CLqYXzJ9jbBcwlKh09foQKSTTjjHyDiADOi?=
 =?iso-8859-1?Q?MEMiYTPA1mU3z0xOlddcnIujKkdtYCyGNws74PxQtEl89vAyVviJePWCKy?=
 =?iso-8859-1?Q?aCSPHBXyIdMCEaf2RiAPFhMftHJPXuqBJ3AgEs/GHu5jvvQ+jg5aCiO9Kl?=
 =?iso-8859-1?Q?/Uxer9B74/xIwY+XZT/0ccWNs7FdsOBtuyW1IyUihEVvo+DXrpU4vgqR+V?=
 =?iso-8859-1?Q?eFuvyIYwhlieWny2Xiu5wzNE8u6BSzOvcBPNsL198TctTkMccFcie0sY0L?=
 =?iso-8859-1?Q?R4wKYOwsSTkYwaQfk/KSy6a0iBF4HdmLvT7tmMQnmEoFVyGA5H+VXM3iZ1?=
 =?iso-8859-1?Q?BXiCQHa8SRT3ty2XKcFwvVpSPuTky9EBJNslpN7iyU7rzwA6sxTP9NbYxS?=
 =?iso-8859-1?Q?dzA9Sz8q0AViEM7VM6aDvprM4vg1fUXnRNTDB2gK0Qju+34+f6SItzbV6Z?=
 =?iso-8859-1?Q?uxW9+8d9k5nFkclxBGAYBAovNLAy+WBXI3LcjhVSYej4gAHehYiQqXOE0Q?=
 =?iso-8859-1?Q?2QThzrlToL/4FwLu6EjccEHVmr7eKvbDh0SUWbYSuacDIQSCOvmi9kI5HN?=
 =?iso-8859-1?Q?nDsTtsv9p5gVdxXSLkzh+L+MEa3NKk1stdSzhbrNqBXMdqi47WB8+FxUi0?=
 =?iso-8859-1?Q?TSlSbiI02Kd7K+0hyxiQduwdp/Sek+q+RztlgoVrb5yjS4w2ifTCe+SmxK?=
 =?iso-8859-1?Q?V8dZViF9NqrxXvmCdXDcRHyC7sJEObvbR6FhBGmCT7Qzn0MsTNSkrMq/Aw?=
 =?iso-8859-1?Q?GCrLyZRZG6O1f6dOZC0Fhs3PhEMCLWKK02FQVdhCBp6ey+VL9J5fiYuNlu?=
 =?iso-8859-1?Q?FXBfbEa6d620e9+C0AsFRc6mNZdJhYOAoNfiRk45mECzzsZ0LZNcpDcHAw?=
 =?iso-8859-1?Q?vog8rDa/ixKMKLIQk2WafTa/jcEPBKvL+XLXcfKJ5suGBwo2m9thYn1tda?=
 =?iso-8859-1?Q?anppiYixQYfcHtXzl28pGXCEzZp0Gv5j0pkA3lZIwGZku5iP3j65HYLhXi?=
 =?iso-8859-1?Q?N6+yePrU2MfrhmsB6w8fA301p45QcbZJOhO59sXX7z/mUBoLo7ysl7lSfP?=
 =?iso-8859-1?Q?1WCGj4pi+0DQx7tuD+xNHQzbDulQuUpxPzSr2y8J3GEq5RBmRmCs3Y12R1?=
 =?iso-8859-1?Q?1etfCUIciWDIK1AKaHs2GR9YZgGdmqcx7oM0gpA1ecmOIeOJrmAw2OEbgd?=
 =?iso-8859-1?Q?hNAgTUS4sURGa8dY8lUP5pddMD16EqfVKl9TVKvk2MHx4P7gXrlYiSTkpc?=
 =?iso-8859-1?Q?lwuPgkBElAECmAAUhOf269XFrEyXIthEmKszSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?FWS5L5+ql4QudbIrz+l5rKcWcu0+AUrkLiZhCRzM+5JGA4UZ3+KD2/eb7c?=
 =?iso-8859-1?Q?Bf/9oT5LxpWCmyq3ZQhB6t7J2g17/qlI9yVsbMCfIpE8enTBCNQ5JvWoTx?=
 =?iso-8859-1?Q?mFb/Hl6T/pLEPhcfBOJBwkcsk90OrbGTjjREmLPlYB8WWB0aSoq/BdpWSq?=
 =?iso-8859-1?Q?04l3nDKCBERM3jLgRwoaoYocOM5puOCtXc4gOJsd5JlE3of4blEpmW28pV?=
 =?iso-8859-1?Q?fY6PkxNXOMN8k0hJLhxZatyizHXYgGELARIWzHoC/7dC6JF/g16EhsEPdK?=
 =?iso-8859-1?Q?mCwYOBnsjfNc0di50h8CQoJ+TfQ6qvS5v4QmRY3E5LP7sJITxWDw9oDZZ1?=
 =?iso-8859-1?Q?x+LAi//Oiy6jDnNnIoAjgYBR+AZIvY+Jt2CrSidK1LrqOA1cJ89zPdO4vO?=
 =?iso-8859-1?Q?yEojBu+/V2lvELqf/gt4exV5eFlUQ52pFcpX9/wLdCcf98rQ9js4eqZ1oP?=
 =?iso-8859-1?Q?Fb2Kb823Hj+Y/bSC4+Cg3mqgg1lJLGl+9TaeGlEf+z4LrMPV6XaSHQl0ug?=
 =?iso-8859-1?Q?B4mEWuy8mck5WbbGsqFf6JNmV7lgjcVdm1bkhsFrbpzRGgFyNVO4MA0Pjn?=
 =?iso-8859-1?Q?GO+2I2pgHbppGVHnqa1TSUKkw3IuaqWa+7lWqjeTp+Dx571oTarlcWKCG+?=
 =?iso-8859-1?Q?EHU0MLZnAmHgtzztzaVdCuWW5eUhfGB20QqrhK2620UUjSMTEC9xs5day1?=
 =?iso-8859-1?Q?llavb1ZOmNkQuSGyqiYMD3AqkWEe+kCKZn7BmPkNUXn7PWW3MYGp0W6/Ys?=
 =?iso-8859-1?Q?MRBQSGi+5tHDg0mcR+T+cjGTlf7201MxZZ1gVTcMvyD/qEjGOT6cAYJtFn?=
 =?iso-8859-1?Q?3N2qOcFZgYfdBGMbvsenCIyJlbpmkokuoqAMF0KEYGvyKjXdlcqfogjhSf?=
 =?iso-8859-1?Q?kL6AdpveiMTovNlsihdJ5Y82BgSw4yxX2P4sJ9hTzGMK1oa4ZLyYKyz6Rj?=
 =?iso-8859-1?Q?9shts6+jbvBnZidkVCjDtNEzouvq+KveQfT+6qgC6beNSlO9FFZJvBS+Gi?=
 =?iso-8859-1?Q?4InFI6qT7YapbUJTvgV9P0CKFB8rCXraWEgiZpdkunvsYmqIE45nHeX22Q?=
 =?iso-8859-1?Q?qcblgPM4yTc2hCv6OE0TcOWmwwlbDWIXcom5syS6HIIhabEqDptV8S8KOX?=
 =?iso-8859-1?Q?m3HtdCjy8yYRdO+eJBIsbkw7EhilCMf1OtGpF1WxR/RiC9R0ChKAKuEJRt?=
 =?iso-8859-1?Q?gtgRX4rjONHhr0hry/Yk41bPtE+36wqv0dR8TiQVG3gwvL+/K1/m7O/58U?=
 =?iso-8859-1?Q?QQvxwljQT5ILCs9gmqMlxKv0pS71bmI4ROtHTDLWlNI5Ke57/fnBXB79JX?=
 =?iso-8859-1?Q?kBZPHthm2CCWLlvvLBZ3CENYA1MDxRowwyAiBURxL2mtv7nYPDKFIa4x7n?=
 =?iso-8859-1?Q?AQVmis6i+BQFTJGajJBot7r6TnE4SqmmqoLYSxm/Lc4qWTiuGlAlWPANLa?=
 =?iso-8859-1?Q?yqNMHk3PCKGjVvBIZSLl4reA/e1GIhdokLY2Sbx56Ytm7Lw4YrU/4UbLOK?=
 =?iso-8859-1?Q?i1w82VQ0FBOdX3ZWMNhfKI/YaPkZoJJN4QPvM6R2qjW+ua+Cu3nrk77nvk?=
 =?iso-8859-1?Q?e/nSYdb5YX9Gtoc1vcUMPFvDshaSU7vBLahEt/BW2DOR/9mNcNjBpjfs++?=
 =?iso-8859-1?Q?Mo/TEtr9go+BFSO9avQlJecYpt6eDiCkGXwgz8yMBp5ym1vDdeDHE1xA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OewJ6tF2weCL2B4wFd6ktPcQhyXwrO4VR3jEk/siqb770LIzinuLOvRFHr6gElyq5eU4uW2aKBV+qRuoyuVN4yXXJ/gWgbF8Ys2wOtfRCqihAshJezUEqZiH8ESCTcflIU/jLW5KyscA1JvIoxcwYtJmnnPm4VBehVmgK8UbXfiveh9M1Ts9PVYDx/H6Jyj0NjUaOPtkEOLdD7KzG9vfIDSXAks3UKe+l8v6z6SXBWe1Pv6tlYXqjN/rn7cIGVn7S25GUI3wR4l2MNo/ZJW3TuvsZcpwdNRi/nUlI2lhFJACrKdnLXYLngWsY/A3Z45T4LxGqjo68UpJgI8r6iFuTdKtbM2EtJHEj4Bb8sBAEhfNqgQk0EcyPihZEwI662pnVqTxI/VbTbaxyu0ASql5ndPNzpnbyJl6OGbftY+vIii2u1TTKHd2BEIf8hlMaIe2DxIhZWYPySA3m53J9Szwjlne0XvLpT/ZmqDjVuhNfsPlUpLCs0KmmTRjE/7J2Gu9D3oYEH+gpDJTj2BPvGlV07hC0A7Mruovh4MAajqIiDQGi4hZEk8iTI+VaG32C3HnsMrYuHQyVv6ZESL62uliDcpGev5B9Xfz7qsYTyRkfzo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c708c98d-fbe5-4e52-919d-08ddd4cec18c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:51:03.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRLpduzVeMGpY+Ae4mPam2vIrz4WX/dHE+N5Z3EUBz/BQ1S0UhxyvQJB90i9qrXiGyTzxcATyhO4Bhg7lp67wLy1reznv7grqqbS/g3a4hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=931
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060060
X-Proofpoint-ORIG-GUID: JsTPOCUhkQrEfdygDMmSB8Zlx6nmEMrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2MSBTYWx0ZWRfX8gB6EE8gEDDI
 ILZvacXYJ3X4ZdzgYv9ODKuqTW/Fehoo5glLcwWXMoJoB7inMSWVGl9jU04D374dIj/dB/MJpAp
 Z2OtEH1SNQsUv6mFKTGPKzBxm6/Q+X1jhrqHHsSp0BhzZRwTaIuyIBMjKVD3Y+2XwBpQY2XAwCw
 UvwanDI8ZdML4T4a/PMnfntXfBcgMN5k+Zbwz2Y5tGfCdJ4iU+Gjecd2jJzK5lOiyp0WTOVEhji
 EVk0fYpRFEQk34ltR3yAPs0qbxG+THmnURSCuRQ9cMjwcA8OSMwK+TbK7V/1tXz/471MoVGpAMP
 gDYUAbgx2+uiUxoLFsaj+0bcdqKeTCkzepvQ5n8Cbk5G/9KXo4AX2gh2fFUqZhvoIMTPZfkXFdM
 AdpWnbfB0lxAI3MZDoSL9KPw4x2H3sqpUPO1pAp62cj+3+fd79vk7LSMzHvkgG1Cu91TRBpP
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68932596 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=dRvm-PZzbjhcwBgFCbcA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 cc=ntf awl=host:13596
X-Proofpoint-GUID: JsTPOCUhkQrEfdygDMmSB8Zlx6nmEMrR

On Wed, Aug 06, 2025 at 03:07:49PM +0530, Dev Jain wrote:
> > >
> > > You mean in _this_ PTE of the batch right? As we're invoking these
> > > on each part
> > > of the PTE table.
> > >
> > > I mean I guess we can simply do:
> > >
> > > ����struct page *first_page = pte_page(ptent);
> > >
> > > Right?
> >
> > Yes, but we should forward the result from vm_normal_page(), which does
> > exactly that for you, and increment the page accordingly as required,
> > just like with the pte we are processing.
>
> Makes sense, so I guess I will have to change the signature of
> prot_numa_skip()
>
> to pass a double ptr to a page instead of folio and derive the folio in the
> caller,
>
> and pass down both the folio and the page to
> set_write_prot_commit_flush_ptes.

I already don't love how we psas the folio back from there for very dubious
benefit. I really hate the idea of having a struct **page parameter...

I wonder if we should just have a quick fixup for hotfix, and refine this more
later?

I foresee some debate otherwise...

>
>
> >
> > ...
> >
> > > >
> > > > > +����������� else
> > > > > +��������������� prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
> > > > > +������������������� nr_ptes, /* idx = */ 0, /* set_write =
> > > > > */ false, tlb);
> > > >
> > > > Semi-broken intendation.
> > >
> > > Because of else then 2 lines after?
> >
> > prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
> > �������������� nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
> >
> > Is what I would have expected.
> >
> >
> > I think a smart man once said, that if you need more than one line per
> > statement in
> > an if/else clause, a set of {} can aid readability. But I don't
> > particularly care :)
> >

Can do this in follow up too.

