Return-Path: <linux-kernel+bounces-731940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0EB05E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39974A17BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF724BA42;
	Tue, 15 Jul 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ECn+H6ar";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NDf6xcoR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622542E7654
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586689; cv=fail; b=eS8yJE4PnfkoaETKbq9iVfMBGUQs+mOOzP95+4JX41lYsfKvLLVHrrow2rIx1R0tlgB36HhhpB6n9m7wp+DXYiK2BQ9NG1rUn0sAlrNVQihJyxLHHRmTlIXzfG0cX4NimuMEt3wixP/0jqMlynlpESzF66oTr6ypv+2VdJo77ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586689; c=relaxed/simple;
	bh=4j+ye/dR/4NoIBGlK+tCrMPfFYyt3IyuX9DmhmcQ5XI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V15d3vk5p08e09J6TE6gMaNJbIK7ZlVh3Wl40BzaOImyYfHXiGRRdcqvPQ9cMC2yWFa+uvY3AdA/PJqgShE674Zfgb9AVuxPOGkP0QPSMkDrZbEC/phw8FawGmXDITDr0D7wEdJcT1WEBvgX+e3q9/4N8jiNdXJOolzaCtHp4lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ECn+H6ar; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NDf6xcoR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZFLd017673;
	Tue, 15 Jul 2025 13:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dcqlmzn6IaT3QYFy
	W6T9egZ2cIA6StVs58QFr0CFKdY=; b=ECn+H6arYm7rcL1OpNoGuxsrbA3+aMtj
	guKar9mskUOvbdKMpdGumYbqdFZcy1SIG5HDxlVdF78SMBOj0Ex/iOpCPtNd3OZx
	SA5PnkBr9At3tJV5ahVxNOroF9wEEYaJ9bzAf3GeXdJWruAf1l1ov/SDwsWyn2SG
	ypkhVj607W8VmbyXGljn+tnQbmCGnLKcrJs6OT7ETUdXdOF/Hso4sLAuaoB69YHJ
	W1GK8PgOfFK4ljzNdCwtpbBAWSlZkissFsur1kokRHMuwVZPfTAP+wiKa2aPOrSp
	dWXafBhDwjjOaTCkmbvHO9yw8kvPmPJ26cIkwT4IZ7uu6kgCt9lgbg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66xdq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FC31Ed010874;
	Tue, 15 Jul 2025 13:37:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59yt6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2DNjaca9KDOBu/MOXMsHFzTh6xcnpIw9e5JP/Z32+aTtjf1+QetSpKyGaeri0Y5UIn8TnxEEvhV6DCWTZcsz6gMKgCgqai1UzlCaaDHDt+2CB8i0S5Hwgylq8R2WABVuo2kiF1VRonoQM1a+rdRwG5E8CDPtbMvJEGtioKH+e+tAgomxBHW9xjrC2gv5LglJRZfSpfroaR+sNsA4SOip5oCWoP2ZsRktMKN11g4fUy/zsArW6o/1ts1YMTJqaGxe1O9MMRo+C6IkDzZr/iHuP2xV+n6u/GHxEt3+hPkRiwktLfdrh5y+amtEoVg2J+gNhByHpkPCJvkuKFADHywnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcqlmzn6IaT3QYFyW6T9egZ2cIA6StVs58QFr0CFKdY=;
 b=cW+5Z19qHTaxKjHohu+MhNu1WmXL4odLTC7IzKA/oMtmT1oWfhptSBEGNHZ05UfCvb67FKlOD+r7AcWRbaZWQxLC5/qgmTI9eRAXB9l7fLns6T7qZTcuuwBHeHy08MRnKpTfBxn41smhPMPRkDi3gh1jkNwt6pUiiXHv3FQUUb3ORpnL4a/uhLKxmz0Nawl+4agkdhFUCfCqwv55Cmc3601WXx8K2ulBDGH0Y9w3yQx5oSvhOAbTRKJ1eXJRi/inz79MS+V/v0pFJD1rDTTd3wHmABD0CUkwvJANRcBdXVswoUcmRxbUHz0Xr96zfKfdxpVosfPvEjrx/UtQyakmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcqlmzn6IaT3QYFyW6T9egZ2cIA6StVs58QFr0CFKdY=;
 b=NDf6xcoRbQRJxYH2bEWMPNlO4aXS3m6NQjZ15JTuJZe0xL3LEEUYC/67rHjsd5PjHk+5/xLyBdoiWBOWDya9tVIFINZsnKQkHJWZy7UdAhly4uL+MRxz6vlTho0biPyWk5zzgD9DElujdY5WNTbHtX/35Zk1ah52bUxiMSK+no4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF0316BCB78.namprd10.prod.outlook.com (2603:10b6:f:fc00::d04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 13:37:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:37:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/5] mseal cleanups, fixup MAP_PRIVATE file-backed case
