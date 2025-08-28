Return-Path: <linux-kernel+bounces-790060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D21B39EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC0A16B338
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAB311C3E;
	Thu, 28 Aug 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rPGKcIkp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MxJdroXO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5213128C2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387642; cv=fail; b=JSe+v7QmMDOtXaa9ioLad7JN2gybD5V5Ov/NyDYy34jKerzXkqLp7Ev7W+IIhIluXsXv5IUVQ39mhmI483goZ9NfSVlzuyA/TJVjkxv6Kka4fDY/DNX2rpJeLCTCCEaHPWwazfOzQBZCbuF8H8emmwuUH0Ie3teNW4og853vpns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387642; c=relaxed/simple;
	bh=dfQjU+BsgKDwtIdoq+WleNCWnooa6VT/unfzwi/cgss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjzUC7Jmwx8HkiMOsTuHgI6vIdgFGh+bxMzsDk33VCQK1sbNDrf/+FwdrfkLsNiF5nihVMbgzmYvkL1yOd6z9LgqXLesJMPHLZQLBkefIKaSkO6WidBquucTeAaGdH0fZ0s+6dmeWfibYt8sjZKQnTtnwlYjKN+KC2QqL7K/p9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rPGKcIkp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MxJdroXO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCisn5000697;
	Thu, 28 Aug 2025 13:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JN5XEnnBrmzAmShHny
	1Y9yK35Kk6pkr2Qo57bu7JmGk=; b=rPGKcIkpEiKHJJyLMHHOH2TlLcyisUkUjD
	//SXSqk0hyB/+e3gW3VgW0umjIJYTasof/s8otSi2kK6BqV3oSOTndAchsb1vbHp
	D6hRkU/H2Bs7F5BfVhAtX+enJRQB/IA3zU1U0C6yRh4Lwq9dcg4cGcilD0z/FyzY
	jfRWvxz6w6YZxfLPh/Rd9fAM8E1uV+MiCxC2V7ucQkhrvsT3/GfLVMFkvYa8EOqu
	wdcs2vSLdg8bJzGmursiI+dF3GegG5cjdpPyJxYfpqG1r5Ej68EHnFln+Mo/E1x4
	V0G4WGxU5CERoY8uLAlZyNExsqsxUprQbLXkoKnK69OBCcRPyWwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48erkj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 13:27:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCocvF019585;
	Thu, 28 Aug 2025 13:27:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43c01em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 13:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGQ2tBzMlaOGN6SVa7C2kuvbZ6W4K3KN4UTO6s0Kfv7AL3BT8/dMYhkoAlO5/mJSXXAQmRn/PAWYYZZ9u1jAvfiAgFRElP9nuY2eSJ5PyjC2Z6iBBB3aelbevcpFAoUefjiPyHNHnBVJ7OvW0ysP3+6VQV7ddle259SABqqlD5J7uAUeQKXqC0RulPCh0EMHZGkQjsoRGSu9K17u7gxV+pZ+Lvv4xDVEuA6xiLypOgIPQw9fATrhWC6cOlAL7THWq/sZrIht4dx/age370pRJpUo2dGS3CcGjik2evlxehleUhtcLzWg5WSX6+fFs9xH9TdvcdZIDMOHUcb6uoC9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN5XEnnBrmzAmShHny1Y9yK35Kk6pkr2Qo57bu7JmGk=;
 b=BZ4ecStESaXJXgBS9BLRWyFcLPcgQVUoMXHQ0fh2aW3A4QqKi1KqdpbcG6zvyx2kJ0msWmSBqen0oobVmUt5e/f98XRWxCNsBn0LGHJtC6BChWxrqQUmgIb6xwwhyzOm0htb0aWh6ALiMZbKY8GrxdXil+2leEgsCaqZJadjB70o+42pNQD6yY19HyGOZPUakbBq5+qe+LBKp54hl1uRdR9H2MXDi1LTHC3qfOMhkJ1aY7p5pgQJoBCE2Z8tctVtEYjKn5pJ1wRTXyF7ATHulTRdYPeqthBvsak0mzSxBpMrrZ+iSIePOYV9G4wahhVSk48xrjXMypdqH0fevhBodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN5XEnnBrmzAmShHny1Y9yK35Kk6pkr2Qo57bu7JmGk=;
 b=MxJdroXOT2EOkxWlMkI9nWmKEmKljRyQnK6qhv1GAelSa22+PjdrHQH9LhPhz4Mb4QgjnMU6U071LZG5EsYMUSjjzDzSgDvqLwmFY8+iIi7y058cQn6WmdTNGWsP2BPpa1raHJ/HGqlWNUtooD/MzhT7y9I501X8WNvLPvWt80A=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 13:26:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:26:56 +0000
