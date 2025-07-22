Return-Path: <linux-kernel+bounces-741444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E0EB0E424
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972DA5813E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B4E284B39;
	Tue, 22 Jul 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rEjguxPb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x+lJmfkP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4A27FD48
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212455; cv=fail; b=Q8OgVCqmuAZt8HQ/AFEQ0rp87CUOxDWyauj6UHLSa8TsBuzyQ+RESE/ATRlfQrMO2moy1QGF6lG3IcOpAb6E6UMCBXRlAcB+UaylYrf54B82tAm9x+BHb95xVHSi7aPYWE/mptCHZFKO3qs7Rre2Q1b8cJpIad281aPqhlz/XGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212455; c=relaxed/simple;
	bh=U/P1pqD68Ipn1OtlbwyRQmo1gxOWr6IjCg52sYk2IhA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IbZ28eFOFlXxk/of5MQIHkqN1BfJBUArECGCxxbFEo1fbUPp2Wu0TWmERfdk+AjWrobCHqpOM7tQiTVkTXTkngYBjZT/0c/iXTKVeLyDiozxWsPVHMAcrWhrjkGr3dW6J99Z6Rq0CAEadWARDJ+/9tXaLpnp0Q4uURwyjXablxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rEjguxPb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x+lJmfkP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFYQMF011941;
	Tue, 22 Jul 2025 19:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=rTiFmgENuacljzXc
	/CAnvVgX6mleKQvhJzFW19/yBo8=; b=rEjguxPblgTW4xvBLmlLiXyom+LKdtOg
	nXXuNoSZQT7ekCjggQzHGpZpB28RPbDPAO1+57m1P/mDc7e+2vNUkHyOoWHm0VFw
	bxpnepfbLWacNSQM/YCSq04XBV9ZsppWDb8zNIAz9AWSMtRDodVrX0TgsbCeO7s7
	MvzBL/2z4vc87807gd5zEf1MF0yyyUIZXrJMbem2HV3AaU7kUAr0Yko8cpyVjSUG
	+cpwgNCrXJrFFNsoNOVCqRbGpxITmZIlNR5xW8yc8fb9/6hPzF/3KqZUeMiurpX2
	7+JFWTl95V2RPjJjJKIgbDBi+1dcPS9Lzz15JwNSnzfQyCD2oQg11Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx667e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 19:27:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHsVMZ010809;
	Tue, 22 Jul 2025 19:27:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9q791-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 19:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMDhA/lCE0EUexyARuqiFJWhUyT83P7nsYQx0fYC8dgqv2LYN2pesEIuvbtzbWpnrxdU+5stpEvibHtAUarptO4OqPyAzWlHUPX9sfJKG4pehLmsb0RyycZdqfMZktE1m8Om8JTOwfzFL3bZop+4YSWJ2E6q01qEOdEsSiIDoKnI6FHk1u9wcA97NlWOU+QBP3PG9Mk/qsn1+IEZBwDgNR6/dF3gc6PtGHcMT3BEZhG4Yydxtpst3CJlCs8UIllrwWQPM+bITYfHyCPwqgvUDlyAJf5/ikzG8a8+KwNKbNCqPYN5cu8FrA10zx/vlhf8qqe9TYt7pN5Qzle9ZXXqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTiFmgENuacljzXc/CAnvVgX6mleKQvhJzFW19/yBo8=;
 b=lBMWFaTWiOaR0Tf9CmB8H153QQYlSu7dH3xFtos0APylUv7Ie29dAHqjNlCjaz8kVk72JZ6h487TbGlfFpICpb1zUI+7qQbcOCy7VklWGZZqvyQg3EywOHc/c6Tmp0Qnf6sqthKmJPq4XPLzAu0JYVtybHtDqTWqaeKzYttGq/AyYKuhLG0yeVItvbg16zAjWBMnQL+JGPpcIdNzxX2xQ3qpa+D9bDgOjX5S1wIBLqhIupLMZ2Sng7xUHTWR/jvJOc0JUXLRrexB/2ONOGWVQPEl9fN95jLExH1BqK3mX6Y3gYfVgEq9qNNhI4YWob4LI3+EFDVvaQ3/yfYDjJRJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTiFmgENuacljzXc/CAnvVgX6mleKQvhJzFW19/yBo8=;
 b=x+lJmfkPyHBqrz83WjIzmUbgt1NmeQ7XfeWAGN5oUdvdZ5mU17S2dFDw0PAhSiOyFMO2W8n4gY98Beo3ra2LIZzckdqQN1Yc9JS1+V6TxqFaA16UKLDVK6DKbBI5Qw7ajQ1IKTaFx2prNwIGmngAS7JkNFkYRhToVtxHe1+1+/c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB6327.namprd10.prod.outlook.com (2603:10b6:a03:44d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 19:27:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 19:27:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] MAINTAINERS: rename MM to MM MISC, add missing files
