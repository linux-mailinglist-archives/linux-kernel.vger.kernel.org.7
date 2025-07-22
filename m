Return-Path: <linux-kernel+bounces-741286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B77B0E26E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5180580E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752027E061;
	Tue, 22 Jul 2025 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N27xp9lk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YvzszJRh"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CA279DCA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204558; cv=fail; b=RPUQPP3u3MRBevF3o8067gN5Wg6e5R8tjYlP+fTHO4pOa9WupCjp+Z8PDwqr33Dla3Ct4rN91Pmt5Xilg9jwO9Yeu54dH4r4JtNp8anR8isg1KKWylslJ4ijq7G/WGuVCdC2tmnyuLyjxNhE6CrjkMmRXjaCjemAjLstf8BgP+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204558; c=relaxed/simple;
	bh=hTMQRTTNLCSMW4YK2soTw6cL71hIExIjLEiE3qJLCt4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S8Q5rwHK1zT5wJRJQ4a/1lhtqc2YlX9MXcphSvasCW9vGj/3ASgustW+vQwOAlr8YB4b5wOpRQ7ikDwiuatmr+fcfosQjh3W/gC2orTNbHP0XiUiuK4E4qCKcXXAzOfb2tmVik5aObNmQjkhxvk5LX99kx3UPmcs5ZRoi5enLyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N27xp9lk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YvzszJRh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFXwlT030805;
	Tue, 22 Jul 2025 17:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=W6q2zX4nLdko6ThB
	AtINoI0cyhLhHuCPC1LGLF2OquA=; b=N27xp9lk8nfIrk5tAjeHOXMLtmFQYESg
	xXydOeQwBCu1RBBw0U6g/aJtJ3uEfo9n8i/cxf+YzB/T3wgUE0eF0U0Dqg9V6lXe
	qKacM+cunaa56RwDvc4hcFyYgvSCAZHR1MbEzvgirP35vhBj4e5aFBSjjn+DoCcG
	jhvBgnfwql5wrJ54Fp+giZuDc0y4l2zCl28xg/LSI938wB/ukprDBmQZNi4IghRv
	LdV5p4gvGAcHBq2vSktS+FpE1UfcC01YMNhYYtbVYRVPgpLLk1HZLNKo1lCM04oi
	HFJDxCpZaBYtxLIkqi8bydwBrIeCgiRZR9fTJdkCkamJysM1DAzXcg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805gpnxsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:15:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHCSHT037697;
	Tue, 22 Jul 2025 17:15:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t9m4e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 17:15:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQNDSodRs7qpplRoxfxsO5x8MGOXVpLhIGODUVD1+inQuE9yxtc1Cnb8sPZThezMR3wEENWb5b86srXVx835eyOnSwl65Us1xoM+zVWJcsrvFe4ElVgktfJM8xOcg1P/Dagbsm7msfLGHluoZwotRnoX0tsE1tc24zB7cW8M+mqmdMlIKZ7kmvqNIfRGd+OpUrdPQ31Zy56rpE2Z+rMX2or2WFbxa8KD+Ql7rZUmzHq17L0U4lHWCVmkzPAWBr4FXOWeHAtw0K77YuuubuRCd1k9GpXcLrcGcbQ5PUd+rqh9uW1iVhvU+7QFgu2x64hJ/seSIwbChrNoscM5sVAudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6q2zX4nLdko6ThBAtINoI0cyhLhHuCPC1LGLF2OquA=;
 b=wXAQ9y13YygNbxQzmbnEQ0HkbmN9jNTlyvt4XhIndpoHJEk/cLN+DC8/8d9/Gg5razxJ7b+ygR94lZ2meiaQaKkLFKq74wI7ihScnNcPsGPFe0QC5Hl7uVzgQPue9qPW/kYPKDT3FxdxL7EY48wCEyHiibLqDunHsh5mLInLgx4UAxpYvq4fXY/nj+wPIVfTbHF9/nO9P5QTJaBz+5GuXlLqbYs/x4MELr433PHwZV4rtAcT3UhKFc6FME1UGOjpATB2k8fuPrtZ9HKVVloZ7nHK/yIaz/A/l5gH98QlY5oxAVME1fMVLh/5G8fUW4BmnxaSA8LCNCWPImQDk9p36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6q2zX4nLdko6ThBAtINoI0cyhLhHuCPC1LGLF2OquA=;
 b=YvzszJRhAMyaYgScxjNDjd/Tn4ohRNGgF4lZGZCkNkmwNyp802yqAs2rI7KHoG3gyt2XdkiLNHylEry2RXR+EO342JIwbveDtJfFOgkbM+KBR8qDzu9gPNLUFW4IswOy6l9IEFTfWHHe6QeNpXzjlsHm2Pt1GvNmqDeYHfJpBXI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4408.namprd10.prod.outlook.com (2603:10b6:510:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 17:15:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 17:15:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH] MAINTAINERS: add missing interval_tree.c to memory mapping section
