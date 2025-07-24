Return-Path: <linux-kernel+bounces-744391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B6B10C44
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2272F3A7730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620432D94B1;
	Thu, 24 Jul 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KiCiyJOB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GRmLpmZP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B612D5418
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365296; cv=fail; b=bbIYVDbUiG964VBp4279CknGz+9sPVuS3bwSTHvXL6zxPd+iiHRN1awcecY78Sy40dTHnkd+uYxayxqSJepjzWmRKBMFGSCzc9w7TnuXpHKINb0Ql7VwrlGBUUlCQr7oDNs8sIrUssrzbbXnppW5TVzlTaWLKEGwKAzsOQPoNWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365296; c=relaxed/simple;
	bh=3RdC10VP/005O3ZhlrENNVNPHl2QXkq86RQYUEJc0hU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Xnx97UqfRKHrhcAnoSV70Im8+YXelNzzdoUafo8dJn0sXTu1CEpkviBj9IrHTIS5uV2jPRv7xR9rULdgRX4C09vs1FGkhWPAklaPUkYUr+tN1Fp0DCm1YunhhMWKpGtjoNIgljPna+9agJ6DVnpIgLt1iNxpqXgS69e4DMwuwj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KiCiyJOB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GRmLpmZP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRQRW012136;
	Thu, 24 Jul 2025 13:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=fx/FBiFpWyXU44HA
	Wmq1q9O9CBa5awA+wR7+sMIP9Nk=; b=KiCiyJOBM32YLY2Ktb09WU3AD7XeUfoA
	RzJMz83CIEWB7dyK7C8szGFJUoCwofBy+pXXd2LXUwAf3C+G7D79Kx+2SnycVoMo
	8IvtmOdECy5/WyuddD2knxTFPi1iHW6SXmSuPkRKRLMrigswj2OYDsA3PtrvAJcs
	APypRPrvVgNzhDZRbVhmDgoeUvHsF+ULIDMmld8ZJkYuAeIV4OHr9QkQ5M93wZsd
	b4braFrLYZtVZUAB6ShH8L9ccoeeEBNBwp2A3xI7o3pq/1neRI7kHuj1v2U8iCDc
	L6/W8koMjxTUqc2BWIwwOzg3ea3qyuiC2vDBxQrsygNzCMwZvlmRkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hphqak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:54:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODhsQw011708;
	Thu, 24 Jul 2025 13:54:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbujaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRDMBizyH5jWlFo/KrYyckttHnnoohsQnvbYG9eM3SwwZTf+JqTxwd0hvhRV0GM0qHV/GbT+ikZmoSlyCj9zebSGV26nXfkVLH32MOcqlaCRRxUSQRQ44pKWne1xFrt+TYmpv+ETks1irKJobTKJreE/3jS8EQJjCvJYlUMMprW5Y8JoAO/0YwSUPMLwZ18HAffI2X84j+hTcxmMK4mLu4kZVy4L4bG1QYDyId23AlOtUp1pJC5acDXsI/ttnMt5KMLBZzIVMucd4vIFLnuQx5qqlznfRoz4jKEmVX65X0ASdpL3Il2umeWSPZu5oif0O78zx8/VXwE6A3px831azQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx/FBiFpWyXU44HAWmq1q9O9CBa5awA+wR7+sMIP9Nk=;
 b=oCVeqCoJ4WL4FQ+bP8R4WP3sTsGQiPe1P5xS++7BMeq1AWvxjnFpQyoz6xQ5wyo9kIpdU/d7WKYcKAaFTaEIbHu+XGOs7ZGEkCVjH7TPqxppdLZ3PwWmS8Y1bc3GdaJ8WMGjhaWIXlBBrDT6cmbGl6A1O8cJD2whHr0FxCuunZQdZvv9vEnqB88ImoTa3zrcnj3QP9FufGeBp31M4rYOlvLVndM1c7YWIKC72pOn5DQ4MCD7zHY13778L5qr8R9jiyznlLIWjjVWDv3bW0dAdETIlZy1PH1LQlRsR7WdeqTysUVIw54kNH2d/Jhd/chhnztrcCYfRonESyM37G7VJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx/FBiFpWyXU44HAWmq1q9O9CBa5awA+wR7+sMIP9Nk=;
 b=GRmLpmZPKVVFHGGqBAP72p6qhiHa5KlkAAUFY+nzMNJpQwwWHq5tc6UvdGk8LkITZ8oOmy7XxU9Q01UY213GXZsXfchWQOilpVToyLo05sHjA/d15GuUPy725mivi57sY9RahXnHBiwl2AGTLBkbEdaW72QrnrUrwuE40UKiL18=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM6PR10MB4396.namprd10.prod.outlook.com (2603:10b6:5:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 13:54:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 13:54:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v2] MAINTAINERS: add missing file to cgroup section
