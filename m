Return-Path: <linux-kernel+bounces-832465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D83B9F645
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6272A6084
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B4F1D7E26;
	Thu, 25 Sep 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D84V7qUg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="my0lhH1U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757E35957
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805334; cv=fail; b=mX1Aiq92W0IoG73Q6zm0AXyix1+dS/x0v1GCx1cYAj/aRtx9Qknq9li9r0phKBF0mtVLCTHhRyPwiFv2c7QpyQSeQh1h4IZyVHXxdeSiUGpKGqHkTBShVe0dgfQjA9+pvKeIVmzTGvundR8xCIy0hkQptTmJEDQOBffDQw6MVxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805334; c=relaxed/simple;
	bh=cOnofxC+qXtnXepK06ueubfRbpKVTU+18kSDVe853+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7mYOw4qKA4I3fDe2o4Nw6cMagJw/B5g3pbWUNZ1JiaEd7OIFMghRDt8OpTy06dnUi0MPovY9AxAxKviUHCoBPuAmK+6HjwAcb8J2M5GJM3n+VRdUCGTli/82Y8/ZtMeBM34EslQ0N/horppSrJcsUFyKmnYE+pKA2ugmywFypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D84V7qUg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=my0lhH1U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAttVf020325;
	Thu, 25 Sep 2025 13:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rNjVYDCyDxI87Ed6dm5MyGu1gOkeyWjUXG+v3zsdEck=; b=
	D84V7qUglMpS7FIYHIfofOb6+1zNUymBd6hD+YtdrCEhP1O8CxU9aJrG9uN2QWG/
	MHGOZ3O3qU0om9sTj1N+PAymWm8nk74KSP0/WbrhoxXUT6O4liV84zznOxWVAXt2
	xAlqhgwtDa1fcmoEesmxAyNGDpng2j8R0qL5vY4K6HGTAg3zjp1ZKjeQbjtRlnsG
	s9j+rY+x6BP3ESwjH1P2IcEIlUhkWb5td+DNYnPszR3B6+lp+NKpjbv083b8uz2b
	OrQ6RdLgMfDHFi/Kw/WnFauvAl6SqTSe4d/hBi+vkWbNOPuInKxiOBOZOxnnSg8y
	vE8M7XLrwPg2HL2ZlVbkfg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt9xyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCJVRJ010847;
	Thu, 25 Sep 2025 13:02:04 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nnf6an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:02:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjwiJjKZd3Vk7vCpDcHwohz7QClSilZHaEBjWCaaEpSAmtW3hwyHtg6MnFTmKmml1KCIwf07o1Q+WH7S1O9rXEwvFWz0gVLICas1DDLdJV2UOe9BWvUB2MU+yWKkfBKN9E3IpMDd8957mD9t7+ZdPsX/P25FpkSLPSKjz2K7VbigDwImcakWjVhs4I/vgUoGyIdsLRZ0D7BUJGzeZfuwjW3OIsrWTwYwVxfo8Qsi2WZZVE2BLQiOEeK9DzUu2B5RQV1mrtNZmgHmSFZWetm43ooD5g2RNfIBMEf8Tk1u7VOJ/b2u7nBWTlnqpgZHJ80ebVJnb3Sa2SPMLkyabFwBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNjVYDCyDxI87Ed6dm5MyGu1gOkeyWjUXG+v3zsdEck=;
 b=Gk1sr2dggZdL6hIOoMingcp2sgxlBwKxsGj/5hGLOLeN6w+fhu8+VEUYjHeDiEBN+d7ean2dan6FCO1KZkehTpo0ku2LxzcFz1gXf7BtUwPMnIGlmmKk1wN2U6B8R51dpX5FtkME9QnHlyYOg6FMSpUIh2W5lasX7Xt65RyINkZqtK+eixeArR15vS0UWp+NtYVqAzTPnJPmY5rK1e6/pkLvYiGvjzLYBpVlEjwXbiilp2aa2VvRU0dJl2CyRdnER3utBZP2FeuIbwBffLKBWqRKOGBi+6zOXsUXvjJGMl0VcOL6fFIGC7nyTbhoI5QdBFC2YWKQn59J7xIrbyj/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNjVYDCyDxI87Ed6dm5MyGu1gOkeyWjUXG+v3zsdEck=;
 b=my0lhH1UP0LwVa7Z+e+Z1AxKwws4YS0i9LOGnKE/m2N7/ENnV38oXD4tDoaTxa++s8+bx4Wn+wa6DPbH14D2jf6MI+Y20Huc84oYdqkLtI0cF9hovlYaByQMcLHL/Rnm9bw3veWYhSJxW8BpUDzEvrk/zb5RlUzQYl1hisQ1qDA=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 13:02:02 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:02:02 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.15 2/3] NFSv4: Clear NFS_CAP_OPEN_XOR and NFS_CAP_DELEGTIME if not supported