Date: Tue, 22 Jul 2025 20:27:04 +0100
Message-ID: <20250722192704.164758-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: fb72657d-5342-4672-7973-08ddc955c2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GdhuxVlurnNdQTaK+dwUFk5oYJOLZDv7Zta1qDb8UZ0w2lAeDdEk5stXyWSK?=
 =?us-ascii?Q?fJ/Tfe0ACkeqMcFS1j5fEjGy9y87EjKiaJMBAGneFjDe0YCYqlRxBqFgsS8U?=
 =?us-ascii?Q?1YYBSXDXxdAyEn+4O1719IbhlZhdkJzQS1Ct9CGmip+M7hEvKy0W9IP3X9qa?=
 =?us-ascii?Q?PJepnPoXqwkt1c/dOfeDCw0Nt7VYykI/xQ8FunyTVbECgQiIGKN0JIIXH5VT?=
 =?us-ascii?Q?zHeEz6hco1jduO3THYDwXKmakFv5yQtco/YsaGzLDyDsiYUcy6FpHSb/7Z1z?=
 =?us-ascii?Q?etw6j6xJfCL2qx7PiUpovn21T8arUn0YEAKR3yQLHQj4VbNcM2sLVDGtbWIb?=
 =?us-ascii?Q?8KZ1ZAyHxedMN87ReZv8QewpdBX2wS1xudO5h1uu4NbWJUlFLAILnjxZgiig?=
 =?us-ascii?Q?j4DZcZWMkLuG0KrHJkbs0XwKr8zvNVvihKwe30vd7eVceaDwk/RaMYSj8wMb?=
 =?us-ascii?Q?ubMCsYW1hfAfPWIanRmoQ5exLmFzv2kZyNSwxipus2vhQxy3i1YKLpLU0tyP?=
 =?us-ascii?Q?u4qC+cnlc+IZlHT+lSE6NQUoVOwvtk6segbNSBOiwuEwipkCXO3f+P+pG9tX?=
 =?us-ascii?Q?to5fSnYQ2r2E39DHPsvkgdn9szy7s06grjySXdDOKvPjh52BiYQXHe3cm1Gp?=
 =?us-ascii?Q?qlG3y3ROu9GeaGYxoEi8nVzsTSZulhKsdpjoy+RbVqa+phLeyCxSdi+uQkzo?=
 =?us-ascii?Q?2DyE4/XniIUJilDDJUuWgYjxy2MMMkCZMKlgTvQWX7KTIASHBP++OnfTlFYM?=
 =?us-ascii?Q?376FFhu+VJddpKK7h8gu6CUCtmTqylabsVD+/uNQW5iN3r7a6P5YLQ/eaDoR?=
 =?us-ascii?Q?CqsAPPZGsoh+kJcCZrKPLmNGr4W/QN2/8K1ViE+T+bVwFTXyWTe5ZBYfe5jh?=
 =?us-ascii?Q?RDgTqvfDWu5SKId7cH8+mS3D1e3gF29hKbjc9U/8go9agh3zAEoRhbPsWdQY?=
 =?us-ascii?Q?Vssc7l7NlPWGw6c4IrlfTv7ZlEOX4wxbQgYcKKwzj4C2bnRXckyVksOUbYKn?=
 =?us-ascii?Q?ybb44UAesyqp6IDURfqcyJoPSU8FEYP5NF+ZfbRlHYH/+HAQSHTrqWcPcKQc?=
 =?us-ascii?Q?I8srq7fMHkcOtGdHpu7yUewuA3flLnGOnQ9R+pTaupspBHbyL9X6MylHBLTD?=
 =?us-ascii?Q?kQ2BQOfnPWoUyMgX1NISTJ1dTgx7i3hQauwPmNWW5EB7SThLMdak4JSW9Lrg?=
 =?us-ascii?Q?MIQAmlkg/NmVyzs8RkbEGB5gSfIBmB5u5G/EhURT6Sji2bbqtik9PfYHBATc?=
 =?us-ascii?Q?TKyp9sj6aUT6tOGcnkrKpZfznj+qaM8SK4ay6RQfN9llreIUOkdn4G4r9+KD?=
 =?us-ascii?Q?KDrJiczn1/zn5l4W2Wq6DZwoEhAkpDGfESomhWZs07Pl/Cyke8HWLDUhOObw?=
 =?us-ascii?Q?DyeKOdUbFfTcCgKekKU7CYMUNpNW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+F3yLVqwcz338xdXh60ZW6meE5QDgDG6YUdIMgALQS3EmoQzRlOMY3DMuT5P?=
 =?us-ascii?Q?Mu5sHJTcNXnbkg5MQ1/k6D7nT0WeYpE8HvpKnGGzIjZgQ/oEWrcUevSx7zgL?=
 =?us-ascii?Q?eMg5Rskr/qN76vHqOZ8TSF8eqbV1aOQsyG1lsbFLfPuHpRPiB4wxmghXYaxJ?=
 =?us-ascii?Q?OHAlO5QNEt2Sh+S1IU593WrCtofzX6xFGgoUiZRZ3TN9wN0N7UWRvw3bHcwB?=
 =?us-ascii?Q?UqW0KL+Bd3Po6sdfh195DcUCZaxClM24AsBY8EHGYiBbz4b5Kp/ZOyecB1Ay?=
 =?us-ascii?Q?ynBUH6WeACykOMPUR/W+Pyc9Jkr+mryAvlcsBHRP7DclmFsb+WNXYLrpl517?=
 =?us-ascii?Q?Udv5QAxKafJ/BmXeAs9R+haPnAx1uQMF5d0WVka6YRfkE01VQWLmaR9QR/ve?=
 =?us-ascii?Q?OyBIO97RC2MBPOblfUkPGa9b6JQhFFyjtFjxq1AXaI5Cg+BY/SMerlzKT24v?=
 =?us-ascii?Q?zDSj+3gLDowKp9M1DyEH8u7pXKj87kZexvY6uvtD+R/at7Tn3HMBAT/8iCGH?=
 =?us-ascii?Q?lImP5IpSclChK+9VFIT01+GNGg1zlXk7ued1zvJ4EVyyWxHWLUTdJ0RRiOyP?=
 =?us-ascii?Q?Dmi1EIm0YxfEG6+NPzqQu4goGXWeo46df2gFH/sk88lhO4dqdzGnqSpOU17k?=
 =?us-ascii?Q?ghawE4c3Fh9G/icZDY2u6JuYF1NUk2Ko7NupG4COVSaSM8KXm+L3cMbAnraz?=
 =?us-ascii?Q?hJyT7DzMrRuH/8hr2fwqMAD+o0Q5TpqN56+KURcqSMu1i4l3MC6F7Q2SB74/?=
 =?us-ascii?Q?KoBMY3RTHFCUYOHvDXDZuy/8RXFZZlMUjkbBN8OulZZ58xcFy+kNzyJ2TotX?=
 =?us-ascii?Q?ymSnTbW7NMvrXfkjUPavDYjTFb5vKgSH492o2p91MCnkvB3KgLrIxQTwcLLB?=
 =?us-ascii?Q?grwTLd/y5AtWsrWOVSJx5baIMxLaNpu0rIrxyAAfv9ngUwP0DBuvEBN7Iu0I?=
 =?us-ascii?Q?A/X3oX0MYtLk41nUjn0wYBofvDjMTCyY+Y9X8/j/DUBbyp3I8eUmZ5wyzR/p?=
 =?us-ascii?Q?hPqggZQQEMqjG36RHqP9GkxiLRXg4XAc2RBwLZayQKevcfCaEXZoEfS40Cq3?=
 =?us-ascii?Q?cdsYJLa4qEDMNgdDylhZuFinDxZG3WMuVO5CAhPz7NymkFUEJkl7i9ezf3Pn?=
 =?us-ascii?Q?Ul8Fgz3jBECw/V7d19kXouDPC7EQZCKUGW8SQeOc6MXrkP19nH/ACMi9yY30?=
 =?us-ascii?Q?R8V8VjyePi8U0mPSYzZErht96g7DrAdkn7SF4TAq2U5sVxjjb5wvqwQVCIqg?=
 =?us-ascii?Q?+eKnluI7sXmCpkhcPq7dr/yXGT8gWuAAEBvPvp6jNkJRBpbDI/oUYl6CvUm5?=
 =?us-ascii?Q?e69G43f80qSVKWq9YJgAr64FhhJocgrL6YEoWsNm7jhI01IUS5WbMEjQ8azr?=
 =?us-ascii?Q?Fate+ij0vpicALLvNsXXhbCFpHKDbT2LCbw0f4dnHfP7EAqeoHqwNzQlqyfo?=
 =?us-ascii?Q?9hXtXwvIRNX8x39mlj0GRvZJRTqkG0pDE8DlpY9LBQts9l87KDlVBPWZ2XAx?=
 =?us-ascii?Q?+3IUfcixr+Q4uee0Xa7Ur+dv0wdl8/oD2X86PqyuVBm0JjeZGI8zinceKbbm?=
 =?us-ascii?Q?l2eokF+qxd0CrM8BW+gs5vebpgGhaDjoazNVfnWuDOCvFzHmJ9nza8MtsEZb?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2y2wkminx99mPMkhLhHrN4ggO/3ZvFW7qgi6bWflptfSUuoyuf+ngpLkHBG7l3ZzAFjAQudYTCtrhdLlr/kjOy45m9As+mT5j1I0ftUjAHijYChOHZXRyWkzmrgAOEaNAnlVtvlaXp+tDGUCm733M3B2HMmEz9EUzW20QKEqT3EGFseKdfIuFws97XfL6wvI8+O8GUFA2F4fXuMtN+hgvd0U5Q/IiM44hhBX5JagQdQk+XtLQOQpGVWAiR8pf7s5cf8b4U9vIWKc4vnz4w1YpS/ymdseODrEUQXJ9GZgg5w9KQ6okWQ186DycGy2KZdHinedjIxhexjQAwoN2nJogIH0V/yS6WJzspdkHFe3jpQHBfHQQrG01KpMpZAT51kKhrs7lSOiaqOiHcP6g78YL5RiMVWxJPLGAXUj6HYJPLN7v72rSaaRJ1WLnmDzu8hT6OuPI+4POK0uuOAPxCaMqx0RiT4ZP1W9ZrMYzkw6rWBK6Kc/mFo0Mxh7+tHwqRyDH6ImoVMaBbYkDHFvrxMeR7KbnHS2YlEzKYCv3ZWaGk1c7Zy6hlOka3k0MJKzC5rEr3O1Ay2fy1B6o3civd6PKEEKm7+lDJ4RRbyHk/aLB2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb72657d-5342-4672-7973-08ddc955c2be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 19:27:13.3882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJlQFKuTOa3D6dgyJIe3c0WdbclYc9ZtuD+rvHPdTecFMbD363cwdujee7ylRHL1jLbDIr1VkgKefX76tVad/AS07z/WxaV64DqVXQ7wtK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220166
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE2NiBTYWx0ZWRfX2pFlR2mQ7FaO
 0URdgH6ykpX+wRcAmbvveG0mJtWmWsMCEFhE8nt3eLhpOZiygTdVY8UY6n0GaTAIC2UkeRdq1OE
 0lG7PB2ibsJWJPsJGT0C4AxQJD1zALbTFAyTj3SfcU3ezxY9nCq310s3/8fpxd2gbUR8cPZ50DI
 rhen4Hq8jmjpnQZ2RVy3J9MLU5SV4UndG05BkDCO3PUgVIRz9k8YeKcRj4Y02lgASRPvzw9LHpd
 s9nGDJfsQWSvRGVYUWo+lklhlOLvHn3vW7GIek4xZc5p0AG7A1WqcSldQvSqpVUJii7Gqndc8vl
 yNk3og/a1r48nmMkdJNnzVdpBiM8oG6+CHiJkLZUqEsr2HKd3vnkrOeP1DWv7gGUYmTIO653OwD
 tBKMpq7gi1+hwlS15xK3O6tMuRBGZrhz8ISFlyVR23/mXc6y8o0Ahwpo7Cp8JnA3BFdgLswI
