Return-Path: <linux-kernel+bounces-728251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E3EB0257B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E4FA8220E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352F1A265E;
	Fri, 11 Jul 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zq0IOhOH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xyviGK+r"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505A1F1932
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263558; cv=fail; b=FhE0kI8LBuOwhbwFvl5SNFgB7bogfFqgXmy9MLAgT1VrvQItKVke60JoUgLNEEYXlb/5gkHjwNi3yDvkVeCe4+0SGBFOSEnvnWmLL6N/WlHUFbtfLT29aOCvxVQov3sGeSYyTq40Z0PPjUdnHBtgYyQdBS2lV9TydX9dv9C7gLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263558; c=relaxed/simple;
	bh=BMftOEJElxG24QRU8PwLWeJqgIy9SkwXGtWNXMJJzC4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=XWXrOOsH/oYAp4gHTsTHbMkZYL2tWXqYzl9Hf6elHnqvOjIGZp5ac6pfDyhOC0jU+G6vDY9gPS7TZkyNX4+tI/b1F9GboavdNmgo3wWk5PZnIoWu3J0sdX3jvuxtBq/7Kf1zMgQYd7oZjK+A2HMQxj25OVKOqfyhW+Mo+xGPZZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zq0IOhOH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xyviGK+r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJlnbl001646;
	Fri, 11 Jul 2025 19:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jVOsiFQQ9OBmQnuQlv
	ywgvAkCYhDBuwFugnAvRXiIFA=; b=Zq0IOhOH6j8kAwmhqQR5B2WrqkvEAIHiKD
	Xg427ZP0zHd8NfX+gU/FsRZ3uMqXhhZgGiHjIS0PHsX9Gopole1Nb+bGtkvP2Jod
	tmvW9AfxcTSwbkDBb2AoeXUQKAM363dLsg7H0taWr440Nd356LGhgIWD+Uwyqwix
	vviqUvshVEwxAI3yaN2omKKtxCaBJ2p+sS4e70i1aXs6pqkc7/g8I0PFNgw5MxRE
	ty0+E4ppL9j6WT/dU1sAapSquFCm3XTZPt75owGe8hah/Xx6KpDadWU9opMI/Iyb
	DlEhtrSRakNwMycyW3RMVL8V5YEwdzkXllnHI2A7E/UaaJvsTjxw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u92r009p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:52:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJ0Jsu040566;
	Fri, 11 Jul 2025 19:42:43 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptge6wdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 19:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kby3IvpEw6CTp/T3ft2QIk+az2UucUZ9yiMeJRR77snzyIukDoSd09OnwP5ugypgrbwD5ECk9BByvCVXGMyB9syesYMAaMYe5aYTY0erfLJ3vvALtpRARNDcCRVtdPZFOnf9ZhP2aXg3FiBy23c79YZYCGwgQUU4IPJNpamycx5DCYLKeu0k3IrI+TopqivpgpYL4IaGMwnNFjyzEw8Myw9NobOOp5ucld1cO3O3+TcPe6M1fYxHN/eJETiDUSsltgTlP3lxOBowVZyLR6oJEZFUXMep+IXFFTSof4ALHnZvb1ehxq8wxAA5BIrYWC4ZC6E8MmS6ClQFjwe3v/Mfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVOsiFQQ9OBmQnuQlvywgvAkCYhDBuwFugnAvRXiIFA=;
 b=N78QyhsutlmsYQWQS1RepnHkfIFfkgm2wpoNNnpfZPrD2X4gJG5KX/snzSVlityKPJxab4/1TOzk8ttYiVORu4RecRChXDpaO4LvWaMU+0EtNOnMBjWaGzgIOqIV1aBMOn0KGOLVwSC09UJEzbjOvqkLukLk8rEOxQEMoxVxmhZ3vO9kUXYf+ELDGPizwsyz+LKeakrll6SsLpldqNmE6P+8ifroxEQ5awyZ++n19qTe3TLas3VzQDupIl9yaAAJj3whff6+/hgdW4spD1DHbQ0huJkCPfmm1LOMCSNZ0z/hQVvuhYOY2gn4Dlr9bCri1SA3rvDlYAEN+6eXyxdIDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVOsiFQQ9OBmQnuQlvywgvAkCYhDBuwFugnAvRXiIFA=;
 b=xyviGK+rMlNIJkUnGsqqvLYU3IVc7I2JIfL6GeBGcvXpxZMwuB8nl9oU5vz0ZcODMgNY4VB5SVOFe7I+jZK1caIzVk2W4JA/K5abVEAdiB2UaWAVBvvT8BPWwA3HSwgUN6hn14YBdZzdytFcEy+a573PvCMVXI/5WhVmhBqgKEg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 19:42:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 19:42:40 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com>
 <87qzymocok.fsf@oracle.com>
 <9865895d-c9bf-42e2-b813-bdbd39ad3af1@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
