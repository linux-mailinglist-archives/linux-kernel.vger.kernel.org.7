Return-Path: <linux-kernel+bounces-781690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B289B31582
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CF4E66A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98882F532F;
	Fri, 22 Aug 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URfPlC/p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nWCO4fil"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEC2E1F11;
	Fri, 22 Aug 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858876; cv=fail; b=d8N2Fhm38ayvIbrkQ3Aa9arMCoFiu45E+lvZ8ngDJYPpb1v8rJodgF0MFXJjHd6J2Tx8+3VAbMTFtGh5LQcOxjdMIoH9HmMPz6ZpWIYXSg4E3nCIFtcAnMtJJCtpL+J7V3e4i4fmAdce/NQjpES+byhu40yV/mdjRazbMgHr4Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858876; c=relaxed/simple;
	bh=6dKjN/EY4j/9QGGzYkMtcp4PyahHouF/5BGulm2voWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYpVKDmEa8Ul8sB8dCFdigkgp+hirF6c0x6BYgFFSWyGNfVTBxl1zCiCIW3JddiWWx/uQLKVom/sRKJNjejO1f33Pdxm0mCazlYEefnuyhLUUbpUgb6Mj5CIOYeO9sCQgsDRjVr3+WOlRgWHNNzuTjegjozR5giHpQtkrO7zlY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=URfPlC/p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nWCO4fil; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M9etb8010018;
	Fri, 22 Aug 2025 10:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=er2YA52FPofkfNjjYm
	A+PubfOl8ElXLIG9Ngdf/ywRE=; b=URfPlC/ploBRiBlIFFwqbYIKT3Lb6zSf2P
	In7Wtt/dqtgqc3YFLjmjTnmjs21+C8ll9+8lfkrAqXAgYWusMNhdOWp/ACKuOaXN
	T7sIzTqNVFimk6BMBNpr9Q2hDV0KQploONkZgWRAT5XibSBz4jwwmFudUmy1B4TB
	1Vws26cX/H3cu2ff3FYedJgBXcM33jOh3Q847wWmJR5ZezweR6D/29n6R2ofi70L
	MorObpLzj51r/2tOizAGULSqZmZf6PqSZ3hddntCkk/0CSuf3z4Pij8COM5KziA6
	F54C4TqzA7/lHAjHmpos1Iixn65j5bBt75wUXI4gC28bpbJ1cJIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqwfqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:33:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8TkJk030239;
	Fri, 22 Aug 2025 10:33:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3wh9py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 10:33:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCGwx13WTmMz8xmOb5EePX35FaZD8CkqMQ3B5DrjHWs5pHIdPBV9n0yUqMxGT4aJ6eWOJZHQg4eE9PxMX1nPGRdnNAuku7QGFTJJfENblbUg5/s4KKfLl4ucGYY4qX9LZ5YShcnNzgEx6SJv7ZC6H6AFZffe2gJARpenhwsX1tK9zHZQFDpyd7pEHE/CljhhZrnoBrSvqNQfA4wTZX7E8ltexS9qxyQUAGIlt6KLq8h6wpb8l3/anuyZWicwvPJ0JDi/MDUDz1d2yprlCr4bCGFEi5xE6LLBB68i2YVe6CkLmLzwumQRde5pkryNmsXVfOmKPsnNd7c3CPU/DUkXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er2YA52FPofkfNjjYmA+PubfOl8ElXLIG9Ngdf/ywRE=;
 b=xRrb8zu+vec3fldZPAoPUHuA8FOz/blYbipXuKuhuQVJBEpBaqLkq6Ac8gx5x3U5d/3tEg4xiyNVaLCI0MawxXeQoXYAu9KybbwCy7sjpK/bcQh5OHhISSojoSFi5VW1eT07QsBEs0nr7Qny23BhXtBC/tLzhdScbZ15VICng9OEfmWT36qJYc8W0NtWX/k7RtSPvURNsScS20BbSf5Roqg/DXsAq5Ck42oLLfHl5c6Rh8lT/qMrtwQoFx/QPIE2M5RUDEduZ8YAFBl/bPvT5Zsmxz4HGrvjm8SJEX6H3LAUIY+pKeB6mrw8H2gs9IlAdVSrgxEnx2tqM+9X8beOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er2YA52FPofkfNjjYmA+PubfOl8ElXLIG9Ngdf/ywRE=;
 b=nWCO4filAM4SMHIKgENC9iCnTIqAWmW1vPr85xyz9oyK9gXUFnNrFktIMYZNmyanGWFtl81f6imXCYA9phZwApJkO09duuwlSJkRxuA13FwoNhe9vf+b78SjpASqKOfgnq6afizGsNRUXG8rghppeClL8YfxaLJOMNn3DAYas1M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYXPR10MB7973.namprd10.prod.outlook.com (2603:10b6:930:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 10:33:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:33:48 +0000
Date: Fri, 22 Aug 2025 11:33:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
        peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 07/13] khugepaged: skip collapsing mTHP to smaller
 orders