Date: Thu, 28 Aug 2025 14:26:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v2] pagevec.h: add `const` to pointer parameters of
 getter functions
Message-ID: <427ac400-08f1-4a47-8dc5-165090ccb84c@lucifer.local>
References: <20250828130311.772993-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828130311.772993-1-max.kellermann@ionos.com>
X-ClientProxiedBy: GV2PEPF00004596.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::441) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: c103cb29-c944-4327-4c57-08dde6368f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWGGeGRJUpweN8GSrVlYgcHOvZnoCwWEXP6+47CiUocj8SFRORefTlqKpHms?=
 =?us-ascii?Q?sG8DKUwO1wg2rOkCDHZ+FvJNnnBJ2lBgyxKYOGU6p49SSA+GdTU31AjE2nsy?=
 =?us-ascii?Q?+1gSQcgw3eDkcVwfYeyfXPgxTPK8jSJ25l81WiXHzRx173e8hhW46BeZB5p7?=
 =?us-ascii?Q?zUW9j8izWiHSdyicFX0RHjI5an0+sHrRdsIERcjKbfWq5v9W43pLTnxepqG6?=
 =?us-ascii?Q?5SeAppUIntlgifOQfYuBxVSpiMsFRztYEEip+2RHdVMPcAqlp3X1RtDqVmGd?=
 =?us-ascii?Q?kh5FQYBJf18VvsTTXea7hBwmaVkPWQTSfVlnIjp9njH2SWH0uoMjSztXjCW+?=
 =?us-ascii?Q?8CFV6zQXvXjX3NoTZSESXXVg62xp90MJyXVB2951G/FCuAnXpFAfyrTpU0Eh?=
 =?us-ascii?Q?dK53p3sd0QOfc4yG9fgfv4pg24Evb0j0cZ/0CM5/pYs/d+iOkHzTHoneWApB?=
 =?us-ascii?Q?tO/YNgWxtsy6wxmX2qzS7sr99SDQ+I+0o4QP/v5i/PGHbXgvnwqP5iTOnmSu?=
 =?us-ascii?Q?fTrm0qVXS3RbgeHmhmllurpJLU4YFPUNGQckq8JIKxNN2fghdpfpeY83b+hn?=
 =?us-ascii?Q?+5Ca2ArO+ICNQ4m8tkP5bc312I21uJsrVNqI2XotwUL7QKKPvwdd6Y/yH0Nj?=
 =?us-ascii?Q?Ra6pXYyI6/aGKImDkW8CejqVACkkVRk47e2uKZRD31QTvz6hxOft4CPImuIH?=
 =?us-ascii?Q?agxt5r7L7WRf7vBp1GanFNoVzKnE9KnCs4DTTBQbuCpPTFoKs5vmDDTyQcmi?=
 =?us-ascii?Q?Y3jgr7ZnXQespVaNnzD0n+COddmPO5rWmvFH1LWoee0SmK0KEw4PnOWjgYN5?=
 =?us-ascii?Q?dBtUiBibfUiXc843TJK/AIDxHDT/w5TY93gnaPgKAHQvfLoPQertJbBdoX94?=
 =?us-ascii?Q?x4mOUdimPqZ+HrrnhsQgk+Izu0IYztS2RdW+r/t1ibDUm8JLRwoMvYV2EaLf?=
 =?us-ascii?Q?Q0w6t3L/bn7nvApiSaD9Y0RckHyVrYWePRWvKBvefmwVV9KOp/ziQ3j0m5yV?=
 =?us-ascii?Q?wVNl86R1CBQgZ0Smxy1EVC3yg1D5DcdtdSYd+/KQ23obM6f9lV8nXqweKmpt?=
 =?us-ascii?Q?nesc/n+H0P9q9dU1WsmlgylNJnVroNCyhfMzMD4ZJQdXdVQWAEuDuxfmeUX5?=
 =?us-ascii?Q?U54fAEeca4PxQhzDJ1+efo+1m22UpbM2Bk8QXqpVMc3Gk1fJXEh36bpluQPE?=
 =?us-ascii?Q?Os3fod8bk+kib4eFDySUJEFBfq923tylxd60Ry//m3JujOf20ySZQv1zNW/4?=
 =?us-ascii?Q?dB06teO8qnN1RVdpCtvHGb8d6zTv/2SrcXUSWMz7tOACBcJepNJBFc6/TpMk?=
 =?us-ascii?Q?JvKzbLFBc1N5p8EqIdBrXYmB730Ja3ncZ0SnoiynluCZq8oOokNvSFW6Gi29?=
 =?us-ascii?Q?xMiV7LQwoxEbAib+lN0aM3brU5qZTFXeNvCLAMZk1JEqGscWWAYpwyJ7aaTW?=
 =?us-ascii?Q?pttJki9wf78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlEcg8zZQ7LQhFApNfUbqQHWdM659/N240+bg0bMP2oBuFMAPDN1sZOFcTTR?=
 =?us-ascii?Q?5+m4O1W64dzYxHI7AAwuzyJaKiankto8Haqgo367Pp99EFk2heXlXyzCJpN+?=
 =?us-ascii?Q?DSVdFGGRluWzzbTMosA8GQ5VTr4kyD+N9S1rxz7iydm4JP4ahtpgpCuTzxwH?=
 =?us-ascii?Q?JBjlcz5j8jVgmnL9KVIK+43ERtumshjwEcmQDI/nFytn7laIuo56RuhCm4Xl?=
 =?us-ascii?Q?GQk7GOmpXHbdwg4gT6Dfv5oQ8U4jG+qWE7UqQM7EO2ia/DFDOx91X3Ww9ww0?=
 =?us-ascii?Q?H95Hk7RQ29tprX8tpzbxvW02+WLJDNv9OV7l3p7+jxgjbfu2WOpjcSic9FEF?=
 =?us-ascii?Q?Yh2AUn+VTAwshva72FntgHp6ScHIycVzqIQtoCFiWL/8XSnugtAk9KbTaOM+?=
 =?us-ascii?Q?MlvJ9l4KbrFOsFcPigXWw0DpkuYCE8IAU3MEv/mwFEcnxqcWOTmY2bmcW9N0?=
 =?us-ascii?Q?YSk95Pb9a3Az0WtG4asASV3tFErmvppdz5SpCOf/f6vx4lOnQ020kJOCb3Rc?=
 =?us-ascii?Q?ch+dhCI13ifGIUVuNJGyZFII0RWmqfH6C21Y4A5vGvoXk3HZuPnyuE+ohOIJ?=
 =?us-ascii?Q?oRwy9MPyKKNBX3nNVYX5WS+Zc0t14cMM8EqbQNS15p0l1Lf5yBB1/F7gzTau?=
 =?us-ascii?Q?AkS+ZOoPUnvAZJ30dAjF5M+9pajDgDyw232NHKNj1G5tYCk/OmEPtTuArV0q?=
 =?us-ascii?Q?fqsKeV9pxEr2bvhseQOBI1VXf3E+UnZqdKcjd1gB4x3Ptyq6K7fi+gXEKc9X?=
 =?us-ascii?Q?9FofBHv19ikv3MV5XqnWX5hX97OLDnoAEV75aGW2/dc4cpLfLdHs0F/fJtGC?=
 =?us-ascii?Q?zoE0RAON+lLnPJnEzEDxEVdwZAMlThy6Mn4OFWsRCQJH/3W7E0q0ATWA8Xc2?=
 =?us-ascii?Q?rrEY6GDoRrUFXaFS5cSuzHF0mJ2UVX7G/09MbCD0PYR++4iJsknhry70mo7p?=
 =?us-ascii?Q?pbMXQ4MmpBJh4OP+UqifPBKG7VfxF7mbg9Kkx52PoekK+WJF8f862F5Rdr5T?=
 =?us-ascii?Q?K1Ig0a+Gc8SUvvUMGHIrrRCDpipMsEwEfWDasqdoOBWv7wP+HLA/AnSK8ClS?=
 =?us-ascii?Q?z3M9X5vRhCiRqB3p+AR05aw0s0ICMLRghHRZLBJ/rAA39tOfi6dBgdAYbpNO?=
 =?us-ascii?Q?/k6NafVXYgDpaCRVnzU6izGd3w/eHA6XiveO7bisICSOwzoGlhcj7XLDJita?=
 =?us-ascii?Q?sDwz9aPk9xL5LxwljdcSdsTxLqz32fjOwx0zTGIRHKCDHFZUkuv/P4CmMCD4?=
 =?us-ascii?Q?y5sZcXLtQnwzKlMo7UmSe3ASbm1BydReFLeXznc2ZfeiMelw/2zVSCtQdMed?=
 =?us-ascii?Q?4u1romMpNwtYfbCbdTOKx7aXmyfyXooBL2ISQuEhWxmVHQMIcDVTossgaSVT?=
 =?us-ascii?Q?SNaplCzZt6O2/M85wqFLl4MpOuyaVrfAxZtwjoORE2R+kK4PmaSV9MpSUOUP?=
 =?us-ascii?Q?qs1A0WNdtwh0N4VnxGJBPBH7SSjXsXDhjNe1UpTWVNgU17efOS7kqe66bYh2?=
 =?us-ascii?Q?V46oZ7qHoYSkmcKQzImZXqmmtEmWqlzCCNMv0to/smyJhai/rtE4Eev7Ms4d?=
 =?us-ascii?Q?+REWG+BUtX2xq7ndOpFZScfTiNvxfI1TAPJFhn4DaLAo0GqXFCfIpS8o9hqY?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mlptpumoZPSzdz6OJiB0u/jv3VdKgYpK5Sa867rAtXWHMzjiGQJRMtPsuDoG7a9Olu1utgxSf7zvagoClAug2W6jSdEmcSpGbdF0KforWiBC7pY/lmyOopvrmbw8W5A3OnKXZxwKVIL54ZDFUbJR8d/uLCN6C0fp58lmOsASlAxNKlRUyrnp3QdPRjLYLF9WRTxDipxoI6HXsjqCD4sO3+t49G9p57t0kVu9YnziOfsBgVvcpiDgm8kjLzV3c/Uctgod72ntBxeQEaZY8alHq7apgm4+stn1icDxdtQKPqrrEfLIC50eLuN4nW6BaHEdgQ2uOWU2NOCJLy2lwc3WWK/lnIirdL1Ydtz/3IDAWf6F59UmW9ch2M2Ghw2aybUIyVGIMBLFdn3EJPOOde6DCE1BrbgNIoidoAbd2P5iveQ80J6tJUL9oHo7QriHYgW7SPnum5m4NlAMNcbLfsd/ktkvvYNeLPxPz8t0r8AChi9F4NCNlm6dTLaUpP444bXy1d8QALnkpgBmEBwLaIstTOwn+N3J9s1rftuthYgH+DDohzrhwcio3cNxEXDHtt+xMvAv8iwv8BW/r4ydT5c8BiXBTOHOCAwIQ5DsCrEnudU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c103cb29-c944-4327-4c57-08dde6368f78
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:26:56.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU+AKMx4qGr/nrp1jbPiqCXUjFi7z0AhHjUR8Qjv5lf1V99vB9B6Bp7azEqSRxDpn0sxT4ZjnzUmvxwmSRw/a1xTcrCRcmYCPUOSOy9/bIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508280112
X-Proofpoint-GUID: cOeN41kc85ktDMbRLG1R0CexF7xa_apB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXyVMCR2/y8WHN
 QN83ojv+arLL2ZSlr2JfQixJjnwhxWye8sXPRP3rXMjd12r6reGXcxoHCtBfBnr8Sj7ZBj7hAl+
 MHOU5V+/H0bsmmWTsDds6vW9/pGSCKP5ZtV1cZ0QkLXl+jjCEnMQotzgJ4+cwY4QDxQkNfACqwp
 zIpecQB8GfLYRp1g3Rei3WsB/vKl1Ppxua7mwNbj/XlJFAVnO3a40YM9cn6rxL61Qvkd6LQzzIK
 K7p7ZeZUgl8z4+lNETxBwDTmNWGpQnDzKiBstOzFKUq76+aGboGhi8Q7gNNjNkg6cFp2zWZQGMk
 Fv/xitXyFNviK5VR87Q0BS7JI0ZIITCKbyRCYDoRsC9OrQyAYRSPpCbE6xqiavS7unO9ShuVbqz
 t5OguO2A
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68b05928 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=yPCof4ZbAAAA:8
 a=nMItFniFRrAZl-jKAOkA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-ORIG-GUID: cOeN41kc85ktDMbRLG1R0CexF7xa_apB

+cc missing people.

Again, please run scripts/get_maintainers.pl and cc the right people, thanks.

On Thu, Aug 28, 2025 at 03:03:11PM +0200, Max Kellermann wrote:
> For improved const-correctness.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

This is fine, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> v1->v2: reduced patch to just pagevec.h upon David Hildenbrand's suggestion
> ---
>  include/linux/pagevec.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
> index 5d3a0cccc6bf..63be5a451627 100644
> --- a/include/linux/pagevec.h
> +++ b/include/linux/pagevec.h
> @@ -51,12 +51,12 @@ static inline void folio_batch_reinit(struct folio_batch *fbatch)
>  	fbatch->i = 0;
>  }
>
> -static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
> +static inline unsigned int folio_batch_count(const struct folio_batch *fbatch)
>  {
>  	return fbatch->nr;
>  }
>
> -static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
> +static inline unsigned int folio_batch_space(const struct folio_batch *fbatch)
>  {
>  	return PAGEVEC_SIZE - fbatch->nr;
>  }
> --
> 2.47.2
>

