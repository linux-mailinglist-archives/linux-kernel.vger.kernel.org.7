Return-Path: <linux-kernel+bounces-869493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D946C07FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B05BF354C13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D102E5D2A;
	Fri, 24 Oct 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPevoN0D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JiaOLXp8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F32E2F13
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336687; cv=fail; b=DbwY0W+vEjyW9yFM1LfK1VzpqN9mHwtuJStjT0l8+ujILwANP7mKV5sgnmM6hACwFVKBM+syyL/I2rm+1fekp6JeRV21phXzE74AuNASKjPba11GA0gNLkr8gmIVCdUNVhlNZmyZpH0F6XYyMuNqLHFMWaCU8aifVPwvQSO9zbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336687; c=relaxed/simple;
	bh=ILptBfokfao0Tg5XegE0minI+WwZAqtNiBYfT4bX2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnWdsxcvYkpFYC4QQfrHrrM0pqlmc9bEW/FoKCkdg3K8dVU7I9VYsb0JsHghVmJ5uqqNLFc2o3jAWko9bzBD6LhwOOSYeTBXE258gZ+2njAeVs0atRknsciwuTDs6ljuUKVUaePyH+sobapDTwDGKCj0cUN9eCPt/EO/fYHkk7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LPevoN0D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JiaOLXp8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINLt8012004;
	Fri, 24 Oct 2025 20:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zU+aS9XFKa58/SSu5M
	0v719H4nTVDBTMvztoIYf7YUM=; b=LPevoN0DODiIdFJZxF9NJBux3LoQ8Gtk+8
	caKcwtOMs4Je5PVKqx0uAvR+XQvKDdGz4fwc7phvyntvk8ZfWZGFh2CioyrkVNS5
	b8K1emMsddcGJvF7s59OMcyNYl9D2XGhmCoOd/4lVixrwvHNcq3Zjlu5k3UotP+s
	UjqPf/f1xHKPdAy2NVL43vksbp6Kd4O0797iygMeyQweDJUJc3nTOrt7jO9iu6oI
	3Zq4bmGd0S5IzDhw5hsxcglRCCc1xzZMKNSdQZgMkeJFkisfKOLimMTxAEyHGs5C
	2xWM5W9aLxYwiuUOP3enC0+FOpbi8ZAzNv9ZU4iVhYWqIlr9UL4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0whxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:10:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OJgLXf030478;
	Fri, 24 Oct 2025 20:10:52 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bhdteu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 20:10:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAYdcRDchLirrdmUsu48sAIB0UM7KKeyWq0SGoGDp1IU2ql+oVgVXEzvvA9FhMQStaEVPJrOLWae7tvHje3zxgp/gNriKSZENHeUkkU7BEZHyjV5M1ZUR4rpBfacjE9gyBBbjTFZ0fNw3US8tcFTOffGLwelGEChi9mNMA25zYk3/8qZqcUd+adl9FGqRh3tEGIJqr8xA1fE35elkBiPH6JU/wLWsR+8bzgPFDfojiHP69QkhHPZvUPvBcGpf1zvltZv93WwG15HQRkLGRwR4gfpcRtyIGcWVTadZGdiuzn+tbjBfq5a7V7gIA495rVtwMsc/D4k8oZXJJNzk3THCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU+aS9XFKa58/SSu5M0v719H4nTVDBTMvztoIYf7YUM=;
 b=TDpxL8eOdUcpbN24M2iUN5U7JB2KfoEwJJS8ixFLzEroya4GUbLyewyDHlMZL8G848y5+/Y5YskEw66T/KUC5BBmsI//AgOS/8Nhc6/RHJd0pgrtuzN5xGTJ8Rnh33/86qwRbSLYDVoht2RqSr5z/U41vT9g4v4+umnWuirTPQgTeR3XJoqdjj+jn97hbu/4mCwwRABaHHb9LOE1NuTpRhiH357UVlgD6+Gwwxvvkm0ejEVxD5Pfjsq4MgA9/tYPwyNqrVqhdnh0E6DvzLV8WS8RTScgMinQUKnplV0QNH1KD1Onn7YGK/QjU2hxdnmeC5l2q3Cd4xpmdCKBY9ZDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU+aS9XFKa58/SSu5M0v719H4nTVDBTMvztoIYf7YUM=;
 b=JiaOLXp8vfzUqG9ztGTHxe71rgkuuUGvnwJ9nqXDrHRnJg2sD+XuQT7wYR6sH7damA1YWb36vU/8/+mGrGv9Higk8MfTezRh7xrkxJ4oe9Y/S0k7uczGDvtYMNl/HlfFakHUrFt1LnFfq+ZdoRCS8pwGwjpKI4BMKvhTI+OAGQ0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYYPR10MB7570.namprd10.prod.outlook.com (2603:10b6:930:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 20:10:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 20:10:49 +0000
Date: Fri, 24 Oct 2025 21:10:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <yang@os.amperecomputing.com>,
        "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Yin Fengwei <fengwei_yin@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -v3 1/2] mm: add spurious fault fixing support for huge
 pmd
Message-ID: <588a98b6-b5ec-4b79-8791-ad01e57b9612@lucifer.local>
References: <20251023013524.100517-1-ying.huang@linux.alibaba.com>
 <20251023013524.100517-2-ying.huang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023013524.100517-2-ying.huang@linux.alibaba.com>
X-ClientProxiedBy: LO3P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYYPR10MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e97dd8d-e5db-4a22-934d-08de13396cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1RQx5aE884xKaMF12/EzPvSxlA6UCXRVgptROuElZc+vWSE7whojaYE+vhxL?=
 =?us-ascii?Q?PgPhnBM4B7V+dh4LCL4J2PdSsfV3IYJhDXywqIuc3BXyF5xg64QVxi+Mtcds?=
 =?us-ascii?Q?WkMkZLomEKkgrT9aHXdw2W+ZDGGlt9o3YPF3HDmQ8JXIipTLV+x2A5faLsPB?=
 =?us-ascii?Q?vHQH/yhPRbcrN9cta4NeQhCK5NzwHGpmQRhUJjPAolmKkiE3wCYCYp+xaD/V?=
 =?us-ascii?Q?KxZQSshuhdsV9N/AjkK2BwFY4f6ngVTEHrWFZfJDX9v2GLsXu5nXw+oAWC0b?=
 =?us-ascii?Q?6PEbCo0qCHHsahlG8Z1TE0m4qGg5gIvnixRdN7X2ZYGKmvE9TJffp8vAGgYz?=
 =?us-ascii?Q?krgH0X3nfLg8N0ApXOhVUQSGPNN4ct9UxiTaHsWc9f3QYeVgtxbtyO20rFyh?=
 =?us-ascii?Q?LmSiXx28iIXGhO0S2/hPzxcXFr2Xr9edUmdENKnGybk7nuXbZL0KIxBR+Rpw?=
 =?us-ascii?Q?XHlmJ5Sas4/gJs9Pfc9qAsekM7spyWVUadAdF0HiE0jx+xSOvhlZEe3tCV5H?=
 =?us-ascii?Q?WBARt6E/mZOIJdg6BJZGwscGNHU6gzVbJ1N9pjbmFWrYZcl/REnQjxyOSO1F?=
 =?us-ascii?Q?k9PzqHu1NyP7mkoisT7xdUf48jqHDjFXdOa09y5BSW9wIPPqKKDsiQYTuR9v?=
 =?us-ascii?Q?xxnRZRt3oXLFKlo/rI1qxCf/7P7GLo4qbVM/X0exu/IWW0QAcSjgaXUfRjhu?=
 =?us-ascii?Q?MqPBP5i+CmeU7/ULq0w91jWGz0PwiqRKsJEWtt/XUeIIgU7ffrRNdRZyh6lw?=
 =?us-ascii?Q?8585+1rYXuvkfHtpq2sA2j6dsY3ofwRE6kQoXVHCAIZrsvppJApCnSktXZjz?=
 =?us-ascii?Q?BwCKxDp0dOT4hUgVkMeLKhrsnyjBcqxYsA99JGUqlFZfouBmNkjUcpFtQcFb?=
 =?us-ascii?Q?IGpv9KpUzjg32ylj6fgiVQQBS0UXB2W1Uw0QJS/6lJFsR2SDkEEk6WdmoTVP?=
 =?us-ascii?Q?FY00oMDzufoOvdGXN5z+jpCh4PzngyqYfjo7jZoRtFaIJgBkrn29jNRonrFA?=
 =?us-ascii?Q?P4DrNOVG5tOxEWw8tUxxnPF5IBT2g8/0j2kVkO/mSnZdfB4aPTkVEQl3hHnS?=
 =?us-ascii?Q?ENttb8UeF5fnkNyv3GPuQ03pmM4d2msAdf4evsxutF0vRRP0leIMTAhYcVoe?=
 =?us-ascii?Q?uI//l/PNmSI4hycJ4OxgYi8mfcG7GEgJRVXIqdlrUAWdhoq7vLUecb90OQT/?=
 =?us-ascii?Q?3z8TyEXcqNsFyroAy3YrUUgRhzbKUL2jDNCH3BpUGH233CuZAMShtZ9x0jmT?=
 =?us-ascii?Q?qhyyR2l65t6r+E5Mou+n2VB6mhkEn8BH8neVTC/dlVjqhns1GbIdZsELACmF?=
 =?us-ascii?Q?R2mzSbTu0HaPFEaiKaM2advI3o41IaXIiyZm04bA9V5xNcPA5kqIT7DfUiEW?=
 =?us-ascii?Q?w2iRZs9HWB7/7Jgu9BZfxZW+l8OgGwpouCjylFAV1WsDOp1bwq8XkEIFyY5W?=
 =?us-ascii?Q?5hv3pUeADmIAlQ+PwlOxLRHKhzQqQe8R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9mMyZTbOXhW2sDs5J8SCNH6zigQuxg/0rVseSxciW+YY1zuB9I18voXp9zid?=
 =?us-ascii?Q?K2/E7B4tvES0cv20dJrEFu7zD8YGyFwTx+LR9u7/FhJjHjvGb5Zs8OpzHk2l?=
 =?us-ascii?Q?rxpJp5VGwylDz/n9BrE0GilKnRpPswHc1IOCW16h4UfHO80kJtP26JXDDE3I?=
 =?us-ascii?Q?kL5Q+Fxh2Cg6r90F5HJfcJ0S2Hy770ZxOJi3iM5gH8xBfDjyauKxaGisF8E4?=
 =?us-ascii?Q?S7pMTWavg0Azzsw7wOtWxAJA7rQmf0A4v9sw1G9hN1oHpRl0r34aZWsoY1mp?=
 =?us-ascii?Q?i5ForFLByM1effPCihAGRdWnGEG6gDfoRQZQbJ9MH5K3/65g5m3TgS5uloWK?=
 =?us-ascii?Q?sbVajUeT0fPhPlltr7MiSRNPiD3LJ9ld888v/mffh/vYnYhVa3aP97klAHsc?=
 =?us-ascii?Q?38urv3gogYsyF5badi6LM20gdlJMM3MKUgR0zFd1fCJy1XHh/GVoga/QDCUO?=
 =?us-ascii?Q?EzcI6M+ggG3kqBLp7BFcIafJX1FJ51vhVud6qckP1v0kmAGWzZkr05wgwRY6?=
 =?us-ascii?Q?dXVA8QtdfU0j+QoDaxIcSNqT+VnLblh5xOJ6jYrOqNZT0po9BU85RTXWYaKV?=
 =?us-ascii?Q?uUQ6w8cBG7avMtEWN4CqcFdSNHro/H7674UyUKTKYoOQli4SNFa14vSxF52d?=
 =?us-ascii?Q?QemJ81qCBIKIO4tDuxNmrrAsqymK543utK4VmoYG6HupPIRx6gXdibJabRzB?=
 =?us-ascii?Q?fuusfdVcnaU9FA5LUzt4N5bckZegq+VW143AAKrWq8G/I0krlLary/yiPu/9?=
 =?us-ascii?Q?2BIrdIm2WAfXx5KShJwP7r5oBFo/TzhHB9t/39qQ6q5HvJYwM9actSiv2SUe?=
 =?us-ascii?Q?wg3QcGReebkFztkJrM4SEzrjqKJBcixVDyd/j59bnx08xAVDjlouuG/eMkRc?=
 =?us-ascii?Q?hFSAocLysTjI703t+YHRi0Iy1Qb6d1q2FsxlvqpXH6LqN5M15BzURU+QwudE?=
 =?us-ascii?Q?/+Nj++Ph6OFQdHVdnW1thdUqqaUQsuuQzq2JvZoQThYC6pdxxQRNBFt9Adwz?=
 =?us-ascii?Q?xwm1DCUpApuzRMfqx6ZLAnxIYrVwgWikPjj8/1KGS6lQqcQ2Gx+qioTZBNCV?=
 =?us-ascii?Q?2RscNjuNGzxgOyEp7Gf6KwG8IsFz+n2wpdU0yE4LwtATNKxWvI6G3rXv1Haz?=
 =?us-ascii?Q?ln2/qF0Ruywrt9r72IPHJund89W6hMEDQawtkCgv+AyFWQ+MmWVqCrkTDS5D?=
 =?us-ascii?Q?X3Ot+T7GkmZMB+vpGviNUp5gCHNfxd/kzbijHQGyf5vOKxBhI1pFGAYqB9Sp?=
 =?us-ascii?Q?Uiy8UJmdLrn1I4n7AlwxtZWyQJWPmJhUYvYlV8WXwf8+22+A1IZ0X8Nq0veY?=
 =?us-ascii?Q?Yw2eAdj+By/B9gunK5emhPAxS6IVq4GScru4X6NSZ/p7M9s/NyJIIYaBD8oq?=
 =?us-ascii?Q?o/4ADYH8r5rU2UBvl60jsgzZqbzlrtef0r8F4Negu8bE19f7PbUBGbqrHD34?=
 =?us-ascii?Q?kmGL03QvShCAooBfEFQ6tJpBcbvHi9o4bhl04G2rhX2M/f+twCwNkyRTUxGu?=
 =?us-ascii?Q?Z0ChBQgGELhxFPmxQkrn4HVv2s8ZlkHcfFgG0Mf2gr3aypC4joAwM+W2O/oV?=
 =?us-ascii?Q?Mf3jAQPZm/ILDar9Z3Wjgtnzn/TK6rAE+tA4AO2K/64aQf9fztM66djqddJ0?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GxHJ2H9TIhOXoB/uFmD3UrE6Q53AhXA4IbdudctbCw5skOekjoF2wTvDV9/fVgSmCkQD1UuDxmLncuKIF+dn7R41ypPLKG/ZDsSWqIFq8qfeOTHM+Phhz8wx4wSOjRk59AMuVhOPCY5uNYOSPV8emi3ZDOOCcVA4ullwzDB6nM7JYNqUB/8XBlFPCObp+9eddErNqlcV99QHCMl4ZdR9QnuMIeQZAVZyifFPqNVnDber60ck+bNc71+xflr42B5tGwY/wkKQnNJ0GsO/NJ903J0C2KQITaVMM1QcImTbO+sawyzbXiL6Ur3WXnhz5qWRyD13ZPgyiZRZGhLymsAqZx1mX3/8e/F/VIHmP2xlZ26lWBtHTGRwj0eHM9AZPlGbtBvKSzLI1ByU9ZRr8hSGBAgOYBJbH/QkLxWJ5yxJyNnh+iTnA7Je1Lvc8JUa6G4BtGZcwUi/398hFMZsGUWqUNwRywKfFpbToJeJat80dyv8Q/jI3/Wqy+qclFLv2GyoNy7/KYYqDXrz771FgFvq/Rk5KcQ5ApP7wsrUvttnyMMFHlqcxT4Tyyu2j9YkBEj6XooWkBj9JrPHqGuto8o7hUBxt6efTLe0qQIrdPWmT4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e97dd8d-e5db-4a22-934d-08de13396cf1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 20:10:49.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFR+zPBuD2mgg6nbEUzqSx6wR54rD1r1I2LceyAPlKniSFhndxMS325ySE3pqGD8pMNpBJqXt4LkDgLmQKTL/XFAtpbRd+NPKpPilLf13BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240182
X-Proofpoint-ORIG-GUID: O_Brw2WoHVoglV_6gRBbIgyUauTcCNkf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX0NXg2/qcdiKu
 XhDZYN6cMaL9On6g81oBaXPAZRvOG9sRtwmcScl6oxxL8FCwz6D2q8v385MXVLsaoIDaoS9iNMP
 g4IIeBTBKQGI0NFhmpu59/2aY9+u8MSuI60d1ST08LcLQwRX+caGOnWbQ5gWcd7fwr8MdVHpbjS
 4banrXWZ06ThmswybHnrTGP+54tMNogfpzO+cNz4cFbKNrNIwRRKIFAQBOmzXV3AhraLe2RypqJ
 FSLr1avpLQwtSvwi8yE+6PW7+UP88zHG34JmVsagZq1i6TLaUlOztSzTeF1cj2JGmRCS98vpdix
 uq1InLTd0eD/ihWrdawQpNtfet0u1w8CjQvIgqgrQuGdmqLZt4rDUWl0WLsZGp9yOP1kQxnyxzS
 m0DYGnHOiUEEV0C4d2xF5+N/3jgedpbuw3fUN1E/A9e72ZMuOpU=
X-Proofpoint-GUID: O_Brw2WoHVoglV_6gRBbIgyUauTcCNkf
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68fbdd4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SRrdq9N9AAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=vzhER2c_AAAA:8
 a=PuvxfXWCAAAA:8 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8 a=37rDS-QxAAAA:8
 a=UCaD48UJgALu0zcx_NEA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=0YTRHmU2iG2pZC6F1fw2:22 a=uAr15Ul7AJ1q7o2wzYQp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=k1Nq6YrhK2t884LQW06G:22 cc=ntf awl=host:13624

On Thu, Oct 23, 2025 at 09:35:23AM +0800, Huang Ying wrote:
> The page faults may be spurious because of the racy access to the page
> table.  For example, a non-populated virtual page is accessed on 2
> CPUs simultaneously, thus the page faults are triggered on both CPUs.
> However, it's possible that one CPU (say CPU A) cannot find the reason
> for the page fault if the other CPU (say CPU B) has changed the page
> table before the PTE is checked on CPU A.  Most of the time, the
> spurious page faults can be ignored safely.  However, if the page
> fault is for the write access, it's possible that a stale read-only
> TLB entry exists in the local CPU and needs to be flushed on some
> architectures.  This is called the spurious page fault fixing.
>
> In the current kernel, there is spurious fault fixing support for pte,
> but not for huge pmd because no architectures need it. But in the
> next patch in the series, we will change the write protection fault
> handling logic on arm64, so that some stale huge pmd entries may
> remain in the TLB. These entries need to be flushed via the huge pmd
> spurious fault fixing mechanism.

Thanks much better commit message! :)

