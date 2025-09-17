Return-Path: <linux-kernel+bounces-821143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D8B80890
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0C46731F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2735B371E94;
	Wed, 17 Sep 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdUXIpX6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yMkEzsYJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13675346A06
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122728; cv=fail; b=M+WZB/CpFN13EIHV+N2p9djAHQAasOWIBIb6nmJONbJ5O5c3jxpZfouBunIuSrzLwUqituQvcGjZ46y4Tnc20JcU4USK/G1ABXp0RTRavYoY90Mx/B2FUddQHrajEIzoO2ynCYIA+whjUByo1QeXb0VMVuHbektXd7Np0HYfJcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122728; c=relaxed/simple;
	bh=luiLulfGUt/XNEqFPjeC7hPuoD/YYW6SyFlPJPFo+Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VmdXahoyi05VPLjl6SJ92g7tv8xLr82jxS9QSUnUxRzy8T5MuKCYSlHA2pznZiCq4WoIxapyWuHrSKYqDTVfp3XH9r7Y9SeZkqoE7RAzoTsIhBFxRjw5U3gnNWermwD0LYIMqLBaAudqMqXbsgnJ8Fs7yqT9xUythx22p5bpN7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cdUXIpX6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yMkEzsYJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIToq007388;
	Wed, 17 Sep 2025 15:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NpT4FKranfHCGixLzEkHiSjzmAi6D1IA01h2Qdl0eRo=; b=
	cdUXIpX6zqlWoGGA1OpsU3niU8C9JGzqJFSI9b0Z/knxNmOv1mlnLUk2Odbjf/MN
	256h9WS2Cu7gqrzp4dcU3s2Kk/+6DtZk6ZZqq7cjmNHe80VGgxj5LrhYtsJ/JeJC
	xOZkJ724lKjiwvn6bLi6/wi7zUhLXUpXp2mtodT/XzICkTkh4PkEo1WEO3YkNyDs
	47G+zYyT0s8Zm/2ui6eqW0MYgrSCeBZZd0jL/dIcOVI8Qau0H4Tt2epy/rxp1lXI
	Pd+Ejv0htIuh1N4FHgX3SegZ6TuBKpzU+WgC0TSNeaQsLVvk7l+sXFElqDaBdemH
	3w6lg+xtzf/4DfFXIkUR0w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx91gt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEm8dI036930;
	Wed, 17 Sep 2025 15:24:49 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2dxufg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 15:24:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBqDfRqbCnAeDO9p3axdT0vFb0bam8BoeV+UQF609bCZY9Gad67+VJofkS5fsBrYH01NRZbvyoCBjVupjIJT8srSWP9hRDJF8BiwoYhYC25DrRBV/E2vxj8mBXdP9XzG/KNV+ztSi4NsXKapT1PonkJpVfOdfhi0QnWngqhpLcCAritI5rbLh86wC7JNuwHYaNUyrpXLy8aE2ex7c8Csad4LoO8XN/nvXMvx7CKCEGYG0S8Qib1AdyDvfM5UenZI/+x3iXL4CItugb/E/ErVSbDH+tXW+9pfZKZlzCjWKUu/6O9vYWT+C3MIPBkDCaDRZd/moKSViuXYf0rLgPjaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpT4FKranfHCGixLzEkHiSjzmAi6D1IA01h2Qdl0eRo=;
 b=X7DbfP8MP6UUbjFrcCIO263SMBA4SeThFCYF8/SjQm8RXvbyzfpx+dV+0D9V0KKps+UBLq4GQ/JJLO69oUtMkQv1L0SqG8/xvndr44v1Ccw8Cuj85TMInl7k1fezX153tT0w9EOwywu9DlsnV9OS9E2ByRVgZHC9xxI45XmOyzS1OwQwfjPrwLheCvBR5RabkRdWH/pEM2/DGCWop5svTPBAM88OcRkFk2th/rc5V1zkanBGx0MpKGvsmkrWsGaay6bMJdCcZMDP9ISWKkJ66Jiy55N+SnYA2arqdiQYzCBmVidNAtRCd9HeK91rxYPsm9xdbJXuzHQfYxGpyUPzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpT4FKranfHCGixLzEkHiSjzmAi6D1IA01h2Qdl0eRo=;
 b=yMkEzsYJRjlaIOPCYOTQ4FhkOER/eYycI/au7jDFOMbPhfeQNrXLymD8y9Pu5KzGn2Lv1LDeFQRCTcwNfccueQAeuKCWYeMihaA8IfgZyG48u0wetwi2CM4PGoI7jNZ+SdF/YgwjvJyNQrtYBEqI9RnryJaCKj/DtOSFLK8x5mo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFD020A49E6.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 15:24:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 15:24:45 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v7 12/16] arm: mm: define clear_user_highpages()