Date: Thu, 25 Sep 2025 18:31:45 +0530
Message-ID: <2e811427a30b62898f63bab33ec07d9253061a33.1758805195.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
References: <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::30) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0416df72-1f51-4c34-00ec-08ddfc33b848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?affVyEpXsYlKKwNasBz3UCOyqCAdKnjYLbxbAgrXNemsTd+zRc/tWNlNTi3v?=
 =?us-ascii?Q?b6ZEYbNwxqdygIyCSQvZKAc/upBoXKE4/q2da6YKh70IFP6tmR5MUbkCfrze?=
 =?us-ascii?Q?2MM/de9O7OxHKkfuETFqXKn+hmltX4f+N4Cfjigxc9lBvlZlPoox+KMLvX1W?=
 =?us-ascii?Q?remTkg4inPZEIYf9qcAqd8lS+Iln3sNhmWESaWVsb+TMYXYQWIECwgAQAo+n?=
 =?us-ascii?Q?bxfg946aLgKJPv+IjUwNr3TmaoPtCYoameqUzvvldhMg+UMxLYspvzazr0GX?=
 =?us-ascii?Q?SRtCZfWVVkcC9PQWpqDSfbQKzK+dnfIdwHaoQtWCy5XYSUmKxw4+eyZ3m0db?=
 =?us-ascii?Q?oW9c5b63NdigtRjnx4zPTSmTCP+YQU9PxerEr9KcR3n6V37XHO3LxdX3339F?=
 =?us-ascii?Q?Jyg5lpjqz+fNx6GuV5MskAAbJs3lkFeMfrKaI2znQQeTPIoynMrd9J4sh1eI?=
 =?us-ascii?Q?ipvfK1t/PxyU1iet3YWIuyRFsPcRAVpULQ+pwHi6icOR1JljFFOJ9JZs09JX?=
 =?us-ascii?Q?qHpveYysTia1NREtmowvbyKrzdwNm6OoXb3J+VhsX/XbaOUYEgwbGENQQdKi?=
 =?us-ascii?Q?b6rk9rpgODY3LxgRqpktWuTjg5pbhH3p9ECzolpM8IeTFjuA4q/EKOMEQ2VV?=
 =?us-ascii?Q?BSs22YMi+lWnOh9D+Ujiae6rbodTv0kEGNfyfeuzZXx4WJmgK8RaPQT8UIw+?=
 =?us-ascii?Q?EFFKNUF+Qf/lqqBro21Xho81BQXTt/hzk548CGDgRX6YqdLaEZxiJQL62F0b?=
 =?us-ascii?Q?IJgEuqlDPHbte0DQjSK3P7/Lk1puE8+VXKLMSLx3YXQIEKY2Hq5lTJCeuDDa?=
 =?us-ascii?Q?zXrUgzKM7GRtd083o5fmVXGqCPxU/MA73PHzQwRuYtWkskRjdFu0dnz4f67H?=
 =?us-ascii?Q?VaQzqyEKz25zDfBcxh164WH+ky7rNMJM1TpipvdxblUs/64Jx4tpVmWAmO68?=
 =?us-ascii?Q?Cx831wRRBMm0tvnsRLUUT6bEyEah7AYRXDlVODfcQyeI6Q50jadJdsW28uC5?=
 =?us-ascii?Q?m0I3XdXYloKHWrnSUQdRD/+32D5OVf4YZ7AyY2RtYwKEFsrAL9286OmzSgQi?=
 =?us-ascii?Q?+jw+lwx35Utnk2lfaHVULZG3oc4GinaGkcgpx5MA0xqWOiqRUpgQ1IZfHT1d?=
 =?us-ascii?Q?5TKgBxHXDYrieRQl187FuQf2wJyY0g9TnOA+wgOH5sl02rCGcxDwGpN3YLd4?=
 =?us-ascii?Q?7+aceIJ/ofI4XicCKYMnalD08ggV0ymdhKSVxOB2FZFmDxAEO2itm712MXMl?=
 =?us-ascii?Q?a36BR+Cdok1wXT5rwGpZ1bSvdS98tR6Ml5zGXMAkXAbOantczYWunNEMrcCv?=
 =?us-ascii?Q?eKRBuKDOiqiTR27mxBGfNL4HEwEn7AXA3R9MT1/FT3CSnchRVlBSSmnxaSk4?=
 =?us-ascii?Q?3pkXoc10ubrfbiaM28DfqE6onfhmaBxJQMxM+LEgHRPUp6FHytjRC6lnKxq2?=
 =?us-ascii?Q?lreDdbIwyRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vj4Qj8zny1BBEeksOCGN9s4cnxFeT7/MEcwEuULeGlY5rcKv0inqZv5y+PpP?=
 =?us-ascii?Q?gCbZKBiElOdHdzjJP7tocfTWvTWT+YFVmKkgv0YXrkACS1hbu3jFuX/Gs3xY?=
 =?us-ascii?Q?gMjEYbY6ECxnfq3j/kzOH/DeP6IhhsQIG/ThoS9pFTKcpJWQSLFHiZSmRwCY?=
 =?us-ascii?Q?NogmPQ1wXC35o5ZcVs16m2l0sWxIYwGjOOjtBm602L9n2N+++HrozGrIefRi?=
 =?us-ascii?Q?IgLZ2RQiFxDEqzh4BvpTtrAPiAM/CE+LV92Q2+8iM5kZ7LQTRx1m7PNY5FpJ?=
 =?us-ascii?Q?wOmSjEyaUE7uduhZUetaYh47eCmAnlyIfN6ITHSa0/8DH6yovrcv69Bo40RY?=
 =?us-ascii?Q?fz+lRY6UGkOF1DcAbEe2HRi6eA5LebZ7yg2OTgNctRUYItQQ+v3tzi5HTPq1?=
 =?us-ascii?Q?s/+MDOL/HwWmfSIwBgSFtClD0mnMhhbu5ETZnxy/bXr7ajN34VI0QX1nj9oE?=
 =?us-ascii?Q?h3Arp0t4WAniC+0M1GEOGKIwCNCq59P13Awpq8GP2hdvqNiee9LNWEVqybVH?=
 =?us-ascii?Q?nD9Woz1/Hmnt330NWdJ2G7L7y53OJVOaPm0ALTfl5EIQREysH1Khtovd2dh4?=
 =?us-ascii?Q?uBlM9JmxnSUunBNNa+OW720WJQ1zFGVSPd/0A2F1pyNvec0V8jzfDJ+fZ4/R?=
 =?us-ascii?Q?GqE23SY3yx0m7hCOxGp1eeVpIA/TPpKLnvllKhjdOHccyuqToo9gGFyQXuOZ?=
 =?us-ascii?Q?+v+81XA0Y26TzV8flCWPIXQ2soxs9swr8wPCNrVtE7m4lwUGnkS0sGGc72wI?=
 =?us-ascii?Q?/fzEuTWExJdnmcRnxeGJXJ0SAeGuRUp2pPZz07LNNQYPqofRqY8eG8X0R4KP?=
 =?us-ascii?Q?nhLC+QUYpZyo2uXCvPHh5ORCs2SylV6WqxEYXU1pEJNMDUfNWbEGPJJsb8/L?=
 =?us-ascii?Q?tmnXA4ujemmMsW2dknsWqxa5+X2jGoUbqXMZxk1KUbyGK6Q1XPiDsepYVIUX?=
 =?us-ascii?Q?yJQSNFGyVxFWwoBfoLwzyssLpzIDBUPCqpjkx2OmXho9D54X7k7oewRlC6Tn?=
 =?us-ascii?Q?Y9PNdoOIwRgOMZbe9OliPI1OR5YN8J8WH08IlLHHRm307ZdyMu7NNqGLvmQ2?=
 =?us-ascii?Q?1xPOBQiJ7YCp590HbGU1U0uqr9tz3h2NbUNKYoU6Mzvpfm3IBfV7UHkNM/EI?=
 =?us-ascii?Q?1BT28N/+4wBqANMH5CIcMQWOQbebsL40ZUxCql36e//aJ+09AHObyd7Dn1+V?=
 =?us-ascii?Q?NvQ+QwlQMYC9Y6V1FNHEy9VjsJqGkBhZPgnRXl4D3JxIvjg2WHZcRseGgcIl?=
 =?us-ascii?Q?OWTihK9CiKWWU/EF6EINvirSJU6HDWf2+Rd+gfIMzhXZr9Zii/Hm0aI/DabZ?=
 =?us-ascii?Q?cM1Avh0PHEVHhdxva7LdJlDRY4e0An5q7U5a7Ev9MSwLohcR5SOkCqAu2fX6?=
 =?us-ascii?Q?njOThgs9rggGxxFmL2yv/iwBBNL4uW9tuGUvXWHfo4tEBt8R0/C6l+2a6D08?=
 =?us-ascii?Q?XlqgZfSya8QvycLdHSMaEPBSGxZwvSxCTT+GJbFROCqtK73inKS2D1prGjLX?=
 =?us-ascii?Q?yaHoSGCfdwZetF19jERVjYPFSFMbe9kNkFi2YWgmFt4d+7E1kU8/MpLfFqC8?=
 =?us-ascii?Q?VCP5GgQqKO9fWEla8pEgVP4DFf6jSeVs6EwdaZ5LNrzQpc3faf4hkqxGRok4?=
 =?us-ascii?Q?kfPMDY6PwXBTUBe471WB1wP/Drxus90hKQJ9E3na6YV5fVPjV8rbo8DUj84v?=
 =?us-ascii?Q?A3JJhw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9m/ys24e22kVwW42CgCGgRRsaVh2y8NFZkJvqz9ScT1JCQdIk9kJe4RvVD4xdSbbYhDn8EllZ2RJUAyl0ME4UUKbCz+KD1mWAXuOLwEUts1Ql5p2WjfdiBbMTpwOijpOsYKFrUQIyKnbFz3oY9/hrby6MnTa+I88vhHXS9N5SKQDEFBNYK0woEwQr0VFodJ3BuablQDSnrtDKkUP5CdcHamB3kwdrEGx41tPzdwYTlQ+FMtHlULQJtnZP1VgFwQTbbeaRJMnGEyn/DHS0V0/moM7gJcQOFge5Aze2kwL7KG+qyVIxwRbmyOwBTe6PFdrgfLjXHt6s/46R5PAflPXS23u+iL0agvJCuaAQiQGivLqdg8oYWcaabjEG/1hYFWvV3ZOqwqcRHbSbyuZKfIy90Iv0CEdIt39wu+26QLLzRNKyCUNncZcyn2HG56XNZd49QXD1RVWoUtFQb7T57DBJHC1MZgLhFay4D/8sPuxdXhiQBFw5ADMzatp+fIdL+ChEnzWRpvn6Y1nrIG4PUPurCSB6Yydkj6p1xfgUmd4cwdF7qzrvLqbaTSFJz5WgBB0WungJos9Jwq3UwiPwwQy6zByDX5Y6ces3s8lyiJ3L3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0416df72-1f51-4c34-00ec-08ddfc33b848
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:02:02.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lg2jAYzc3Od6pDo+Dd/CzePKILi+z95PtevH64pyPey7XwSZmU20WZ/eOGCxlWZjZc5SETcu2uXI+Di9zBTOPOt2knR4xlNKSa4Mh/bqY3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250122
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d53d4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=SEtKQCMJAAAA:8 a=yPCof4ZbAAAA:8 a=d7l94sOMJ1zuhXB2X7AA:9
 a=kyTSok1ft720jgMXX5-3:22 cc=ntf awl=host:13622
