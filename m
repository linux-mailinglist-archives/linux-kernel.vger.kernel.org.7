Return-Path: <linux-kernel+bounces-797676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E05B4136A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A0C7A2EB9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988D2D1F5E;
	Wed,  3 Sep 2025 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSp7XEM1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gdFQL/44"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE932745C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872544; cv=fail; b=KCUzwk4dm0219/21Xl7aO5zOZsisJWtSlCazbyo8RzZnMWEfXZgFpbhLKUujFuoiMVGq1SywLS2eDTfKc5tuUeWTygm2JwmiECEne/J2ctzjBMeCrLbNOtOAPWgO+ev7Ag2RPkk5cyW2tdYsqxtuA/rC+ub67vi5R41BCfYMnVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872544; c=relaxed/simple;
	bh=H2rtx3G4nBjmDInv65Jg82MYM2/8dZz50q58ia151xc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=S6qxN+c8E/SsB/vX/ZYnMUyXObpSWQcmo0AE+UWZ17hpHU9Gq5mir8ezU4S/+zlcgA2xtrHKnE5g4QkJULaNWFZY6upkpRjm+wXdABph0WJw/oVYseh1PbrQ+6Fn4WiJr57opP4iKS0axKdV3YHiR09K5z7zrlDvKiw1xlHWsmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OSp7XEM1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gdFQL/44; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582MNL1H000567;
	Wed, 3 Sep 2025 04:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SdN1ndzotNSa0cD8K5
	VaWRYxVkjBM8zmDwKUNrNDBL8=; b=OSp7XEM1Rpx1UcvlPJ8JMb2G1XqPLQV9hb
	lS/tiPpTCp/j7oECDpsl+vYtN0e+vlymJRRcd2p/H0jLBPHRwzT7bLaqDC6PnMXx
	yUiC/5CwNbgwpG7m9BJYcJPwkNAqjMxcFvziggQrifzkNhDwNlB1q1ZpSsOIvTUA
	pVW9SlSDk5YsN3IHete1PwzZILQfmfLo9BtryKkCG941NtJFu1BG0+UOFkfJnf19
	ypv8Ljc/+C3YcNS2E69MPbs1iz9RvsIAtFnjlvJPHiFQweH520NqKPtgGoCcR7PQ
	A0B89ag6k6PSVp2yTHGP9dKKCk4S5Pn0UsB8tdd0wSFU3mj9+bCg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4muke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 04:08:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5833Sr3Y030940;
	Wed, 3 Sep 2025 04:08:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr9xh40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 04:08:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjWPz7FE/ZjqliCCyjUSaSYSIhDSXjIs57GNIabQAYU+1ez86hXcizjdpTGQJs6UWWDgqvzruECvlTGNmpiTiMCVCK3npwJn9jTvCz7g+H4n1NCmblqZm6kvPP5uLOwBl5aMdch/HO/Z31YtXTz84A2HzNJe/qOSuJ8RgDdNM7JrgOVaNATN1sNef2XPml3YXyRm/dzXuyTM9ILDgvx04Ls/T/R2GT9smoeOLr7JKbZeR8KNvJbKmqubBQM5YIZs6S5ShqLC47BXZ3m/NdpaQ1NG8ugGqg+sgdWGWg566vkFR+JABn9p7BZd+8NL233AyW6oVF6BG5vBd3U3yThVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdN1ndzotNSa0cD8K5VaWRYxVkjBM8zmDwKUNrNDBL8=;
 b=eUMjg4HKTOLjyVuD1gh+CmF8FNzWDtI83GqPFvIDpFa6Ta7S6IfBC8u4v1bfNqCvOO/OZwMqBAlf6zyo+MLX1QR3tKUN7mZ78G/LHWSQCJH2ut5HtVx+OoGvDIkbmow/PLvn0CWGE6ydM2DClO1nvnycRWDIhPYUYNbJqigROPWogZk94b/3tK9XQoBOhur67UDGs45dFXdekXhWQIHWWxKhtasMTzSCEWo+NXP/Oftgl1PZDcR2zF286c6Q3kEwXg1f0ewc6TSE2cfk3iSVPPFs9TmApFTg6jkfRx6GrUVxhgbqrVnqxImuf7DHKGM5MtvrD2zSuFFD+xqjyQkcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdN1ndzotNSa0cD8K5VaWRYxVkjBM8zmDwKUNrNDBL8=;
 b=gdFQL/443RHNzvEP9eiToFwHIKCeSI6y/1wMNuZqNZEUa+ICdB77ZaaoA6naQd+bc6qo6bAuJTiSblbBppKCl3PBd5TY7XsRGUWAGSbWTSSmptIRbHah9tS96FWTlvukwm0QQ4ABVqtSQuhBO/E1ctK2a73BTEGjT2sYhxGN2mU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 04:08:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Wed, 3 Sep 2025
 04:08:06 +0000
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
 <20250902080816.3715913-12-ankur.a.arora@oracle.com>
 <643f5482-cd34-4534-8cd8-69f32482bc27@redhat.com>
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
Subject: Re: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
In-reply-to: <643f5482-cd34-4534-8cd8-69f32482bc27@redhat.com>
Date: Tue, 02 Sep 2025 21:08:03 -0700
Message-ID: <87frd4p49o.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:303:8f::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 241ff2ec-236f-413c-4dea-08ddea9f7b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omL3Xy6auyvDzF5+easq+5rCRfC49JsMhr9ea3gLQQdXHdoOv3V0q4MrZaHK?=
 =?us-ascii?Q?ZVa+exZrf2+pIiQkR+MSAyC+DwrntiMW3p/07KMkdAvpgW54vx/Qx8grUher?=
 =?us-ascii?Q?zMY9YKqCR2r9b/G2eLgpEYAb7P5Es4Vwt4jAMnn0bAqhjfkMPl3j2ydRfcO4?=
 =?us-ascii?Q?ZuVlqa7OtuwmYVFYarItEwSaJCPydZR8aLZmhwZqmeSFLPcNVx4vEuhdtJoC?=
 =?us-ascii?Q?NX/Kt7Vlo7rCTPHK8lFfjzRv3DWUdqCZhUyVPSBNCM+nz0IxFrvLeAqCHHRd?=
 =?us-ascii?Q?cr2PBEI+c+1Tb23SvVlX+r8HvIFK1cDFNOMxwsjhrIm5cZ4NgPEnyvqoSf6y?=
 =?us-ascii?Q?S3y2K0Y5UddvjZqq5j4tZy6LLtRD3vxxgCAhgJEI3V2ql50cqQk0g5It2lT1?=
 =?us-ascii?Q?d8bvqIX97dJQi7FH/9uWEPR8TYNY0TBwo14Hdpd8D/jX1Z0/Ck4xYL1LWSMf?=
 =?us-ascii?Q?myi3i8AlVg4j9hFYZAxooilhHCLgdjq48T6ih21LHKoS6zwppGcjojBd1nBn?=
 =?us-ascii?Q?m9lDd7gsb4fvIeYhMIoB9XsLw8fn4BLJHSAKOgheebItZrDu+2+ntAkI5rqj?=
 =?us-ascii?Q?b4LYXHBBOz2zTUih1C2K0Oe5zy7/VG4sQp9Y6Jz3I5+g8jPQzSJad5fSWl8u?=
 =?us-ascii?Q?uwYgJ4ORLmWh91FIR0fM9NSH1Wa6bTApAm6BSoLO8myCimqzcr+oYiqzwwua?=
 =?us-ascii?Q?0SLFDtohRlIoxpKVmsVghYPH12Xk6kkGAMzONAw8RTpsPusUIFjfX/kb0jCr?=
 =?us-ascii?Q?+0JwOTZKQRUtez94uq35XCAZ2UGdfZLhyHGDT8w6nZBswnJEqgsMFExQtVVJ?=
 =?us-ascii?Q?DY/myCz6Gj6OpBMHs06Uf+TyAh4w8jnyn16xCuPDBwNCxcaLGJOTCxvsKg3c?=
 =?us-ascii?Q?lX4eoSK3UVVnWJv+E72THOVco2P7qySGQAkWsfVhNcplMfzH17AMUiYvUKk5?=
 =?us-ascii?Q?Yr3KTXKvBmYjWmyod0t0mnjQBPy+WUR1yGsC9w2XSc/YHjJTstcDrG4mla34?=
 =?us-ascii?Q?CkUBEIErB6K2T1bGW84UFgu1w99mu/vVpAAj6dbPzlyUz7NorefjPVoO1wcu?=
 =?us-ascii?Q?+Ji+HXsSd5Dxt3+nPuUMjSfNbhUa2rEFJBzMx00urnCGJqyAEb7jrP0MO1N3?=
 =?us-ascii?Q?5pR48PQ8z+FUYgNX3PeCWF4sF3jv5J79dav1hqzbey9BBTRTpzif9MX1qGB9?=
 =?us-ascii?Q?c7kGB2hGjFjlIcAe7TRUs3LlVzf8Hani3403nWue2XNwLQkq7bJUKyBySHoS?=
 =?us-ascii?Q?ogIVFW5ZRM/5rS0tCt5ny3KL2eAPyBLoLUEY7fd4Vvl1HeIJs7ABWVO/MHTH?=
 =?us-ascii?Q?L6zMGQ6PFMhpcUl/c6ET1ZqUzRBD6DhX+N0ZhiJlJZ20f65IgCv8g7wFIRji?=
 =?us-ascii?Q?b3SiVb3I+Y2+UaxK5ywjhGDq7+YNv67E13fG7TFPIyZgoq+8gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wG9khyR9DNNqfkV205IHesJzrj8MRNYqozH1RRWRK/EH9MqESzbJFHg5NJXa?=
 =?us-ascii?Q?aSlSLg67rVMZ2VAG9iBIlOM8JWyW2JKJeHMuXsZlt/kwBdUHBJTSPBuFlN/N?=
 =?us-ascii?Q?sGG6U2Oo9yT7jYicT+/U0E/5CsdPjrByJsCQVoE2pOzanh8GD+RLu3AP1b0n?=
 =?us-ascii?Q?Yt7NCH6vf5pohlv3WGakG2xxvzgTaSsAwUaaM+560wZFW1qI0SrYX2T6dDDi?=
 =?us-ascii?Q?stj2EMDq3mbPeYAERr9AHw0Q6QNWPCGra2XpbMzxLvX6dB29JgA6Re5MWjf6?=
 =?us-ascii?Q?buTFINEPrjS6sQjsvNxNNbmr4P7N8jcDbMcZ7QsaWKm56raZjxStFRZycWoq?=
 =?us-ascii?Q?fyRNbC+vvDMnoYcHbjhi0UXnn0gwZbsabV56pz4VuW64CLXO6VTJzL/iLRI2?=
 =?us-ascii?Q?Wa6GDWmN0ODQhJhpV7lb0Kc4kQFmOYuByNwCYqSC1hpfwmAO8oC0Mkjln/V9?=
 =?us-ascii?Q?3UhovgyvAvEsPUT+F8fE7u6b7E0MJygMHD1aLuXAVX7yxVbmr26j3Q0sc6fl?=
 =?us-ascii?Q?tnDWt/n7h4jis5kISML4DumUiJDMiT8f2qq9a6/3teIqBKLqSX09bEBqoXc2?=
 =?us-ascii?Q?FJ9bxE78e8MwQkYrHf+gRoKs5H77ywCjy7dHOTzaw5A8I358VK65kcZfgU15?=
 =?us-ascii?Q?qGuH+SogG+zN4kP7zJ00rbS1cCxwiVc2Zn+wCKGqkX/ui9zN+rjgrklm5yCV?=
 =?us-ascii?Q?WLsAOVPfgzzZx5ouFYTMgA0Jnh6ghsaz6IWNiGRiATRH4GdZlSAJYkixrQy2?=
 =?us-ascii?Q?fX/T22oFW4ootxwtEuywp1tUdxqIihVlW+KzgJ0qLyorok5+2zwjWxNEXCnH?=
 =?us-ascii?Q?O/sdTnbeBDsIGoQdiwcjYL7/6fMaYyaWKJ2KZ4go8W8gG6x9we6snUBg5IJp?=
 =?us-ascii?Q?ofEE7bbCA2RtrEnz8d1cDD/SEBBSH3Sh/13jKNeab4fEkloLw5j2jPdkHNFU?=
 =?us-ascii?Q?HMBw92eszPrDvrbFOkXE7zQz4ZpEn7m/Wx4Hgp0dOBm3trZrI9CX4rHEFGwb?=
 =?us-ascii?Q?ikEZWnV2s1d/XVelVpPIZC38B+vc5c83oYm8kSJYRsjbyijGuJHJNUHWwC1J?=
 =?us-ascii?Q?D0p2mdjX0tDrpGrcVU063uxQ634LVjhahls5kBPBQxWExBGDY/i6CogZB89P?=
 =?us-ascii?Q?MW/WL+dl3XV9dCWXE+UmC4N6rwwSjb5dCGJ8zoHEgIdIxoNNFjkeI/H7aAxV?=
 =?us-ascii?Q?hGF42vlYexH0xeBXvCxEgyvYYXOAdiUkQnHwIIJa9O+ub41NzvEbCnHvMnoO?=
 =?us-ascii?Q?0ktPuUrf/DTN7vbsXkCYdbX/RD/uqiYIXxyTwQaz6cMnrRex/Qgw2MCtiuLp?=
 =?us-ascii?Q?W3WTuwR+JsPOgEufmrLYNjR5M6a4Ytv+ofH5EdJPbcvD1clNxPM5nmZGrQUz?=
 =?us-ascii?Q?54yTVv05Cz/eWT1wx8v8LZasP+xT7s5ED9nsGRyp4TgrwO6B0avGOPP4o3rX?=
 =?us-ascii?Q?DI82UGU65adPhcaitNajdALjyXfbjdHG4JTEoJiVaEg4fWeAVuIBwN1nCEXQ?=
 =?us-ascii?Q?EoFdztSxIPSbctModu8OPjOuCzpKPznhrTr53jAnt1QKagmBVlu/xQ7ep7+R?=
 =?us-ascii?Q?duBlqi6M4iPL4Qq1HnUtcUUbhLHZcGWgIFVz7xaUumTO2Zad/xOQqMBd+v3G?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wTi9CCW3WCejRDXFrOO1LWQBOSsXmtEASdq75jhMjN/ALYpWWOX7KQPNI5OeCSSR//yKLShm2Qxf1Ms7cD0P9lK4gRGigBDG3DvXaLA8cY5pT/oraZZFt3FM6FL3LKgRPR8RzbAlSQlpg0s466jUB28lEkjZ1PTyzjrCG+il7PklfonRXHvbe+WJO69GHzyrH3/uSaDiARhf40gDWWi+BZ6EDaeVHInblfaElBM+RaCbYpG5gmDkry9jrRLBOJN2pqiVX1zHhCA2aUxxXDYbn5wQt33dYXeg5K2N2X639undaN/DdrmLGmMwJKxEiVHxClrTRIk2GURH8a3+Sa1l6gTeH/qd4wJEa8WRzz/xLbbl/Gm3FiWrjs314zghT7X7jkMhKuR5FM3BfezeORBqFJhI/n0TBu/jyDD9wdJyYf2Rga2FLxM6ZKk18dKy5wyRxqe3k+3lh2QECzCIR/TCR7bH0vmlqxNwPMZKChXsGHq0OTEFQGXegIvgyQ17tqE0SjnNww8zKxzeSaOFdNLRW5D+keuC1Yx4WSIEgUx9UTm1nJVY4wsnhVH6eodlmHzRa2KXnfGHkdSoJCHwd35PS4VflXTW2p5gR7mkOnv7DaI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241ff2ec-236f-413c-4dea-08ddea9f7b32
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 04:08:05.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pUFiuLSdvOxxnIENFbr5VcOcCHqVP9TAAXYZpp7JrKa9LAYGvQh+HfBR3MYIUfjoH3mTlYyH3jfQ3K+IJd4rVfXxFBD9GxcTHc9Ruw686o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030037
X-Proofpoint-ORIG-GUID: 8_jWFIkzP2bhjQuS_1eFUbjXo3jyXank
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX12cri6dxazoc
 m8OnZJXk+lbWK2LBIcvNDVHVq4Z3t0V/533t5efTNEoOUGgsfKjghAqAUN1+f7dNm8uhKPMjunp
 s9N0DAVYvQl5TwJYBm3T0HzR6fmqD1cPcmD6cOAUJDmLe97lG15G+7fY2K433C+tPdwgbY0ILKl
 iPxDCrlHHxYkqfgouJH0Gg1cHkPgdBBkbBljQPmihd7uO47DOWlS/nQ0rTVD++FiMMDenVGk3fH
 R0Li4lFy2gS8DZz/jPmrI8CxXpPyPAQeqcpzobJXISO5m3+FjZtTQSJJZ29FfnoWf95YeZwvUs/
 T+pgU+H93X/x1ZFBeiEWlggisEx3kxTuLKGLr2sNs7cyPGVM4LF8YbPefxSIZhNTebpuLls8VwG
 UDRpUTcGcqcBVevxxKna0ZHBcA3q2A==
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b7bf37 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=_2jW0KM6d92rkqGiJZMA:9
 cc=ntf awl=host:13602