X-Proofpoint-GUID: M5ZYQiXeUgqmaJyOHNigIWaIUXb-k8x4
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=687fe615 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=1-S1nHsFAAAA:8 a=Z4Rwk6OoAAAA:8 a=37rDS-QxAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=BhBO9pqS-LKupugTUQkA:9
 a=gK44uIRsrOYWoX5St5dO:22 a=HkZW87K1Qel5hWWM3VKY:22 a=k1Nq6YrhK2t884LQW06G:22
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: M5ZYQiXeUgqmaJyOHNigIWaIUXb-k8x4

To fit in with other sections within MAINTAINERS for memory management
files, rename the MEMORY MANAGEMENT section to MEMORY MANAGEMENT - MISC to
contain files that are not described by other sections.

We also add missing files to MEMORY MANAGEMENT - MISC and MEMORY MANAGEMENT
- CORE sections.

Move over appropriate files to the core section, and in both sections add
remaining missing files. At this point, with the other recent MAINTAINERS
changes, this should now mean that every memory management-related file has
a section and assigned maintainers/reviewers.

For the time being, we maintain catch-all mm/ and tools/mm/ entries for MM
- MISC, though in future we may wish to remove these to make it obvious
when files don't have assigned entries.

Finally, we copy across the maintainers/reviewers from MEMORY MANAGEMENT -
CORE to MEMORY MANAGEMENT - MISC, as it seems the two are sufficiently
related for this to be sensible.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---