Date: Thu, 24 Jul 2025 14:54:21 +0100
Message-ID: <20250724135421.54510-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM6PR10MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dee72d-4fa3-473f-59b3-08ddcab99cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ntjcFIPw2f1kcNMLHVb0+76gL35FUS88FnMce0f43hEnVJPXQ5Gxq9hngdsU?=
 =?us-ascii?Q?HTKZbTV2Eu55yi3RSePVfH6FoRKeBDn9nL72hZS+M4c8oU+ZO28Mq1hpTMyE?=
 =?us-ascii?Q?zp88rNhJ9a9eZl8M3k9RQCVb5+obM/5yHz/YOlfAz57P9Tq8W1/0UXoInPdK?=
 =?us-ascii?Q?m/6TXa8bd+af6PXr3WX/dXF0WHl67nSCsKBowCcrOEOh8UexZdVoCrRo9hgh?=
 =?us-ascii?Q?DpWnvMo7S7yH32u4nUJ7SamulhwmOywkwVUt7cl7LJkViKZH4JQSn/RZ3cf2?=
 =?us-ascii?Q?Sf93HhQtuDln4m/qhRTZ3Yu9Q1hqP2V+rp/5ISYDwoWD48puiffCIhXK9578?=
 =?us-ascii?Q?kM/zc8Ly6VqSmBrzs+tPiUhblPnCyc0Zzlh0HsFS7y+Ch/jjp+im/rSDMer6?=
 =?us-ascii?Q?QbKmnb5i8TYFCaluKIQoYX2I9v48NpvPKJE3xWomDAmfp18+oBtBVke5qmfu?=
 =?us-ascii?Q?UZdz2vTkc4keAy8ylIj0F7B6BtMIYEcUSrc49J4/CARQAF1UBJf6c0r1yB7Q?=
 =?us-ascii?Q?qQGNS8cu9SXUlc6SxKTwYBbSP7g4gcqqHtoL4MkhBIzxBBWIwNna7tzNXSKT?=
 =?us-ascii?Q?4s7BKixGz6qHGdgvuaJfV85gq6IOIHB5v66Vkze5U0dBqWPr4Nq4yyATezDy?=
 =?us-ascii?Q?P45A6ZSOcPLDaU/ZQh5xiRtrIpzCn55PqRlb2bSqpVhP11HQKTBEMn8L4qUt?=
 =?us-ascii?Q?ASfAzoM7utTnz9jxoL1JOeJToJUfh2P1xm10LdvWIL/VEMnjqdKzgtJ8UX3N?=
 =?us-ascii?Q?IKdmwFIoF5DBziC97XaWQEkWmoLRBvi7VJcRyricV1qWuDmqO/t5/KMNvluH?=
 =?us-ascii?Q?xCjg8KfH1/nGzzuqCF5qrRaapo4Qs9JsrUfSxeWp1XjzFb8PCi+9gnTjQytF?=
 =?us-ascii?Q?p0bNU7gwfPL6QfxaTvDxuwoiLcfH/yI8wgRXVn6xnhfXqkYGx+IC3QnEig9H?=
 =?us-ascii?Q?fIrU10fxKBMBCkSMLF70uOukoNXS08OxmkQlMdMAi8YPGdLofXQi2jTnc4uV?=
 =?us-ascii?Q?jTSIE8NzJ6O0J5IOKSkuYXYu5fFAicYa4vFJdtRXfr5mf6FKGJLcpi/69saq?=
 =?us-ascii?Q?gxNKpVetGhCBc8VvcZFWv6pXQwL34nK8hVfKZWYSqxlnwBNQyDr7w2SrDFIq?=
 =?us-ascii?Q?KoHlsoRtWRlUdQANp1iGL9tkQys74NXL5F8wUlfAgufDtGOEndZvPQtWUX4K?=
 =?us-ascii?Q?nigOLY4NJd6OaF5ruskkFvFDWZ350teruMuWAtjUPMmmwGOUl7sij1cl9nOn?=
 =?us-ascii?Q?bWNXeBwHBkdPc5xmWxaEpS6IF2Qabhu1J3C5pGB0NVFZzNrsJHYRuEnNq2UM?=
 =?us-ascii?Q?z6KYscKWCfrbQ+2cQDJQH+QV+3JkUeb4VeGt1d/3VKjkN5OGxjYLw6Cu/jBx?=
 =?us-ascii?Q?QGeWaa+mIMoRKAOBW4Jz7KiCjNIJpQqEdKKYVJkG5Eg5dzodeL4QxPgnWVzn?=
 =?us-ascii?Q?k96oPGyTGmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G+o6psvXHIJ/b3Cj/S/XNmy39NX7KGm6rQXB2dEhVyqhGWmE8j38rumUaYyV?=
 =?us-ascii?Q?D9ib17lB/3pLngs2xHBCxZ73xWOnr1MO9kITiX1s24WXu8vaIIiaz69IfJqA?=
 =?us-ascii?Q?kSfOB7gevNMUkVcYkgRqU3JOyrT4MX/fWZVMdt1TKqOoLsRFZWjLybamYJGU?=
 =?us-ascii?Q?ygGz7ytr4u5+BP3OG7EZTmMphXGchbYcLbDpvJu436OrxgFEibZaBFMv1rEG?=
 =?us-ascii?Q?+uSkXGsAm4zIzRhPltzySSzLQ1TE3zhb2VAV39Q9235KbIQcZbjmJoNrFSx3?=
 =?us-ascii?Q?MiWVxIHoV/EAowtOmqIUvTz5sZjb2rvZqhQYlNhBdM0widpcSVwQP4rt7tTk?=
 =?us-ascii?Q?Nb726ezQh0Py+gwHjUmAirfGlksGR72Yt0PCW0kJ00ugT5x+5cmroI066Qoa?=
 =?us-ascii?Q?UBi5LUsUBeQb6DaXNNL2FAaspfMGFcZX43Jkow90sNsJ7WxInesva8LZRxHu?=
 =?us-ascii?Q?Ldffkh/ACWAwnhS55+NqYDGmFGabYJaLLAJ2fOuC17zhDaFp8I+AA0MSrkxE?=
 =?us-ascii?Q?pjzIxM0yP9IbQYCeBnJdqmh88Uwt/i7psKfiZl/4kOPsQp0gr7Qfp2KCY/tt?=
 =?us-ascii?Q?yZqtsTsMIsZmvT2oxGxSTP6ZAIp+7FZOktx1+mv//0nWzB6lg8m+6NG97YMd?=
 =?us-ascii?Q?ueGHmndlneP5m/S64UyJLjwCVS9vOBIw4ST/4O53tYNmFQSeTDSSKJLiRtym?=
 =?us-ascii?Q?R/Sx3mx54ebLLX5bBGNxFfQprGlh/qbF9EBvfsvcEgiTnF57ROhhTI54k1O6?=
 =?us-ascii?Q?yfLZDyQCvX3GDBySDxRnvIO4IjZNM3DScTaODYUgcKlq/xDPQgG2ossXTfAQ?=
 =?us-ascii?Q?/wdViOz/qUP0kN58yhY1AATXmsJpvAGtnWzOZmpn5EgI+lebGSe4Zlv+wEXY?=
 =?us-ascii?Q?6eS10Dm9iSaRdUtAlkagMa2LaAMesdK6IaEYFQn9rs/sWuxNCT3Ajop7Y7f8?=
 =?us-ascii?Q?fPSSYeb0hZCw2/p3LnQVUo5iHcRvwjcKkeprJNzd+mpxadI4IOCJgvxhFDQH?=
 =?us-ascii?Q?+RxEW1dD4x8nCH3IUp3ByN0bVTrSGDnEUqbnZJkHe693u933ISWwntcyd264?=
 =?us-ascii?Q?N1HpoVKPvAk/6+o1BDX9gYXe06jfTGxegGT93TIXABaytDX4pDdg68+LjnCq?=
 =?us-ascii?Q?Myzn8cxKbzMPr19AsL5aTGDBJk4fWOpRm0tOB3BPbUXIYesygX1/8Ujlh8Mn?=
 =?us-ascii?Q?geiLD48dQz0q5j/wkhRyF9OJcvLksCmQmDT202hz+AN7uw60UyJTBJ36eLmg?=
 =?us-ascii?Q?WI9cjZnP1iGInGHmINpmC2c0T9m0RvUiKLkFxSnYofLdlwUovREuRQnUrSy9?=
 =?us-ascii?Q?RYrBcDKF23gBpp+OotMxmXbOCFgMpGHBl736agEw9rQab8zvJ+otAdQcqy7o?=
 =?us-ascii?Q?hZxXQ9ignYTmeL4o0f2Gs0orYx6tIiFpHI59zZ1A5jQ6NluBzqwXCf2Zg80v?=
 =?us-ascii?Q?PlixV9a7J6MDhcMo0650CpRJ9QstgVCqGIZe5kwNWjezmc/lRZ1knXHBC7vS?=
 =?us-ascii?Q?3+28OiD82LpsOd29MV9r1kObfr4HTLH2wdQ78AQ2bcLLwiansvIiFmIW9yhG?=
 =?us-ascii?Q?meRuNS2tDKieiJPSqfHPAoWMqLrWLOHx+e+uurbHX6GVj4dsjDdfjgLhrJyy?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F0NgaHvQohwegASCELtefbGiMId9+G8e0cmu5kthTw0UaK6zGHgU01dFiOZKGwKf5Mm/g99o5tYCvrqAV17tZ3eVJtVLT6mOXT2V+NDMNwyOHxcHXlTWS6YtVrPP+qkHFVwWzlGY7ZN6DlvMnVkAudqxOa7KZvjNg/l3Q0HtpDx/0TTujGt8lHCHD+fwO3bRhORP0waQbbdb8tgzLP43wzvVz685qRsDvCWMG4fFZU5JbaoM01UOsMtkfQMqIL7L5IETkAl/LpHG7yg19soNOP1AGq8o8wLAXRosB02lXd40uXT25Yz1o/JGz6tGUUmrDjj7+Jedw95M6FAR4eBFBV4AkM/cznlqpUwhjz5VsKSb3SxD+JmJ9EINugn+Ve97nq7eS3g5/xDSNIoXMPJbPfjFAdK12P3tsOzamer5pPuL7qMx1ZUnKct/W+OpdBQTNOvBro5YzuBcDdXX8Bz8EB8n8YL65RY3YXg74/e6SnMETkDFU6dq2eAWBPovqJUZbjZuq1zKNjjByoMmpOZwUx3D//KsROAXng2ViUldaFyIPNqUNxWuDtGZVAPP7xidHiZTft/8tN2gcJtxpjXaq1sWYyE/e857N7GrKZfgsUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dee72d-4fa3-473f-59b3-08ddcab99cc4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:54:30.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgJVYWBZOHa6LWDwUbkiIhlqx7gd++fLy8fKDHpV7zDbn9reyASDnBgY6RKGVv2Z0W2Lct1BjdD3V2KEncuiPJDcG2nzPv8IWl3tqjiWLi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507240105