Message-ID: <a345af33-ddc4-47a4-ad26-65495e671964@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-8-npache@redhat.com>
 <b6ebe641-0a0b-40b2-a34b-07393f883985@lucifer.local>
 <8e11042c-0e7c-41ac-8da1-b6c6a1c1dbf6@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e11042c-0e7c-41ac-8da1-b6c6a1c1dbf6@arm.com>
X-ClientProxiedBy: MM0P280CA0008.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYXPR10MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdeef50-0fbc-439f-cb28-08dde16760ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYqF76BfMvT4QZFrhHPdrF11j8OW5f5oVMTv5XrnJi2Eo6oiyuA813c2lLWF?=
 =?us-ascii?Q?brK03LcvFAsLEHBm63zRIJ5kmvmnGGgHeh22KCDUem2njabQ4bQzZ3IaDn1E?=
 =?us-ascii?Q?zZLK+L+lEjhwJWHlDV6y/ADTS5IC0IoYCjDS6f/9wbMV6H2nMUAH54Gxkmhk?=
 =?us-ascii?Q?1FOIqb27Mp7TGEw90xjTculTqYfj4KjD+bKaAXMe9RdAC5DSxZgQ4vXTusA+?=
 =?us-ascii?Q?+L1JlTl3lD0U4KNS/TBcIEdWqW1gQ1/NHpqClAqFbCInZa0oCco73p0lnngm?=
 =?us-ascii?Q?TjzKMmiMnrbU5pXy0Ys7OdLWMmHiIMKtVqbLhOMxrpWt7TiI1rLYBeYCWLxW?=
 =?us-ascii?Q?+lpMIKYJkBaULRSwqKb6yXU0nEK+Mo3qakMOq0QKtKh5inVmWgyjA+zvanle?=
 =?us-ascii?Q?ANZgbbG8XMIecMPJHZlxL29h2C8jo2757/iVGRJKAsNrWAEkSuLlOX0wNTwq?=
 =?us-ascii?Q?Dy3LesM5cpp6yfXkBh6PquMCpfOz7mi4VO8Hoz/zAUrzXQoRqjsPh9Cskr2k?=
 =?us-ascii?Q?940vazE2B9wzImmOdG9qps7Xg8jJM6hmG/w+wtoDdw+pa8yrvdBEmAg7cydJ?=
 =?us-ascii?Q?uiBSHP3Nj86vBhTELzSokGXutwbEEZbh++DSRnndecja6ArAYgopq3W8S+An?=
 =?us-ascii?Q?1E/rmsxJ40K5f1WKbUBSX++/ySVOsea+S8kouCJlybIPfgMFlR2i2buOZE1i?=
 =?us-ascii?Q?ns7f06aHXIFUkzN9kQDVbvMrHH9Zmc/08JPxtSCZZklDGDkM9oMZ3780rfl/?=
 =?us-ascii?Q?z2vnkrCGSd9gmMpGlyi6YGl53b6ZPYKg4puml+2jkgMAP5xrep8QFlUTNEif?=
 =?us-ascii?Q?EyNGd+uCPSruk1y45c+WnpzxrayOBNHSzrHjk+EnXN/JPvMiD/ZoFS/6heWF?=
 =?us-ascii?Q?eSyQbo24SGY08PEe9A9R3BmF/vHJd/AIIgVWm6z/SjsW/M1L7y7m1TFVUrxx?=
 =?us-ascii?Q?zzwm3kDmR3zrbBVkiL/wkh3OkNwq/ukxtTQPDAWZsFA878EZsQFByccjSXcG?=
 =?us-ascii?Q?wLqcVUeYhlNgUgSC+c6M5SpVyt37/7QW0/jPl83NZujNB4FNguDHsaO97rrD?=
 =?us-ascii?Q?BcxkpTiqnDpHmmWtkj6E5TExFB7HGLsXUFV8DD+b1aeqFabCG7RkI1noTnmD?=
 =?us-ascii?Q?NA88rTCCe5pJv7lmSz3ohIeOtqiCztr+K1Pa1l2rtlbxa8mqUc8yRtSzji3+?=
 =?us-ascii?Q?IBfdkV9nSlY+MLK4L45sFjqMPyHsHIPAoCadi9A0mwWdjZ/jDnIBE8Y9jukj?=
 =?us-ascii?Q?JxWL+A5T+Zv1AEcpKavwhzf0WnIoKSoC4rBAtGeF0PQwQMYU5L/wZNZpjUUp?=
 =?us-ascii?Q?Cf9La5+NnaRIBg7w+eJATZO4lnRpalkTIYM+sMpqmF4R25Ys6cZmASNj07HF?=
 =?us-ascii?Q?Iz281ptVNsL/1Xz4WuAqcUX8mA+lrZZSwWP6KvrTAywX7GZTJyJ1CHvXXqE6?=
 =?us-ascii?Q?wOiToO3t/hE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/nxdf/dSnf+9Zhn6R35fdXS7Bf5LCn/p5BwWfehpTNnASAW0vwg9iOcuWmHu?=
 =?us-ascii?Q?5qrHTlrdVYBFtc9XtugrEaYfrgPrYqvgVCKKq+CI/a0w3A3ZdYkczefuSrhW?=
 =?us-ascii?Q?hk1KQFrNmUKNUyOgMmG5Z9XSkeFavCRIidaOQJgnp/GU1wWgv6OzB7HMri7r?=
 =?us-ascii?Q?xA9FYirDnbkSrvtknUuquhh7JsCyDTdP18CgkLnzhs0pkCVh3k0hcLyLa1UW?=
 =?us-ascii?Q?gQFj/uBHrAEXFp8noKUhUdSema1NJH4fTlulxB/kpmRD0BkGySlY1P+JrSYv?=
 =?us-ascii?Q?raZfESEkg9YqNOMTlAPc7JzDqukHxnaj1e5XEx6Ph+D8iA3Un5nrIffJ/O9m?=
 =?us-ascii?Q?3pkU2VG3GZOXfOORAX7fMuaWTYlkXR+zlbaAGuLPB44SndexaXwYp1dl6z7T?=
 =?us-ascii?Q?YJHw0ONQW1Iu7cu9SaV8Qj5mvCK0UeF5hg6UYAsHh2vWb4k+TsavWT3FLglE?=
 =?us-ascii?Q?MnSEyUtl4p77kQPPtUFyEIh2msWTclxuep98RqAZPa79UPOXDEVXrA4umXe5?=
 =?us-ascii?Q?IVBpb/cxPgLEksooUEvgFL5bI7/cHaN7VbC1UmBrtPK5h5PwDkppxuIA3+wS?=
 =?us-ascii?Q?mRQv1Qpav9Awm03UMzX5gns614Z29Yqn8C5AFoJ0tcwpSSJoQEt35XY5SSNh?=
 =?us-ascii?Q?9acrp5bdCui7kNjuirQlUCpr40j/k2ZXI5xYH8myLqk7KoU7n0awI9kyjgY2?=
 =?us-ascii?Q?MSAWQXmLSIgC+KEKx+wrAwyej7ogI4MeEUi2PUoZIZnpRyon075VLfG6LGhN?=
 =?us-ascii?Q?f/NpnbZs1pZWdSbKLYZ7imK0s2oPf9PTKAuAX+4XWezrQc7WMD+y3sJseZzs?=
 =?us-ascii?Q?2h6oygU9bgC2QThhlobapXw9vDa+bpDJlEQd+Ra/4a2tg//7W674szOooZv5?=
 =?us-ascii?Q?PFQuVcSI5Wb/LNJlEn/GgIbZpJ1gR4w0ajTSytDUrY88HdHeX1dlWoSMe9gS?=
 =?us-ascii?Q?2Wi8SOEWsMzeuqJZ2j6y19DH7xjEb68rO4PtaaiXe8kzYCszhQODoiP6t4IB?=
 =?us-ascii?Q?3uH4F1+R0KkJT78GXud6dcDH+yGP9GWyTABUywGh93p5oXN+eCjM0pYiuPBX?=
 =?us-ascii?Q?IEm+N1JjakicKFzu0Mk0uDUed52m/GkshBqRh+ys00Tl1gIaaUzSgWiG1oyj?=
 =?us-ascii?Q?nuWEErK3kaocEsu8hxxmgT1wLjq/EIhAbuImaY61y+o2BH48W6aKUni1oiks?=
 =?us-ascii?Q?ISk6WsBpLgDhWZ2XMxaB3LMK/VCNfsWVFnv8ZkSRvgvgBuK4d7errwQ9LVpy?=
 =?us-ascii?Q?M1848hm5i0ZNwgQEzmJc2kqNH2ZPDYROpCq3pRypGupuJzpIWmVg367/Q1lJ?=
 =?us-ascii?Q?fEfEUV1OijgYA3pJ7FYZ09V5XrCgwNWy2U22vkE5qAMqvYjrnMkEwvdnq7YZ?=
 =?us-ascii?Q?I3uJWVqt4N66w3kTINNwN2zC19Htr3d3Ep+Lh48WZIzj/++TtVZe9lN/MyIW?=
 =?us-ascii?Q?mw9Ajv+hx9LS9vtANWankjL0Mq90rB2LE/g3rK7GTswug6w/er83Mq58D7s+?=
 =?us-ascii?Q?FYNVuW259Sd0secTAfCS9003pgr/uG8t9G8e3/VWe/xKOLLRnUGCmIqYO+bU?=
 =?us-ascii?Q?/m99+OiOcbFcb7HkH07F213C1PNjmEgLNlLmCvr5T7ZbJE9KFyXxDupMgtR8?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pkus1FwnQGwIFcCi3QyMnwU0bxl8RJIHDppuSigRR6FL+7JZF1cyOn3dmtLLnXrjjzlMcsuIHsYRoqoreL+rNwnS4nOzXzngP6ao9PRCRg40h5IMBHzauF6kKtSx1PoJIunzLmf1vc2GiQr0MJyHJCAXeGJ1WRW0E0QexDN0ljpRgITX7fGMC27NpnFU+o59n3bGi1SWjjLOuC/2kKJRIp1EZUIHY486DSY38kQE2DsQwzkrGRyJf0k9oOu33uaVbYOwAFzyou4CrfjjI4wDOkZGB1uRXEHdu29PsypnBDBFU+VzwZItS+dO8L6Bq/2L20ENY3JgBBUMphiDK0zFLHoqizjUGokTMhGdbZlwJCyh1RQJ3vfbUJ+Vv/tkk7FvUYmwG82eAB7eHGiRv7LEauvgb9eIYuTibuutNNxmPLKMp39vlp0Y9f04Aefq3sCUeCICmeftQuZwzgNCEU6Tsccyfi0zIlWSG+xdcP+OjueOhyeAnQOmPN8tjVASrfI+C7/8kezteMlKAadydOZuduQx/iGoSsFFtvkxN8auoyAX3P5bmPLTNUcWII2QesAMS8eenju9SiVC64v6rqj3TXbWlIv8ulKA75rROQEwhoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdeef50-0fbc-439f-cb28-08dde16760ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:33:48.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zRrrN8Q+QuvYJJyynWy3+6CPucCa8AuvUEmUGENisAkNwzfyg24dPH+GdLDUsoCVIm4w5TeZZYnlbda1i6prc0w2q+ApcLoeZy9B334rAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX1wE10NijidZz
 /9qHfRibSGTx6MKvICWGiW4k+/25QJg83O9PoYpZjRajyUx06tb92tbnx1wD/k/h1IOzsZ86zNd
 MNlDEZVBGs9ccg3KaUYZ2s1iljIWwy12s0y/sXthetk0ZTbZUr8u4nLpoU/2VLG03iAl1IBS/Ij
 LHtwmFgJZ7zCg21DGiYJPjIf9dNOilqF1/iFchrKgHzY85BjeAMdtLxdvvHhuZk+ZWcm1xD7sW1
 pKhoOmN/LGhOnQXiy3XhYQZ+bjzfJQVUdHVA3EFVr1M1IxLekpIA1HzA8JGMArEZhwN1ACKkGJf
 Co2/T4KQOp+XHAxCE/nc6JzK83BehwwAPM2nbRAkYMWkAOD8I1dNHS7X7Qyxsfn84IvN7BFoDjH
 JgDEZiF5szgizRK9VSP0eziUtQIbNBxSKyKZ6ySh+lhILHHW2ro=