X-Proofpoint-ORIG-GUID: -7dpaDaHahpQ62TN0lvbLE0E2D-g0jYn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX5UHMmzKX5hsl
 OD6TO1DWB0wvh7wNzKUYM0oqJMWy3n7o2mhzrNibngOy/HyI41oOtuCbhwSeyEmBASJZxaoWfHq
 me75y4LoXxuLipkjCt8ImOsXM5f1ko+S0PYs+HfgAHtql9Iz8mn76htWdP5fd56UPGy+VZg7UHQ
 6ZTZrZ67qcd1IyNA4z7jB+3yKBn10LdYLR/gpet5pZT2nUx64qGyV3hiYDktHl2qcCANiFilfQp
 X2jTTjUj7PIxDvTwrUKRyeHa7Rw8eUxgBWZXX4XpiJuDkWPellHaylWb9+8JaCcSRwFt/BsYno/
 JSq99WZ+uQCtyVR5G9RkZm3Lr7ztxoyxZwVVf6SZqTexFIs+n9rvYq5cJ9D5lgtEV4Z2sj9zkoO
 Mk9pCBeCpsOo3Rc6XeJmjLmaEtGuJQ==
X-Proofpoint-GUID: -7dpaDaHahpQ62TN0lvbLE0E2D-g0jYn

From: Trond Myklebust <trond.myklebust@hammerspace.com>

_nfs4_server_capabilities() should clear capabilities that are not
supported by the server.

Fixes: d2a00cceb93a ("NFSv4: Detect support for OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
(cherry picked from commit b3ac33436030bce37ecb3dcae581ecfaad28078c)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/nfs/nfs4proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3d854e2537bc..91b95310e107 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3906,7 +3906,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		server->caps &=
 			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
-			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS);
+			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
+			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME);
 		server->fattr_valid = NFS_ATTR_FATTR_V4;
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
-- 
2.51.0


