Return-Path: <linux-kernel+bounces-732749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E2B06BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA604E27AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1EE27380C;
	Wed, 16 Jul 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sYvvORAC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="soptamJt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C155475E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633213; cv=fail; b=JMSr5wKnYDrSODvLcQtS6YPNhKw9bVzjCaA7LR4xn9oRTdtuNc1EeQKBuAeYLi0QBkqArGk23HTP51MYHXUw5fEin0UO0u4QG148f0iVDaHflIDH6DQrqxrMeoOn6sQ6EASu38L0dPloJzEM4AJXifocYLG6aFdkQQfSUDAD5xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633213; c=relaxed/simple;
	bh=1fHb2xjmI/x52KwlJnE4g2BQotJu6cGvulfdq5zMTUk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=gIQ2f3QYdqTRvXZnfU0hPw/Xh3OH3h/pJPnw6WLjA1zStfHiH2m3W8eOCPO5KQIOZ2z56xXgpn767A4Z3qP4ekbSnSx0GNazj0iJLQj+Tx6PE8z2WoBazta4YqAnV2InsJ0DMAgUHIhqqFmSUKWRloVszo73NowV5PSr+cEQfgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sYvvORAC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=soptamJt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0gIxF030171;
	Wed, 16 Jul 2025 02:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BkQ8y4e3gS7vayCuOz
	AQTU5xeL4fDQ1HlpFj3A0cCbM=; b=sYvvORACp9SNfH2M//9QFeGVLhjt+uMIzF
	XfYSgK1q6s+I+QgmH6YZHlRWMasoHP/v6tRCdl0iA6ltPYpNZQ0yt7zOomnn19xI
	X/KZZRlYhUv8+9ScN5QzCZTtY/D9fopkXJ4XFBl7biqcv0PZk/WSM/C9ImcbivM7
	B84TI+Nm9G09ANNv8kBlv0o5i81rFiZCanau314ofYIeyA1G3xz2TTjZaM3/zqBf
	V2otx9TvNUVbwzY9XlTzE2gbXim7TOqyteArRhYYOBQ3J+kVP6G/aGSMbAnMK9IX
	/EHQrB+xKicvfBoi1lLNGP9Jcv3xqd37QYwo8bHhy11yP6UcA7Qw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx807rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:32:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56G1MYHn011570;
	Wed, 16 Jul 2025 02:32:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5as894-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 02:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C16r8tS0tlUlhVkarhIzjwPWM4aQKiUMJQ6CZtED6NDS4T+BILaSq5rjDVJD/MtQGvKGi+KltTFXZNLMWRNIjaQq+TqDq0kAzWf8gM4Q0E0cJ1wahcosyRXtt5dg3kjIewpA2bVor+aVmUHySR3Qqv894DFgorrM8yfKmDSTTWz9m1spzUf/j7t4ARiqoKW2FEicRojHbHRcY3yns+X5QA4h5g/SMfPdkKkfoaP8NoGrqankT+BMpM5JBF5DT23hkXDT1M3JlCSyqXAIucAnQq3/6Vnkga2fvO3J4OCJ+iS2pO+arwGmOB4Dgw/qMzHA/xmRKldayS2kbg7IXIdAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkQ8y4e3gS7vayCuOzAQTU5xeL4fDQ1HlpFj3A0cCbM=;
 b=Bwg6tMOemCQ/VDpgl4tkrxmpJDTRPXxebcy/xp3Av/uATEXKbLDm6cjZlyyr+H534QnBgsNLn5I7qPjU0ANd8FVqolp7xrpE2b9qoAxr/g7gEHwoDQ+S05kUC4CmeyKoMYmZ4cigPpqv9vVAPfZnej05BYzj37P5viAL81jMh8YuVTCjwOOD0GfzhWxpP9OkS9sQ0Pp98PEL/heaNgNf/kqCC/e0yVEhbxo2PH6JISM7mMmC7hlv8TKFCEHBFSruvzCsuIkTI4utK/Ub3A8314OifXOAvY+hJ6sRR7KeoykNNaw1Uf6duwDsTwi64yC2OyccND+qQRgLpNNOY0Ts4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkQ8y4e3gS7vayCuOzAQTU5xeL4fDQ1HlpFj3A0cCbM=;
 b=soptamJtOpp88sTl2pdpazJa9e5xJEA3+rS/79jKpMO0zS4vog16gJqQgDyHvY7Qb70Qtg4jt7cAAu0egIiU+dJYuKz4O20bMXuAjSKA2GhFTxTC5+4Le3Ft8JI+3rT0HlD2TO513BG/MUjPb1iQPGx4yl4YXiJ/ZNtqlBhvEOU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7258.namprd10.prod.outlook.com (2603:10b6:610:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:32:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 02:32:52 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-7-ankur.a.arora@oracle.com>
 <aHa2HHWaShp-Vk4m@google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 06/14] perf bench mem: Allow mapping of hugepages