X-Proofpoint-ORIG-GUID: ib9fCTpd7RjULRkfnFSgPyeYZt2u4tUy
X-Proofpoint-GUID: ib9fCTpd7RjULRkfnFSgPyeYZt2u4tUy
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a84790 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=aYei1u5E-cdDifJ9MrIA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf
 awl=host:13600

On Thu, Aug 21, 2025 at 06:03:52PM +0530, Dev Jain wrote:
>
> On 21/08/25 5:35 pm, Lorenzo Stoakes wrote:
> >
> >
> > > ---
> > >   mm/khugepaged.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 1ad7e00d3fd6..6a4cf7e4a7cc 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -611,6 +611,15 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >   		folio = page_folio(page);
> > >   		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
> > >
> > > +		/*
> > > +		 * TODO: In some cases of partially-mapped folios, we'd actually
> > > +		 * want to collapse.
> > > +		 */
> > Not a fan of adding todo's in code, they have a habit of being left forever. I'd
> > maybe put a more written  out comment something similar to the commit message.
>
> I had suggested to add in https://lore.kernel.org/all/20250211111326.14295-10-dev.jain@arm.com/
> from the get go, but then we decided to leave it for later. So rest assured this TODO won't
> be left forever : )

:)

I think it's better, despite Steven's sage words :P, to put something a little
more meaningful here like 'currently we don't blah blah because blah blah'
without the TODO ;)

But obviously this isn't a substantially pressing issue... :>)

Cheers, Lorenzo