Andrew - apologies, but there will likely be some small conflicts here
given other MAINTAINERS patches move stuff from the MEMORY MANAGEMENT
section too.

I kept patches separate in case one ends up having push-back we can still
have the rest putting missing files in place.

Note that we also have [0] going through the slab tree, as it seemed a more
suitable place to do that change to minimise conflicts on that front.

[0]: https://lore.kernel.org/all/20250722175901.152272-1-lorenzo.stoakes@oracle.com/

REVIEWERS NOTES:

This is based on discussions had in [1] both about this newly renamed
section and where David indicated he was open to maintainership of the misc
section.

I am sending un-RFC'd as, while a lot of files being moved about, it seems
relatively safe to put these files in core/misc and we can move them around
later if necessary.

Additionally, on the reviewers being added, these files are broadly files
that could have been placed in the 'core' section, so this is more or less
an administrative decision to split into two and so it seems reasonable to
maintain the same list of people.

Apologies if this is overly presumptuous, the intent here is for us to
finally reach a point (with the other patches applied) where (as far as I
can tell) every memory management-related file should now have MAINTAINERS
entries.

[1]: https://lore.kernel.org/all/20250616203844.566056-1-lorenzo.stoakes@oracle.com/

 MAINTAINERS | 82 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 837bc5cd6166..9374dbc3a6ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15732,31 +15732,6 @@ F:	include/linux/memory_hotplug.h
 F:	mm/memory_hotplug.c
 F:	tools/testing/selftests/memory-hotplug/

