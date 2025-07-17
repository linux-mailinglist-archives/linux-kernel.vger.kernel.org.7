Return-Path: <linux-kernel+bounces-734598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7D3B083B4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE9D7AFB76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4DB2036F3;
	Thu, 17 Jul 2025 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dyvG4HZ9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PADl2bjC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718C1FF601
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752725921; cv=fail; b=RLrJZXr8wb4nQ73BwCukVJ8wqqLcLoqm1ccN4CqR8z0oWCm7UKpZcEUa9UxcK9Y8KE4Ccf6WosR+aAImkQPC6po1qx2TBnMhTLztL97JDbLTi8cUMl8XratHH86vXg4lsBNmfGe4i6/YDg33T13S5lB9ZO9r1wL3RVjxQsnojSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752725921; c=relaxed/simple;
	bh=jLuZhFsgIgDu4Pe1C16uU4nezDCKowz2OaiK26m03D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2tLEdfmbxq/ZKGPI34YhYC+Lm5WCXw4vJcTyqkEOp/J3WDpgmfDRaZV+O/2ZoYiOht2TW35rF2Zxjpg5x7EeyUGMbupU9Juo81GchJE8NQllXFxy6Emv6ZQH/v5IF74Sd97msZqnPQZFB/N9uCvUXtj96NuIb8l9jE4IPUzp64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dyvG4HZ9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PADl2bjC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GLfmEu002836;
	Thu, 17 Jul 2025 04:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2XPFMH5PSfmSQjVqx6
	p1B8Uc1aKtW7Djne7oEi7t9ZU=; b=dyvG4HZ9Veo67jhvoj9BSRksI9QHO9rXTn
	b8AsbafS53F3TDrN1XegK3c3hFuRREyJO3Ce++dZrDKvXQY5QZjUjYcg/w97FBZF
	S89d1+oBHGIMe1ypHRSUM0ytT5nOO336iC+72wowcfx+ZdWrKEA4kL0sA5giRxKN
	bOVtSvuyxP9R0IYl0i96Qrb0r4H13tGajehVDd4Os6DZHrCk0tO1qxq2kopuA6i7
	5fr5+nstOnTgEw1VpRtgRJO/+JOiMmOiOuPIhBDEGXAT+LfbowRUIZF4HJ/t/JnI
	d3GojDLk4hVc31PJvDuqo+p/FFgVA0Gjpgf9LSgNeiUrYwNoPXMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqu0mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 04:18:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56H2VEZg011597;
	Thu, 17 Jul 2025 04:18:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5c73bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 04:18:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cem+qVQrgXuWnJzNcHfCWWs+YcmPYOTkv5dVP9EIuYPVK6nhdfQyISBVh9egSb+bmsTPtBgwGlnjg7qNx3+WsSI19P1MWywBFKORcPlOEm2IvykLS3Hdp4qF+tDO0pbf1WSnTXpZc8xNTUKb4v/DDEMDGKdiBtyhEnvIa+fkKyCkNC9g3283R3rh9VZ4ASn5hFuQrrUtzaBKdPo1cEDytZOxQre+tKBrhsKKeAgJhqX8uh0F8ZdKrzK3nT7wkh1Q9LhFZvhwuwoPqu3XTkGM/41o43FKldpDcofXHiNlrX+Wl1Gv1weNMVLoB2e10Hg1J4jNb1UGxuWZtEj9xh+5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XPFMH5PSfmSQjVqx6p1B8Uc1aKtW7Djne7oEi7t9ZU=;
 b=tBgIlmCFoMp/hHLj0JBEMh/Ojq9Rl13lOFje+f8EpZUWmMX/AQzHtBwvnmuBoPZv6eFbgbrUteaLsuhdOIMiUi1ZOonpaGFnbggSiy9GNnqcPR9OPaaXDxgC4tPqSj1CwYPBMyb1bi1vOIGNyTzgmvMkd2XALD1ddUX4x4Zn4cOqyQzVnvCHpSWz1vLfrduTDqxu9X8jGp7CsHrWvHlxCuTXP0EsayG8um67IZG0NPC8gCg4WA0MIIDzc7SBCsAEmrro86SwRCkkD1e/+pBaUlULxUblqLTkhtpxk8ob5sRY3LqILyXeL8oga9duo4d6HDn5xXNjmz1ItvC8UFBjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XPFMH5PSfmSQjVqx6p1B8Uc1aKtW7Djne7oEi7t9ZU=;
 b=PADl2bjCHm+96HvreZ1OiwSjv/ovYh/Bi9E23XQQx7/TTXcdgQglOEw0xUcrG6L5+NL92oQT5qy6/Va6A2PhJOgSZhFPX9UbfTgmdAbd5mqBtLLIcim+iqiPolEtPNSiB8G2SZIutbTAoiAzL/zoiVXkhlh501x7VkP0vPzDgzk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB7401.namprd10.prod.outlook.com (2603:10b6:8:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 04:18:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 04:18:22 +0000
Date: Thu, 17 Jul 2025 05:18:17 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hdanton@sina.com, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
 (2)
Message-ID: <8a2f1892-3184-4aaf-91ea-522e9ba2391b@lucifer.local>
References: <20250717014623.2253-1-hdanton@sina.com>
 <68787417.a70a0220.693ce.0037.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68787417.a70a0220.693ce.0037.GAE@google.com>
X-ClientProxiedBy: LO4P123CA0185.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 1228e1a9-2c65-4c78-fe40-08ddc4e8f775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcQIMWBRz4L51xccbkOxil8xuEhxbfQd7LibghAkX+OWmtR3IQ0GXyoj9jJa?=
 =?us-ascii?Q?JgZ0tbVqHwZXV7ajwt7N/uL7n3dcURKonuazWzEnoak5EOQ6oIB6tGhr8Hrq?=
 =?us-ascii?Q?RHOsFmVCko3tqU9sIqBDhtmgz9b3AmBvqHpy3evnBfqkSf4a5iaR9wUTDpZd?=
 =?us-ascii?Q?yqRRRx8QYeTJAcmZrDihDqxbPn04/C568EsFFR3O4UoF6vqb4bFkF9zNg6TB?=
 =?us-ascii?Q?ZGlaG2ZReRB1fyd7KGspX3ngwSJrO28qN8X7t5wW1loj4sfPWp/b5TN3NPDa?=
 =?us-ascii?Q?kzOSuZkS1xEt/tGuOP4ZWx71OJWHNun2gJhk34oebfcD/DQxxneuHtPEoYVc?=
 =?us-ascii?Q?Fe99S4Y59bTXv7nWMlc4ye56O634AwrpEWcKBAKq7oQbxm+RIbugkk7aLXe6?=
 =?us-ascii?Q?hLqFS94/M+hL9AcKj/2e86A6ZxnEzhIVvVlruRDvRNlnHkN1WHKIqyI7U9Q9?=
 =?us-ascii?Q?u/f0zSZqcAJK1NASiZqgZUuugHhn0OG/P3I9MKBb5CfBlIiEgHiTKJAXwqqF?=
 =?us-ascii?Q?5RNuzcqROxoqFsEER7ikwSZriQKO0ChHw/zXFg0HPV1ozL2mvM1NW1E9bwLX?=
 =?us-ascii?Q?wPfGdHnHT3f0JtW30madHBOsbmI9ag+VrFfrYMHPaaIw4NstfTSBMD3H+GOj?=
 =?us-ascii?Q?KVWWdzLFSaOH+CqUY4n9UqNAcmDuaML4pT/qr/974vkXD9pFWFIFnHEExGYS?=
 =?us-ascii?Q?wdKd06Zc/EQQGsYIzc4BBPcJ5lF6oOukddzPBTJ6z2CkNDlbJq7jezEVKdda?=
 =?us-ascii?Q?2FywvKdXh1CuQhNUQSLcvy36U+/Nj5cougEu6+5R551+1H0m7NGK/vO11KzA?=
 =?us-ascii?Q?E2rL8JbKt81O6KcZlemL6zl0tsThnv3O0tYHakDH9hRVJ17sPcKxd1LWmVQZ?=
 =?us-ascii?Q?IYUfyiWaxPexyjYqWP7UnXFjbPZ+dfwsglcdPmrL0ufwe2WeW7Wxd1vyDrqe?=
 =?us-ascii?Q?JG0of158IbpRZodnUgNDb/EkIKacib3zRZrPiRkNKs/S4zwlhonnZKt7vQIt?=
 =?us-ascii?Q?CJktCBxgSYIoX1/sEz68qSUDwgQ/T1OoSFB6NQbDIZ/bukpBiR7FFP+U50OB?=
 =?us-ascii?Q?L54OOjASWOhGybiP8vSS+zknYRms0bmfIfp7fNGivEdZ0S8r1cFBedH93hMV?=
 =?us-ascii?Q?nv9hZbVtVPUm/cEP5hOCzYsXT+27y5lANqmQviLeY/3zVSf5PawsMdOkT7V3?=
 =?us-ascii?Q?mQgtAiA1m/c8cbdSgxOZOwImc6xJQCdfNFjOVrsLg8vYe/BLbpjbm757vJm+?=
 =?us-ascii?Q?cjnWQne/vi/cqW2lTjZQMnw2aYeh7p1SYjltnqeAwEbNkXVjRflmmWEC3l3L?=
 =?us-ascii?Q?08SwvA6uQLc1Lksd6A7Q/E1NzHIlG/16mQqTL/Y3T8hwGf8BRAN3w08WS1jX?=
 =?us-ascii?Q?Wb4Q6ATrc4RasygGRkNKbmWUE64q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iO6NSWbHg2xWLZ1F/Iwc29mKOYTIqjtb88QKH6MU+g+8QypJxk/j9X10aULj?=
 =?us-ascii?Q?uuzwemENjLqYe67uhbsGm4hx652e98j2/SWfbT3nicg0ExjIkquiPuXhPh6/?=
 =?us-ascii?Q?zDuDqLeVLcUU9oMaGXxR+t1DtHwBzdErMrEMY6p9wEKBJpZGOJvx7AtKhENY?=
 =?us-ascii?Q?4bNg0btfZDJPddcprEWEe+UxUKijCxIfAWWM604sRI20w2Egyj2O2bVt/8x/?=
 =?us-ascii?Q?pjY6l5Id1TMKw2uLjrNve1+pFIeAx7JDksLRYacfhn+5fFiezo+BWatKaygC?=
 =?us-ascii?Q?5R3UYzwd7KDAmwZqYOYe0RztXD6BHkZhLaNaJsJ5QuJLt+/PJBTOb2EbSAGF?=
 =?us-ascii?Q?qzKXH/m9+w7tPDEb0jGbk0Rj7AKRITBtfw/7kDwKQxbCwsvLFp4ljSJxVInH?=
 =?us-ascii?Q?pmA3lW4FROTdaOwozXgJJU6cKh/WvXpO1vE5VxEzx+zHx6BHQu0gdx+fyrUP?=
 =?us-ascii?Q?cOPfXVrCgd0ztOX7c/yxnsgz1quvtDQbj+OUu+lUxp0dlmNiDfRNvRW7truw?=
 =?us-ascii?Q?5FPiVrhR2MgeVYIE5mjKuc7jAHpcwwVoUgEG5Gfeyy9/wYf2gxz3xApIz74u?=
 =?us-ascii?Q?H3dC+USADdnf9jpku9lngfkrJebqncc7pNpX6ivVsAIB+SaJs6BQzO+gt4+C?=
 =?us-ascii?Q?ddLxLqdm/undfVSW0DNNWa8eGgechjsRQTYGIKMeUQQdFMMx3p2GtWnSBeJb?=
 =?us-ascii?Q?qqMQTow6QJpHYRoL5lA5QBgNYAs2r5mxmWWxusQk3dDmEWSIe3y/mwIJySCh?=
 =?us-ascii?Q?ZZ+/tJWHljzN4ixoo18m9XHjDpNSgVkgmKHnN6hJf98pSeCrFBtSW6iuqwCe?=
 =?us-ascii?Q?kqjM3mGeji+59NBpukGlLAeMFrqOPDjfj+5JrwwlYBE7KuukjNk69/fKFNWs?=
 =?us-ascii?Q?2LC4nVCk9myZZmqeeJQynUw8g79ekVgLH0e1L0Ml11KptTGEqGSO6wca8vBG?=
 =?us-ascii?Q?riYkaJWzU8Y16xJI4Dz29N6TlvbE2ZkSV8fJccASTWQoqjhxGbf+GYRIGWui?=
 =?us-ascii?Q?ICbBcEUsgB0f8dWwr1nkI/b8D1pC5jz8q86gRSLL5YLUpcpPv9yuFY7rW4jG?=
 =?us-ascii?Q?ay95Q8NyoEZSMWMGsdcL7Qd0YbD8G9tyx2X+b1I1blTcUimbBUYATzq2Bd6h?=
 =?us-ascii?Q?kPIOJqtg05neu1LGUV9CORKqoyMmABS5FOsuPAfCvPlbl/MB2Fn44AL/0/HZ?=
 =?us-ascii?Q?cVmD3NKNep1uOcuG4Pnpfyy9XXBrqwSDh4JDcYfsUDij2kwWHFj/svKQorDZ?=
 =?us-ascii?Q?wMdgLTXe09z+RB1uLpVEtIuO7rxCb2Ncy7miw1O/q0WYtxoVeIpNGnLF1Jbs?=
 =?us-ascii?Q?VfwN99I3fBMyoM+HrhVTDX5yrC0nnRScPl8E9/43GSnmDDxdrw/ZQd79gLzf?=
 =?us-ascii?Q?Hx8WtpK7g7QZo5PX7PkrgFLpYlgUZ7Rj2bEnWrRtXUkZxuS1D48+kfS2J39u?=
 =?us-ascii?Q?YTdYbyL/JvIXUnLS6Evkcn26kHQSScBHBmqFdDyfhmLVxiOqmfE82bOGtcMP?=
 =?us-ascii?Q?y/uj6JPwxKyjOa1sqmbDAwi8IkezcW1ayFQ8lH60T7gXNCdDkFN4ax57Ii5/?=
 =?us-ascii?Q?bfaE7WywZtgUqQmSNorGgzu/6P3IMpPn6yCLeK3UuZD7T4T37kZ1nUCfI+1t?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c2eDcMR1Jb0g7MSJyWYxxvWObHZb5Z7l0p167ybnjyScBNm4NWefAwUzmWJ0uRdzRxsEuKq0JmoozMG9BIGzLFAeYVSDnd0v9vwOVZ6bxAa/KDDgNrCb+8SVfWlWbMFABe9ecpSfKnW0wrEjSwGjAiZ2q6FKIwoRwKmwuilSrDuJkDv4rqD+kFNGFHjJBmL/kf/uQr1wuhqOBakdHOD2sZQ7pOFgCW54vHRKi7x7JqS4Yj00z3jzcARLcXVzERuGRd9KyoplnTg5vTWym3irOTThAroGiQpdf+MJc8hj6a36TzHQDczMhTG8IoAgdB0iRV+WHJscGyJm0U4NgupL58wOTDprQhpIIZZGJXY2SrqQ8WATMqNB4qhuxaHfhTW15WN6jJutZCR54/WLD+TypQ6564zTiA6fV1DGqy9+8IGH40hgSCTKTkbC+iinKZwJLRVwGyFg3zSF0y/MzayNPaOsmbJLg3iH1VtEgmDYfYlSF4nlTHUFYN0dZN5JfGqhC/JnZt1naO6+WY0FtgE9nVEy65cFUn5w70nGi9tzw4P1m+Bj1gRFEtlr91xlDG8QIbOFMtikLq4T4vhuxyFSa494dboU1sm6EHTdThBM/CA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1228e1a9-2c65-4c78-fe40-08ddc4e8f775
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 04:18:22.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rPUsaIbPr0jpZFIuYTiq9m0bo1AXDPbhLQzPMRZFm29jfk8fVbQXU2T3ajgTBVKiaHt070b65tJI4nalla8Vcr5rCtt2afk9ONATRVxGPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170035
X-Proofpoint-GUID: RODdO7wm8v85KnJZH5BqUhBLOzKo2z0B
X-Proofpoint-ORIG-GUID: RODdO7wm8v85KnJZH5BqUhBLOzKo2z0B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDAzNSBTYWx0ZWRfXyb672SBOi5yc SXrOUvxe9MNCooMX7rrVvlbrKexcK2beV1xwRnHhTqt7viGjc1TLoDzNnhE9lqqtE2maWP558BS I6a1A51HsI7XUeKVZC/GqgIkAVxlz/H7DyDXWkgbHel8NhGJ15xrz8gmOorQLPKubfBnSQtzyEH
 IV+WImCTNECa/QiZgjGc64ySvM5uJxxD3dR9ZeiOCI0eYsmDACmvvEcs2k2g+1U8Y/SYGTw9IoF Zlvz51uJ9OkQzkymr9YRUPY3eZZ5M54nV1ucGTTegCS4fAcr4EeQACuvTcVarOAFqz0tAN9AVv0 4eyIN5ARlFlEMEkiMDiPVaRd0ZU+QdUOAv74LWqWnDkSjo58RD1Dkau8tnOn8h9U0kGWjDH+iYV
 TI/eLe6kylbvhIcirVmuzQ7HbCtjMdAzoP+aZ4L56QDwMkTG5WfwRplkzts7oWPN1BcdSufi
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=68787991 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=H2fahNeD0bhbl_JXj84A:9 a=CjuIK1q_8ugA:10 a=DcSpbTIhAlouE1Uv7lRv:22 cc=ntf awl=host:12062

This looks to be unrelated to my patch and some issue with syzbot (it's doing
weird injection stuff).

As I said, I have tested the change with reproducer locally and it fixes the
issue, and I have been able to reliably observe that (note, without any of the
below stuff happening).

Thanks

On Wed, Jul 16, 2025 at 08:55:03PM -0700, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in exit_mm
>
> INFO: task syz.0.16:6665 blocked for more than 143 seconds.
>       Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0
>       Blocked by coredump.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.16        state:D stack:26920 pid:6665  tgid:6665  ppid:6577   task_flags:0x40044c flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5314 [inline]
>  __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6697
>  __schedule_loop kernel/sched/core.c:6775 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:6790
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
>  rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1088
>  __down_read_common kernel/locking/rwsem.c:1263 [inline]
>  __down_read kernel/locking/rwsem.c:1276 [inline]
>  down_read+0x98/0x2e0 kernel/locking/rwsem.c:1541
>  mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  exit_mm+0xcc/0x2c0 kernel/exit.c:557
>  do_exit+0x648/0x2300 kernel/exit.c:947
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
>  get_signal+0x1286/0x1340 kernel/signal.c:3034
>  arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f524bb8e963
> RSP: 002b:00007ffc99164708 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: fffffffffffffffc RBX: 00007f524b5ff6c0 RCX: 00007f524bb8e963
> RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffc99164860
> R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
>  </TASK>
> INFO: task syz.1.17:6807 blocked for more than 144 seconds.
>       Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0
>       Blocked by coredump.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.1.17        state:D stack:26920 pid:6807  tgid:6807  ppid:6787   task_flags:0x40044c flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5314 [inline]
>  __schedule+0x16fd/0x4cf0 kernel/sched/core.c:6697
>  __schedule_loop kernel/sched/core.c:6775 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:6790
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6847
>  rwsem_down_read_slowpath+0x5fd/0x8f0 kernel/locking/rwsem.c:1088
>  __down_read_common kernel/locking/rwsem.c:1263 [inline]
>  __down_read kernel/locking/rwsem.c:1276 [inline]
>  down_read+0x98/0x2e0 kernel/locking/rwsem.c:1541
>  mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  exit_mm+0xcc/0x2c0 kernel/exit.c:557
>  do_exit+0x648/0x2300 kernel/exit.c:947
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1100
>  get_signal+0x1286/0x1340 kernel/signal.c:3034
>  arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
>  exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:40
>  exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efc6b58e963
> RSP: 002b:00007ffe5b639e88 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: fffffffffffffffc RBX: 00007efc6afff6c0 RCX: 00007efc6b58e963
> RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffe5b639fe0
> R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
>  </TASK>
>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/31:
>  #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8e13e2e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
> 3 locks held by kworker/0:3/981:
> 3 locks held by kworker/u8:9/3028:
>  #0: ffff8880b8739f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:606
>  #1: ffff8880b8724008 (per_cpu_ptr(&psi_seq, cpu)){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:937
>  #2: ffff8880b8725918 (&base->lock){-.-.}-{2:2}, at: lock_timer_base kernel/time/timer.c:1004 [inline]
>  #2: ffff8880b8725918 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x1ae/0xf30 kernel/time/timer.c:1085
> 2 locks held by getty/5607:
>  #0: ffff88814df960a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000332e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
> 1 lock held by syz.0.16/6665:
>  #0: ffff8880242d4260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff8880242d4260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.0.16/6666:
> 1 lock held by syz.1.17/6807:
>  #0: ffff88807b8c57e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88807b8c57e0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.1.17/6808:
> 1 lock held by syz.2.18/6831:
>  #0: ffff88807e36c260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88807e36c260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.2.18/6832:
> 1 lock held by syz.3.19/6858:
>  #0: ffff88807b8c2ce0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88807b8c2ce0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 3 locks held by syz.3.19/6859:
> 1 lock held by syz.4.20/6888:
>  #0: ffff88801a476d60 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88801a476d60 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.4.20/6889:
> 1 lock held by syz.5.21/6925:
>  #0: ffff88801a472220 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88801a472220 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.5.21/6926:
> 1 lock held by syz.6.22/6955:
>  #0: ffff88807f93b7a0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88807f93b7a0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.6.22/6956:
> 1 lock held by syz.7.24/6990:
>  #0: ffff88807c9ec260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:423 [inline]
>  #0: ffff88807c9ec260 (&mm->mmap_lock){++++}-{4:4}, at: exit_mm+0xcc/0x2c0 kernel/exit.c:557
> 1 lock held by syz.7.24/6992:
> 2 locks held by dhcpcd/6995:
>  #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
>  #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
>  #0: ffff88805e42b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
>  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:311 [inline]
>  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f6/0x730 kernel/rcu/tree_exp.h:967
> 1 lock held by dhcpcd/6996:
>  #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
>  #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
>  #0: ffff88805e42ca08 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
> 1 lock held by dhcpcd/6997:
>  #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
>  #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
>  #0: ffff888078933208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
> 2 locks held by dhcpcd/6998:
>  #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
>  #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release net/socket.c:648 [inline]
>  #0: ffff888078930208 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: sock_close+0x9b/0x240 net/socket.c:1439
>  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
>  #1: ffffffff8e143e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:967
>
> =============================================
>
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
>  watchdog+0xfee/0x1030 kernel/hung_task.c:491
>  kthread+0x70e/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 6.16.0-rc6-next-20250716-syzkaller-ge8352908bdcd-dirty #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Workqueue: events_unbound nsim_dev_trap_report_work
> RIP: 0010:__this_cpu_preempt_check+0xe/0x20 lib/smp_processor_id.c:64
> Code: 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 c7 c7 00 65 e3 8b <e9> bd fe ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90
> RSP: 0018:ffffc90000a08bc8 EFLAGS: 00000002
> RAX: 0000000000000001 RBX: ffffffff822479bd RCX: da4b2af8b834fd00
> RDX: ffff888029254d90 RSI: ffffffff8d994444 RDI: ffffffff8be36500
> RBP: ffffc90000a08ed0 R08: 00000000c506ef33 R09: 00000000624b5ae2
> R10: 000000000000000e R11: ffffffff81ac3010 R12: 0000000000000000
> R13: ffffffff81a7e844 R14: ffff88801cecda00 R15: 0000000000000286
> FS:  0000000000000000(0000) GS:ffff888125ce2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055a7ec2b0660 CR3: 000000005fa88000 CR4: 00000000003526f0
> Call Trace:
>  <IRQ>
>  lockdep_hardirqs_off+0x74/0x110 kernel/locking/lockdep.c:4514
>  trace_hardirqs_off+0x12/0x40 kernel/trace/trace_preemptirq.c:104
>  kasan_quarantine_put+0x3d/0x220 mm/kasan/quarantine.c:207
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2417 [inline]
>  slab_free_after_rcu_debug+0x129/0x2a0 mm/slub.c:4730
>  rcu_do_batch kernel/rcu/tree.c:2584 [inline]
>  rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2840
>  handle_softirqs+0x286/0x870 kernel/softirq.c:579
>  do_softirq+0xec/0x180 kernel/softirq.c:480
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  nsim_dev_trap_report drivers/net/netdevsim/dev.c:833 [inline]
>  nsim_dev_trap_report_work+0x7c7/0xb80 drivers/net/netdevsim/dev.c:864
>  process_one_work kernel/workqueue.c:3239 [inline]
>  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
>  kthread+0x70e/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
>
> Tested on:
>
> commit:         e8352908 Add linux-next specific files for 20250716
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1523c58c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2594af20939db736
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=10776382580000
>

