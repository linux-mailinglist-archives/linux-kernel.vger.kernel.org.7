Return-Path: <linux-kernel+bounces-866120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A84CDBFEEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31C2B4ED817
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996120C023;
	Thu, 23 Oct 2025 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MkTrwy8n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AZspjQm5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967535971
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186338; cv=fail; b=f5Z3K31mmuMa24LhaHAMuXGpqct3TiNJEZhGLD2ixaNt8A3K1/7f1kkNRGeRRqg0VxnCc/GPl3093caDg3Pm+L9t/ozqYxQvLHB29FUNam8cNItp3CFsMpWr/++XfrXEpxdH3F8ubgy0rbZ5iH/PFATmz5bqNpkxcQGEzzINEgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186338; c=relaxed/simple;
	bh=fHHho84C1GusmWN24xa4v8ZGvGAvD90FEZAGm6djrTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hZasXRwFIr+gTOSukvyd+u04O1g2niJxRSo7a2j4NSBVXR6b8z/CoWxuqJJwjsO78nCJqRITQ5W9RZkREV10XboKhIQlooXRGJLFKNpPjuAbXrcU/clGuiXqYF9bRN1Y8/nnyWC6aTeMIeX/awHytybt4Y/BU8CD7wCSWtke3s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MkTrwy8n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AZspjQm5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MI0IoY010188;
	Thu, 23 Oct 2025 02:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xiUcVYdvyfonSk8A7Y
	2VZHjCUQVoB4Np2u5S/JCS8fY=; b=MkTrwy8nQ94ndB7qxKznyMoV4LigVsuMUo
	I0/p3+0IJnIMED5hn+9SNyhUWtWb76GpOc8fP2T63+PIg63bf8L/oRoUew25yIrz
	CEzsMqbL3lERPJp/bwj/6FImPS6aiL5qrEb4COKlB0ssnAb6hl2MFQmdhlJBcGOe
	gBteTSK4lyC+g+klSRrCGq5V2xQkoWzZr+PTzPZdXbF6hPCO7G1EOnkhzZbv9Xl7
	jT752lmeI2jbgZVCTuX4rQfVofhCm72ZKgN33HjgZP23UnWetvDL8eTGAcROaEdx
	QpIC3/lW65zQ1h+F4vDF+baZS2dMH+tDoaRAbRxRR2lx22LYEWMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xvd0smfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 02:25:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N1joRY035534;
	Thu, 23 Oct 2025 02:25:00 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bf0euq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 02:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6EPcTsZf9l80FrE5F5Upohtmh9LupfQ1HrUc/fZavJL075ueH/5mJ+cDjEWa9KRWUY9NKQyxb2OzRFoG0aWZ9KBhviPHMW7XRvMdH/EMutx7RvGu1j8/akmJHnQRubDNC9C8JpzVD3klVGHJ+koJ3qGDb7brBHDioaoSY3hRYL/hP8LPLbsX3V359wmj4Qz5ktW6Qh94En/fGUIRClPNOAnuIRrUPGe1m6L4CXWgbQKYaa+GfyMAkn4t2wQv9Kkrjb4s73aFvEyyFQNhrdonZVN7IHaOueO/0kczdjD/kLF/vXH43rPOtXL/VjSErCqixVyVGOtF4uRJjFiluefxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiUcVYdvyfonSk8A7Y2VZHjCUQVoB4Np2u5S/JCS8fY=;
 b=Rno0SgMEZmG7L+blqHOgHmvhZq7O8N8COhJiS6kN7lQ26RT22bSUBpTfdWCebq8/mjywUm/Bl55xgkZ1pO4Yj4cLouIPtxhB35D82vVFUf2bXMn2K4gppjdEI9eBZSKUTMag6OhcQ0/r8X+r9LNQFpuMckMknTMxLTihfVl5wUkagwF0MSScGrls23gNpPjozYx3Qm0KPL4MX7MG5gDfkevJCoxE4unuVaFx6Hxhp6RJgGnSKw5llHpJa2crEy/DrF0y93Bxaf1WrIyEQxzgHKUgOagaNbpmetrNG4ePZegrjnZBDEaL+ZARCbudYaj0Tzr4EB3zVt9Ecjz+5zmqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiUcVYdvyfonSk8A7Y2VZHjCUQVoB4Np2u5S/JCS8fY=;
 b=AZspjQm5Ihu6JqJ54dEErxeLvMpHdfLc/r/GcTsTSltfHrP1DZBO2fwVAlIri7bnIcSqRa4fR+EBe1MnqF4EAZ1S3T8O+IGDNvnZ9/wEMepC6C/r5TltMxJm5mna9kFXp/YsP2wWgyQkIsTpraYZzojcCvUBJxsDCMhnPN+t8Oo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB5733.namprd10.prod.outlook.com (2603:10b6:806:231::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 23 Oct
 2025 02:24:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 02:24:56 +0000
Date: Thu, 23 Oct 2025 11:24:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
Message-ID: <aPmR6Fz8HxYk4rTF@hyeyoo>
References: <20251023012117.890883-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023012117.890883-1-hao.ge@linux.dev>
X-ClientProxiedBy: SEWP216CA0123.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: fd21c1ba-a62f-46e2-16ee-08de11db5af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?szRNa5dPAFz7RWw/JYVUr6AxvnpvTluKH2VL0pxKDKZ1S7ai2vRw3AgS2Gf6?=
 =?us-ascii?Q?fxkAhuRdUe9LIW+H1arW7vyJRWjmXqR4SYtWGJE/rRA/Hg4PlffIxvovjOua?=
 =?us-ascii?Q?LZJiLuJfr2/g4srtSOBYEGXoVaQHod2eCD1Jg0mximDIgV+K3F05yCAhJD/Z?=
 =?us-ascii?Q?jN58bBKOq8vVZxzDk7x/RslbGh3syNavbRxFni0+FRwDkQWV6VRxfvVKXSCw?=
 =?us-ascii?Q?b6xCiIzDlKX6pzpq34N0z5xxR67d674JqyvM0YAPlJxDLcKaSdqR9PX10IkV?=
 =?us-ascii?Q?z/HPnkWwnpP4g1gVIk4BxMfQouu0eAdLzeLtbB5rznS5CN6EVzY0s3vQxU7x?=
 =?us-ascii?Q?3L2zn7gWgW45w86BHRnZ/PVT2KttcipfzGDqeuRgdFXQJbRg5Ray9BAMw8lx?=
 =?us-ascii?Q?v1AUJ1ZtGdL73z3aE4BImnj40W4S68sw2ckZYkBBnt35izl/0gXOyBRzIxCG?=
 =?us-ascii?Q?d4fAlAjxYzQKVj4t/lQszooZnouFpIcP/GoZ1uTq0MyrKaez58jW28LmMtOc?=
 =?us-ascii?Q?e7f+HVoHLgtHKvyRFiNrteFk0kIkRE2gdEr213Fb/uL0ybb6ruAEBItBltjH?=
 =?us-ascii?Q?tVw+dMVQCtHtXcPpme/4ve+28BXOinnQEWTXIgpGTV8p3+gAVtU4Pf9U8M5s?=
 =?us-ascii?Q?7HBXCzXa1cMVHpBN2hS8x08omU62lk481nHQKN8ED2lBYqG5J7bBAzmYil9y?=
 =?us-ascii?Q?95s4/aSMYfICMmXt7C6Fc2t0qp8bwtWMAmEkVm420AR9FGmFbwho/f5yLNor?=
 =?us-ascii?Q?TwRQOjbc2SH3JIACYsUGdBLEgpnvqmJ+t+I9VrkmPbrgk6+heusv0RH4TuF8?=
 =?us-ascii?Q?iEbq54YddV5Ga00DB0hLZX9iLHzJC+PALJGOA/nnoEyFPttYG6gZaM3fiEdn?=
 =?us-ascii?Q?Q8CHCS8pklAzIAK257ii/c/lbTRWYI+cszLtC3VQsoVvgFzieVMbLP+EbeP6?=
 =?us-ascii?Q?rpXU9XhxseldkOGAQ7hM4+KRNMq/Ku80LG8k3qKX2y+o84iff645mBshveB4?=
 =?us-ascii?Q?RxXa1UVHZFc6nsYl/b8l3Q2OC4cfrgeBwCTUc/leN6ppM6aL2jsgChqAm3RB?=
 =?us-ascii?Q?Hh0K6TbfxYo5rlYvUaEOJ9vxrHX/JLHVf3JoiWNuS+/QOMDzOw9xBFLqDwgG?=
 =?us-ascii?Q?fwR44iyQwIdv6JpIN4g3KziyHOZbzq1o+cCHuyrA3WEPdrvyhC/rTNbos/RA?=
 =?us-ascii?Q?Tq81+qAf6iZnobfvYydMMxNaIvyrz/v2FYQg2cPgwDLysoXN+v2KFwFvmqO1?=
 =?us-ascii?Q?/tO5uY5sV649YTQOd5SpThDBD+ekaFnoXSnSsTsmOH5/phiBW3g/a+IqGJXO?=
 =?us-ascii?Q?HfPPIG0uy+A/3ORDMatE4/Yul3nJoB81tR6txsDI8LwJqZyrKJBClBl5M0IJ?=
 =?us-ascii?Q?4Gy2QiY4W1QkkU4aojQRuxlXn87XYnmoykaLPUHHb2N8nuw5SZGjftk43J56?=
 =?us-ascii?Q?n22h8xbCqjfoNTzNspVkjncaxpxBJfCg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6zNbSULoGtcI7hGBvinGqI/8n1KZCIP2oA1KCtFxWg8Pg/0GUcJHy+yONzz?=
 =?us-ascii?Q?WcPrnOST8GzvgJOejAj9f+sLIIyOtbtZcodJ3t5OU79dw51D8qkJSatQrjFU?=
 =?us-ascii?Q?qygtJHbitAKpVbQfLnBI4sbRwOccsOIl8I4XBqeLhbJ+QqyFJpFi4GfJNCEu?=
 =?us-ascii?Q?TFmLI0+oD02NmYLil2VV9iE4eTtvhg+9Gv3zXxBHAFYMFdBXK9FMJeshxTCU?=
 =?us-ascii?Q?tMttx0D7r3+/Ru73Do5X/oP5zXemM4tBeAgnvyGVWon+W63j75kplvbkdc0q?=
 =?us-ascii?Q?R7FusL37oxth3K4VwYJ/+bC7Ksjd12zUeHV69M/4Y0pNunlC8PlkMbs/VL9C?=
 =?us-ascii?Q?XpRcHkuzoLhXlmv1GtdgONVD2qXtvNIswRBVA8SGI9gN/kClCxDY4y5wIIxG?=
 =?us-ascii?Q?bOQTmaUI6s4WOLMzCiIfAyfU2prb9//89J2OJK1wjy1CjVfjEu8GLsDid7E/?=
 =?us-ascii?Q?xIWzLl+XLQcjknKbeNeX2TdiLPXc9PqgQduS2zFxPsEiZE2v+q60aTboLi1F?=
 =?us-ascii?Q?+tJiAMszGbTQdyVMI+clJaVPzsQKPSGQ5rpCXvoPOY6BKDe2p0eMn5T/hi9N?=
 =?us-ascii?Q?iq325lYbWM4Xjs3rxo+b9iaqO6gA/dKhjg0jh0CCyW29MtQMBBQuhQh08L6a?=
 =?us-ascii?Q?CT/YuEHbO3FG13QQ2Axdkpw/krVk5n61npIX6vzqSGQUQLFsqesf5amhgLdM?=
 =?us-ascii?Q?iDyCvenYAtAjBqLKWDAODzJHUh3/P/B95NtNhM7lLgIk6DKO+M4IDyd45Eas?=
 =?us-ascii?Q?B8k9i/FQ+gwF+JN6zaEYgLvijSg6Zjezy4HxAa2BNO2V9gpUFT8QkbtrBfEo?=
 =?us-ascii?Q?2obTr3yVTelHEGx5RvVqVt6P54UFhN3hvSwgsimF2sBd5J/9jiz/RweMNyNF?=
 =?us-ascii?Q?r3TdQrhpTsaTyokfsTU2SgVYrbC6/kMidkFqY6UdOlEiSrDUQ3C4giZfIFQz?=
 =?us-ascii?Q?E42nlWBbD/186V1eq3PwmiLgewsruBPJInIbOOH54hEg2GiCOOqL3+6zJs5G?=
 =?us-ascii?Q?yDv87KEecGfXZZ0HDpaQ2omA11f60cI6g+Ki5BNMUrX5sdfXBjD7C7X0HgAO?=
 =?us-ascii?Q?8sBiyWANZ9KGVSM0GWII6D51mSpE3ExCflGqLcvrP6qtoWNCp/0xEvZT6MTy?=
 =?us-ascii?Q?Kc3rYMmejN5bezVDlPSwMtmJbzm2yp+kfJOYTbO8byGYcLR5RwEp8IE1U72I?=
 =?us-ascii?Q?/zP2Ue2oU9CB5dmnknk7mgvyacd/iwAWWNA34oHIYdZFN1sNZlSL0qpSnq4L?=
 =?us-ascii?Q?8ZHb99ecTb94zZamFQEvFSTZK5tumLNU/HJPgB32XiYTn8M55VCRrEtlLYoK?=
 =?us-ascii?Q?mYron8PNBUZpsNOGVjQh9CqXu73JEgW5YdUDT+J5zjbiktEXpiWa16bWUeZh?=
 =?us-ascii?Q?tljwnTaDBmeiukqpZtowt6VvD3qHnicbvM+d5HUt5jkEx4N3xEqo2jtGjz25?=
 =?us-ascii?Q?zN30oWL/aPMvOz9Q4X8trNJvBotAONeM+1tD0DFy2VZbgao/wGgJn6MicaGR?=
 =?us-ascii?Q?HIxf7+PNiheVsiL6KKHAQ7xmaOTdDEFQrblMYmGu4WZZElIwH/JFNW8tPAKb?=
 =?us-ascii?Q?R1vogyu9fysm7OTjcccZor5SE9burdViXQepki+m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	baAr6oerncZ0JI5s7ozpmzhlrK4R1S9NGeNOkTcc48WAkHBQJ95NG3KICS3ef+E7nHV4Z+z/hqmo4tHm8fCSC62YC0PkV6ZGtxNBXWQq6w7Bqx8S38GwpzIncJm5I4ghsw/uvspMiMcRYMmJ7sVmzdsKkEC4nO44jMQVUslb74GCmMyn0SnrDuqfELFbOdOFZWtqP30yrtWP/mjT2MspnXE5TcYogrE0JapoPToysBcsnW6dYwaQWDw5EGh41VITt9lWn87lAk/m/rhInPLQoDkMgYJoHK/5k+WG6MX/Jl7emKEKtCBRhCnbSG4+8VB4QKkS8r37PH4kUmTytLOJb40h4ubc1yi0NExRr5lg+iX3zR9s9KvXSdIfSxMPsx+gMhUKVXXymxYuh7R2KP4f4eOCJY3uC6rAhoTSzYHyLCTMeFX8NoKCrKvLvWJpU4PqC0Ckq35nEAbaaWTY2HbEgY6E+iRHv/FIuQ0hJeM6eBsqcrdX4ZxkyklnaRosb2eiuhbfc8Fma9/j4BvEA6FEoswRG9+s3IzdeFl+/KqukpXxT22TiSbzcZ00wuywRTLMkQDNCZv//B5DgFl7dlo7feQFGC2EJcH7MzYwR/VjYi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd21c1ba-a62f-46e2-16ee-08de11db5af8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:24:56.1231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egq/5NZDLZytJZwIOv2xtWAzSB4xQvZgrYzv+53CjnoZCnJQ3SbS2YHjFtGyOYIAgn9jxTBw7U+ecQPgwpJrxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230020
X-Proofpoint-ORIG-GUID: m-wVmLKMncUmAcVNTBQ0S7bQhy-3y0tH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MyBTYWx0ZWRfX3oHINjerLt/X
 A17TAGUVIzewSDGTG20flhf363l1xRr74YFyCaHt5SjOklx+XHuBCSbpe1fWBjJV1zpolxvoLjR
 tfg4HBVy5e40MrlOGMVNltYCmbp6aqPrMhStstMGcwfgHhILaiz46jypyuUqZa1TFFPEq5wuL7T
 8CnuOVWDq8+dsFI7KCWEKtmBAzWnYYF5QyEFi/lwGk6+dYqGzX8gxdFlgp10tlGSbMuYerBzM3u
 HVSmdpLL7PccQsRHsuPaLhXknRDd3DCgiLsXJrIIgArunUmvqMhNtPX1hHH0vW2d3WYsr68EZKe
 GvmDUXP2q00ujtFwLfg+QBsWJZ60M0zpQKOkaWpcDFiAarvJPz1jq7ODkKn/CxboV3f/Rp0pBg4
 bE6x2j1xxiS8V983VikAIsI2aWyvNgM5Xzy5ObhsQdR9wNHxd38=
X-Proofpoint-GUID: m-wVmLKMncUmAcVNTBQ0S7bQhy-3y0tH
X-Authority-Analysis: v=2.4 cv=D9RK6/Rj c=1 sm=1 tr=0 ts=68f991fd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h5u6Wo2c8ux-1qlBGlcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091

On Thu, Oct 23, 2025 at 09:21:17AM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> If two competing threads enter alloc_slab_obj_exts(), and the
> thread that failed to allocate the object extension vector exits
> after the one that succeeded, it will mistakenly assume slab->obj_ext
> is still empty due to its own allocation failure. This will then trigger
> warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
> the subsequent free path.
>
> Therefore, let's add an additional check when alloc_slab_obj_exts fails.
>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  mm/slub.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d4403341c9df..42276f0cc920 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	slab = virt_to_slab(p);
>  	if (!slab_obj_exts(slab) &&
>  	    alloc_slab_obj_exts(slab, s, flags, false)) {
> -		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
> -			     __func__, s->name);
> -		return NULL;
> +		/* Recheck if a racing thread has successfully allocated slab->obj_exts. */
> +		if (!slab_obj_exts(slab)) {
> +			pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
> +				     __func__, s->name);
> +			return NULL;
> +		}
>  	}

Maybe this patch is a bit paranoid... since if mark_failed_objexts_alloc()
win cmpxchg() and then someone else allocates the object extension vector,
the warning will still be printed anyway.

But anyway, I think there is a better way to do this:

diff --git a/mm/slub.c b/mm/slub.c
index dd4c85ea1038..d08d7580349d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
-static inline void mark_failed_objexts_alloc(struct slab *slab)
+static inline bool mark_failed_objexts_alloc(struct slab *slab)
 {
-	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
+	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
-static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline bool mark_failed_objexts_alloc(struct slab *slab) { return true; }
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 			struct slabobj_ext *vec, unsigned int objects) {}
 
@@ -2125,7 +2125,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	}
 	if (!vec) {
 		/* Mark vectors which failed to allocate */
-		mark_failed_objexts_alloc(slab);
+		if (!mark_failed_objexts_alloc(slab) &&
+			slab_obj_exts(slab))
+			return 0;
 
 		return -ENOMEM;
 	}

-- 
Cheers,
Harry / Hyeonggon

