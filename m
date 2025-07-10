Return-Path: <linux-kernel+bounces-724727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B1AFF642
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516F53A536D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDC26D4E8;
	Thu, 10 Jul 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndS0yYwy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XAEVB/tz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C566267F77
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109220; cv=fail; b=Yo5uoXVePrgIohF+bzdQEZce/pTZen6qmp+QNNH2zt3Exsyje1TyG7pMQOVctC0qtMFQzbWPFTWd/IZxnf8PofKgrogpyR7YxkjMQ3NEtBlrWkg6m5nEPDdBYBDvxoLRJfjNxT/ur8bYlofyCURr/saF38RtfZSJVZBhyOFh3MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109220; c=relaxed/simple;
	bh=iK4uV8t9sGwRtVB5+jPj0Y5ujRplzNwY3m7vtXAl/Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiTHwn9j+gRRBdJhdHHhjTXFwWaCUfuo5cp1FPsUSBeHcRpprQFL2P97qxfoIfJeGtBYqsmDQeVgKqYAuI8YPWVMnpl4/1A/v2U7KkCXU6VdpG3PsEAXf2MqHaNNX9LP8lNpeaG0a9eaAZiagO2fc8wM9hy3KN9vV7fchpwJ9Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ndS0yYwy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XAEVB/tz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0rKlc009976;
	Thu, 10 Jul 2025 00:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3BaTMwaQ1i1/OsOsrAZF6YxXSymikUJQlHjGbZ6bVO4=; b=
	ndS0yYwymg0jBuhyFBjyn64IxsYKzUvUui+sIY+MgWwh/FZQPxeAwnO4CczxJJVz
	biBfy/Do5AZjbeC0DwXKwNjHii+Eoex2QDeIpOSsWfPo3PsAvjOxuqK6th9xHe+8
	W0vLr7WHp0C5yjL2XLjljDmbwNmspTBF3u9+zdQi+6m2wytbv/14BrXgXCAqy+cp
	DmWOc/QiRZgWGZ5C85YQpdyOmusbd03DxQ0yLp5vQdHwbrG+EyDdyl+AgKck/OqG
	XInPRcvSsmxPSLTQudvw89Ls4NoKqqV8JXPo+w3zx1128jU+GYsltar1LuZePH2q
	VnyqG7KjMfWV7j7Stzw9FA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t3bng093-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0gUsH024359;
	Thu, 10 Jul 2025 00:59:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbvxmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqWt1PhBVh3b/ywIuQ5PziKw0PADaBqUE5BZ7RXLe2dB+3Nb4/pcyOx3Aplou/z+lXZUM8jx2CQ9RaAwdJLU0yzG7zEPMgMm3QvcEB8QuLlhG4OUDd+gYwBlkziCTC2vrqfjLdyGaTiHgvFGNG2xqxZj5nwOlwW6ZblsGPln1oElKb+jI1AMCJW71wyykaeQpRj60Xcjd8AgMsgyRxqWLuuxTekZuo/0zw+eE6Sgqa2C8O3mheUo4rDyn88TShfotGx7eBfAhkZHeTvgMe/rv34UMZtBomf+wVcO6OCvxUwtlhblSLEtXCmdX++4Qw/aotv59jBeLQAdpu/27JZzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BaTMwaQ1i1/OsOsrAZF6YxXSymikUJQlHjGbZ6bVO4=;
 b=k58l//xSn1FIXj5VUEOfjVsQ4cBOW1h36Dm6N7vW8hhbZT5lvAkkPnbt2fynaVUKvyAxbqvGqf76oqbFh6x1oNF9Jnek2S2H2NsIIH0ZUvqOdn2Fp1/NjgvITB0lrQicr5ZGoDERYUEZLdfCCTcPnNMe+rRwcVci1pg0QNzr9h++5LQDxkKVmT0XrEEnqnBXehgcmLilJkhdpPQrtg/D8MLxCrAqDTeZ6URVOUDRMNwAvMXMPF4hdEY5cpEqAXDOTD6I51K/JUP4uK1Ix1CeFkcjU8rcJnJ5xoyHLI8TSyl+nSc4nXmFrngC93vSTaBJEJV8lAG+K99F/KSOXzUvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BaTMwaQ1i1/OsOsrAZF6YxXSymikUJQlHjGbZ6bVO4=;
 b=XAEVB/tzFEX+hjP+r5vfeNL7rE3HZV6rO0Gt5qpxsW+GT4B8rtFIInu91deOKo1tiRrr93rUMsdyMW3Uxr4IYGj4hSTCzkIHptZ9d5Auhu9nPM2vE7bngK4iV5+EiJd4/dUW5eUbLBBivP2F2qhw1ISxQT/BzB68pv3lV4jH3KA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 00:59:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:55 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 12/14] mm: add config option for clearing page-extents
