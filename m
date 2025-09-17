Return-Path: <linux-kernel+bounces-821134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F84B80854
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F89A1C26E12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1E33AEA9;
	Wed, 17 Sep 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YpSnufRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JKmxrDFX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCA335953
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122721; cv=fail; b=Tq3FLYgse/snTmL8rUDblLKB+ZMyhL0s8kGxifIDxD/VPqUCTAghdzwJNVWY+tLB+kxrGR8YfRxUv3RXX9+dxNulgswvtOZhoHipYKy8LctZGT/rHv9o940H9c046oH2+NJbtbjw1jFsvN4l5UrrmxRUGQx8fvlPj43s7DPv628=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122721; c=relaxed/simple;
	bh=va5PjuVET7bMg9lutx+/F8phNNFvAW8z8zgI/Z/NEeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sElhY7Tn9PytddMcxnweHOV2TaZMbn+QXeobXsGape793NGXrf8Uq6rz1sPvhIc+f5ZHe+45VphZVhlBG2jAn1MFuo7VgzAc/NH3UZaa2nnIRNGC3s9cxRXXG9GbrGNokpgKZ7XV4hSdOCRBQ03ymQe9F89g3zXnYsGs7YXNgx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YpSnufRc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JKmxrDFX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIVFD008348;
	Wed, 17 Sep 2025 15:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fwqg6TK1hb+Lfr0elQAUySw4BRRSEzNjjtEsU0h0Mb4=; b=
	YpSnufRccd7tNvdMS9kQK/Aj6mGtvOP5q5oOomKscdQxkUr8khl5h6/sCj98r3f0
	Qj2G45LGRDowRsnguvYOvzROccFAjBkjj1KrADzkJiv5s+lWg47jAQGYKSQtgP+j
	DZEG9Eh9G5nBcuXn6hjLOCXuvXF/8+Qu5R561wCZDzkGbhGSTN9S3RQoZb5LvIXt
	Unb9sxv3lJK4gbSHbNpofjququi3tGc2HfVkrLI9EEBJkjEO3oHj/3Q8nJvApRkl
	czuNcQl1b2a1w11VzE8HeNCIoRZJOBqO+OyUozSPpINumDBqZBi8fzIO31ctJYdU
	ZsQ1rSL8WREeReu4GWr/kQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8hfuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HDxEIP027229;
	Wed, 17 Sep 2025 15:24:41 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2m7116-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJnFRKk8r/W2ljLb66y0rPzX+V4WAzMy38MIHir3G5kLXRre+6NjcfAohVQvIq5KO7fMzw8i0AxXPSJq9iMxF60PRgtsY2DQdFkpVrfiQ2PzNZ/1wFR/5tSC47Dwu4nIzt7tmHJgHo3IAQIDRbgCOjsqS4k7ePS6SuKRHV9BW++uA+ODlxof8kPVxQCURqHBBmWJ//o5+zO2m3pC+C+BeBiJZInWh4ezXL+a2BZIM2ruxQepGG+V8rgj1FXugRnm7aObXWVEcHeF+HlkRUeRqQ0h+lTztBLTUbGduIQD3IGHg5bw3JXliUmChU+UWrzPmPCGkrFI/2zoumLRCMXl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwqg6TK1hb+Lfr0elQAUySw4BRRSEzNjjtEsU0h0Mb4=;
 b=prPH9BZJqif7wMsp45y0NQlysFN9/LNTEKO/Bpwwlletpawe2H7AlJ9QZmp5d30wxGZtSON5tnj8af4BQQfCwZsMNBwKLeU5WoA36YrS5aUfVdFbuTIrw2/cqlZHcIUTM3Bsn/I75ljCNYtTbQDhvUUxD+VcfmasAmOzHAy0yLGmr95ykpbypr7iu30O20HlqEBA9l310vKHXLHbXJ/w+1cDVPuA+hjxd5WB2C60Wshhuz6+kqbRQg0vQOegr5Q+g3VCITyE8lGwm3s7cuU2G3u220Cj4fhQt5JwO9Mg3cxCCEfzKuH4Tbuhd4mzF8NUZXIsIwC/EircD7cXaa1I1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwqg6TK1hb+Lfr0elQAUySw4BRRSEzNjjtEsU0h0Mb4=;
 b=JKmxrDFXEm83OYehBArqagQ6eG+Vmfje3+w6BwlWHUIeNHzae85TiMj7a3qprJuDi7xjKWAKMS51HE6MMrt/aMnmpXVv24tuiu5ywVVoLPwGCx++IMYn/fZe+lh8npwSFaOiErIxFgl64hwzCV2NvDLrZSYibc0rGKr5Ks3Q/7s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:38 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 09/16] perf bench mem: Add mmap() workloads