X-Proofpoint-ORIG-GUID: AykL-hCWDzQ_QXEh_-IbJJLZNcjCM_ys
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=68823b1a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=37rDS-QxAAAA:8 a=BNUERyVmLf8bsFmqDc4A:9
 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-GUID: AykL-hCWDzQ_QXEh_-IbJJLZNcjCM_ys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwNSBTYWx0ZWRfX1AjZ1fWrKlh6
 IqLKfnkaM+YVtPhJXeOQelXh28rnID2Ekoshg1b52Yc0YDVGWue1RRbbYkZlCjTi7TthflDkelo
 wWKmNvIu5aw0lmIvI2D8R9RMQYf1wcpCurolZb1IdP40TwXF9w3kyGmOgALasxuaQ/JmO/JN2gQ
 L8eNfgqCumMVGzzR7g7FvuPW35XNR7xwP4+7GzWpUMdmXmsmrKkGrDObTM40lWXwah+03QGu3gX
 iMrHwwDuEv4CLh0nx1nxX+KtbcAJJcdmSysJpZZ8ye37b5pz+e0CSml0N4a6UZpIcY8UMAkRZXX
 X2JGwaajC3QfKieUbPWwMHKfT6N0IHJBvA+OG6NVY7MhyOGyC90moqZAKeyi+52ueHmSZjFlRRs
 +BcMLPk44ys7ZzOFq/VUZKddJXjWmQ/rDcpMwlzV9LemlE6mJh7QuXoT2HNVnwUkU2aI6OXW

The page_counter files seems most appropriately placed here.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
v2:
* Add acked-by (thanks Shakeel!)
* Fold page_counter.h fix-patch into patch as per Shakeel, and update commit
  message to plural.

v1:
https://lore.kernel.org/all/20250722181409.154444-1-lorenzo.stoakes@oracle.com/

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baea67083b6e..cca9ff3361bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6163,9 +6163,11 @@ L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/memcontrol.h
+F:	include/linux/page_counter.h
 F:	mm/memcontrol.c
 F:	mm/memcontrol-v1.c
 F:	mm/memcontrol-v1.h
+F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
 F:	tools/testing/selftests/cgroup/memcg_protection.m
--
2.50.1

