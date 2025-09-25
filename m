Return-Path: <linux-kernel+bounces-832468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F6B9F64E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2A74E2DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E981ADC97;
	Thu, 25 Sep 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLaDb0sv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/Eb2xcB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38D20B81B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805353; cv=fail; b=gEFLmFHq5PlQu1ZsmEvl3lkEyHUD4gK3eXdlmGR5OjS2vRlsbBWTnh+mZM6trB6QoMZJMAzPvvUSmSOME+LOaTz6FGviZqSr2zFPspbvlXbyEHCzwIvi8hmZVRoioxyyIYtlEn/BlJMX9Gv4iU5/P/bKHesqzp0Ztj1pXIP8nPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805353; c=relaxed/simple;
	bh=NZrw4PaWICecnrc0ww5WUcflXrHlhdP9vh8KOM4g/E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=re/aqgHyuYLsSDvPx2IDVs+W11GVClhHCP5AgSmR2YqWY+tuyeJYEOCaeLyI3CgqTYdQG6DZpPklyOIjZ6qleIL4dACZfUHTsezrcN/Fe/r55pE/INBtM1AHNxsQq2lYlyoUFjIZJsxwUI3yzc51eXUDRhTkbS9cD1DI+pPol10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RLaDb0sv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/Eb2xcB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtro2020270;
	Thu, 25 Sep 2025 13:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L8iMSGL+MrxHT6sVFD/Tu5StjKspsnEjJIYryd0TU3Y=; b=
	RLaDb0svsJ76apMWWzqs0J6t+zZI+HleVw/P/7ZWzJu3sRShvrc6ZZzljTkDIW9a
	XLyNU/koFxX77qajIeVjs3/Etl1TWDGsIZx5f5hkwBBFV3fe/G8Nf+HiHqIUvU4u
	Ky2gePSZ1XrWl2ZREcawDj1ep5EabTuAr9MSku2GuKRGRXfkePCIZ3/AIcLeNcwl
	ZknvEN8vrjcmb8sYyVXFUpOx71UZXA529z+ex/tEVTtx8RDqeWTU0nZp592mF7iO
	vhvkmPinCTAIzLU37bYuwJO1LeUas6U+GgZmwJCAEiY6b9j1DR2oyYqsjIvfqLbn
	iiFtyfp3GZf6WCWgtxWySA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt9y0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PD26Oh030416;
	Thu, 25 Sep 2025 13:02:25 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqb7s2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBFV5nPsNs6bMwaegUHtU1rEKMtJyJW43tZB+iThzJmK03R1S0FAu7yfIdVsDY/O32Hv/gufeWz+UMf4eFjPfJW4rv+Z0vfa/eHM1Ashp/b8woiAU5bQIHC8SWzXYX9+q40xc4jowZT5wwYKCFUxS3EK/fCjeex1P+1g5I/DynX63tmijm2kpaJI853L2a4P6A/n6Hbtb1DcuP4EoGT7+NQfqORiNHWvULH8cRnKZri9Dw5YTgodlv3Pzg0zp3Z/x2wBwuzgbyHNDuCZM38nyRsUGaW28kGeU0NmHXvlZp2h0OCIyJ41DMo2QcoJ1W1dXGprqmnQ4QtR82k5SrjOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8iMSGL+MrxHT6sVFD/Tu5StjKspsnEjJIYryd0TU3Y=;
 b=Ua3PkfnLXNeaJ9EUs8kAxfyUouL0tAfryv01R8joJgxMxXICSNVupsRFqyEhIZ4lTUxsRbyvwjMgYP53vgJYionRJoCuQQvXFl9YtdWZIBdfz9lbtNyGp/TlrcWHJpyrOWyxtrbzsQ5pTOXFGshkgGwZe5q4MT5QKW3C2tAwK0o+jw6eIbRl3qEE7CFUsoG3A1J28QBDsEAmwEeJQbpKT3DI5YuLgwUavofWBxMl8n+5U1E0wv5j2Gn1agfCBOQ/8sUMQglaPFIoF15bwQk/Bg+jfVRslvXb3J/DUzBLw6sw16hYosru6RCArzEaZh1uYNmrwrxB+CNc4AwZpJ2dLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8iMSGL+MrxHT6sVFD/Tu5StjKspsnEjJIYryd0TU3Y=;
 b=i/Eb2xcBeOtiOVOM2Z7rdV7HpzSbIBjz7HkUeRjv5AWJZyHfxlDF0/3iKRC3KMbyDGtoNjVtu6Kmy8atynNeLQku7gweroGqfxPjSrN1P3jHupzntfxz0Hfs6NRXRKOVi+7iyrKWVNOBvU6AKC3wbvn2DA9+WlOoyO31BHn/jz8=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 13:02:23 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:02:22 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.10] NFSv4: Clear the NFS_CAP_XATTR flag if not supported by the server