Date: Tue, 22 Jul 2025 18:15:28 +0100
Message-ID: <20250722171528.141083-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0382.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1a23be-a2ad-4786-9934-08ddc9435f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pDgTFYFpp7NNNLRLsvQLWYjbY6mRWMELsQYD1w8fY6vDu4VguCuBGMeHI/aY?=
 =?us-ascii?Q?B+v1xA6v7Qzac1vUR1MHDv83WerrvXV3S/Eh7ddJO0B2ZoYL6N5IquDNG8c2?=
 =?us-ascii?Q?QH93VDu9hwpkKIVDlanb0vUx7cu+/bhUOke4MX3l8Wtd7RDWY53N0xR+Xfk3?=
 =?us-ascii?Q?LECCKdabpSHyo57wcPkcl7OdzOLuzAwlrZXor5tqz3miQ5YEKiYaV92RBRaa?=
 =?us-ascii?Q?VblzUUiOIoLt9OfAwLJjH49SFk3yPRXMfdUMmkjQo+mMiXnLsyCW1aDHZCPa?=
 =?us-ascii?Q?ucUq9f9TCnr2mmqX4HuBfFdFwFavdBLH7MtXZwSmOrGBU1mD+zaDNF1PQVzM?=
 =?us-ascii?Q?fPPuQgjJK2SxK6v0tu91w+rQCYbD8JZ8Fpd9S7hNwTEBqvThIpZBwjo66UM3?=
 =?us-ascii?Q?AJe00TnUDj8wnP8s82qg08NguNKSrT4rTJsLGIVoT3sbfUp2Kx1CeKWC87rp?=
 =?us-ascii?Q?lJQf3V2SsBC2lzIorWsO63wxygW+mYlnD6R/skZfAYwdsbBq+5zdjX2L3FOu?=
 =?us-ascii?Q?s19liVeGUgrE+RX94EgSweO6C0+z0V3VcomgJMvas44ua350TJ+O4LKFq1E3?=
 =?us-ascii?Q?wKxWwI7umbn4hLES5KDTfZrZE4eS4p+lOdHbtzWE3uQv+zbGV2OYkKpGx20G?=
 =?us-ascii?Q?Tu1iGrhxokv+N3cGDH57OCVyD6tjgjdZSdrolnr8dIZVOKtHgH6egcyy/8cr?=
 =?us-ascii?Q?sHNfhpSKghHTkzGdsNUVS/xVhlXpyieUJzmZohMjCWDOwk0ih6HecrR5WH92?=
 =?us-ascii?Q?enxF58k4piPY7et+5CzzjGeJzF7KoJMmhr7SipiqIBEeNi/4QnE5f4uJVqzr?=
 =?us-ascii?Q?GQv3Whhz1ITdk6sVY8Er9PDyGm3Ju/MQ0PYuvz4dh4QcywIPQexIDFhM1yru?=
 =?us-ascii?Q?kwHsjs79LSLunHdoKGrEKuU+HYqPUrOASB+Qko5ZgWk6STehGwT7dv0fXewE?=
 =?us-ascii?Q?IqAE/hG+4EvLTXXBJvH/SXH7mftGTIajOxqgA3tvD+cVPi3vbRnZvioYh3fz?=
 =?us-ascii?Q?qN9i+nf1AYZ0XGH0Is1hx3+BtZJ+ILXZATNgOpY1B9B8mRUDUm+HnSsrr+dd?=
 =?us-ascii?Q?5YtC44Kk6avi2eeX3dQ54K+rxRPL4TY/e+v+dm4sA4j5C2pDYwY0uuhd9L+l?=
 =?us-ascii?Q?0dn7RCeZf7vIfW7aazvNb3/+r65VGkED4BZPkJ5jalU/Fa/ixMISbo6vnWdP?=
 =?us-ascii?Q?t/HnKUMfvG4IsZXEfSOefdHJYPquqDK4p32Z1afWcfViNdP/zHpXAb5DLgWl?=
 =?us-ascii?Q?X8jXrVOYQ+brTkHy8nTm+FNV89s8psn04vrKNGE54j2Q2LAWiz5pby4ai3yO?=
 =?us-ascii?Q?Woxb5GZxFsMVb061QKLKbM1ARr/4DeKRWPHnXbZHP+qwQ1Bu7smGf7qE6+7W?=
 =?us-ascii?Q?yUp/saI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5rr0VgxvkpmoxoaxWU2RQ0qNF22RnnQHtjdYgqSGp94zcMMnARU7ymXjtLM?=
 =?us-ascii?Q?tTAgykGVpxiNJ2W+16sb86swAI7H5TQVCHBhnf6qN4nbqJDmq30vfTPe/nYu?=
 =?us-ascii?Q?gdmz6hWRhfms1t8OZcqT/BbVpxDwf3Nj4GbOTdPNy+dP8ZMHgIKNOLikgvqf?=
 =?us-ascii?Q?q5cZLbF4AYRhRjLwNGyXGoYgBRafuSn9jdHAY/k313KM4F9jdFQx57kCbftT?=
 =?us-ascii?Q?64uVENBlbCzY2e5izi14B3o+VGGuD1YpPzr6bXd3V+vbGtxeo3Q+fAK7btVu?=
 =?us-ascii?Q?bcguBbEvdw6OCXrpdECN+ZDZUvNCzLlkHOhEkh3RHpm8J4j4dx/mOGmHawdh?=
 =?us-ascii?Q?mrz5j4aRYAe0aJn6RrUUM7b5xLAVTx8uiVdCLG/uJPfViTp+8qX2b3YPGKDx?=
 =?us-ascii?Q?RD65FNZX42L0ZJqi9qSfb6Tw65HYDRgKXoBDFUChbY/4YB+zXDJA9GcgjxkH?=
 =?us-ascii?Q?IR+Ik1SShPqTgki/qo5uG5U5ZYtTZcRclUDXR0GwD6kGrETqDzYtMlKk7/bk?=
 =?us-ascii?Q?NNRPf3kAiZNzYVa8rd2otdTGWHdghU4eDs41DU2bhrXXt+Mpu5iyF3/Hy3Uv?=
 =?us-ascii?Q?0yU0KIXNpKlhbeE1Vz4va+am/C8fDpe/X2beuZkgsrhbfVAVk7Fqye3Qjl/o?=
 =?us-ascii?Q?zCc8ECRh/Rdc1raiCUcM29xjVPSw5x2/qg20T9JlZMeqIkMx+aPYecHoEVY6?=
 =?us-ascii?Q?7E3OUkjHPi2GHrDzDQBQjV/Dhedrzj4i5Gb9wJgQq+G2l+yCeVTt/MF7WFrw?=
 =?us-ascii?Q?cikIgZAaIZEMKNk6SLU3GyR3bYMxLjeJH9i8vUwvmScxvaqeRFf0+LYN/aWc?=
 =?us-ascii?Q?5ttQBJZCMp1hvvRWonXAanPoB6IIZX7ARsWyewy08r7TsZ2p2kz+5tHmNub+?=
 =?us-ascii?Q?wS5AVT04MrxXmQGxtCIOrv3ZDkB9bw2DpgPnAC1FlP2CvKjuQ49m0NLYpfN6?=
 =?us-ascii?Q?qb2D/+GIOlKKNT2jV3G7g6y7kd5Px6dP2Rl7vDY1qxnxOUQHlIoTrjRSMr7l?=
 =?us-ascii?Q?OibFAYHKcL+ZXe/yRo0tX4qqcX39gUpAmPis+PaAavD2X0fYyxIQr/cYK6QY?=
 =?us-ascii?Q?w5BH+QoUScJoQhxS2cAznPs+Appx3HRLOVR2swotEeVBPbhO0QW/onkAY5qZ?=
 =?us-ascii?Q?+pyuIMsKC27IClWw+XX0hwIfk0RQTBcCg8tY006ux6HGCJSEn57BjTEROTzK?=
 =?us-ascii?Q?D9NaL5S566efcWYajp5lgmmoqEGmBm1DP0aonFsF9kgy9gWjMC/ticpRV4/L?=
 =?us-ascii?Q?mYA8n4eK07ff/lQuokHz8dXaA9shgIFHxIGppXSFTLqXSaxPzQKQX4nwJHgr?=
 =?us-ascii?Q?zUCILgznhho7ggUS43HF0MoDgQfslAz1OwJlnGMmgVD4if9ihkuPa3J08H3n?=
 =?us-ascii?Q?inTLO/cvdxthQD9/DFIvImWY0to3VWskoLiJOcyxWCcckJcco44ohIQaB6p8?=
 =?us-ascii?Q?4CZwvhSG88YJznBpfWHyTmW+5m6jE/irQFrbV46Gn7rsY3ArqnbxmiZ4Oa0w?=
 =?us-ascii?Q?VvP6GpHQoEBFDMR2/j/+3I+sFY3nAgiaJJ8h7vC7p/oZaKTawOUZwfPazF9P?=
 =?us-ascii?Q?oxgq4xr2xz14fKcqC2v68iJMvzQUTq335sfibFkkbCFbmUrvGpNkhaw96qE0?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0auTgknJWPO8DmQDU+INZxUrLgEfb3dS4DGX5SROT2hczq6lBGbZ+4KJf7kLLE9xsJwArCjgrLunioYO3uGPF2QSog01olmvJPOrmeClSBqOhDZk8TAfZMCISg9Vs/Uco29xrbn/qufC6a/WAa0EzFbevb/j3XvC3vltgeTunM53BM0mNSDV5VWmk30Z99VWeJrRm8cbbi1JtK/50T18N2FSNgrOZjXdPhoiuNlRd9vF1W+wY66qnwed+RL1n0MxpJCZfYs/WnbCzXyIurc4o7Onup1GvhnclUGifja1GU1W2iPjoZDGD9Tc9ExpXjuWQarHfScD6eUtqmtngKycTXfG06aClmPqhejysg4V1SIrmYEMMkcrMmwfOYaey4L1dFqhno8AasxiTSV1d0wMWm1/ECP0yFKwHrcbyxZ4sX9RF3bhIlHCHykL2H2cguS2QCGThQxQ1b0lspZ9yWu6oDA+H4tQ3ZOPMKb9lWengncf7STjXd1CXiFgYiFsxdlUvishp9R43dU1nXhsBKE9cNa92SV20hB5IKneP1mr4DEqhsHbDndINcLU7APOOctC5xp7vndUAgMNGNMaSMEAdOvcZ6yxOResupN63mxN1hQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1a23be-a2ad-4786-9934-08ddc9435f46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 17:15:35.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGZ/GY90fgP7kKbwPk5dLnAH+lJme3aK2dFnPWJzDe4sPacBGETKNjXxovx9Lo6svNMxu/sXNxnsM0ArNbg2oBwD39M32Dz9xw//duhXdRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220145
