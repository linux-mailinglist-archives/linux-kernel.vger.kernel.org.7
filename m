Return-Path: <linux-kernel+bounces-730158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E02B040CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E23D4A1B56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D3253957;
	Mon, 14 Jul 2025 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JnxFMXZU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UB2RpVNk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD92517A5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501540; cv=fail; b=h/4zodEe6NFRj6VmBwYp/pu2fyFxGsro1EuKJ65Y/nUUySgcSmC9URCkROFkNrFsmAqI9Ri77JLgIxXw+7m0+QG+mCRn49rcxk6T215K9AIVlSv4bHlmCa2PM+U47Hw15FU7vfUlL0UqU6Sg3W78wMK/+ZY1Vp8bkGAPs2yagjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501540; c=relaxed/simple;
	bh=sc6hShmKPRgOmb5YBDi9ceHrz8fFE2QlgVmnC2UYJq8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HZB7SS/YeACLf21P2EoWX98l/cSDUQE2sDV5YjDXjLsRRViOuHlZykYIfgtQq1CLukI5sXhopNRMSpf27qp4MJwYh9FY6/xgTwupQWXopfnHew8fLuTGMfomiUleUoEdTKQKbx9iOJb9tVSImfCUjW7Zi3SAh1Ywg80LaxG9lYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JnxFMXZU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UB2RpVNk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z34x018923;
	Mon, 14 Jul 2025 13:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=M1Sp4EK3LtfwGVfK
	d4ZxLyfysoSVsvyiY2EGdh3+e/o=; b=JnxFMXZUKF1ApzInsRA7ChHJtUNOLkjE
	vSw9sID9MZjb+pcLv+yiITmiN19/Ry7rmyxmr6KZ4ODOmtlaQK2QMZOYpKi116M0
	Bh7slUy0MpPrDfN6aWeUfqlPcTG99pol8sdbnV00b5cqwDgzaYWKeeffhfFVX3IV
	QywylUsb9etMUuRcOxeonJkg3zpcnZ9BoG3KFsrjQ8Pec0drJZsP5Ns4G1Ijp+vl
	qKw3a0Jzv1c7W76XozOPLdpd9HgMrVoIeg+KpY3jdoZY9clY0YR8EozXmZuIrgrV
	Nwg7UiEO8sY9MpcDWaESfohaRbcFlXkHl8poUdftU8x4c3yKZkzchA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1av679-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:58:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDEgdD029770;
	Mon, 14 Jul 2025 13:58:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58ay9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6xPV85J44dq3p/g67C1CFkZgK2zwizzJFIdlBdFuYKBFMKNrRX+ljr6EBgnSwSF7urPGufvch3rHM3aVXBLnP268yS9rQoaaBdB2M67YMMjAX+fKl9x/F68icW5ur8G4dWCqQH9IekaTAl9a/hl9khIkXYacGSNpCVvEgZyAVBbmT7EZPvh5S7i9gFgG/jThSaGC1dfG6WGh1jkuQ64wQ7ahdKadFf0rhCSob9JvcFnlOmo/Wvm2SoSrqd1NUOtnUQ9xyur3JGMaBsBDIBHi9ZnFaspVoS3q568ekWOFCf9QCo1RwW43VsBkTYZQWJUWEyXnXSmIjp1FhD3laLt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1Sp4EK3LtfwGVfKd4ZxLyfysoSVsvyiY2EGdh3+e/o=;
 b=ALd/qBaQtAuxk2l26KHE+iqNGLJY2bp6Jl1kVeq5iGoLV2DHIydbsIKpqAFoJOhXpr3U0Ji/C5iQnvlsOvMPRyCrSzK6EhtJBip/5ApPa84u3lI21qGgjRzjCEbBdtk/uX6hNJkq0f1dm3iq28LpfT0M+3fRCFtksfRqPqcWAFtuDxYMCBei7fUd1I34ATe3cUmkpAXgw9IuNsHsnihppLdG/XnOGoC2OfcN6t+oQju8grIPvGMI6vVAIyWzOx5/w09uAtxxbwgMXpefGOBzphhPIMj8XkkxKdolbnpo8wMgzePx7SjI9/i6yRhLAMFfYhOmSd7mO+jI52tyu35fiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1Sp4EK3LtfwGVfKd4ZxLyfysoSVsvyiY2EGdh3+e/o=;
 b=UB2RpVNkMDq5ozbM3z97dLlFY+BJaH+M1jqL5mNUprFWk1wpH3+MYTnjyNbG9Si4Tp6YUFEYtaYxHqXGsCGqRuPEHFD0VwPVXpZjmGhHYVojLqK8gQRzk8Y6DKfYsgLEb06sLwXF4gzcY/3WW2uwJDCu9jyTWKtDfRMeL+bFhLI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6155.namprd10.prod.outlook.com (2603:10b6:510:1f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:58:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:58:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vma: refactor vma_modify_flags_name() to vma_modify_name()
Date: Mon, 14 Jul 2025 14:58:39 +0100
Message-ID: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c2b075-3d97-43cc-4bf0-08ddc2de8afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nlQzTWODDftQWrrmeclPotqxESY/8tLqNDJ2k3Q1JUG+g+0e8fCX03F06m8?=
 =?us-ascii?Q?3U/N7QPqTui4Wjrpd/Gp6IaL8ZGfnouBBKvdHwynCbQPYpgc3bsjeEkCPF/l?=
 =?us-ascii?Q?dixb1KJXfgN2wIb1FU3B2Zwm36njjANpwgMcAcmMgrG1aKmWimMlEBJOnu/g?=
 =?us-ascii?Q?YPBxGUQHevLGUUopy1JvfwJEEAeNPuxvIKU/jl0r4l2/8iGKu6DPd7SaBOA8?=
 =?us-ascii?Q?rcvAPinzGMVTdg4Gj8VPlU3uCAMjbLjVpmZo8+aVyln32sq8OowwplN/3Agz?=
 =?us-ascii?Q?vKA3jt9oaPsp0BzTFwDEGNIPqi+pAH7q1bXTCzw9AqNbN9WYl9SBd/5RzDAK?=
 =?us-ascii?Q?L9kRFoRZLaiwbAiL+ze26XO1+fZcw76UlGIGTsvpz1LgiO4f9Okz0ad1iHpK?=
 =?us-ascii?Q?xO4keitnNlgyYJzJ6hrAqXXQ0N9G5dQJx6zED0qkv1tg7J/xfy7l2WdD7ceF?=
 =?us-ascii?Q?zXxg0zht5nU669565pm+BT8sKXg94etjN3oSL/UwjZzPqttPQVy1rf4xqlEf?=
 =?us-ascii?Q?CELYXHRjMzakIgA0zjJQNNzPb2qdoNqIOmARXGYxFFdCuAT8p5Ab8u5OFZil?=
 =?us-ascii?Q?CkJ2i/myxv6wmFGpNEBZ2lnp0FfXWXxEIK0pAeUmylOMZa/N17nlIvmM0Y8D?=
 =?us-ascii?Q?AagQblbdAFgnwxQc/hmIUbW0HLxe0srdMFH/kUirDxze/RxMQNDEu7WNfuZ5?=
 =?us-ascii?Q?asLp5kO5YX+I8yS3A1odMFvNSFyWPp3+91ygAk8eOQkVhcoUCCRLolvByhA8?=
 =?us-ascii?Q?Oyk6mM6dFvEsZ4wlPqCaUUX12dDXsTJPJE///aLd3g2hW9UY4oSB70iYV2Qh?=
 =?us-ascii?Q?q1P2FHoW8SlR4CoLsQcs4RHShRoypga7FDbgNz4ZIMP+sr12kZAyYzzb5RKm?=
 =?us-ascii?Q?cY9agxleWxa4GdR1vqKrYXVoMkArsjyr2Lpedd1xQWFqS3dhOntIL4JN+FjL?=
 =?us-ascii?Q?MJsUgnnlfLqmwcaKgpbY/h7GAqjDiythF8eZvtrESNbAuJ4sVmlv6ehe6UmD?=
 =?us-ascii?Q?6bFWv4L8YtEsUjghsJX0cnnAAMSzLUN5YxznpT0JtfioVyUsPHoYsZQIdZh+?=
 =?us-ascii?Q?+zKJ8fpzXGdyc0h6SmhEIoSqu+3zHUuQwXVJOM0rkTuI6lsK1RH/uPbt9ojC?=
 =?us-ascii?Q?luJmdu/qC9aCEWljO7RMaKL2fCIXcnfDITdKpBTAhqk0ChJPpPaNOnT9c5oD?=
 =?us-ascii?Q?xkjgVpGgf16lz41rNbLdREj/VQzbBkr8SvFZ9T0F2+LvyvukCObjp83McTB3?=
 =?us-ascii?Q?J0WdGdGb2RQmPV2MxTULqXbD446C1VPBaBDG7rxZUGF79B5z1H/P7GoPflXz?=
 =?us-ascii?Q?lAkkerQw6QaRViXL8DXI1IdpAhRWcU48XxQMrpNPxIkfKX8yQurtGS2JiFL3?=
 =?us-ascii?Q?3kw59DJfndqspRaWeiwH+dHy9mFMavL8FysxlIsXUwIcovC0Ic7b8zy+ZMfH?=
 =?us-ascii?Q?nJQckc7rE0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uC75awjrbxEW2cQg5mwVcmODLpEmuEcHJizh9Q7Po54f2ySPjKk1iDtrYb3Q?=
 =?us-ascii?Q?fL13MTOn8b3GxTygTz6TB5Ae4X5AzOvcCqnkFJFADkkH7y49RUCkwcZzCqt5?=
 =?us-ascii?Q?TEioABUkweB5VSVQJ0djtNUzER6v0K8aNOv8gRebmE0ulvSrIyQhcxsJA9qZ?=
 =?us-ascii?Q?6AF1NYqvyk8ey8kyuoVVJ9y7nQwmV0RZrjY/8QuMo24xJbG75x8V+kN3IjB/?=
 =?us-ascii?Q?42afeICUJea6rrMS+ptpiZs13x9pPepKyCxBShg6Mxz7jML1YSrc9d7+dZ1M?=
 =?us-ascii?Q?SpcNas++lwQjkhjKiKPNEyXpINRXe75ooPyYMrTSAcXOPwpKGy2n9YfwmnzY?=
 =?us-ascii?Q?fET6ohMRkKgaMHxIJlLN4vDsCWA6kpY1/VjWsvz4wpn6/aBHclSAXM4bFswv?=
 =?us-ascii?Q?bTnjXWcM6mPXQ6oC+G8awLy8zVnOME+k4R15qHCw+Ir6wS0VnjOBRc5V4x1V?=
 =?us-ascii?Q?Snuc9XXjQBxNVjEW4MoYSz9Fiofl977PKxAWyTyU/hbyrHqg4Pb5EWznyPpc?=
 =?us-ascii?Q?s/d4lX6wnAGQYWHMAkr8725TL22pSEMfMHzAioZMSWldiGYLIczZl7KyT7IN?=
 =?us-ascii?Q?e593TQ9JdJG5vbmSfTRd7D5r3YySnAmu/Fi2KCZIvBQoEc31DQyqhy7ygrlt?=
 =?us-ascii?Q?z1wX1iZeRD96j3UNsudQclPJ3MzOdZ2mfbqEFVyJDOGllBZ9+jGTA8Hqu1/A?=
 =?us-ascii?Q?T+WPc/jXyh8C+ErqjjuCiXsXReyFD1X6m1ItxnP4fIDbBLOYY4YJLARtPNIi?=
 =?us-ascii?Q?2x/ucCjCpEzPv+3IPoV63/YtmQMUg411tk6rBNZe9kegVUaVQL9PbCLQ2eSR?=
 =?us-ascii?Q?N2b9KxdeipItopk48GgOIhVcHCe98ghmUxOqYrBLVz1HkkqRQJioAXVqMOIr?=
 =?us-ascii?Q?D3AEobnNlgvunhJD8KIQQ1nfngil07geJmmBQOaLyYUV2cLIAZI/QC9S/dmF?=
 =?us-ascii?Q?39UHn5ErHPP/sBg+z+QwfuK18+CxOGgXwO+OycF2u2JZI7X9YLVjJG5SzWWI?=
 =?us-ascii?Q?H0drUupPsln6yNhCdwQd8DCw+J+zk3eqBu2PQBjwifnzqpRe8bXHoZ06CRfC?=
 =?us-ascii?Q?BfI9GqBf4YK+co0SvMdn9pgxF3z1ikgdcdCwpng1zkJ4siB+s4ahRxVBxW5q?=
 =?us-ascii?Q?WOSpQloyjOY0s9PFPstX1JLB5EAf1Y3hjv/ZZ8w69UjOYZP03rqpe7BRyfl4?=
 =?us-ascii?Q?AU3MWokPl1nVlO4L1YAqWj3JUcOXBO9K3ExMZ4+exVjgtjXUaqCUpRGoIrm6?=
 =?us-ascii?Q?wC6VNWjHx3LQWKqAY6XU1hnzt8uav0RQePF2ugn8FC7pXyLSqpbLw1PKPoz/?=
 =?us-ascii?Q?KZlZNQaZU+8nRH4IGsFlIbDXD7cJV1+jijT9Nby7b5lOvUYPnICA+2T4eDXw?=
 =?us-ascii?Q?IFs5DWldV7ttgCYrlgPs994pdpQgUGbKdPJHWKnLG+c9bdAfkipwU7xMuamg?=
 =?us-ascii?Q?gEg1f88cIXZPNY6UPZbLS+1b7eNtg0VDrta09P/TcTMSXPifg7pANcDM0B9J?=
 =?us-ascii?Q?dOrUHTgceQFpZaA3Pbx2bvwvTx5AgYTlnexa+ckG5uXl+8JaYloHBz2SX/uS?=
 =?us-ascii?Q?H070pVmIM0MKllkXdw/LWyF0yXczkswwvRdaj70AQHM/Xen5T4GUGSFy5ihn?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Bv/q3BoP905f+mwwBsiDkIkKpV2GZkIormDQKONeYg59inOnyjFttwRQVishQHOW7zkMqnW4sItsmzGPpnFedLQR3+XkqNf+6bAh0QCAVdt74ouI4/sDdgr6kwdmSpXBzNY7ugy41TLN/2/yEISsTG8YJHgcpqR6X5/wcHM+EFnq/1X73myAS5Dl6j1GOLhzVyzRGHxACqC+etfE0QSOytr5g4JOclAXirortSsyZ48URU2oEVOwt+QzwL+mitVQuwYxkUqqm9v/kJn7OSLcd/Nkud/fqqW3jXaZYwN4V+ict9h3d6f/mvZJJY50kgvYHG1S2V+eM1updyRz9JmhvuAqWKtvcf2AxDD0FVwvBBXDbkReLx6CB6of82SYvNttKCdFjcZLWRJVEALHC3aBGDu/Jk71nd3hrrNTG/lrU0IQPcct5F9hPyLdPWpRfXH4QWm65ZaikEayb1SFI92vhjmywUDJrEsmfC1YqkefjD+iruzxKQnM4EmFvpHewCx78wsRqoUuuvptSgCt9VE/L5o2vcrOPKkcveg/PC3uqPAkLkPOAr8q0EoYEiUVFovzX0r/cfcY9aArNBAk+J14IdkIsGjIxND32oL+hd/CF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c2b075-3d97-43cc-4bf0-08ddc2de8afb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:58:42.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6N/2UlaKRYnTkTi9pB9bx0/8L5QC5jnENFCuZGLHdRdiGiUk1bMnwQP12n8JTH6yNSR8YCetDKC5Wgw9IH9SedTbbwONl8iOfb1vYn+ZnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4MiBTYWx0ZWRfX3gfo+yPC70Ou f/mR70qK1h1jzEDsEOsQZUyGLd6/4sU8hiKaVWW093qdfe4UOZvkZpj44dsPY+XuPC4kU40aGKE 66AOs7koMq9LUU8BnNkypBpaiD592cWStBmfnu6v3lZvb7OrayJOdLzbA2SOYIrX+vpsYuPGx68
 mTBh+mTnkQZ8IQr43twaK4YqIVGbAJVQUiakhr7Z1kUH4xY3G7UIi2iyaiPHJe+jNJKGXB8ipKT lxGLEbm+e+lh+9KbBkKO32llTvDhNmxx7JqyfY29NOuohB4OuEV13m5mifTzCQTADgxLI5Ez/Nl janwOf8ltQoKVmDXeE4qu14F0kqfnoc8pK9Tbo6/muyTBNc1sga9oPnElKvvOELkOTW5EZbCCXN
 oVA8gqnZ3ubd7ub/Avnw1th+PSLO5S/EVHSs0lScd4yZdhct9MCTAq5dSFY4iyid4rpSXBQ2
X-Proofpoint-GUID: UFYDFKK8XHJImqbtmPFgNokP6JzelvlS
X-Proofpoint-ORIG-GUID: UFYDFKK8XHJImqbtmPFgNokP6JzelvlS
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=68750d17 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oWJLeghRLH4mRXU-W0cA:9

The single instance in which we use this function doesn't actually need to
change VMA flags, so remove this parameter and update the caller
accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c |  4 ++--
 mm/vma.c     |  4 +---
 mm/vma.h     | 15 +++++++--------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9de9b7c797c6..afa9e4db2adb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -162,8 +162,8 @@ static int madvise_update_vma(vm_flags_t new_flags,
 		return 0;
 
 	if (set_new_anon_name)
-		vma = vma_modify_flags_name(&vmi, madv_behavior->prev, vma,
-			range->start, range->end, new_flags, anon_name);
+		vma = vma_modify_name(&vmi, madv_behavior->prev, vma,
+			range->start, range->end, anon_name);
 	else
 		vma = vma_modify_flags(&vmi, madv_behavior->prev, vma,
 			range->start, range->end, new_flags);
diff --git a/mm/vma.c b/mm/vma.c
index b3d880652359..fc502b741dcf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1650,17 +1650,15 @@ struct vm_area_struct *vma_modify_flags(
 }
 
 struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
+*vma_modify_name(struct vma_iterator *vmi,
 		       struct vm_area_struct *prev,
 		       struct vm_area_struct *vma,
 		       unsigned long start,
 		       unsigned long end,
-		       vm_flags_t vm_flags,
 		       struct anon_vma_name *new_name)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
-	vmg.vm_flags = vm_flags;
 	vmg.anon_name = new_name;
 
 	return vma_modify(&vmg);
diff --git a/mm/vma.h b/mm/vma.h
index cf6e3a6371b6..acdcc515c459 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -290,15 +290,14 @@ __must_check struct vm_area_struct
 		unsigned long start, unsigned long end,
 		vm_flags_t vm_flags);
 
-/* We are about to modify the VMA's flags and/or anon_name. */
+/* We are about to modify the VMA's anon_name. */
 __must_check struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       vm_flags_t vm_flags,
-		       struct anon_vma_name *new_name);
+*vma_modify_name(struct vma_iterator *vmi,
+		 struct vm_area_struct *prev,
+		 struct vm_area_struct *vma,
+		 unsigned long start,
+		 unsigned long end,
+		 struct anon_vma_name *new_name);
 
 /* We are about to modify the VMA's memory policy. */
 __must_check struct vm_area_struct
-- 
2.50.1