Date: Tue, 15 Jul 2025 14:37:37 +0100
Message-ID: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF0316BCB78:EE_
X-MS-Office365-Filtering-Correlation-Id: 825cc632-0d4b-48c2-2343-08ddc3a4c9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hBBX9HR0Q2x9aLc1OcEjIf6fHoy1wP6xg1bgfyZmMHWRcyEqmlb0xhZv7b6N?=
 =?us-ascii?Q?OEj1NGa+7A5+7ETf26CS0xcWDztS52U8vAF4T5sWctp2klWL4lqzTwbR99BI?=
 =?us-ascii?Q?3DQoeyZK3GzsvzJ7BDqgP/bIn07dKyUnEjwAh0+iUt86DcoBy8Pdam5SJk46?=
 =?us-ascii?Q?GUMsY+HhXpXVWlSbuYchc7zFUTtlFB3zoaLuXjBgk76WTTJG2MtuJ96drnCd?=
 =?us-ascii?Q?JcfQ6+Eqy8MZskxnEI8GIONQQjQsH/tM3IzRMTTt05S3I1ZXV3Z1dMaqEy/K?=
 =?us-ascii?Q?G60dckSxR+VTOTLZK2HNfSUjM5WJfShIo6HHHqS/fs9CO4KBS47YCJVdEBjT?=
 =?us-ascii?Q?Nw4zdNpdrH63CV6PqI3ng61N4xz4Voy4iZmPNiT/WVVcLTmxplCiLbk0OqO9?=
 =?us-ascii?Q?P4OLDpKWimNx/4YhC4H93pklCaMxP6ssdVMNDfpa5bmiy8ALshm4iD7gRiaL?=
 =?us-ascii?Q?mvWcJxt7Y/2PtAvp2l5Ento5lZGI3JEXW+Hj+facQpt8e2hsKvytsVcKmsJA?=
 =?us-ascii?Q?MfYqQs6tNYssZO/HwbUYUUihcGNnZhxUnjPnjzeWU9PGxYbqyFNzhfVpDAYt?=
 =?us-ascii?Q?d4bElaS43LLIuneABbgPEKL9Z7vfhghWQWAxswmvnPJ8RFVHMKNfVhPHvgwP?=
 =?us-ascii?Q?vQbMdS9JJQmTRFY3prvCmb6NapxKF3INtPBGubADBpURayeIau/24pLRye3T?=
 =?us-ascii?Q?oTS57968xtZSSjTziMviJStRoM6Zayw4nOB8ynK5UBtzay4u/hHS1Dgxsg4Q?=
 =?us-ascii?Q?5uew1dqNiTpUe0REHXso0X9mZWR+t97sICDAZofCI+kPKNdN+RDYaEMDg3YP?=
 =?us-ascii?Q?Gsa2racpiOls5osYLcT7j3biHpxDcndD0KDzrKSJpcKEMFsobGvX9NgMQvSD?=
 =?us-ascii?Q?M6gFQ0eEi5DpxLaPCDVX7c6cEa+V5bIq6U0uchtVy/O3kKvErQRCECZ+2F9w?=
 =?us-ascii?Q?G85akuxMz+9W3ZOYSTg2l24kJMAN430QG3qm8XvBLX0KHiUmxzUTp0Hdy+zd?=
 =?us-ascii?Q?FCeDbG5zu00nEtM8Hw0chGG9bd0pyVJ/qYrhqUZAKsvZ8yhp0mWpitQjVOtF?=
 =?us-ascii?Q?UIvqRu3WWtoul8ZFtfgoo+bDnJkw4+9KSC1S6gaiZDsuAH1xdRbWmu3EoROb?=
 =?us-ascii?Q?orQyjrp0w6tZ0SbHsXSmiN4q+oidA2WWRrwRqsUlu/4n0ZWeN1n3CWQ1lrOZ?=
 =?us-ascii?Q?CH46DC7/1lo9byWKHVLfI50odQtnqxxyBJE+Zu5LJK4kZ6HWM1Q7BK8iJ6za?=
 =?us-ascii?Q?NpbhuJT3ECWneql9AuuutE2x4VkobH5a0sjInOzRDosiT5DfqDAl8pnAeBEH?=
 =?us-ascii?Q?joUuXXzHOtaTKDt2cgxdqlP3466mSnh9pqFwsm9UdKIHy5UGAbppqU1ZxbWg?=
 =?us-ascii?Q?zf3TQkjeiKWjl9D+raBw160MPb5ZtKDhOggouLPpKJVoAc/vVLh7p2axfrT7?=
 =?us-ascii?Q?hFFDI2Ij3GE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MbUHAk1NQSWcqwZwZdQAcojvU2tZ4bZWgtXLd0meZzEl3esCRiMT6836gZ3q?=
 =?us-ascii?Q?+EG5kb/rcKYk1kq/jLsJwOhNaJDX+HBUPFZ2eEhH1YDOYWdX3HnMZ0xd+sc1?=
 =?us-ascii?Q?AS3sVEmbD3qfGFhgQU9aqYYRMpMhYCMqQ0aT5PsHD/mvs8e4jQLrTD4/ArvS?=
 =?us-ascii?Q?oKISxSR4MKpjvVfsCzwlVI+eQrehhrTVTamKQh6Ry/L2nK3Z2eLkH0Rbq1W9?=
 =?us-ascii?Q?w9sNDx3Eol2TvsoEKqm7WFrsHaIPjUsHftA5RC5YWOn5Qltgs6skEqSziOmm?=
 =?us-ascii?Q?Gmemn75ajl/EGNOHgNEqFU8Hi4HADyaNi5TG4D30niy25mY1uQb07kno5qzo?=
 =?us-ascii?Q?Bht0kfARfCh2wE707i7xZ9qJMprKH/l7LvrSDRiNWYdKTOTf60ruEemZH5ZW?=
 =?us-ascii?Q?33pmiBNwhXTO+ZUJhQQQXdDIYKfdawi3K9IAJVgVnij0+2zP6sgDZ5DHWUsn?=
 =?us-ascii?Q?1uwKqCaXnGorM2yKxzT5sE5EEjcbK1ymZ3vyuucGOvXAoYwVHEcKpluldKA8?=
 =?us-ascii?Q?RcQ156YkOD67e4Ijfux3PtnvCatDtboCCDhjmYtUxHv+y4ZKlNfmwmiT/vAz?=
 =?us-ascii?Q?R+MIe6xOTJ02RQOVx7RHFlfn8VmSiJxu1TNWgDiRG1ZIeOlwP/ERV0vJB3Jh?=
 =?us-ascii?Q?+sT1Eg94gF8mBVR1PQNqGwfAPJ07YLLrKCGVZCMNCiaDFtbE/9kxYWlqyfYt?=
 =?us-ascii?Q?kHi2HNYuc03uRIoGhH6z6l13qUQv6LxtNzmYexHEkI8Z4itFO0V/0959dRum?=
 =?us-ascii?Q?VXbKtbL+cvZKspFkIcnM0YtKN51+Z8P7PHgixonKuP1vuofTwNQyJ5cacIu1?=
 =?us-ascii?Q?KiuEVKBzqQqpZxCOCf0lCyBArHEezFX11iZbNwrzO6f1jn/VwQZJs6vJNiDY?=
 =?us-ascii?Q?0QJzPkiIEyjDnbacrlT3LufIHuerewGmb+9dHxeNhuVkwBOHKTBPn3RORQH3?=
 =?us-ascii?Q?/WMVhkYs2J57TRIba6uz9bdpUNmFnsonCZiUEaXxcgY0wSU7HBiOatJ1QMzV?=
 =?us-ascii?Q?FsEvv6ISy4HEVD77DpBrUpUgdEHXtL6VXcGPQwhYBPru2qGvSWnljD7SEQcY?=
 =?us-ascii?Q?QL6FGUVfbJpzBuPx6iFDoCwylaHgb0a1z9Jdir3eK8oFbEXjnHW5PpJ+FP+v?=
 =?us-ascii?Q?ApPaGLAm1D/HfI7OP/NPaMokx065ii21ON4ooN9pmiwhF+nlU9VCVj5OGIxN?=
 =?us-ascii?Q?XJv8S4wN25wNkRQ9YL1WjnYXNQ1mImb1R9QwRDx32+NPMxGmPWSFLqGzt4jR?=
 =?us-ascii?Q?eriyPyMKjW3Mlv1QlmJNm/y088gibmFQMgzgIAqEStJ4zjP6sy55/qgAxFYR?=
 =?us-ascii?Q?32q4+MazmY7nhBsyDqhMGXKiFMyCZjLQMIQE6s92vYvUAkH8Yaz9BF5lcpT/?=
 =?us-ascii?Q?48SEJUpbOf6TSJ4M0yLfo32FvOaBGAha/8J52zIioTMGs+5xP5U6MhGo4RRu?=
 =?us-ascii?Q?qBlHhfiyX5189fHzpcKTX41oBRs8V4NPzvmAM+s/fyXUtGgCzo1jUVK3AuN8?=
 =?us-ascii?Q?pTNQUJ1XGPA8crt9cNO5VzsZL6wZ12CLWZ6u/6Q4b6mpDdE02kECtGUeFOgo?=
 =?us-ascii?Q?C/eNnVOSDRwCnpjBhvuwhMacm8hkpd2xseQQlRZtqRJEOuj6ipWHP0MMfqAm?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HrrLtpjhSNh0ka4KcXF8qPs8NZEBDLQiYBzJYg/UFKT1iRo26Ij8aTVh/n4ho7K+v3Bciym71E7lVYesw5T1tZPiat0cazabukoQB4e5vpHy7ZW0AaeFMz0lhKlXNgI4EJs4kpNc1nFiGsILZ1XjWqQWGlhX1G4NXknkRmMlM74QU2iMiTrthCZoID/emVPh/Bn3ggNRh4P5BzAbTOJDmBWWA1InLGvpPP9KGMSDo752yBpkF54+ABCQC/94FqBnvaCkFb57t9qqSmwjdLSkkg/phe+1hq1KjQ3NWb4UlFb5vjILzf3MVva8xbHg04rlplTDEZo0oYmcooMaQrHmTtCaw814hWTjT4MY10reDedgaHZAfr8kUwD4+7ksWP/XKE+Id5Jwb6c4p1k7QsyUarsLPaUPywpYRaxqZNiEDnrMa7mLCo39U18z748MUFVSy0hpfW2J1IQjG8OfeBsYMKwISOIzqX9hzzGsUXxjOR5FSqKlM5+daTO9JtVJX2F9DhgRCFBeCBbCJ1OA8uobrvm2BbViQQynrdhEkZg+NkFpByuWFVEt5lpYmm9AWMKv/kSjAlhSzRZXSZ2wQxTTTjEjmzaXmsmMl+IEPujUpyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825cc632-0d4b-48c2-2343-08ddc3a4c9a1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:48.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHQIu32JQ9DnVS3TFQ1SwT3BgYREj2piMVFJnSKmi39id4dQdv71tTfkeOHubzMrAKLBXT9ml31s0uDAvM+5r7PNiTOiupb2RaNF2cQZpeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0316BCB78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150124