In-reply-to: <aHa2HHWaShp-Vk4m@google.com>
Date: Tue, 15 Jul 2025 19:32:50 -0700
Message-ID: <87ecugkgq5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: c2ea6b57-9ad9-4b6b-9fc1-08ddc4111027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?noI39NsJjE9SQlHNJIlklm4Mqp5csxshJgkVLpeLedVZkYYo4nCbNrXeIRna?=
 =?us-ascii?Q?jiqWohqkIaGMI1Xy0MhGe+WsZy2V5ljcCX0XhGE/eMZ7yhfOmoVv2ARm3oTT?=
 =?us-ascii?Q?wKWfZNqftNdrF/9tvUAi/IhQF6H1NkfzRlsFlGfN4gVXMyV3X9DFCaC6w6LG?=
 =?us-ascii?Q?glK3r8nkVP6nqcscYckCjn0YXKaU9Y4QHPtzVAs6iNmIiSRtB0jiY6nv4MyJ?=
 =?us-ascii?Q?snYr5VhwHuLWdtSlmjBlD/gTN7CCG5V3xlsc9oBPenY8lfMin9egfRAL+X78?=
 =?us-ascii?Q?2RF9zUCwsKhIvJBewAOcS7tZHO9j3rrAH6zC/jbea9hpbGVgh8PSZVV9mTCm?=
 =?us-ascii?Q?XnmDJM4UR8iAQ2rAe7AMuzZjySNPjEoXgsFHZkR0gr7RQDKY53aPIm75NPpx?=
 =?us-ascii?Q?0TMZfuVQLJHHqjAz9FNBc534LphpjW1sS2KoTWeg5tcz7NaOsuIygx2PMzGc?=
 =?us-ascii?Q?kf66GL+l6bLfUGXrXlf/gkj5Uvk9V2jgkbfhCriEQXuWNKhwIJkYBYrk4RPe?=
 =?us-ascii?Q?EB5I11bE9ar7p4AuAtJHfDNSZHdh5ymAqJHkyejHlfMk02ug+/yXMC9DmsSU?=
 =?us-ascii?Q?uyIRoJgKIHV8uCw/kY5b7jFyiZejy6zh5mRP99Ptg1k0eSXZ2farh8It97r9?=
 =?us-ascii?Q?TXHfEK50XrX8Gh8NLdCHbZkuf7/8W1UGk+20O4a+8/HtkoLw8Kh3C8/xE67y?=
 =?us-ascii?Q?M7gi/Q0bR282pljYvspLBW/LHAPG3PTpYIPtxVenPY2M2Ln9l/iQoFLXLlK0?=
 =?us-ascii?Q?x+0GnlX8vue40ioUeXHVmtDoAuubhlfFJvZfKcwu6vVIo6h6rNs1wkVA9z0g?=
 =?us-ascii?Q?DMrGuCKxfZaW8NfCU6mGOyh37E7zZUvyS9Q/KJE9l/8caze2lBwjwkPLrGEr?=
 =?us-ascii?Q?XUnUj0zscLXVBp+y5KU4KyyD2E1vGkPCrtrDuzzw4x8n/agzHeRmAnumpn8Q?=
 =?us-ascii?Q?fTL3PaMwWo874tXcUJAJf13mGv8s9a34ne3xlYpHxxP3RZ5JfmHBCxe+0coS?=
 =?us-ascii?Q?hshmPLlcBB5stE02ZiXcPkEq3Bp+y5RrrlQMM55p1IoPyPrXE34pFOPR/3qQ?=
 =?us-ascii?Q?Zj0T2rPMi8XaGdvSYMu6n2O9UQJ2qiH/WSSiNdDpoKB6IyyfDJIP7cACzy9S?=
 =?us-ascii?Q?mDUvGKdLsABe2Y97lYHAI6VwdsLbgzbPbPRrphMqH/dmjSKvYc43M491UWN6?=
 =?us-ascii?Q?QTHplSa+exRWWto3Q1HrpJC4f/yYPAGRtkFwfPjE6EPdlxAG7SPyZ44ggoML?=
 =?us-ascii?Q?ungMJGmrBbktaDp08G2kp1mBUMb9v2CmI3w8UO+FhEqeaXclXcO0wRyLv8PU?=
 =?us-ascii?Q?tTpCvZEQAGhFQLCNoXA3CZCsBv7qsyEVtwQ2q47GT63CFWCKJ8dALFSwi0In?=
 =?us-ascii?Q?DTtCvMMPpmBGTlCbGbBSZVH6csh0X78x0Fg2QCuINr/5/MFMINgfVVewlykc?=
 =?us-ascii?Q?MBQWJJIZriE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HUK3neJiHuMtI9dzYIZ8XI7DyecLNRRHSSCRZOsgDA7sPZma41/WQL85thlq?=
 =?us-ascii?Q?9A6knM653Boom3zKNQaB+wN4CGjqpOE96PqRu1Ppmzc037qI+LYDYz+8Si4H?=
 =?us-ascii?Q?UpPYfXmWxvs+N6J7ww5iS07bStGoMzY9R05ABqi9/SrhF7Cu1cz6VWIMvJgr?=
 =?us-ascii?Q?0JyE5ifGvHe3lr/JQaRN7bkXwBcS1vFTVemUqjEWJdIHOoFbRd9HTfjBo/p7?=
 =?us-ascii?Q?Ldrho7f+S+1iBS650L5SOBY5ROehs5MXLrUckBHKeWj44i1PyUVCg3TYHMRx?=
 =?us-ascii?Q?ah9mkfhIFRk0DguU5AZhUgVFV1qL6Oehbv1dX7+339u49jEXYvPOAYuiaXCi?=
 =?us-ascii?Q?7JCjQNvWlYrac0JQ23pL+8HexfESvjgI51sDWiPd/HZVB60xy50YT7zfCXSv?=
 =?us-ascii?Q?O7Ujo8KGGlMdeoecwLWnNHU13dcLGwtJCEXMewNLgwOvWzmxDd7hgUIs5yf0?=
 =?us-ascii?Q?zwbZEZ71GIj5OoyilIMzCsaNk+eGgbVvsJ+DXyDx4zx8Xv6TqNkkYAehw7Ma?=
 =?us-ascii?Q?tAKPTFi1+gAILQj0tubf1wvpxOxXxARq241hC0X/P04Ia58yFmsrNv7yzqOd?=
 =?us-ascii?Q?ogUee55NjOq0L55EHzPG2MWoRwgciMnQnoA70Gsb+cxOKpI9IFmnAKCZhIiw?=
 =?us-ascii?Q?hsGiijb0ZdhjZtydznt6+KZUGjNwcHYDqE+0zwfKSrEZ89VDjznWbz/T5PSr?=
 =?us-ascii?Q?cS6hB/Jzh+dD/WgDq1XjGui0IwxK7X08uMZFb4oBRHP4Cjaq3tLbz7MjVZMJ?=
 =?us-ascii?Q?crwBbs4+qEQX/BFg0H4T5av/CPj3sK4MN+JFJ9wQ3AjzGyHlVn67lKqIdUMJ?=
 =?us-ascii?Q?GFO2InRfWuWsldbDAjwp7UmYK5dwdN0ni7El/brtnvoWFgL9gBXVlPjIKn3O?=
 =?us-ascii?Q?b8UYBRbYKD1em5I+Tk1QnCmZw7wrMQlWD5NKIkw9K1bURJtqzv0FC/8FePRt?=
 =?us-ascii?Q?DFKIyF2nOIQRuiuDWNghwPTXhsSGXDakSf9IqCl30HNvzEtpZ2k+M7MK5oDD?=
 =?us-ascii?Q?CKFgYuw7ENwkfC/8TA4UdwxjTgRWv2HHKyLelP2xhZv+H/t95NQXKA8bbkAN?=
 =?us-ascii?Q?sDI7cfWlSIPCq5jbavRpRl0A7Q2zKMSPE3r3uLQka/K9NggDF8rhSV2/LODW?=
 =?us-ascii?Q?5wAN8dgGblV3zPyoKf8spsf4RCnO589MogzBY7alu3N/w/F9lzbqk/UD1sTR?=
 =?us-ascii?Q?o+nqlmrpvPU1+s3eGbE787driZlVLVswR9nmLdpGIoRGmIPIINSnzjD1tIk4?=
 =?us-ascii?Q?ZVg6PsCaYNZJ8AMTj2SbRViVD3Paw4Crdytf3EgrZX5Vv4yQ0EeGiNkNOzYG?=
 =?us-ascii?Q?A8/EgHOob/1T3fI57exL1CNw3pqXw+0jRXvveMC3qi8opeIRXEB9b89oAyu8?=
 =?us-ascii?Q?sIG7KTGMNNwLAho3mh9G2e9VQMlCcguTxo4hDvINpjQSWxCsIYCOo3ofz0m9?=
 =?us-ascii?Q?Yv53GAKV8C2POuGBceLxkdljU0/NGK3VqbknbZ7RIiHPEzCyTKEEHL3Gzxho?=
 =?us-ascii?Q?6KpGJD/pKMYZNmHSnzHr3ZMXsldLY1mstD3fKLeZpOAcQdWVgKuJa62HziTu?=
 =?us-ascii?Q?/IfigUt5JoWqHp/CN5Va0t6B56z+9Y16r6zdY1bVk1tGJ/TRTS+7S5+erO0m?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8k/UuSiD9hXr4T1BwPlJ4O1Lg3RGC3z+GTic+YmPSHWpAlWmmQW8ZFE+t7QvBGLIL9yKtEWYJ+BF/3Q8UvXiSAFouQmvTNfsC/OVSGrhuwfm9gOXLVDQPAx/J1VUDaDGph8LiK5mcUKRquIcZ6Dgf+vhu3+Pqcy85LrqxG5LSEl4XBbEHL1uxiY44x6HaE1yhqwrvd8Ok3fFTzIQsng1gD4xW8PTXVQjVFFSfWtCE9sUhCwP3NuAzqr+9DX0fIdtS8LUvmau1ZDQMNTf6ZLVNUPlMGQtbkqEPK7bNSS3iTcO3R+Va71qy5T4Y62ZnsdYWe3x26K0yczvPFl7lyLnqbZcql4KypsM68yw55CbMQkKnlkrshBqp7Jvhk3Kkg4PrpCDYGvtmsu8h0GhLazjikH7U69/RuaQfKGR32ZCc4Zww0cvKIktIWjs5L9nXCEBDm2WMztoNJglf8INZ0G+i+zep36iyHNDM/ErixF577Fd7gYRyZqIvNuo6iRW3zk62yfeT0gFd1cnPoLAkrEpT76xGZLV1Nrb7OCErfVWMYcsrv3sibYv7Y3+DwAbLJYjeR42X4dsa+cUQOA7uZKp8gHi2fcPAeywRVcLQxvFwM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ea6b57-9ad9-4b6b-9fc1-08ddc4111027
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 02:32:52.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdUM0SAGkiOWBBlyeediGHPIzMIplUGpALPhWXmmuboGoX68vf3IG/KhGhGP3BpwF7tI4DsirdyPHrciNCbXGCVJ5iPNYuzwwOHmeKqJxjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160021
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68770f58 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=0t52dNnFalp0tdyUlW8A:9 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: _MpSaD8kCrjVby-BqXaCY-U3bO3i5EpY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyMSBTYWx0ZWRfX3a6dmCZfiU78 KOpK04/1n7lqyxSYthBUT914TCy8o7IC1b8U/5TvPQApmZHlTcyXMr+0lnCLjIg9b/m64VFri59 DcZCQULikLTHpYnpYCJ5HNhFSfhLyhmnVadv2QPf2HfTx7tlOjofacHfC9p+xNmd0cBh12+UGVV
 a5RX0a3Y3iQGn1JO+NpoFXBWFUDcZ5T2hbjyoJdy4drM+9rKpJRKLP2dNmANiNQPHAxCzvUrsjM zEbYsO+elWtdn9mXDD2Fn3n9A4AEtijLKu+Ek2qzr2BTak0PrbFnlGRYIGBYdcvi5W6qxZfrtBJ Yds4wkRKPf+zfpZtD8vFZxSGG0KePb+NoImdsn8uUMcrsi6m8dujhufkkei6nQrI7yysQ3GlfWT
 x0ThBgGGgP1N4GLMxwj4WtfuOR4+AHN7DNAybaqhI+VW/h6oM+JBLv13iG9c/hMA5Vv2mhUS
X-Proofpoint-GUID: _MpSaD8kCrjVby-BqXaCY-U3bO3i5EpY


Namhyung Kim <namhyung@kernel.org> writes:

> On Wed, Jul 09, 2025 at 05:59:18PM -0700, Ankur Arora wrote:
>> Page sizes that can be selected: 4KB, 2MB, 1GB.
>>
>> Both the reservation and node from which hugepages are allocated
>> from are expected to be addressed by the user.
>
> It'd be nice if you could provide an example in the commit message when
> you introduce a new command line option.  Also please update
> Documentation/perf-bench.txt.

Will do.

Thanks for all the reviews!

--
ankur