Date: Wed, 17 Sep 2025 08:24:11 -0700
Message-Id: <20250917152418.4077386-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: a956b466-59a6-4a5b-a5ec-08ddf5fe511a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZkpScP8/DCBGkX7w3KZu2+TfcRHzIngiOWi1axnvcvM0bEptp7tjoAiQ93jq?=
 =?us-ascii?Q?rzYbE5DAI17r0HoimjVNhlRe1hdLVx3bzJdvRJ4KNQhMo3duHh6JhD9SKr1t?=
 =?us-ascii?Q?n7yWrRBL0OED3RneoJcNJgeR+xEq6LNb/oHsrGeUBq5Lrz5SMdXKtTUcogXm?=
 =?us-ascii?Q?Sjk82juurJkLr1YXG3btsfsn+f20zbMWc+Jyc6VYhn906Pt708gMrSZ9yCc8?=
 =?us-ascii?Q?zRaa8EFWpGqSPXZVYYK9XwtUkW9mjBrhJxKMD9d2t4pCnst/8GDXc/JGkBFh?=
 =?us-ascii?Q?rNtzo+MazNnzkcGwQ+jA+4sJ9LtI8nVlWvRsMi82U/ticA64ZCVfyGsvMllY?=
 =?us-ascii?Q?2wHg1qg92Y7s9F/TOk/5kCGLmSheUZTmYvRGKIkfU8us/meVcvmImfZ81qhI?=
 =?us-ascii?Q?2/dIBrQExSo+qK/H7I3PO0pshpxt/JCPOW9vxCKMNK9pHE6h6cueyAqmmkZh?=
 =?us-ascii?Q?HUxlD58M+oItjI2NZR7YFqduTlnS088Uc2KrlwV3BrgGmBxH7iDTLoIt6kBJ?=
 =?us-ascii?Q?juqUd9+Z49Aitj2cpcEhvXOVsiJBUE1SAtlE+N2UmSIorEakQP+uoAdDbnoz?=
 =?us-ascii?Q?r46RmHl0grSt5PCPz7Z4GcVXyRCUMD6ZmoSwyL1GFZkQO3h9kh056wSogHru?=
 =?us-ascii?Q?oJ94sVDsMTNuIJMcjp68gZyVENdNKLHVEleM+H+ItBl06u6GEZ3awv7B4C8H?=
 =?us-ascii?Q?l0hCc9WEIOb9Mc6xmUOG/rLxl/Hlq1GDpHGwztJg/5wGBsyO4CVtarUpo4SJ?=
 =?us-ascii?Q?quvqpcD+1fc2XDtHKdxlYwsID8Ao+FEupzVU1TLWYXssQhPFCfsxaPCngbNj?=
 =?us-ascii?Q?NnF7Jep/jm/D4N/gFJPO0FebXdyySc58Lyg7oIJghbc/mdC+RkTdceuSRJq1?=
 =?us-ascii?Q?U1IUUZeGJKheVTbX3+YE+SA+jptmQ91LmR6c1SGa3QGEDpZZawSDqN32vGim?=
 =?us-ascii?Q?PdrBQQ6wEoqq4WUs4Zz559G1N7MtzbwnvcitBfVjC4XzlNKeI7I1iWukvgYW?=
 =?us-ascii?Q?bZdgyN7z+w0Bop/lqNFE9YFx7j2uDJYtXRYp4XIMMpgZy6auUiH/1bUhcVfn?=
 =?us-ascii?Q?h0FYFkODFD0RcnnC19iY2n/fUjVVMDb8i2XJhzw3sbTD0br+jE7t0kToaA1y?=
 =?us-ascii?Q?Oaj1WJZ7sOij9uyBNuvTohYMs3iITfWwppZCDrmnJ4nyKRYtrRD9LAFtKMfk?=
 =?us-ascii?Q?s7dHc63B7cFvTJVOQ1oPOw2xs1vubrooTmfYSR2Q5mNLVmfYfjjY3ro4SQnP?=
 =?us-ascii?Q?hpsKCSf4/tRny2V4aSK3udo/sOyDU+29d/P6dxWfUNg/9cvEn30PKbgEqwqj?=
 =?us-ascii?Q?ERp9e4WxFAWKn5Ugkifcf9ix9yI5hWg3GCYY8Py2TjWTgAt55neTCOHgOw3l?=
 =?us-ascii?Q?Xu2MBYD5/cQ6TNfResQ9DBEIj8p4vEPmA/ysEqJ5fHvZYxJiHRdq+UuVHb3m?=
 =?us-ascii?Q?AHwWP45Qdfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+YNZ+/GCulAxwQ/SjvCg8cwxBY0auDMkJzRi/iT8Y87VTSPghoGwpbexuw4v?=
 =?us-ascii?Q?YEUFLSHuYx5tC8lXhnfQ2fYqDzXbAI5x8kL0bj5yJLIH+/t7gfLbo2lUBhJg?=
 =?us-ascii?Q?SV7kjtuA4YPq/l/bXo6tIay3K5dqtGweVaOhPq8txA9XUGdAYmcv6v9UslRr?=
 =?us-ascii?Q?3ZM2OVJXRN9mTabKfN8edOcfB/zXrdicCs7ijzq8XXkuTw/QBnGze1kBrGTC?=
 =?us-ascii?Q?eLo/pbebvAbionxu9+FxQTm23XSRYz/GhwuQ99duk9dL7pjpopU2xnG63a+X?=
 =?us-ascii?Q?5hsdWWoXaunbc85+iyIlP9RL5fUAUtkTE7bJ2qhOvEEn7oDSsSVpCofDcdp/?=
 =?us-ascii?Q?65pKGEHYA/zqdHAIoc4axmTfeWTlH+Zh3Q724r8S/XWtzeFR/DV1FI13CngE?=
 =?us-ascii?Q?D1yLgnKpi9helu1qvKbzFCtdaDzbmxegL++XbNKbexiray2V4Ovm1Ceh1fpl?=
 =?us-ascii?Q?ITYmF5DKCldQFgzKlf0EdN+3ymSB0XyrmhL2SMZUH0P1b92SuE4MNRGZxe6I?=
 =?us-ascii?Q?QHafFAnF+hBi++wfSPh6DAMp0nyQhgQFQbosEDqyNqYx7ElmB8ctvWXzU9pw?=
 =?us-ascii?Q?dpcglneKDdxYK2quC6BrTbcys9DU/FDZsyPjgxzZ3JrjGDrJaOKSFqJcFgQX?=
 =?us-ascii?Q?5BKYGjHOTBEytP88RY6EEcH7WZbVq+yip9xc3YMQKq93Jja8Xt8GsNf6HwuJ?=
 =?us-ascii?Q?RF+NuGuY8PywNO0HIyZt0u93qaeqoGfzhkg8zq5RCea+elH6VPjgn5UjKFKK?=
 =?us-ascii?Q?/qReOiD7NjVAcWynlGU5Pb+uXX/BL49XBaB/9dACVq3AQ1tfDhtqT5jCLVyd?=
 =?us-ascii?Q?L9aQSYEe8HfFD/KNPZjbIFKFKmZye3d710b02AKy7EJuOueZ/y3Pfi4ULtHf?=
 =?us-ascii?Q?xgy5jLEBuCQugRJqxygExZjrJN1N64Zl9Z19gvErBPwY5LKG4uyzGqIwkbdz?=
 =?us-ascii?Q?035AV/w3JnMU+XpF6h5LGlblWVgtf/VMcbiWUynDLGmZkd9wL6qq0/vAi35v?=
 =?us-ascii?Q?zTOFmgtfKxf7mf12ZwBXf5Zx5iZ0BARd3Zx8t2j/EKA9eJ8fOXEjZ+rSOs4W?=
 =?us-ascii?Q?LP4LzJK25KY8Cr2qFkeDzbyll0VHOuxpR+xQ3CcgLezDOd2IW2UCA10h6LcF?=
 =?us-ascii?Q?EWN91AgpjhwCOjffkrpkVUG0afdA01OfkolIVq9E3sZfL+OlPzsfVUpnpd4l?=
 =?us-ascii?Q?Yp1RIXAUru7/qQgJnYJ1tDAixvwil+S8MVk8iEX+aRkP5EAd2PnhCn+E4p6n?=
 =?us-ascii?Q?7xlgQMP7cdYiM9L8v4Eu8pUj2cZiCPlixHmeqEq3VbSBrBbd5Nucp7n4P4qB?=
 =?us-ascii?Q?oILnzcVPW+M7NelFWz38gP4xhZZycW5Opw+jf4GTGqMxJx2rXAMmR2RqLv8/?=
 =?us-ascii?Q?Dvie5S3KcYSeXTRHKBOvMH4f/moCB8yNTqB0xwfmnyzGBL/50YeuQmgbEcMl?=
 =?us-ascii?Q?hMnGrymjpsDOxE3dJ0Gi+Tq4VrJkETESO2L/+1UPNz1KJY/Nkbl/fpaF1Zdw?=
 =?us-ascii?Q?SXLXXIWxonIwkjx+k3sN4NbhCjnaCVFePyf19FHxf3cpsoK+UUb+1xdBK8+5?=
 =?us-ascii?Q?HBr8/dG1RhmqlHL0MuW6MZVnPEhbQNrNJstIFQW64p4jVP6Hx/q4ZRfwX2Ko?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TpvOQLSMyTOt2RhKRpIhsbPopfk1P37ogZVv0wPKI/NA2ZWLr2TcMDfo77IQJKFWVWLvjlARVuZLRPgEpsbF8swduulgsczBRmMpid3do3grT8BAAo7knYglaka3wc3VaXc8gJZJIqb2VYwMFvtoxyVdPSQjL0NXsZ7+GSuOBfTJT4RngVnojeWRtuyypgfqc7KLC7YvoC9ZQWW8TwI/ly3xpB/g2yrg+VUKn761airsbfw9z0NPIBRd1HMcG/k5k2s/Gd7PHb00LjMoGTEpyIGbftNBHrt1miJmxWZP8Rc1s+J4vY1y6v5EZFazqf9UTeYO5WdpDASjSopo9Lo8HkB4RJ0HYk2iXc2JG4BiDze6UH6EWu1wU/hIYnEtMtbTVAXyXEsyuA+Y0A3Uqd6i20n/OfHVL4wqUXB0t6wPIJ/jUXiuZjCO6e8BdD8Sxsw5SLU2KRKXkuIscUC9pa1rBjBo8IENFIm+dgMLyzQcWJE1T+WYJNh+E7VqnXpNg802OxNpHGN5Sh1gGAGXkZjv24TUD9VVRq68Nt08ALY9XjsS5NKbdhAsd7rkMg3lpFIk+9vMcCR4tXHqfFI5gzFB6/+plrcj26IUt3dm+xBzhtM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a956b466-59a6-4a5b-a5ec-08ddf5fe511a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:38.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtCxlJvBN4GNZRAct+72PMPvwzqQIJfmMjuck/5kra0YJDC7ta8Yt/sZPGGE4fnFEChwctb85xEwMB7Xg4erSzHV2TpvYLFxOGQgqtK5Wgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170150
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cad2b9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2MWhjARPlSRgpm0SOp8A:9 cc=ntf
 awl=host:12083