X-Proofpoint-ORIG-GUID: XIBXWZp-WpFVx-vuo0mkmQjGybLyhC93
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=687659b1 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=m3iXoojSnKQOflw0TRsA:9 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNSBTYWx0ZWRfXzQFLEx7qfCeI sp09La1XYAV26d/2hN9GgJv1OoxeqhuT/SLKV5vi1KETVxm8viygQgNV3XwlHH6DwcjOgj4/uh0 3C65HSiJRch8L1OzpXnUM0EC2zvSNFl0M4hSlMt+kaw86M9363rHXrb9CH/mPkkI3/esy15eeRR
 HRrTGKtUBGCrHtRKyAbqQ5pgkI6w37xCSkenrqjpafZJZaCSPjwm44cl9/agumV7qpxG2PIkbv2 ce/TvZ8jMW9SVcVXPqXb6MGcb12xsUWss0/OhJlorhRHSVcx5qdpGmtHmMhCw0sb/EPq7eOGmBR nvS1A+L8fg+8RA5yUdFFDtUQ6Nq5glPLhTJtERQNe2e1gTgZqz8Y0tW2oo8ysNIjZj/+BYCmH4Y
 GZcm3ku7b4nF3g4gOPT0oUczpuNqRw3r4D9h4rgeA0hK+Xl91b75hseBSmIa/aOW04UobuDY