In-reply-to: <9865895d-c9bf-42e2-b813-bdbd39ad3af1@redhat.com>
Date: Fri, 11 Jul 2025 12:42:39 -0700
Message-ID: <87ecumms40.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:303:83::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 9407e34f-c519-4595-93e2-08ddc0b318d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PXSUVeJv73E0oazqLuYbghCAIifZBURyaZAfdYuxZZm//aIB6QCLXnhFtnFH?=
 =?us-ascii?Q?A6+IF15o/AUEwhuwKaMUYNBiXXzPfAuJtk0wKWAjgahO8PpQyvaeoOrch+9Q?=
 =?us-ascii?Q?uXVnRj/icO1AwZh7uE6baicb1DnZf2G+try9NMYaBa3y5e7yfnELLaiVHEba?=
 =?us-ascii?Q?ewKBxpbNrtZN9WBI28cXxF6HdIAkEcUIrlEbjsQCJc3NT1eeXnCsS5YlCCPj?=
 =?us-ascii?Q?+C/YEoM+fm1GQQpmAj73gG0tiWwTPxW9fgAYaHx/3nmnswid03pkbbZlV/mc?=
 =?us-ascii?Q?2choGJXorcijjnEC8CDOL8KNn5+ZWyDjRz3JY5n8z0Nbwu7lRZ8UqgnKdZ74?=
 =?us-ascii?Q?TEnqV1cHSuKJE4hs32iGPn+vHZpE2lbAWWOqQK3rXUEWmeSnngmyP6GFvfwg?=
 =?us-ascii?Q?zlL40Xru2/c+aS8pv5PwhpLeNpfne0YZV9QZmgHA30ca+E+gbPcXUknfW6/1?=
 =?us-ascii?Q?OXWx5YpbN/JJvkJCM4E2zODiWUlZZuD5r75RPZ5eddM0DxJCFTlmV0VThj2S?=
 =?us-ascii?Q?saOHlHl/6q5BRxq+kRm6JZvScby3PTDiZWWFe1pnEjskCtPxiEkIJvjoyKZS?=
 =?us-ascii?Q?rJND3lh/3PCCFqnXZshD7Kj0T255D9x1aXyXzigoaXrJGA+Cziq5RTOImgME?=
 =?us-ascii?Q?ztcvpTZ5ANzQxPtFJ2SXhqpxvkTFStNstUZ+hsvFzGmeUFpp8cDUFBQVln7g?=
 =?us-ascii?Q?AaIeOiOIfiYKxUob+EFj44uTtqXNmyotVwAUV9has/WeslKBcVTWs3X51yps?=
 =?us-ascii?Q?I3itFTrs0OdOiHIBYQ0Jjc7qAn68tz42aZ1NRToeO3qRp+nqX6bxqlHbIV35?=
 =?us-ascii?Q?YsEM8qc+CCnbopuCvucP5MnWKlrS00MH7E1wXvTjpute0jNyfhKBW+7NqUse?=
 =?us-ascii?Q?2bWZr6WGCfO2lCooloMk7DpbdQGKPsXgYnfSiUKJAlUKlLnbo3sLknnD9/59?=
 =?us-ascii?Q?2h9iCxlnQqZaXao3CNag4WefxOTfZJybG3ahAG6zDdx7v+S/0tFFdWIPeu1f?=
 =?us-ascii?Q?HUYuDRiwata2vnlueO794iYAtDGjGqpuAoSnkYjAChLREQQxHJ2/ZfR3BW/n?=
 =?us-ascii?Q?rgp/ut7ngCphbL2OoI1sK+ACRyhxImo78nJkOGlSkLtvJ4wh5u1L2PGEVtkU?=
 =?us-ascii?Q?AST79HF2MntDbXOMpI3uJZSSvOlaDDF4yyyGduSEl1Fpoz1Q7yNe0+GVLDqN?=
 =?us-ascii?Q?58uZmcKHg5nNAW+N4bYs4DzwX6fqFX9asPLy2HxPmjUBZltw928U9JmvGlYk?=
 =?us-ascii?Q?owOjmuJFWZZtxApO/JNxJPSILfc0USjU0D0SxFazDzQDASs/kpDdDV8upKPb?=
 =?us-ascii?Q?lBfDt93Ap6lvTR//L+XWIDlrF+L/951ZfMnYlX2oYJP7dJ4qL5X/1XlDAGYT?=
 =?us-ascii?Q?JuoUQcEYuaPtHYsMVbDtpmiFqlVv/xjQG+qeKnafPtfFVPhYogI4XEKTh1sW?=
 =?us-ascii?Q?QO0XFredp1U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/mggT4ymy9Cr4uMcdKd6ko4KOAbcfJqgzz4G6xI3nRp7alvdnrQQwQxgFoC?=
 =?us-ascii?Q?z2+nbES+8EyAquGLlu0VuYONwnRZgtpwg4+x6w+jffjHNgojP9N1jkpijBGc?=
 =?us-ascii?Q?7IWch/+YnXJVtINvoihCqCqYH8+M5liVazAxLa046qfyoOImTZExg21A0LoT?=
 =?us-ascii?Q?neTNYZ+yVWFW+1UsLnB4h7ibQIvjRWMmvaj+NLP0kgXkR+0VNLUUzkHVDwnc?=
 =?us-ascii?Q?ghSGGme8gkR1EgSpaK5PWGz7a9tLNi1ipRd6fxxLMLfWP+/UJbnvHmeUHYg4?=
 =?us-ascii?Q?FcGoR5wM6CWvQy5o31KtuI/NvNsAS9UWVB+XJITnmrNPhTcu/mZRUAOYY26v?=
 =?us-ascii?Q?tD5JxdEKAmKtKRn8M5Vuga6lBbGwjasBfPk5L9v7PH5poZvaD+Hkz9kY7JHe?=
 =?us-ascii?Q?mdm1GCTm0ngc1HiyIXpUta0xhCTt9I9vSGiRrEHO+t9EaucRaWDTYLNxowxq?=
 =?us-ascii?Q?iTGE4yJXSkMUAzDQNEWXdUeFi1msh6CTC3+ffzDcSj+P5WUXXOlNBAfLm+ng?=
 =?us-ascii?Q?c7CbkCLD8TYZJ3jiNBWzmyLIdKXiTkPrJ3ojgDLrFP+CFjP8VWErYdSugjn1?=
 =?us-ascii?Q?iSDNJeupmmVyB6aJoHQ3v1NHDwkrhlT6XfbQDNftD13+np3G8IBszk8JiCGa?=
 =?us-ascii?Q?qIUJUu6hGNLgE59KSxjHXd/2x1bpABP4A0YQWupxVrFi7tA+9pMWjuoAeTs6?=
 =?us-ascii?Q?shvjoyDauLdbPXMXrrz2HHFgugReta5x/O/ncQ5B54GI9R1eSjv6yHaz0AtT?=
 =?us-ascii?Q?I2QZqXyOZX8yhKHSeXoYQWhep7hRUFb/v/ThhMMXk7ovVTJFi1s8Rgh4SCWE?=
 =?us-ascii?Q?rNXHR66DxWcxer+FNpcZP+F7DRbS9LbWRprfapKmE9FzPBN25sHPm24bt3hK?=
 =?us-ascii?Q?fqAKdudyKFRfN6tNGWFTukfbxrZZC3VDR5q0fj03TrgfXJXDaudYTUfuPeso?=
 =?us-ascii?Q?W3fGj7Hj6r0Jaf2prrhml2V/9QY34XSiEAx//EzIgxb7h4uNKaXAlQu6X89Q?=
 =?us-ascii?Q?1dL/1BwIjo1pH3KhHSo8zT+iRIeOGqy5n5+Z4CUXvBJSeIw3540vdi8GeIXf?=
 =?us-ascii?Q?204L0aXwHheVkO5gljRIZRZgogzjjgmLtxxz8C1KKCTlwr208VGDwzllh1Gi?=
 =?us-ascii?Q?MO7U0NdYBXjk+tiGxOfOsKvtxEbiqeKqSZHKCS5MnGw+dWOF7A8Jgg1E+OF3?=
 =?us-ascii?Q?kETTb4f3b2p9JEsbWlGjqzZkXH51yiqP/GGJ5hOW0usb9mLCn6Hz5bG8VYP3?=
 =?us-ascii?Q?q00I41/GYHU99W0nX+il/5dEQ/eAtnn59o1W/QR8EF1QwFqEP4CdZlaI5lxs?=
 =?us-ascii?Q?07RkHwSP0U/pxCEc8sbZOWB9a8omA8VAdsrmd6cytZpz/vAnvJ16ofCiV4xS?=
 =?us-ascii?Q?3bXwWs+z4q+IErSqvHvkW5cB5WqmHwJ5aOKsu6v64xsb+oRiNXuBIUcC00jr?=
 =?us-ascii?Q?21YsQRRTGaP92vMzNnapgN5JKHvwrMNlm+hja4ca8s3BkONPfXoECeyX2F4/?=
 =?us-ascii?Q?ACpzvBgBc9ohu6dvpvVrhnDu3u9baDrPnqCiNnvdj3Wxfrtz04wK9fRmP2iF?=
 =?us-ascii?Q?D+GomXRIg16hdV71yKFeEk/jRWUSHPMC+TM4eJTK6NClkdDhF6o7oPoy/LNK?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BXn9jTRNlkWhWa/G/VJvgsTN6QYPELGf59TOz14UQbi/5EdjyTIPxIDih1R5Dliy18S8/EcDMqdFh+EnmWqGMnogi7+nn46b1gkK/WKTfv6a3BSSYdjNA4b33K6L22jbN2NOdxECQiQ+nsvnb59qKz1tTCCJmMyhn8hwdo1hMoI3M6j+k2WcM+JHbZwgPtb8SGT2HOriJfVhl9mJaRDjdraE90zuHz64gwxtVJ5ge7kLiuTosTd2093C8Ub98AjjravM6FxTJDGEYxjQBee5sVeKCXbvOBRdxILuD5XzkhkqSSYL3oOALF+MqFgSsQR+RvzSJJPUjqW+Qzy3gK/j1NDvQ623/zf1UXw8wYE0eoyiHucMg8Vd1FDG4oCABek4ufQ63gioYUfynlZUh+SE7SUlu1sCT2J1WqfDABdAfb954wtTIlHbYK6WlnZEHynrp+kUgUYxkccB0t8iCDGetILakTAdxU4l25w73F9ODkbBBYsNkevvxbqr2BYy88JpCpsKHnWsWGHOttAKxplZEL/ia57+7wnYxgGzjUIkr9A5V0j1g8ITzy31jnnIS36hfqv1L5gXW/FrLnoSo34C1M/pUlsYQa3ob2/atJyft6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9407e34f-c519-4595-93e2-08ddc0b318d4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:42:40.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnJR8THK+d1Zf+mg1rSL5LMLp86GGIsZXZ/9pUP62psKzkwNWdwHpStEzpPKCAoJdbgpFaa6+X9+MSuhRXT0hzxmyWq9ErkKqveaIqfDp1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE0NyBTYWx0ZWRfX8J1VXN8uh3J5 6OO77zKt+gH7wJuha1lpz9IQexcjJLvofqOplDInh9sgu01fQ3nSRuWRjaYfaFTLGDHyfO7uAeT t1IIoSyWzxlpvK600I0CUXvQsFynHOH/Cjumtqz2z/r42JW7eLkH6XHUMLMR1RiZi7uoeMEwTD8
 002y3wj/wZVQl2sYBOQ7mxWX5fjM8OKTKOqBiLnrDT8td8MPqzEC0OAe74sXPY/5in5/p78DGlV XmRQ6rMkalNzYIpomd1Hkm/LF8V57dPTBGAJeiT1ntMpZGbgvJ/+nlmawYqZv+l1UHxSlLoU+0r vokIRAH8a+BjtUaW8yK5i2BrIIpQ63x20Oed0zA74J0gupFCUXt5DeyEuarxr8MOiedR8GyMVHt
 CgCzrrZI3gPQwncXmFsNT57Vx8/MQ7pcyDAaylwVZJQwiH5U5peX+pjCQaICTpu2WpwOYrwX