X-Proofpoint-ORIG-GUID: Kool9WOgdaC58kFuojGTvFpWgrEVhTud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0Lzpqd14QDSG
 GG+xmMOio5QuiR2yGYKlRtpsLAxTiiLFX2YtoJKEaJbF9n/SNGRqnEHruWZmjBLi+R1J6Mq2kT4
 K3iNPi5FACbXGx6+yBz2zsNCJpnMQ3rkrQRF71AXPF43C9Dv9Rx9lf7dF9Jy9h8af41Vj2peSW/
 6uOneoXqxmMii1iA8ImKgIqD5Vt+ypxUFiAVk4HsfDNMAx9ihdPT3pHqaVhy8KqxFDCnnhQZBeD
 qJJq3y05+DGFr9M2X/YSeLXZJvXUxNa29IwpluEBLuCNWiLTiZUxojlIygyno3xF6L00wLIItRS
 7Lv5MQMVebMiBqog5Su6ztEN10pbJaGbzQbC0RxdsbliAN8y1Rb0M974C9waoKDMHguClpfoLId
 QXivmCBJmEJT7oLiRIQuMsV0izq7Tw==
X-Proofpoint-GUID: Kool9WOgdaC58kFuojGTvFpWgrEVhTud

Add two mmap() workloads: one that eagerly populates a region and
another that demand faults it in.