Date: Wed,  9 Jul 2025 17:59:24 -0700
Message-Id: <20250710005926.1159009-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: e315ffe4-2322-4b0e-b052-08ddbf4d15e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9xnrBaNuBXfzLqbXSgFA5VEyGx5yLSFgS7SZXqknYeCcBJj1LcVNZM855uU9?=
 =?us-ascii?Q?BhlhPwh90BmAkPy0+QQUw0TKmbhqmECoG/q/xOye68ucpCRma2OyjieNcqcY?=
 =?us-ascii?Q?m1z5s10Mty4Mm7hFA62/Uu+wMNMpSFdOYeoo4kDTIbtX0bNDEac35g37fUnQ?=
 =?us-ascii?Q?4x0CZDLW52t82MyThOdqOaEM3i6T0VFzmcl8UUIzq++Fce+1UVM/8k6NQxAb?=
 =?us-ascii?Q?9ykOAFVmsSYNIDy6eOgBQds0v6+x3fhwKqi5wHLHGdE9G5cWYfSFb50MSXLz?=
 =?us-ascii?Q?R0GkNDVmVsT6wYgzeRp92u8B3PLoMxsiT9qITqk/DZ9Cx8TwAAd0Bnh17F3n?=
 =?us-ascii?Q?6R3ZSEEu0LZgksMNdcrUaa3hJ2SdaFm5khNLyTaNIM6wMpNTqIhTG/t0/Y+S?=
 =?us-ascii?Q?n46qQBKJ3npCMuHuuGJFRnpB1OA/FgnS2ND0c876KoPetBWO8ysz0B/cCUPq?=
 =?us-ascii?Q?EoBRUkLuM0wHZ2OXmzyVh9njPZ6DRb0wGZs4TgivF9qGgjyTSYS33GwZ5zzi?=
 =?us-ascii?Q?0ZWEEooDDZQUSfMNfSPLnWG0SXfT0eTP1TlzaT0CvF/y8fT4WQldyobgLF8q?=
 =?us-ascii?Q?7ZY3iHAIfHK6draZSWehDGpgEMBj6QW/6YTL/+bf69PmlldA4xk7voy8ayLT?=
 =?us-ascii?Q?xY0heFR/h2mhJCBxlprVSI96vbmNx74VQaQneH9MVkjdsb89QQQ+rOemN/o9?=
 =?us-ascii?Q?cFEXxjb9WyaUvTJ/TeUBnqxCVQ/NAb2wfTkX49AQe/OWTYHr/WZP7409gTF4?=
 =?us-ascii?Q?iDDEZtW5JzA5aFWUAHYkNFjmKxRGzsVGf/RLxt5qN1kYkJXSuK2PsZUiZ8v+?=
 =?us-ascii?Q?OfJA/05c1Epkk3LtMHhjU0srSI9KuHMSZf+jfaFyrJ/K7DWhEFvtsVPrChEu?=
 =?us-ascii?Q?0ErOcuxc2A0oVndj9KTX5sRjWXnJlkt/d2IE5YPZGY+R/jwG6JKfSlpVSRyl?=
 =?us-ascii?Q?Z07yvOU2M0JJ4HmoeVJ/ghv7oNWfc38RUo5BHndNftQ32SghHXQTdCOzQYdY?=
 =?us-ascii?Q?fKRBm+nStmRYBjiiGSTgDc9AxMDzTFV5+iurMSqKJ++wa4OUR9x0fZWcJlVt?=
 =?us-ascii?Q?5DVkcvPa/3Oz7jFBMEfyoWqnn+67HP7ECu49aCnucViPv+gij+mPy+hLe3Ab?=
 =?us-ascii?Q?qWRtfft3x9izFH6LyOax5+XFdianyN80ALaRBT2DgGWiMSMJdbDooDsAwuHb?=
 =?us-ascii?Q?62cYwSjl7EM4s5e6tTdy4TiFKDU3n95xMB7ucxIUodnouL2lHsR7jQ9Y/r2g?=
 =?us-ascii?Q?PXsB6nu0nLRW/e0hFZ/fKzNkn4WW7spDWbq+Gi3cv79+ICAXW55unf/Rjqxs?=
 =?us-ascii?Q?Qh+YpMDlgZVIs14CvU4t14e+lSYAGMbpNJZl9ONlfVv4hrirpiw1cXPNmIx9?=
 =?us-ascii?Q?/dUUyoAFsoNnbTlm7/x4aU7c9Q8WQgOeq+126aUVToZPCJQCPq1pPLjpYEAz?=
 =?us-ascii?Q?yVgEXOJk5z8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bG+JXclvEGBTg3keAxqdLi9ZFEYL5xqEGqiML2j0osbW+yHDDxzWtWiz1zD2?=
 =?us-ascii?Q?37NrQeYMIozIsA+kIqv0AZCxm3bZWysmnEptwWj3/jk6ZjTZ+25ZHqdO9vo9?=
 =?us-ascii?Q?D/lwVre2OTuysWYPCFMF7W0Yx3jeWyZBWHbCdrIjZHWdKrqNJax9tzrvEwI/?=
 =?us-ascii?Q?pfd1rTtCDXIO8/c4nHp9bVEgU5HjQkgMU7S2ocNcpqux1425EgxAM70oyQIP?=
 =?us-ascii?Q?mRfJd9okpTf0gWSyDNBjwUTFBauU4BdL4YIkbiIR6Kgt54UCsHC+bhvO7ztQ?=
 =?us-ascii?Q?ZQW2giApY3VLnMaK5+LvTIUoXAEqeNDkrROFIjx1SqbMVNDkObZukTc3W1Av?=
 =?us-ascii?Q?+bpN0K4LmJYGJ0V8Q2gd+A3Ki1B/uhnUAbqHlgOo2j6MP+5iLtR98Y3za81h?=
 =?us-ascii?Q?wMgfvgTvFMUidYPk6Ne2kFrQ/XffKHjLNVSxjUt1Olh+8lb0HuV+NCZS7p/6?=
 =?us-ascii?Q?RcegnoGYPxshOYYfJ/rsSGEDIbOTzaAsKWt23Vo0K9dE+DCsoV5dJCm58CAu?=
 =?us-ascii?Q?Z3wL2z40OOeOWVtdLRCDmH5AvX4XUjtkNN2XoIkkvP7BK4hVwC3H8g+uzLYU?=
 =?us-ascii?Q?U65rNJTc6V2mPGLBQvXKt3uW5+oLcQrzDpdj/NQwYmHEa3kRvsvgQRXugILW?=
 =?us-ascii?Q?VFTc0ZLcQtmHCHUEKgxLglOnQ81WUXQkyejIr2v/iRVFzBBc5blkMNH6kdhE?=
 =?us-ascii?Q?c2Gxu3tjkgwEQkNNuYf+bVamO8Z16YH/3fntLtJoagj2dOxrF3fkV2OKBW0U?=
 =?us-ascii?Q?pGTVYbSEmDsFgkyCBdcJHHqedgaIQ7gFGfZj6Jsd6hMTz/h9tVksrjMJYXYt?=
 =?us-ascii?Q?ycyMLd8R1EIaZfZa/Cp8o3LWawRasDAruHC9Sej+uYvzi1xMIodphHTpkfwE?=
 =?us-ascii?Q?15rdOePOSFmAvCXU+4byG21/d9dSje3QheQe4c7RDpzXtUCZhQX4H3n3hqQR?=
 =?us-ascii?Q?W7fN+s6+q0ybm5rHT1j0EyiJ4+NpgrwYMMT3I+CC3ERAR/LIsVv3VHn+c6is?=
 =?us-ascii?Q?n2A9xj+0VqFSWtjrUWYOVD0Mv300IUsiN/xnPvaWR/DBd1TQAI5kd49+GaMk?=
 =?us-ascii?Q?ELry8PDzYIfbxkDJgsOXZ6cu/fvttYkg09Z/1CYkf0wJRiZ1XsnuZOcDapHl?=
 =?us-ascii?Q?bxEFDHBbLV9vANu7TAN/AWhqyHiQD+9Tky9CQ5fQ9d1FdKuh9NWrmFCylhK7?=
 =?us-ascii?Q?W9zfezfcGiw/DSmqk7IOT3Hwie6utBUGOHWmywYg/cXrgCQURKw/6hd1KqcJ?=
 =?us-ascii?Q?zE6GSpObDp4fetBk74E3rTLH4lH8nV0SPN6CMb9gx5bHUuiuO/ik1coDjz4W?=
 =?us-ascii?Q?jBEDoeO5yx/hTHztwDzp8HSw1e0zXsgMTgK1FHWcaJ/+4/uSW4VDsKzMB9zF?=
 =?us-ascii?Q?VgEx/owY67zyapysXDbhnUrYoO/pfc1FN/466cYYcQRbtCvyXLh8789mSrs7?=
 =?us-ascii?Q?MpH9w7wtnWqC5Zkr7tzZd1RFpkPONfp2KV3/2epM6Ushl/OV+fBb3mK7b+yh?=
 =?us-ascii?Q?ZngretbD3pc78HCc/umMfATCgh5gbs2Mxe+E8gGOzP/oW/rrysnf4sJbV8et?=
 =?us-ascii?Q?ZGPW0rnZ9MOmy3MhwXZ1V2iWGzvp7GcBkuLesBrmXPPE0BdfFVtxWNmAUGY2?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EoYXDRjW+zyIFvcXSN31k9yTxeucMioZNr1zMuj9WnatYiiblQBp7F8eR14TatFHJdGGQT1SPO4hoDk0X1QehloaqBID8dY/D0725c2qIrg4mh5aBPKYxyRpxUyKImOeRjuwur4HWer9Xf7XQvU+geVUZ++9lTgZfk8Ok8yABo9TNnZOirNT056qVGbmn1ro8gRWV+lAHlVcUKKLHhdG1HyHAjke5TNqUu2LkF0COmXG/gDINLzdhgwMP+tQg3uCKf7cBHUKlOQbt0Qiu1VhPMkrMQWzduH2IVIzF115Vs6yBf7SNonFuQv/ofTPZTxARCgCGLYCBWOExfJb21cuc/10+q+B8bEqMkh3tPUs3ebvIl6ZoENYJ7lChCiYVNwGZUgeXlY1KjSf05MJB6gC3K8gZUihKUgtvtLM3glSeUutb6u+ysjFTdkkGTkOuGEjvA5vxcuQWHdw63mvrhPvEXbbp5ixFZyA3ML8I2yGaHBz5RE8KT81+mOuRg6Pml4bx6BVF6ur5p7wL9BmC/0ZhApwRaDFK+BXc49PSbmxLj1dDU2DtbOYixUcZMV1cE0RHPjHbKeuJVRJHlsP5ulrZiWtb24KrlLis9XWNvOn0Hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e315ffe4-2322-4b0e-b052-08ddbf4d15e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:55.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ntc7QPjn+zw1/QHVpd9o3Y8WjTf3NV1jGXQmo4J2skgP68txmwu93KL8Aqw+1u1dlldhISTyePXMe6AUKYb7/U2qIrIzDn2HKejF3HhowK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfX4FWsWnMwooE3 c9mSrbcMq5aa6XxmaM35/tY8PUxIHeSQkEAySiV4tem5Bi41wZXXzkxJSVpvXAiaiKvsI24u+2t Pv4ocDCQhBw4Dv5Zd/kj8UEpXEeoaTnDGbBsye/nROwaE9YVeYpdYcfShx3d68czRmx8/MANIv2
 j/ZvQWRFx9mQMTrQkgYcSONmKDTcmaiE8yjx1wcHzdi1By02NH44ebHtgBTgpiWSK+Bekwnvgj6 e07S7VlWOfjMz6HiIaj6JCZBkjcRfWsN50xHwH0tjxeMwXxvKojvNMGJ2HYzuEGwFoKMACuDOCj ctcfX/iSEBeDt/v6cYM13Z43UVlnRhwgQSpy9zdQaJUqfNAGNG5hUreQgbRwkUhHFOnMJMWWxi4
 qrAHkQlG4ZWLUYkx2fa0iAcXocSIDMGjquYErte/usa+2S5FLt6R6JsNCqvTT2lzuYmknyCt