-MEMORY MANAGEMENT
-M:	Andrew Morton <akpm@linux-foundation.org>
-L:	linux-mm@kvack.org
-S:	Maintained
-W:	http://www.linux-mm.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
-T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
-F:	Documentation/admin-guide/mm/
-F:	Documentation/mm/
-F:	include/linux/gfp.h
-F:	include/linux/gfp_types.h
-F:	include/linux/memory_hotplug.h
-F:	include/linux/memory-tiers.h
-F:	include/linux/mempolicy.h
-F:	include/linux/mempool.h
-F:	include/linux/memremap.h
-F:	include/linux/mmzone.h
-F:	include/linux/mmu_notifier.h
-F:	include/linux/pagewalk.h
-F:	include/trace/events/ksm.h
-F:	mm/
-F:	tools/mm/
-F:	tools/testing/selftests/mm/
-N:	include/linux/page[-_]*
-
 MEMORY MANAGEMENT - CORE
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	David Hildenbrand <david@redhat.com>
@@ -15770,18 +15745,33 @@ L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
+F:	include/linux/gfp.h
+F:	include/linux/gfp_types.h
 F:	include/linux/memory.h
 F:	include/linux/mm.h
 F:	include/linux/mm_*.h
+F:	include/linux/mmzone.h
 F:	include/linux/mmdebug.h
 F:	include/linux/pagewalk.h
 F:	kernel/fork.c
 F:	mm/Kconfig
 F:	mm/debug.c