X-Authority-Analysis: v=2.4 cv=TfGWtQQh c=1 sm=1 tr=0 ts=687fc73b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1-S1nHsFAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=cRiyZiBJoB3utDqw_wIA:9
 a=gK44uIRsrOYWoX5St5dO:22 cc=ntf awl=host:12062
X-Proofpoint-GUID: FvBR6WGYMqaCmnt4ZJ4oEk0Ikvt4RLag
X-Proofpoint-ORIG-GUID: FvBR6WGYMqaCmnt4ZJ4oEk0Ikvt4RLag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0NSBTYWx0ZWRfX5GieoDJR9Cdt
 fNHXva66VMuC2sc3NGPMd+BFEugbTSPz9YBVEZJ+wpRfWF6VafPYuSAMordB5WpDO5tFvYD1anO
 pEVz8vleE3NIQQek+ky8oxGyT85G9JOcyDp8RQUzbJjDmQpZ5rBfvraq/8eH7/Lo+RygkWAsTz/
 C+pEzQdDV5x0aV7vC+K8hYJffzH+I1Y/JVmzD0PRJblsOIpH02fon5JypKiHg4doRYMEgPxJKji
 7vmwNebvPkhwtu6ZOLa2FtsLaITiffNHv3iZ1PKyPtVG+wVOkKy12MporTL2QjHOnga+sViHmVj
 HJfgzi2xRnzuHCoW1lVuZ6MO2/OXD96F22U/H3tYjOzH9odpuMqvnv2qv2ui6rqqrkX52S1kGDg
 d9rs9xD9qGrpCPXRfXuTqqUs6PgmDGv7GkTEH0EpNNKbyYjweU3ZQDzUvC90shj4c/UXLgtj

This seems to be the best place for this file.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 837bc5cd6166..ec8db35c0d6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16008,6 +16008,7 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/trace/events/mmap.h
+F:	mm/interval_tree.c
 F:	mm/mincore.c
 F:	mm/mlock.c
 F:	mm/mmap.c
-- 
2.50.1