X-Proofpoint-GUID: nOA5bkkWxeRww5vnq1ydOh2efhrT3Nnw
X-Authority-Analysis: v=2.4 cv=Sdj3duRu c=1 sm=1 tr=0 ts=686f108f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7JCkoe-2NP6uNvfLALkA:9
X-Proofpoint-ORIG-GUID: nOA5bkkWxeRww5vnq1ydOh2efhrT3Nnw

Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
where architecturally supported.

This is only available with !CONFIG_HIGHMEM because the intent is to
use architecture support to clear contiguous extents in a single
operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
which excludes any possibility of interspersing kmap()/kunmap().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 mm/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..a74a5e02de28 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -910,6 +910,15 @@ config NO_PAGE_MAPCOUNT
 
 endif # TRANSPARENT_HUGEPAGE
 
+config CLEAR_PAGE_EXTENT
+	def_bool y
+	depends on !HIGHMEM && ARCH_HAS_CLEAR_PAGES
+	depends on TRANSPARENT_HUGEPAGE || HUGETLBFS
+
+	help
+	  Use architectural support for clear_pages() to zero page-extents.
+	  This is likely to be faster than zeroing page-at-a-time.
+
 # simple helper to make the code a bit easier to read
 config PAGE_MAPCOUNT
 	def_bool !NO_PAGE_MAPCOUNT
-- 
2.43.5