Date: Wed, 17 Sep 2025 08:24:14 -0700
Message-Id: <20250917152418.4077386-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:303:84::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFD020A49E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe3ace2-faed-4d62-f377-08ddf5fe54d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MH5bdPslvnZ5jFpCTSFYAzDMqLtp6LdEwMV34MglG+3lZRqD6SbIdfM2z99v?=
 =?us-ascii?Q?rsHPi/yvygbezlr4YdYdZlnOI8zUEp3HaEawG2A9yEr/a33u/OU+w6Hpqoo8?=
 =?us-ascii?Q?L3LNjF99dz4h79JX7MivDLyQG3EtRrVgyweyllquw6M+yx0/3lyH1HGmRW/q?=
 =?us-ascii?Q?+1mCnvniCaTZvI62+yC4CdK9m2DKvg4k8D2rLicP/hYbTJaOSrKfUgEox8p1?=
 =?us-ascii?Q?5PL35hgel0hewRqh8UT9FxG1uS5kdYy4HmSPOv2uHog3TJaMWwSYaFlFcqSk?=
 =?us-ascii?Q?b9Tk5D1pFsm6K0ifeGvl6lmp7vtiiomX0t2P6M6abkqx/GSMB/6v0Ri6TyPH?=
 =?us-ascii?Q?SmRY5+PZuVnkVITTdZC62HqiJnLe084fdSAh6XqbhvN5KAW6mXh3rEx8dWWI?=
 =?us-ascii?Q?Y1Q1p5a2TT/DjhAyI9pTWZW9ORyNqAkWuw3abkk7e5p68Os9x6pd+ol9SSA/?=
 =?us-ascii?Q?l/uUHcVQ85aGqcVCAmMOBHyAMC8yyXffwbu8L2JxwzVJJGnpXSZbnRd2yvVz?=
 =?us-ascii?Q?0tewJ1LksXOulhaNmumwjDnBaBEIWhOwCN2Gw3HBumzN0FZOFsceBub6fnvm?=
 =?us-ascii?Q?hxTVFvGiPzoZuSia7OBSziaSOJkWC+7rgTzrOBcxsfFK+3yp7rH21THhJDN6?=
 =?us-ascii?Q?155YE3sAGRBGn4b01YnQPKeldoQHD/VEDD0/QuMkF8KuVzovi6cxMgEXVC8y?=
 =?us-ascii?Q?awggsg3sCmVE4h5riEnJvC3ejZ/uTrMzCaYYnassZ8FdLlK9jHSgPFIwtXYX?=
 =?us-ascii?Q?cFmGmBm7DBnp7DyU4xlZTh2AJvrinbkIAlDNp7nOLjC3YmmFe5hhCamHm2NZ?=
 =?us-ascii?Q?15NCJcoEd1pX9h3w008wzun8eBlC/C7pHXq073ZvW4+MSdMJJ6r5aXMfr8F6?=
 =?us-ascii?Q?fciV5a/xcJkdQaf2FvLZritL195/AwKV3f/Gd+NfnXhzN11WeL4pzVdSB5+a?=
 =?us-ascii?Q?8oqLiDYIYQJn40Wq24GyBxPwK23jgjcKe59GcGP2k9be1x640EoEN7/ZlA6D?=
 =?us-ascii?Q?CbW/7eHun35nCH8hVaxZrLDRnirWEris5uQUsLPeoUENVy/fErqV45XBx/Fl?=
 =?us-ascii?Q?XR/Vn4s8SPTjPJOs037aVuQ74UuIjwuVRcKpCXfyanFUc8TyFO7ymQNMds8B?=
 =?us-ascii?Q?A9chN7UUBawDWYVPfrCqtunS/7YLa2wnhrNxh3r0AwO3YBrciyVAaD+fO/6y?=
 =?us-ascii?Q?9cj7r/fT1vtntgGh4IRp3bql4ufsfZcVLYiHM0/qf956M1YBznsNhZA8p1TJ?=
 =?us-ascii?Q?OsQdkE3AcjxRefUk0IDYNCkABS0g1BvWUwjTO2pLBcgQ7tMJcransm97NylX?=
 =?us-ascii?Q?7udfzPy1753mhPq7y8zLlItMGP4UCTeW+vmfmm+MCGa79iLXdoSwoQ5Kg+NB?=
 =?us-ascii?Q?hApHpAbijPfG7pjv5Ilny80A/dnzvPrS9mnmas4c9rRAnOO3lE7XB3abg3Ov?=
 =?us-ascii?Q?FyZ5y9B2ipc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VeIjGXHLBnh4PPz2Pw99/qR96ajYz//SmFJrROhSL9LswfG8VhPynVYzjf+w?=
 =?us-ascii?Q?Ha/HVdZIH900aoyOTydeBi/rWNkj7M4CMhD2s9mlWwiOjgYJtg+XsU0pOyD4?=
 =?us-ascii?Q?SJ/4Ai5m1CN0L2FPUgC5NGXXUR5hX1IJN8Rk7JqiuHW1VV5QN8O/9GXSKNO3?=
 =?us-ascii?Q?ic5u0YlnMZLKnACTnQxRO3ZL/nfnb6xfwl71dqHwT0SE6U3meCV/UWc583+L?=
 =?us-ascii?Q?UAG6P3IelC3l96wkaSfJNwWE68MpPZyqXB1sfrEOk3C1NavNWweN0LIQpT87?=
 =?us-ascii?Q?+lziZu1ap6EOJbX/MtuzemQRRaQGjLk+EQ4EJKvmCJ4XhRtbI4S5B9nVtxtM?=
 =?us-ascii?Q?1OEibEDkwkkBebZpH9RbzgzvOYfXryMdPIQUPT7TY30g5k8xHDCPnjM4oNs2?=
 =?us-ascii?Q?PpNttkuorzGUK4bsunvo6wdiK53EiWFBJhSNCIpxQSvByvyL0DqpWSFR2e5s?=
 =?us-ascii?Q?LW9OJclec9HBajUV4xWgb9tqI/7OM8/Vdl48e8WclmTIbAHvhq7GnmqrocZT?=
 =?us-ascii?Q?WKTV9kuKHQjkUWwyB4qZdJx79ZCq/14DxnYbn1Mb2ReFPB806RJJsuL8BEn9?=
 =?us-ascii?Q?Ce73ztAGcXyionEK7i+EUn53vHX5iB8ovwP2nmV6FtTALbPsdyOPdyEQN2GD?=
 =?us-ascii?Q?uCpLJsdIvd4obR3RdjsEs0aXwpkbpimdzhlLpzfK6yeixxysIults9SVtRZv?=
 =?us-ascii?Q?jSJHgUXNXmD5lzvRBV51jTjSwN4Bhq8XtFQRpOMIJgLCFdsSPv/j8fH6/EOb?=
 =?us-ascii?Q?S8nzDAwOOPvieobtX3ldxaUWCH/7WQ9k2o7i80JeAwnXBKmz/O0an2DNB7lN?=
 =?us-ascii?Q?kGImuQd+/3NurupBPBICE9FdcyZhfCxNjC37vkjLzwGfAHIv57ZK/Bk13XL1?=
 =?us-ascii?Q?hMnvAnR+SEwJSXEpMU8Oy8kwFlsNeo2CYcM5kNFDsjg0Bx2APxcuqYvSheg2?=
 =?us-ascii?Q?9vYW0zqYqVy+s3RYMft8aDwSBrm7dyKi2x029VI0gkyZWrT8dnnyb68m73Kn?=
 =?us-ascii?Q?Wy2uwrrDamZ+1MNaFaDOEZTM/hW6aZ+erPn3t638hYDBZ/rcA8OJQHTbQycl?=
 =?us-ascii?Q?ZZ6tFDk+EwPVHeJNCaC1Enn5UQccpSuja9Qge+0gCc8M61FsrocjmDzoaEpy?=
 =?us-ascii?Q?PTfazWLkOMXg532zM0eZ5mV8iiiG5EnLdUTX8VZml1WoGEk/PEv0CWUO4k30?=
 =?us-ascii?Q?LjGcOip4Q4IqU7cxbkqsOlCkTF5jm5QSNkMlbGHoMQ1TI4euLGwklKJaH8M4?=
 =?us-ascii?Q?biqQaKRHTxkECCtTTjWOKTwpWZ6OLjwGhIsqzJL31OdTGTFLcGc3wURUkHt6?=
 =?us-ascii?Q?P1b5hiupJvzWwv6OI6jdGpv2GLzyDxgOzlokSh1x+6+c8xe0FoiuDQs7pn8i?=
 =?us-ascii?Q?0hUA8EV+xkNF9gNGDhREQfqCxAsSCRhKUPO4oPf+40zcrXOFVmJZdJF+nE7H?=
 =?us-ascii?Q?469VteEwK+bx9VjRR3FgMbkDdV+ZA6tf4L7i04QwHJ4m93DubZ9ed3A6c4DD?=
 =?us-ascii?Q?BSUpIn5x6DsRfkOJu1ZGG3u6s9SsawTiDQPm7SZfiA34LGIl+laJJylhVumQ?=
 =?us-ascii?Q?zF82fdmsuOzp2v1HJq+Cza7rW9f2UJ7964lmG1hD8z+XlSaPAE5MM2gusqq/?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YBQWdOAjgTG/kXbcO/aZ4fd/+dWq4AEiZ8yyupEYuOTJz268y1mlu7tICiSnru48oNOZdLjZw73TD19uGjgCV4v0EGuwlD251K7tPBjOJjld7511k+PpZbudIig1A8wrCyiI3urKTbUM11o5zC6msHvFNV/30J9LEad/UbgjxjhrFdC1zqwuOXDPXVqz0+7o8eBA4lqG7zgjAy6tWOh3BY5flEtX7MaCGqiPbdfub4dTqkQ7Wz+QyDdlYuVqnwjfn4dkRBA63izCrJV+ll7sq3ipUPC4GucXxxSonVYAqEov3rRpSPUfWF/7LvljUFdUtONBthZ0Tx6knM1zLasx7Ej+HdnTGAmUcG6vyOlQ/uVTBFFcHbmm8jtcN2D8teOTAsxhnB40LOB2q82Q1lkvWIHojy29MKP/DkIDvHiwGhMrCo6pZdYEOX8qgr3dsSrOuL9A9PeRBE17AHaRVWbJUh4eso+4qmi9Qfz7/c51hydZq+7AofsioglqSR4k6o4JKzLazxqfUR0PMA6gP87YlQHdIepW7qo9MvKNWQt3nwFhUSiWCRiFCnUnR6HpVJa7IaHaFKFdjIRW1B6Y9rbe64443VSgbhQvqwQc9rbn/tA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe3ace2-faed-4d62-f377-08ddf5fe54d4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 15:24:45.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQhW8EDj1LnvJ1ByjegFRxf90IBe9Ax5h96tcykAhS4omOc/lZtTHvieQxtjfXx4WXBWj3/pOQv7vkvTScTZwbh4LKfbJqUJSZJZJEplf98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD020A49E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170150