The intent is to probe the memory subsytem performance incurred
by mmap().

  $ perf bench mem mmap -s 4gb -p 4kb -l 10 -f populate
  # Running 'mem/mmap' benchmark:
  # function 'populate' (Eagerly populated map())
  # Copying 4gb bytes ...

       1.811691 GB/sec

  $ perf bench mem mmap -s 4gb -p 2mb -l 10 -f populate
  # Running 'mem/mmap' benchmark:
  # function 'populate' (Eagerly populated mmap())
  # Copying 4gb bytes ...

      12.272017 GB/sec

  $ perf bench mem mmap -s 4gb -p 1gb -l 10 -f populate
  # Running 'mem/mmap' benchmark:
  # function 'populate' (Eagerly populated mmap())
  # Copying 4gb bytes ...

      17.085927 GB/sec

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/Documentation/perf-bench.txt | 34 +++++++++
 tools/perf/bench/bench.h                |  1 +
 tools/perf/bench/mem-functions.c        | 96 +++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |  1 +
 4 files changed, 132 insertions(+)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 3d1455d880c3..1160224cb718 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -240,6 +240,40 @@ Repeat memset invocation this number of times.
 --cycles::
 Use perf's cpu-cycles event instead of gettimeofday syscall.
 
+*mmap*::
+Suite for evaluating memory subsystem performance for mmap()'d memory.
+
+Options of *mmap*
+^^^^^^^^^^^^^^^^^
+-s::
+--size::
+Specify size of memory to set (default: 1MB).
+Available units are B, KB, MB, GB and TB (case insensitive).
+
+-p::
+--page::
+Specify page-size for mapping memory buffers (default: 4KB).
+Available values are 4KB, 2MB, 1GB (case insensitive).
+
+-r::
+--randomize::
+Specify seed to randomize page access offset (default: 0, or not randomized).
+
+-f::
+--function::
+Specify function to set (default: all).
+Available functions are 'demand' and 'populate', with the first
+demand faulting pages in the region and the second using an eager
+mapping.
+
+-l::
+--nr_loops::
+Repeat mmap() invocation this number of times.
+
+-c::
+--cycles::
+Use perf's cpu-cycles event instead of gettimeofday syscall.
+
 SUITES FOR 'numa'
 ~~~~~~~~~~~~~~~~~
 *mem*::
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 9f736423af53..8519eb5a42fa 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -28,6 +28,7 @@ int bench_syscall_fork(int argc, const char **argv);
 int bench_syscall_execve(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
+int bench_mem_mmap(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
 int bench_futex_wake(int argc, const char **argv);
diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 2a23bed8c2d3..2908a3a796c9 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -40,6 +40,7 @@ static const char	*chunk_size_str	= "0";
 static unsigned int	nr_loops	= 1;
 static bool		use_cycles;
 static int		cycles_fd;
+static unsigned int	seed;
 
 static const struct option bench_common_options[] = {
 	OPT_STRING('s', "size", &size_str, "1MB",
@@ -81,6 +82,7 @@ struct bench_params {
 	size_t		chunk_size;
 	unsigned int	nr_loops;
 	unsigned int	page_shift;
+	unsigned int	seed;
 };
 
 struct bench_mem_info {
@@ -98,6 +100,7 @@ typedef void (*mem_fini_t)(struct bench_mem_info *, struct bench_params *,
 			   void **, void **);
 typedef void *(*memcpy_t)(void *, const void *, size_t);
 typedef void *(*memset_t)(void *, int, size_t);
+typedef void (*mmap_op_t)(void *, size_t, unsigned int, bool);
 
 struct function {
 	const char *name;
@@ -108,6 +111,7 @@ struct function {
 		union {
 			memcpy_t memcpy;
 			memset_t memset;
+			mmap_op_t mmap_op;
 		};
 	} fn;
 };
@@ -160,6 +164,14 @@ static union bench_clock clock_diff(union bench_clock *s, union bench_clock *e)
 	return t;
 }
 
+static void clock_accum(union bench_clock *a, union bench_clock *b)
+{
+	if (use_cycles)
+		a->cycles += b->cycles;
+	else
+		timeradd(&a->tv, &b->tv, &a->tv);
+}
+
 static double timeval2double(struct timeval *ts)
 {
 	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
@@ -271,6 +283,8 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 	p.page_shift = ilog2(page_size);
 
+	p.seed = seed;
+
 	if (!strncmp(function_str, "all", 3)) {
 		for (i = 0; info->functions[i].name; i++)
 			__bench_mem_function(info, &p, i);
@@ -465,3 +479,85 @@ int bench_mem_memset(int argc, const char **argv)
 
 	return bench_mem_common(argc, argv, &info);
 }
+
+static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, bool random)
+{
+	unsigned long npages = size / (1 << page_shift);
+	unsigned long offset = 0, r = 0;
+
+	for (unsigned long i = 0; i < npages; i++) {
+		if (random)
+			r = rand() % (1 << page_shift);
+
+		*((char *)dst + offset + r) = *(char *)(dst + offset + r) + i;
+		offset += 1 << page_shift;
+	}
+}
+
+static int do_mmap(const struct function *r, struct bench_params *p,
+		  void *src __maybe_unused, void *dst __maybe_unused,
+		  union bench_clock *accum)
+{
+	union bench_clock start, end, diff;
+	mmap_op_t fn = r->fn.mmap_op;
+	bool populate = strcmp(r->name, "populate") == 0;
+
+	if (p->seed)
+		srand(p->seed);
+
+	for (unsigned int i = 0; i < p->nr_loops; i++) {
+		clock_get(&start);
+		dst = bench_mmap(p->size, populate, p->page_shift);
+		if (!dst)
+			goto out;
+
+		fn(dst, p->size, p->page_shift, p->seed);
+		clock_get(&end);
+		diff = clock_diff(&start, &end);
+		clock_accum(accum, &diff);
+
+		bench_munmap(dst, p->size);
+	}
+
+	return 0;
+out:
+	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
+			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
+	return -1;
+}
+
+static const char * const bench_mem_mmap_usage[] = {
+	"perf bench mem mmap <options>",
+	NULL
+};
+
+static const struct function mmap_functions[] = {
+	{ .name		= "demand",
+	  .desc		= "Demand loaded mmap()",
+	  .fn.mmap_op	= mmap_page_touch },
+
+	{ .name		= "populate",
+	  .desc		= "Eagerly populated mmap()",
+	  .fn.mmap_op	= mmap_page_touch },
+
+	{ .name = NULL, }
+};
+
+int bench_mem_mmap(int argc, const char **argv)
+{
+	static const struct option bench_mmap_options[] = {
+		OPT_UINTEGER('r', "randomize", &seed,
+			    "Seed to randomize page access offset."),
+		OPT_PARENT(bench_common_options),
+		OPT_END()
+	};
+
+	struct bench_mem_info info = {
+		.functions		= mmap_functions,
+		.do_op			= do_mmap,
+		.usage			= bench_mem_mmap_usage,
+		.options		= bench_mmap_options,
+	};
+
+	return bench_mem_common(argc, argv, &info);
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 2c1a9f3d847a..02dea1b88228 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -65,6 +65,7 @@ static struct bench mem_benchmarks[] = {
 	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
 	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
 	{ "find_bit",	"Benchmark for find_bit() functions",		bench_mem_find_bit	},
+	{ "mmap",	"Benchmark for mmap() mappings",		bench_mem_mmap		},
 	{ "all",	"Run all memory access benchmarks",		NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.43.5