>
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/huge_mm.h |  2 +-
>  include/linux/pgtable.h |  4 +++
>  mm/huge_memory.c        | 33 ++++++++++++++--------
>  mm/internal.h           |  2 +-
>  mm/memory.c             | 62 ++++++++++++++++++++++++++++++-----------
>  5 files changed, 73 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc985..887a632ce7a0 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -11,7 +11,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
>  		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
> -void huge_pmd_set_accessed(struct vm_fault *vmf);
> +bool huge_pmd_set_accessed(struct vm_fault *vmf);
>  int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		  pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
>  		  struct vm_area_struct *vma);
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 32e8457ad535..ee3148ef87f6 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1232,6 +1232,10 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
>  #endif
>
> +#ifndef flush_tlb_fix_spurious_fault_pmd
> +#define flush_tlb_fix_spurious_fault_pmd(vma, address, pmdp) do { } while (0)
> +#endif
> +
>  /*
>   * When walking page tables, get the address of the next boundary,
>   * or the end address of the range if that comes earlier.  Although no
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1b81680b4225..6a8679907eaa 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1641,17 +1641,30 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
>  EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>
> -void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> +/**
> + * touch_pmd - Mark page table pmd entry as accessed and dirty (for write)
> + * @vma: The VMA covering @addr
> + * @addr: The virtual address
> + * @pmd: pmd pointer into the page table mapping @addr
> + * @write: Whether it's a write access
> + *
> + * Return: whether the pmd entry is changed
> + */
> +bool touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	       pmd_t *pmd, bool write)
>  {
> -	pmd_t _pmd;
> +	pmd_t entry;
>
> -	_pmd = pmd_mkyoung(*pmd);
> +	entry = pmd_mkyoung(*pmd);

Thanks, I _hate_ this '_pmd' stuff :)

