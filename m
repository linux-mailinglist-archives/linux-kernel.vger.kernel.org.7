Return-Path: <linux-kernel+bounces-749603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F7B1506F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6ECB7A8689
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75257298277;
	Tue, 29 Jul 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dSMR+t94";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hxr9Y9jM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676B2951AC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804154; cv=fail; b=fbAue3EI8wwIJcnUF6bizm2fpvelFVPTs33iB1Xlcz/L6q9lVd0HBi7IqyyYjE+myKeEKuBB8f4il1/OFcG6YAe2BgxDWwiaJtYb3ffbMZuvsRHwf7v5Z/ftE47TbR+QFnAx44jQIQq+rPGyaqZlzXLfFbactKCiGqnZa9nQPHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804154; c=relaxed/simple;
	bh=JvWVyfVMIeOHetkRxZFXJshkXQJZxjn+zzvZHGRXHQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BZejwJNCT4OPrE7tYPgFjul9nhvN7DMVinZ+cixFLEHRW7ak0sP54nR5ZfE/wtz09nrPANhyIjLNEYVHD0c4HE6LylKeS5e3MLTT0nrvk3LYIjTnX77npvXHNsGeiUVf1UXj6PYQHvbfnKW4E6KIxMpyN/IiOeLr2IKOpbqINoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dSMR+t94; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hxr9Y9jM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDu4GU002995;
	Tue, 29 Jul 2025 15:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=epAR2jk4Z1027su9ew
	8vZ1F+/KhubMdy8N7/wL+wPQ4=; b=dSMR+t94wZQtITdH1SokQzlpfiZPAATtY9
	/Y7t/lyYhpVDiL4YnEvUP40klZdVKtU7h3O8AobjDGqMAjocn7NHy1Hu9zuNUnjx
	mm2yh07qDzclTDWK9mP8hh/0MMSl/pGx/vFjovFXqdVtBJQexjTiZeQtR/FIhAFQ
	KSpPw8EXXLKv4EniKhuWoDfGWechUMLaqUBfXXer3oXtULstfoyM4491EpxVEOkv
	8t7LlSC+N/0mPufdN/9q+Vdb7qSQCKDMkA6nnvEpwe0ttn6Oh/aML8EpyiwquJEu
	XEIK8d4D9yl20JABY7dSS97B1Jzv1oOtENDF1VaSSon+PCfY+UBg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwr2dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 15:48:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TFOIqe034481;
	Tue, 29 Jul 2025 15:48:46 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfaamu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 15:48:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+Vs9wdX8BJn+h7lhSEbBpvmQr2ZjAW04Wwyjn8LCRUi6Av0mHRSLOOcyhHNixrKE7AB3Ca1h4sMvrj2gP+n71pWfla4BU6D9gOEoPkUVosd6qqE8W97TZRiH5nQHtGWJzWWHjpjsoELM4PJNPErAXWnyEfyRHj3dk97U4F8O6wTLQCtr+/p8qn1HVYV85FIB3wWymRb3tV4oRIyuLdhgE1TSa4P3CzOYwpJimKo2fCOP6WapHKgvBLQrijZd9DroGwLJbYPbD/KzKrdC1k7fy+tR0THN3VESMxlN8HL02uAdfztcZ/Jhw0aGY99m9EryOjszmzrJJ0l4b0UBlk90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epAR2jk4Z1027su9ew8vZ1F+/KhubMdy8N7/wL+wPQ4=;
 b=vPr+aIjgaAxH502J7dlzuJwX7b8GAkmU7yulnBEvxh8fHZW5NrSsrXlOeKALgghnUPgigUtaw6VmtFTHeU7g0JDzMttT7EHFomEb9V5ATOzJirFX2xez7lmPylElckpMjWHgw4TB49OCofSNoReNeqnViatXcpJiYeyClc4dVh6RlhQL0DuuDgFtKqDg4Ef6n4gddAT5ZePXSMjgCiFa18VtdcKPPPAs3y/9sbZ771wNoCoqTc+yZS2OL/+2YKHqCwVgMCUQ37RBe9HLmiBKhr6TvgMGNwr14AUb0tkIg6Kegt3PBgkXY2fUx6pNC0fqxjakxSezvjoMowCj9/aTMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epAR2jk4Z1027su9ew8vZ1F+/KhubMdy8N7/wL+wPQ4=;
 b=Hxr9Y9jMSTRnkHFQ1SA6oijeB5M/jwFA/MTf/2IdWPzDE3giVVUHKZzAfQpFSb61M3JJZ8NvfqvsJnDod5I4Ly9l4+9g2G82e0nn0xT6af5VaIeGBem7f2dwsAzpbkLFCs2ZLL7DK3XnCMZU0y59UGM4ZCI5s7iwKA0bIAG58dE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PR10MB7926.namprd10.prod.outlook.com (2603:10b6:0:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 15:48:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 15:48:35 +0000
Date: Tue, 29 Jul 2025 16:48:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zhang Qilong <zhangqilong3@huawei.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
Message-ID: <3a5ed894-e9cd-4433-b82e-be4b049273e1@lucifer.local>
References: <20250729134942.900517-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729134942.900517-1-zhangqilong3@huawei.com>
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebafd5e-54b4-47d0-5593-08ddceb760f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dpo7x0nkJcv0ZnZmtfOtOZOwZeLsZgWWng/0fnbVBnnW4tDoi5/aJqHWup82?=
 =?us-ascii?Q?C1uTaNBgSMVppxHh0T22+gG8IMTUCxJPW2GsSdSfKqDo8PPwQ2FrHDDCYMkJ?=
 =?us-ascii?Q?5H2BFXQVQf22L0Hab2I/oIylUs2qXfizdfnCE8i/ZzPC2tBIrowLy40BlIdn?=
 =?us-ascii?Q?nG9kOzqtqTTAyCZAFEP+Hkpw/uv8tv20rWLHK6hieDJ7tCEypiYFr+4ukru8?=
 =?us-ascii?Q?ru99PIVlGKHUN0/WCNL1qa+vgGw83m+tBFc8d+PAMwUiR++axs9cG6rcUMiy?=
 =?us-ascii?Q?fzTjOZnmgZq28ZzYiefqw/3EzzjGz8tKU3CEbqjRKaPDuaIL5fLQ+EWz557v?=
 =?us-ascii?Q?se65/CenjP1JXnZ/HJ1wCDcv+gCvVmJE8i/LxvLP11Gu2Uds+e6CGaBFa7UK?=
 =?us-ascii?Q?D5qU7igaj7OFH13NJINTqyLs54gIHLVTDffTLwUCP+97J0Hdh/N/tKNcBqdF?=
 =?us-ascii?Q?QoVHxSOEZpzEoSFsHm7d8xAhYtFRdOVyJkKFWSxsCTQppuy8mqb/yIv2Hvpm?=
 =?us-ascii?Q?Bn3WplQ03AD444Ww4Vnk98U/1wTxd+S9Ucbj0rMOUx8Ccyt6mpRywrtC1zsa?=
 =?us-ascii?Q?5pjZfYUkwo2j5qufJMlW6tSjitdNCTbI1Sb9DgmhFfTi5GyMbE9iYUiwhU27?=
 =?us-ascii?Q?6rGaBWlB/xyoxqCgX4xM6O6OHvnZwQcZtQyrqP9LZtqiSzUSgqiWgIDlmj4l?=
 =?us-ascii?Q?eYX06H59s48Mcj6SbhY69FkYyslOfAqdHOhvTlTpAyA5GsjDD1eHyqPSiCf9?=
 =?us-ascii?Q?1wmlUKFTwXjXmus2vxaACQeGXkSmUfHkZ+m2hkkfmn74LPduV377eiT+4tGa?=
 =?us-ascii?Q?VzZwTO9Vt5Zdn67N3ioX+yg7sz5v66syzGRuctQR6fiCs/mDOV6DbWUEjunh?=
 =?us-ascii?Q?rrwqBF/shFvoc5ZgPLwLM/h+JOvF0Q7Rb6/9KRzrfKI+ZjVRhVfoQBr1NlyM?=
 =?us-ascii?Q?6+DuvMJCtWMcHkqAMKD46Q9pGNfVhmed6ZUGSAQOEnLX930npBmXZ8RdniU4?=
 =?us-ascii?Q?CRecVYFy4UkPh8TVLGci88ltcZjB/8mjOykIQFjNJ4UygB/ot8GN9s8KOYeP?=
 =?us-ascii?Q?0qje8s0P4gXubG2saskJvfkWocCBeLGgF1ESmv7H+0ZZ/wXfk1lK91xyYGSA?=
 =?us-ascii?Q?Dl7o0q/wsf9WBx+oNvXgg6pVZwK6K/vM5C7f84IxHbKCNGuM9WdBPQu/ldQq?=
 =?us-ascii?Q?24QZrR3b46wHuMIOhd8GjYSSrcpIuGnfnD3/HBr+Jmb+GuCD89QxGpCP7QGK?=
 =?us-ascii?Q?zvcSJxHWzMlHN6o5MMv6bwx/97xS3l3ITAQuw8HtttWh8sJjv5Ff3YkuylGH?=
 =?us-ascii?Q?5bf45RqN/sruAlmupSCAcC84iivoI+X7j9E6aNezuWgpFskxYj3eoznv5ami?=
 =?us-ascii?Q?+rn+iNGzaDRW3zGQcOx9MoSjL/vDbuUlSdOMl/RhyEKXvqhzDuQqJzNdoVEl?=
 =?us-ascii?Q?OBiFNcpVeC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CBujR2KgTIun/dporENwgv48uRLJHI6OroWbs3SAqSTlIF4G8Pwh91GWIYcb?=
 =?us-ascii?Q?Ab8sDlQJDv0Vot1NH57QtLpiTPyiQC9mu6kRXHSOTVA50N7GoI4EHy78T/Nm?=
 =?us-ascii?Q?szhAbCkropANKr5roGyMKCxxJ9dJAvHTaov6ZvWv4Gr8YpuuPPZATYUlvL8o?=
 =?us-ascii?Q?U5XdYW8xcOIPL6y9IsMoVbkdrUO+cLVWgS+jcZbt5lzFUMGuy2NG2s5AgBtn?=
 =?us-ascii?Q?I7+bu5Qs1LXitvockIZMQnQGF0dwqW/Ot69zUMGPgQBbROmouxTWyJSxweL3?=
 =?us-ascii?Q?kWOuHQXs5kJ6XW96KxqhQ9n56vEDMJA0mauLL8ieTRNGdomeZny3LpEwZROd?=
 =?us-ascii?Q?ED5DrRAm8HTXUT8fVvnLdLLpjmo0C1PTWbYN78T/UVGfKrLpOo8V7hRV6eb8?=
 =?us-ascii?Q?X7uRBPDa6Qc9QIy3bWL3FsC0e6IHPlwR1k5W5fUSnpmvkvHLIDknZT+v3GVO?=
 =?us-ascii?Q?bUyFhbtynI4hQywrU+Kq66+N7B4AIGdOOv6d0TZvGg/n1lzFfcpKln8hPX8U?=
 =?us-ascii?Q?ktKDDv+Z+JFQbDxp9+lC3pHnO2KOPgORQLdRvZc0l4SyQnL/F8Y1iHFvrrS9?=
 =?us-ascii?Q?2Fst193otcSIqTaGeSBBLfm1etE8mzRipKQacPJeO86OHcsFXJ4emoob9+gN?=
 =?us-ascii?Q?pz7SAqH1Zzh0A7v90/vNeDyY6jbZ/1PlIh6TEQpYUxRtbinfXtTQK0y+/2Nh?=
 =?us-ascii?Q?QhBgIMU6xMgaFDA4olDd51hd3tXnJ6SuSYgBe9jiswuzH8zkzsdVFWWkl5sd?=
 =?us-ascii?Q?pr0Z08K41QQ5EHsz2PrCveKh6h+n2VhFK6Qx954VRQrs3/i16kfhxizhoLlA?=
 =?us-ascii?Q?AzPc6g3Oqi9ABn5l9BxqcAGq9vQOSiXJCzI14euP8c+deXRLnP8IVcAXRDRW?=
 =?us-ascii?Q?BKFMrQX8kCHxAy3mB45lNqmNNQ5aXoEVx4AqJ4RT+tSMgw70FpzEU+a3K4ZK?=
 =?us-ascii?Q?oVcJTZ//wTnj9ZymUc3NI6MfP+CDnw8N9puObg4+MW644hxN3enY70yeZLFO?=
 =?us-ascii?Q?TX62G0q8R3z0RJCXOO7Fa+p/mMgeC7bG8HrXMG8yildQS2Mr/l0/jCOc7ccj?=
 =?us-ascii?Q?AQ16xU9BHSnQwtqW3Myy3TOA26ZWBOjdcA6BO+t5KIOijt/DeJZNOZ5DUMQd?=
 =?us-ascii?Q?2aizrPYOEEzntG23rGxlU4e6S5Bk9+ez421qwgFSTcA/xMYEOa5RJq4xtjnu?=
 =?us-ascii?Q?OUmv3Ge/3f/STcCFikLKwIKuOognVkouVk7y4ZH1vDUFDAuefDgRD+P2SuYV?=
 =?us-ascii?Q?+vYoR6+3++TA3Y7+hNX07hYHROI4YsFdqQ0WxhyuOu4zhZ5RjSlWXQNM/ETQ?=
 =?us-ascii?Q?7rsl3oKvpawyLrJWL0xKDPy+9pwLyqzkiEKjmAKCfDTsjvOGJK+7UgfnQc/W?=
 =?us-ascii?Q?AksPSEtpPpVVz23XKQiHmbJICIVCa0hefDjB0ZJzuYhe90QWArjU+b8PT3nx?=
 =?us-ascii?Q?DGBw0JMKWqCCrDDx3jgdqOe+LJc73dL4hAuKF58bUChtyh31y2q15cg+sAD/?=
 =?us-ascii?Q?eWH+JSmsF22vwP+iMiqkXWG1IozwpY1XsogHHAWgSUrXHWIJT5Ik3tBzKiSH?=
 =?us-ascii?Q?SLngESBcb1Hfz0c5YphWbD7GEuWfjyJ+m6oQxfY19L+w29N171FwU0qkndAI?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5cFCyvjVl64eVzZKKrlAQWed7qg1yOcgLcUP9FtcZqnMe08lX8Dbo9BRWiTForsgDOyvUoySaYmZeEpF+ublMUehASAGEpWmmI8Mj2MmfPYlDTcTwmGGgtIL8/gZ2UK9G7nION8qi5pYFb8JlzQf1tWxcXrwRGdtC4jZk4vRxalF8QSI18O03ChTWWJPZLFBmeDdVP5VypuufhQhZzIV2jxw3skjF2TTpBomwkGaDz+Gba9pp+nLMYt7rxsWJcoDlnPw2ljRJ4PN9/e54n2jtrzvIKa+zfAN/OAd7w9cowJghbapnwx6a3ZMXdyJgIEmK86mC4tzNHRq5CFdiuoaDV1vedB18oxmcVzlBgzrgy3gCnm5ZQMXWEeIyG8moXLEgNGzxmrftvDft1xvldWVaST9hWOwieX2RfU/X7vOYNTYFgSDVoCORcxuz6WaBRE6DI1vsDvpzziHyrAZvhpb/T8lJ1Ibli6uVEcOxwwLg5/qPKgQiMUpDwwTFyXLOzQJnx1nnL6gx5cL1JKcrkAipspFeYgirEwn+EuO+WlxOfa4cJI40l+/6d3iM7sj0e9x6S1aahmIemHyApwQm7G4aQwn6AI4MxneW0O5Q2UAdtc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebafd5e-54b4-47d0-5593-08ddceb760f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 15:48:35.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZU2ry0K+cLU2s0gegTmqwaKDf6WhpGCxoGiR96K7O4X78kL0ot6MCElwfHDJ8dfrQcriqfIsLsAsZ4lo/7IOmkiErV6n2xZTn5GitiBwIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290121
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=6888ed5e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=19IWuELmRu5mVkkd7pAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4zPIhVKetFfFecK8FWZwfEHt6yuxpXua
X-Proofpoint-ORIG-GUID: 4zPIhVKetFfFecK8FWZwfEHt6yuxpXua
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEyMSBTYWx0ZWRfX9p3qiv9qwSe3
 +JNW5VcSCdiXU+exei7vkAjNozQtitnxfaZI9CpAncShPfhCp99IC/JJpw2QiVMQFsa0CCOBXfn
 ZkcPyp+ZTnODOSsfz+DaI6ao2vqd4Arou6T47ClGeBO0vre8SwT1YguVOTcE33OvH5HsEy9r/Ih
 8WXrdbS363anTFIqzKOYhHFnwRr/IHXERWJcUIf3gl+HwwMSH32fAqj5FL+RExwy9/7i8G28e6/
 UC7YpdaBUMWYNJt/fdDn15EDh8viqsi66HZCYxeA3WHZoxGmDEjLCNfDpVYcXPBRJI6Cmr3SkEX
 ClsY8e5BwM6jm9LK0oFm8IvpV39Td7aNrPB3EvsK9iXKZ1KYQg05jMJT+sVjp+LJOslxvYIj3YQ
 0rHIHszEg57JV+poftZxFgkOAx/LzBa5DJ3Ofy1ofwlTdTcYKb0juhTePXLt7151h8T54wn8

On Tue, Jul 29, 2025 at 09:49:41PM +0800, Zhang Qilong wrote:
> By default, THP are usually enabled. Mapping /dev/zero with a size

Err... we can't rely on this.

As per below comments on code, I'd update this to say something about fallback
if it's not.

> larger than 2MB could achieve performance gains by allocating aligned
> address. The mprot_tw4m in libMicro average execution time on arm64:
>   - Test case:        mprot_tw4m
>   - Before the patch:   22 us
>   - After the patch:    17 us
>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

This looks ok to me because there's a precedent for using
thp_get_unmapped_area() directly as a file_operations->get_unmapped_area e.g. in
ext4.

We also simply (amusingly, or perhaps not hugely amusingly, rather 'uniquely')
establish an anonymous mapping on f_op->mmap via mmap_zero() using
vma_set_anonymous(), so we can rely on the standard anon page memory faulting
logic to sort out the actual allocation/mapping of the huge page via:

__handle_mm_fault() -> create_huge_pmd() -> do_huge_pmd_anonymous_page() etc.

So everything should 'just work', and fallback if not permitted.

So in general seems fine.

> ---
>  drivers/char/mem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index 48839958b0b1..c57327ca9dd6 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -515,10 +515,12 @@ static int mmap_zero(struct file *file, struct vm_area_struct *vma)
>  static unsigned long get_unmapped_area_zero(struct file *file,
>  				unsigned long addr, unsigned long len,
>  				unsigned long pgoff, unsigned long flags)
>  {
>  #ifdef CONFIG_MMU
> +	unsigned long ret;
> +
>  	if (flags & MAP_SHARED) {
>  		/*
>  		 * mmap_zero() will call shmem_zero_setup() to create a file,
>  		 * so use shmem's get_unmapped_area in case it can be huge;
>  		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
> @@ -526,10 +528,13 @@ static unsigned long get_unmapped_area_zero(struct file *file,
>  		 */
>  		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
>  	}
>
>  	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */

Let's add a comment here like:

	/*
	 * Attempt to map aligned to huge page size if possible, otherwise we
         * fall back to system page size mappings. If THP is not enabled, this
         * returns NULL and we always fallback.
	 */

I think it'd be sensible to have an #ifdef CONFIG_TRANSPARENT_HUGEPAGE here,
because thp_get_unmapped_area() does the fallback for you, and then otherwise
we'd be trying it twice which is weird.

E.g.:

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
	return thp_get_unmapped_area(file, addr, len, pgoff, flags);
#else
	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
#endif

> +	ret = thp_get_unmapped_area(file, addr, len, pgoff, flags);
> +	if (ret)
> +		return ret;
>  	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
>  #else
>  	return -ENOSYS;
>  #endif
>  }
> --
> 2.43.0
>

In _theory_ we should do the thing in mmap() where we check the size is
PMD-aligned (see __get_unmapped_area()), but I don't think anybody's mapping a
bunch of /dev/zero mappings next to each other or using them in any way where
that'd matter... So yeah let's not :)