X-Proofpoint-GUID: duRsvXtr6GAREeNJsvjyzj5CQYp5y7pU
X-Proofpoint-ORIG-GUID: duRsvXtr6GAREeNJsvjyzj5CQYp5y7pU
X-Authority-Analysis: v=2.4 cv=BrSdwZX5 c=1 sm=1 tr=0 ts=68716b68 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=xdULd-7wYXAVvBIq_qsA:9


David Hildenbrand <david@redhat.com> writes:

> On 11.07.25 19:32, Ankur Arora wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 10.07.25 02:59, Ankur Arora wrote:
>>>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>>>> where architecturally supported.
>>>> This is only available with !CONFIG_HIGHMEM because the intent is to
>>>> use architecture support to clear contiguous extents in a single
>>>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>>>> which excludes any possibility of interspersing kmap()/kunmap().
>>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>>> ---
>>>
>>> Staring at the next patch, I think this can easily be squashed into the next
>>> patch where you add actual MM core support.
>> I wanted to do this in a separate patch to explicitly document what the
>> responsibility of the interface provided by the architecture is.
>> That said, the commit message didn't actually do a good job of doing
>> that :D.
>> Copying the more detailed commit message from my reply to Andrew,
>> one important part of the clear_pages() is that it be interruptible
>> because clear_pages_resched() implicitly depends on it.
>>
>>> This is only enabled with !CONFIG_HIGHMEM because the intent is
>>> to use architecture support to clear contiguous extents in a
>>> single interruptible operation (ex. via FEAT_MOPS on arm64,
>>> string instructions on x86).
>>
>>> Given that we might be zeroing the whole extent with a single
>>> instruction, this excludes any possibility of constructing
>>> intermediate HIGHMEM maps.
>> Do you think it is best documented in the next patch in a comment
>> instead?
>
> I would just add + document it as part of the next patch.
>
> Looking at the bigger picture now, you introduce
>
> 	ARCH_HAS_CLEAR_PAGES
>
> To say whether an architecture provides clear_pages().
>
> Now we want to conditionally use that to optimize folio_zero_user().
>
> Remind me, why do we want to glue this to THP / HUGETLBFS only? I would assume
> that the code footprint is rather small, and the systems out there that are
> compiled with ARCH_HAS_CLEAR_PAGES but without THP / HUGETLBFS are rather ...
> rare (mostly 32BIT x86 only).

A failure of imagination, I guess. I couldn't think of a way anyone
would have to operate on contiguous pages without also having THP or
HUGETLBFS.

And, for the cases where we want to operate on kernel ranges, we could
directly use clear_pages().
(Though that needs some work to add a generic wrapper.)

--
ankur