>  	if (write)
> -		_pmd = pmd_mkdirty(_pmd);
> +		entry = pmd_mkdirty(entry);
>  	if (pmdp_set_access_flags(vma, addr & HPAGE_PMD_MASK,
> -				  pmd, _pmd, write))
> +				  pmd, entry, write)) {
>  		update_mmu_cache_pmd(vma, addr, pmd);
> +		return true;
> +	}
> +
> +	return false;
>  }
>
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -1841,18 +1854,14 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
>  }
>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>
> -void huge_pmd_set_accessed(struct vm_fault *vmf)
> +bool huge_pmd_set_accessed(struct vm_fault *vmf)
>  {
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>
> -	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
>  	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd)))
> -		goto unlock;
> -
> -	touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
> +		return false;
>
> -unlock:
> -	spin_unlock(vmf->ptl);
> +	return touch_pmd(vmf->vma, vmf->address, vmf->pmd, write);
>  }
>
>  static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf)
> diff --git a/mm/internal.h b/mm/internal.h
> index 1561fc2ff5b8..27ad37a41868 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1402,7 +1402,7 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
>   */
>  void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>  	       pud_t *pud, bool write);
> -void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
> +bool touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	       pmd_t *pmd, bool write);
>
>  /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 74b45e258323..6e5a08c4fd2e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6115,6 +6115,45 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>  	return VM_FAULT_FALLBACK;
>  }
>
> +/*
> + * The page faults may be spurious because of the racy access to the
> + * page table.  For example, a non-populated virtual page is accessed
> + * on 2 CPUs simultaneously, thus the page faults are triggered on
> + * both CPUs.  However, it's possible that one CPU (say CPU A) cannot
> + * find the reason for the page fault if the other CPU (say CPU B) has
> + * changed the page table before the PTE is checked on CPU A.  Most of
> + * the time, the spurious page faults can be ignored safely.  However,
> + * if the page fault is for the write access, it's possible that a
> + * stale read-only TLB entry exists in the local CPU and needs to be
> + * flushed on some architectures.  This is called the spurious page
> + * fault fixing.
> + *
> + * Note: flush_tlb_fix_spurious_fault() is defined as flush_tlb_page()
> + * by default and used as such on most architectures, while
> + * flush_tlb_fix_spurious_fault_pmd() is defined as NOP by default and
> + * used as such on most architectures.
> + */