X-Proofpoint-ORIG-GUID: z4uuvFjpi85RS9jCNtzTvJ-zaxbYe7Pi
X-Proofpoint-GUID: z4uuvFjpi85RS9jCNtzTvJ-zaxbYe7Pi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8yxgyNrg27SD
 lxOHI0G4aTftV80MhlLzaAt03R0ID9u3lfCpjXNF43HHMNgzxrMg5rNuPHQmJx4nlnoCXNNEHSh
 8iNeyB9QPhLuIOlS/pHXr08/+t0ZIGWYSEZI2M9sxkmT6uLUuXaLNmjdHp3uY2JNWZtcq/+gykL
 80uNYfOYQ9DS0WjD9rmIIyyFCq1+dciCgWRjZVHy5nVXO8gVQzvgCv4kodVhpel+KDI/ZvV1v/r
 qyFdbVwBf3Ajobj/2qFVr0tJFOqsPQcua4kmcpV2sF42Kg4D1uXxmUX9XEHtZJnqnJr364t9oLN
 UUREBE78tDtvhSLataTA0QoyELmJ7eokmM/Nvdm62hrpG5OqvWqOmor1Rb5mBkDBH3y6/9Lkip1
 xJ57Ub/Fz2mFcoh2EhDptsMgg4PpOQ==
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cad2c2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=a6qOOIzeGn4LGes8qBYA:9 cc=ntf awl=host:12084

For configurations with CONFIG_MMU we do not define clear_user_page().
This runs into issues for configurations with !CONFIG_HIGHMEM, because
clear_user_highpages() expects to clear_user_page() (via a default
version of clear_user_pages()).

Define clear_user_highpages() so it can supercede the generic version.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509030341.jBuh7Fma-lkp@intel.com/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm/include/asm/page.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index ef11b721230e..ddcc8159b075 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -151,6 +151,13 @@ extern void __cpu_copy_user_highpage(struct page *to, struct page *from,
 #define clear_user_highpage(page,vaddr)		\
 	 __cpu_clear_user_highpage(page, vaddr)
 
+#define clear_user_highpages(page, vaddr, npages)	\
+do {							\
+	clear_user_highpage(page, vaddr);		\
+	vaddr += PAGE_SIZE;				\
+	page++;						\
+} while (--npages)
+
 #define __HAVE_ARCH_COPY_USER_HIGHPAGE
 #define copy_user_highpage(to,from,vaddr,vma)	\
 	__cpu_copy_user_highpage(to, from, vaddr, vma)
-- 
2.43.5