X-Proofpoint-GUID: 8_jWFIkzP2bhjQuS_1eFUbjXo3jyXank


David Hildenbrand <david@redhat.com> writes:

> On 02.09.25 10:08, Ankur Arora wrote:
>> Define fallback versions of clear_pages(), clear_user_pages().
>> In absence of architectural primitives, these just do straight clearing
>> sequentially.
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   include/linux/mm.h | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1ae97a0b8ec7..b8c3f265b497 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3768,6 +3768,38 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>>   				unsigned int order) {}
>>   #endif	/* CONFIG_DEBUG_PAGEALLOC */
>>   +#ifndef ARCH_PAGE_CONTIG_NR
>> +#define PAGE_CONTIG_NR	1
>> +#else
>> +#define PAGE_CONTIG_NR	ARCH_PAGE_CONTIG_NR
>> +#endif
>> +
>
> These likely don't belong into this aptch :)

Yeah :).

>> +#ifndef clear_pages
>> +/*
>
> /**
>
> for proper kernel doc
>
>> + * clear_pages() - clear kernel page range.
>> + * @addr: start address of page range
>> + * @npages: number of pages
>> + *
>> + * Assumes that (@addr, +@npages) references a kernel region.
>> + * Like clear_page(), this does absolutely no exception handling.
>> + */
>> +static inline void clear_pages(void *addr, unsigned int npages)
>> +{
>> +	for (int i = 0; i < npages; i++)
>> +		clear_page(addr + i * PAGE_SIZE);
>
> If we know that we will clear at least one page (which we can document)
>
> do {
> 	clear_page(addr);
> 	addr += PAGE_SIZE;
> } while (--npages);
>
> Similarly for the case below.

Ack. Though how about the following instead? Slightly less clear but
probably better suited for caching the likely access pattern.

   addr += (npages - 1) * PAGE_SIZE;
   do {
           clear_page(addr);
           addr -= PAGE_SIZE;
   } while (--npages);

>> +}
>> +#endif
>> +
>> +#ifndef clear_user_pages
>
> Can we add kernel doc here as well?

Will do.

Thanks for the quick reviews.

--
ankur