X-Proofpoint-GUID: XIBXWZp-WpFVx-vuo0mkmQjGybLyhC93

Perform a number of cleanups to the mseal logic. Firstly, VM_SEALED is
treated differently from every other VMA flag, it really doesn't make sense
to do this, so we start by making this consistent with everything else.

Next we place the madvise logic where it belongs - in mm/madvise.c. It
really makes no sense to abstract this elsewhere. In doing so, we go to
great lengths to explain very clearly the previously very confusing logic
as to what sealed mappings are impacted here.

In doing so, we fix an existing logical oversight - previously we permitted
an madvise() discard operation for a sealed, read-only MAP_PRIVATE
file-backed mapping.

However this is incorrect. To see why consider:

1. A MAP_PRIVATE R/W file-backed mapping is established.
2. The mapping is written to, which backs it with anonymous memory.
3. The mapping is mprotect()'d read-only.
4. The mapping is mseal()'d.

At this point you have data that, once sealed, a user cannot alter, but a
discard operation can unrecoverably remove. This contradicts the semantics
of mseal(), so should not be permitted.

We then abstract out and explain the 'are there are any gaps in this range
in the mm?' check being performed as a prerequisite to mseal being
performed.

Finally, we simplify the actual mseal logic which is really quite
straightforward.


v2:
* Propagated tags, thanks everyone!
* Updated can_madvise_modify() to a more logical order re: the checks
  performed, as per David.
* Replaced vma_is_anonymous() check (which was, in the original code, a
  vma->vm_file or vma->vm_ops check) with a vma->vm_flags & VM_SHARED
  check - to explicitly check for shared mappings vs private to preclude
  MAP_PRIVATE-mapping file-baked mappings, as per David.
* Made range_contains_unmapped() static and placed in mm/mseal.c to avoid
  encouraging any other internal users towards this rather silly pattern,
  as per Pedro and Liam.

v1:
https://lore.kernel.org/all/cover.1752497324.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  mm/mseal: always define VM_SEALED
  mm/mseal: update madvise() logic
  mm/mseal: small cleanups
  mm/mseal: Simplify and rename VMA gap check
  mm/mseal: rework mseal apply logic

 include/linux/mm.h                      |   6 +-
 mm/madvise.c                            |  63 ++++++++-
 mm/mseal.c                              | 169 ++++++------------------
 mm/vma.h                                |  23 +---
 tools/testing/selftests/mm/mseal_test.c |   3 +-
 tools/testing/vma/vma_internal.h        |   6 +-
 6 files changed, 110 insertions(+), 160 deletions(-)

--
2.50.1