Date: Thu, 25 Sep 2025 18:32:11 +0530
Message-ID: <20250925130211.76431-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925125800.74222-1-siddh.raman.pant@oracle.com>
References: <20250925125800.74222-1-siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::16) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8bdd88-9cd6-423f-5250-08ddfc33c42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HT+FIxarvYX3+WLseRJcShuDmWv9FFstbmcfGydSSUFsfpdgD1WQPTh+IevV?=
 =?us-ascii?Q?2kTY9S+1yFqK9rLHZdyHSWkzc44YwQ5TQUxIpYHqnlwZT/nle4gf1e21L617?=
 =?us-ascii?Q?IhkDQY+1GiWohgnZog7zIHao1WuegjbH+auc3i/mySU4GjV4NLrxdFypM+qz?=
 =?us-ascii?Q?KithstHxRBAm8eDzcXkGWiIJz6/nyVD8h9J7KYLyEHdtLrmxQrJzt7XcWhfb?=
 =?us-ascii?Q?VizMQ4Tl0fAeBMAi/5JKuFKNGEcROGckidyWVDgAx2UmYdZDXzigDIooqtx+?=
 =?us-ascii?Q?xWkQCFA+qFw48WpuAvhND7sqTSwwEoW24TztCkRKLv9aIh5jylhVr2yuu+bw?=
 =?us-ascii?Q?YLA2yAGWuD+YMIl6zWKLUay5CP44isTbkCKmEhSTt7O/9Vy6Unw6rIF3SYr2?=
 =?us-ascii?Q?tS9rZ0XsTrMCDN99/3XF13DrXarwXxDwTujLfynnWTkCwK0sePO/lBauGzAi?=
 =?us-ascii?Q?j+YdnPZFL3ZfwSazVW665xlA6ezVI0SYegojs/llW+pEpSuTrMKhq7PmbBX2?=
 =?us-ascii?Q?OjTbso/fJAYeB/Qeh4zEAJQCtJ6QkXBv1bGoFEoXoI0lp2wgWlUkQ7vH96Eo?=
 =?us-ascii?Q?uls4bnBzhoxd1J2aaMTGr308F09t7EXYOLngfQS6CnC5wcAQVZE7AIS9qh+a?=
 =?us-ascii?Q?d7PsXMxXPPp0ztBUAqfhlOLEQz25CHUhLGE8KB2PjKPhdIt25J74UrJJJPDj?=
 =?us-ascii?Q?GgxSHjYKmLBX/Bgz68Ke1aK2NzEtSnMrD8gLrdv1SO5nRCwIyKnGV1nMdaTM?=
 =?us-ascii?Q?2di5ee7rs+DWA4XF2tjLPljS8VfPIwtW4v2YGBoZO59io1NlHHSUDxOdfEnC?=
 =?us-ascii?Q?epp4W6e7Iw8kD+q9a3NIkNFb92aHrJ+JBF4Y0mql+Z8WUY9gR6UAPHeM+cLt?=
 =?us-ascii?Q?H+CZfNbhWwA3XKubp1u9qHhNJgZhqir78QqVVhkvX9aU8NhppiA+D/+h53tA?=
 =?us-ascii?Q?+mNs0bk+TGNcOs2O7G2IL09enUzm6Kq+NIU+putOnI/cKe1CijVBMU5KCSWo?=
 =?us-ascii?Q?3QnfSUXvSdGEVf2nA774aotr0mU3dkWazPc4ApQMdGLQBNaUzPWBU4rNGKnq?=
 =?us-ascii?Q?2/SDHw+4IeYtNY8ecnFhaj4LcU99dDjF+ipsFN6O+GxCv/bGLIrxtxE078GE?=
 =?us-ascii?Q?Ofxq24YMTRb0Ou5UDU3hGVXxko+NCsZP6RdirgDsVNhTx5qQ2mmgdqVVz379?=
 =?us-ascii?Q?Jz1M2eAesPVkpsQ3sPBk4mcY5PrY5yE29o9iV9ANAvRolCOFfrphDrdgUDkF?=
 =?us-ascii?Q?TN+ZBfgk2p9HwH39suABCdWoSfNIzovcq759PXUhqIgnUvvmaOV/4l9sBcKZ?=
 =?us-ascii?Q?ej820jLutKzCPGiDlmSYlLAZ56QFUUfo7UbqTxdwK9piqFBqnkt9sJYNbCYw?=
 =?us-ascii?Q?Szhoiq3BHs/7hN+asxDMah0rR/L7bKSCoVNpcD6KHZ0NFO8NgIDPL8YifkTV?=
 =?us-ascii?Q?1qEqeW6F6vc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bp2RXPIdTGO5h5wbRHnkX6gchj+d+1be/GiQqjLybpLXs/tPLmOuAWw957b?=
 =?us-ascii?Q?fRAkEsyAPk23IhqFdGeGg2LiVnFZAoyEY1jNdO1QosJdZLc3jy4zA23pclb8?=
 =?us-ascii?Q?MycLvVpqz6V0PuqjmKj+xIm9Q4UL+dJyHWWC5cQ8/xUGSlAz7KVXoRz8tS8Y?=
 =?us-ascii?Q?W8db9BSy2rpPirtt5PKvgmyXSofYlMifQNzK5XCbbhzBtwjWK2tsF/v3zdbe?=
 =?us-ascii?Q?zy/beDUEnZ56yi5vF4aeQY04b6f4b9YnCWW3c/EtV3F6dSIi99Ft/yQSGI3s?=
 =?us-ascii?Q?slq9wnS/KKxiiyjitzy4UQFR2GMQNMtultFJ+qy/eS2l99R9/s0DvRNtC2mv?=
 =?us-ascii?Q?AcNEDZBukiCoLJ5QxWxvQ3CzR0/hjQVjwwBC+CIrzZG0y3PrdyY/4Ydn7eIj?=
 =?us-ascii?Q?bTD5n1FrQZpReOgtkxu/jK8uSp30zzsncvK8iSKpreKROAqg+td6CsyzNslT?=
 =?us-ascii?Q?esg0ARCRWIMxlnOmzCTrjV+5FIfA9l8zv5gb6j67dVbHwh4ZN9P/VB+/ku3e?=
 =?us-ascii?Q?LwHVBs9/8AQzoZYN0tXRSVpVewt5/OQiBW4cBjjxEAMGYD1DORxo9r2yCe+1?=
 =?us-ascii?Q?QZYO1CmL+P36ebWmaTMfQyR41scmugbxEayCyC5ObrcAocVzU4104ILQ1gyZ?=
 =?us-ascii?Q?yAb7Ump9L5MSTDk7x0OGNsVj1cgGhfatMG86FyENwHnTFBWJonVf2F0Oo2L5?=
 =?us-ascii?Q?aUrqJczQJKB6y7WGRcCPamGTT2gWyYwDVOtfaHl5lO/LriGCAOGOfF51Nrz8?=
 =?us-ascii?Q?6iGmt7P57eq6I58Vlp8vHvxLOmKmYH7SLqavwr+WVaez11OuoFbldK1lLOSV?=
 =?us-ascii?Q?juZnaSx44nRa/7BcrmJLgXKkf2In2uCiKPV8NhWsxYmt66Vv/pm5hpRgH6yJ?=
 =?us-ascii?Q?ER+y/Pm5m1iSd3JTAGq6Cbr6RbkiFM53qqyCZffKHFjCtDGe7U5cJwlILE+p?=
 =?us-ascii?Q?VRn+fKI5iWnE5HdzuPdNMRi6K248JhkRKMhjKf/7+A4oP+bQaBydGwvok86M?=
 =?us-ascii?Q?o7v5UigiU/jyepmsyQjeVbzNm6wBVYZJ5wiAlSigzccHoeTzwFYUre4iB+er?=
 =?us-ascii?Q?7qeSJDW7bYE7FjrOzMt3fNeZM+umLGUIOUCWFLUC4isI4qGyQUDi9MKmMurN?=
 =?us-ascii?Q?jZxDg32V4CR5wE43W44vUFs21b7Vckrg7mXJHUMdcbKm9jYkyvIh+kSVNKZW?=
 =?us-ascii?Q?nsh7hoELKPuB44VxFxxGbqVLOR+YHtKb6/I8jz4fFyxXwF06KOug/jVMEv8G?=
 =?us-ascii?Q?kClYpvM2+uNDus0Sd/MBW3Qbs5xK1vHQ5PucFfHxhZc/8DnCYKEsqN7D6X9I?=
 =?us-ascii?Q?uwFu0rrmZNLDZPizmEC/c+TRw5rk6ZBIWmBamMisRCk4O7YOtkbvjiS6O1AB?=
 =?us-ascii?Q?eRFCD4KcxHUOT1OXzTNvdHi7ELaDQt8HoLsEECnriM4DZmQifyYbrGGq2yFb?=
 =?us-ascii?Q?3W8saIUyyqPtOlaGMw/bGoUkfJen3LXJ1F8QU1koIBZGCIEMMDGVg6uNETOx?=
 =?us-ascii?Q?cgbUt1ls/yQkicmlrShoRnWHq37r3iuo5hj+3a6wDm8/MjwZA/dVhiicxzTa?=
 =?us-ascii?Q?y5kOP0/IpoyGq67fEDSVH0eRydmOPV1WBzgEOJW6708CMy1uEdHUuBdBsYeP?=
 =?us-ascii?Q?a5gRCsbt4b+PN5/8TXwS0X9pDyYByUAtMKQWN9loHwNm5FVhJz8SPbLiiLYo?=
 =?us-ascii?Q?kI0R8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2kBfeNqkQfTzoXuu32AjI3H5DP8wJm03zNG5JObfxmU5gdIXm1edrpUs9fyD3cOQdb3QMM6LM/TgjSGSiiempqDgFHx/njv71muZsQ0+IMQQCuqCTSgx1t15S1I9Z/aGWjF5CUniAqQnyqk+uoipnAF5WouSmfB1OnhU5MrN45VUUIpVjiRmaDucrONcepgrX6hD/JPd1ouo6CwVpAm0222N9fdYpANk9/cSREpCiFTU24mHWqk4+3OXrmmywCnv35Oer1lclKIpAKggiTFT1np4Z3ZaZwOKL6ARg3Wjk6PbSxK2K2EV67sAtQM2tcaeSKx8l8zJsq1X1Vq79hVy5K/uQ/5gUwbQNKocOFU64uO9G6R1XoPY2OQTwJJ8JT1iV8w+y8KuvPOjOUF83X52ccYMG+S/RmWbJ+hA0YJlCz4FXpam1+neeq0gYKgGgJSiAb5NpSHE2R5CdJdns9T9m/xugX1bSL19z+4NyrqS4M1LyBEz26z4ExPqL7G8PmnlFudJHNLLY10qwPM3x+KTyDuG+OVXIA5QF9Y0xwUPPbE/WG2hqAaCOIUkilSMBYNAqJKBOQ161zMpxTnyz0/SAnowudksOEdkazX/070UN/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8bdd88-9cd6-423f-5250-08ddfc33c42e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:02:22.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0OjSg5bbxoLOUqeVOxYQ1HgJHRhbipGHSjL1WKSb0mPMHmLxo3Qjla7E98LvAZyAG4msyKEur7xH2k8X8cY0yfgWYi3z4KjUAVCBtzKvEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250122
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d53d62 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=K7RatkPSvDhmpgaM:21 a=xqWC_Br6kY4A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=yPCof4ZbAAAA:8
 a=3gqAQrb8DLZVcbKcUoUA:9 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-ORIG-GUID: YElNJq3lfzhZqzFum-F3YzKC1nhpGpnS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX0oaaigiRp6Yc
 dKXYtiSVK/WcL80xg1qZ744B22AP5Be651PrzaiEM/uPDO4p5CM4S1R5NAN/3Msh/sQF3Agx5lH
 Bc0e9H7zTWe0GQYqErJFg4xdsFbtTvKuyjnm+dE3c3tdTBgPUnfib5sfvcge+3p/ElnSXMo4lVD
 QIdKCApu6Qct0RdKnsXXuSoAGfgO1WXOfb3Jf8kJrZI3PpGExao7NZ3ip7VOegckr8ZXQIlGBkd
 nZUyUMomEkvFe12fPyFadut+6Fvws7cs5admQo4abSBoSBgUwuh1b69zQZzGcXmxpvlN0bGe1ot
 YnJqv0L8FrZzupX7k0ypAkeGTLIDtw4JjsMwMJ4PZLtxGf/vPFmioBSLEIsY8z9DLzSZW/JHY/+
 wEn1hG1+
X-Proofpoint-GUID: YElNJq3lfzhZqzFum-F3YzKC1nhpGpnS

From: Trond Myklebust <trond.myklebust@hammerspace.com>

nfs_server_set_fsinfo() shouldn't assume that NFS_CAP_XATTR is unset
on entry to the function.

Fixes: b78ef845c35d ("NFSv4.2: query the server for extended attribute support")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
(cherry picked from commit 4fb2b677fc1f70ee642c0beecc3cabf226ef5707)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/nfs/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index ac2fbbba1521..6134101184fa 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -850,6 +850,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	if (fsinfo->xattr_support)
 		server->caps |= NFS_CAP_XATTR;
+	else
+		server->caps &= ~NFS_CAP_XATTR;
 #endif
 }
 
-- 
2.51.0