+F:	mm/folio-compat.c
+F:	mm/highmem.c
 F:	mm/init-mm.c
+F:	mm/internal.h
+F:	mm/maccess.c
 F:	mm/memory.c
+F:	mm/mmzone.c
 F:	mm/pagewalk.c
+F:	mm/pgtable-generic.c
+F:	mm/sparse-vmemmap.c
+F:	mm/sparse.c
 F:	mm/util.c
+F:	mm/vmpressure.c
+F:	mm/vmstat.c
+N:	include/linux/page[-_]*

 MEMORY MANAGEMENT - EXECMEM
 M:	Andrew Morton <akpm@linux-foundation.org>
@@ -15843,6 +15833,48 @@ F:	mm/mempolicy.c
 F:	mm/migrate.c
 F:	mm/migrate_device.c

+MEMORY MANAGEMENT - MISC
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	David Hildenbrand <david@redhat.com>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Mike Rapoport <rppt@kernel.org>
+R:	Suren Baghdasaryan <surenb@google.com>
+R:	Michal Hocko <mhocko@suse.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	Documentation/admin-guide/mm/
+F:	Documentation/mm/
+F:	include/linux/memory-tiers.h
+F:	include/linux/mempolicy.h
+F:	include/linux/mempool.h
+F:	include/linux/memremap.h
+F:	include/linux/mmu_notifier.h
+F:	include/trace/events/ksm.h
+F:	mm/
+F:	mm/backing-dev.c
+F:	mm/cma.c
+F:	mm/cma_debug.c
+F:	mm/cma_sysfs.c
+F:	mm/dmapool.c
+F:	mm/dmapool_test.c
+F:	mm/early_ioremap.c
+F:	mm/fadvise.c
+F:	mm/io-mapping.c
+F:	mm/ioremap.c
+F:	mm/mapping_dirty_helpers.c
+F:	mm/memory-tiers.c
+F:	mm/mmu_notifier.c
+F:	mm/page_idle.c
+F:	mm/pgalloc-track.h
+F:	mm/process_vm_access.c
+F:	mm/ptdump.c
+F:	tools/mm/
+F:	tools/testing/selftests/mm/
+
 MEMORY MANAGEMENT - NUMA MEMBLOCKS AND NUMA EMULATION
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Mike Rapoport <rppt@kernel.org>
--
2.50.1