This is great thanks!

> +static void fix_spurious_fault(struct vm_fault *vmf,
> +			       enum pgtable_level ptlevel)
> +{
> +	/* Skip spurious TLB flush for retried page fault */
> +	if (vmf->flags & FAULT_FLAG_TRIED)
> +		return;
> +	/*
> +	 * This is needed only for protection faults but the arch code
> +	 * is not yet telling us if this is a protection fault or not.
> +	 * This still avoids useless tlb flushes for .text page faults
> +	 * with threads.
> +	 */
> +	if (vmf->flags & FAULT_FLAG_WRITE) {
> +		if (ptlevel == PGTABLE_LEVEL_PTE)
> +			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address,
> +						     vmf->pte);
> +		else
> +			flush_tlb_fix_spurious_fault_pmd(vmf->vma, vmf->address,
> +							 vmf->pmd);
> +	}
> +}

This shared function is nice!

>  /*
>   * These routines also need to handle stuff like marking pages dirty
>   * and/or accessed for architectures that don't do it in hardware (most
> @@ -6196,23 +6235,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	}
>  	entry = pte_mkyoung(entry);
>  	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
> -				vmf->flags & FAULT_FLAG_WRITE)) {
> +				vmf->flags & FAULT_FLAG_WRITE))
>  		update_mmu_cache_range(vmf, vmf->vma, vmf->address,
>  				vmf->pte, 1);
> -	} else {
> -		/* Skip spurious TLB flush for retried page fault */
> -		if (vmf->flags & FAULT_FLAG_TRIED)
> -			goto unlock;
> -		/*
> -		 * This is needed only for protection faults but the arch code
> -		 * is not yet telling us if this is a protection fault or not.
> -		 * This still avoids useless tlb flushes for .text page faults
> -		 * with threads.
> -		 */
> -		if (vmf->flags & FAULT_FLAG_WRITE)
> -			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address,
> -						     vmf->pte);
> -	}
> +	else
> +		fix_spurious_fault(vmf, PGTABLE_LEVEL_PTE);

And we now have a nice cleanup here :)

>  unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	return 0;
> @@ -6309,7 +6336,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  				if (!(ret & VM_FAULT_FALLBACK))
>  					return ret;
>  			} else {
> -				huge_pmd_set_accessed(&vmf);
> +				vmf.ptl = pmd_lock(mm, vmf.pmd);
> +				if (!huge_pmd_set_accessed(&vmf))
> +					fix_spurious_fault(&vmf, PGTABLE_LEVEL_PMD);
> +				spin_unlock(vmf.ptl);

Actually rather nice to move this locking logic up here too!

>  				return 0;
>  			}
>  		}
> --
> 2.39.5
>

