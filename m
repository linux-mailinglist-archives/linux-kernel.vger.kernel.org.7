Return-Path: <linux-kernel+bounces-751092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD5B16532
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E087F561A26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5B2DE710;
	Wed, 30 Jul 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJWrWRwF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lbsclcV7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A512E3711;
	Wed, 30 Jul 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895473; cv=fail; b=AeHSavfo2X9aW41wlE2fCtprZF69OHM1yh/4dJCD4QzzuTikJ5WFpgD3xfYbyyhJze5ASMkdbv9UD3ROADezpy6AVUfpi7R6G6iemEdT8GXgYGJErZ6U3DFNcq4y2ACLlne0w816JRcShr4WDp4GsZlQ40dnx/SYunFH8iC4N+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895473; c=relaxed/simple;
	bh=a7iSE6VZQL3ByLIziy6OjZ0tvuus8U7saavj63wFlnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D8Vd83hq2OuuV6Og/Z9LEc83TMe5wfkgYdFMiCYAG+H+hOFTeniQa19Uq/2EDiHKjYvSCTZFqWncmB13BRhA/BYvRt57uN1MPpW4EofoQ/16TF1l8RvhQji24NHoQZ4QcHExphoNnG0hmsmeYaJGgRGdEOid0XVjUH9hpOdv0vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJWrWRwF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lbsclcV7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGNk1b018015;
	Wed, 30 Jul 2025 17:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kjKYLf6ujX0LUpw7hs
	IxKV73wvf1pH+ee90soO3IDEg=; b=YJWrWRwFo08Tl/myNX4pCB75NkF7S8Rx+b
	M3d90J1y2z5bkC/xOb66jvu+2/6Wn3R6/dL+F4lmgcXUIXAHYD3KN7Uv1skzy5ar
	rdk4am5u00ZnPKhb5XTI8aG2FoGMQkssNThcfMrMXNbKhH1neGiXS4LRjbXxqpGe
	QR/xV+eOsAqsd6EHgiz+HFVMhJnp7ykckFP3Nga3Ii/p2y7edQoJGvFINzSFHrR7
	b4I/EMoRfOokEL/EDEjtCn0XZb0ine2f2eXFqqrPxkJiEaf02ijfKARBpa81FaKv
	Y71IlE8DXqjDtIYrSurP+QBs2ke/oxhQ15oqH7tkm4x4YRSx5sOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yjcdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 17:11:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGs8Wl003007;
	Wed, 30 Jul 2025 17:11:02 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbfsc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 17:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdCreHYLpbIobKBNlZ0LT76TxsLiWV/xHskMaerKXE9NX3P8kUQUfLTZttETe+TnFyp3Sx9HHSRp48bOCG7ntYcEQh4SCDcr5nwHKxYjwzZtOtkHQhs5T1FNQdPFHJaFrLE6yD1X52/V9/c093qcqKWph/bc8VwoTeu3KzmZn5Lp+WTfDRtvkpvPNfGaygvW4bKZx4QihsmOfzyj93zy66YxgxQArtQOeEKV4inevDTseoCYmmtCjJ3fQ7/F+Ubgkk9b38wPr7mkB86AZhlEdUfSrqvq/GodzUJqtGhAwN2+7jJ/p+dpgDrIyCKl941rAVscw5GP3tE/IgcoG44X1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjKYLf6ujX0LUpw7hsIxKV73wvf1pH+ee90soO3IDEg=;
 b=LaMZQtK7APqRjmnZXde8Kw1lWMiGPF9IWODXpOyolRxQRnZMO69mXPXsuPC9z0loUEm9dnfh1PjgjjZsxrRMHVv7L3GDq8X79zu57Uf1+iM/PrnL2QGQDRgzaS/CjXAryAK6Or0N4WDQQUeTjgajmn9pcF9yMMcqZXNPqQH5TNp8Wm76+BRctiZrXtjNupmfUaT1P1Tvo2zwhZyC1eH9S9pTPAZ99IhZeuAznYt6yS57e6DZrLW2n649QAUPQ4CNFGjk/HBRQqxMndIAi3cHhYUk78rjMdzEznYb5Xi4LBM/JUFw9cUnlMGoVYSwZxXGeplviFqzVCSQcAXneWFZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjKYLf6ujX0LUpw7hsIxKV73wvf1pH+ee90soO3IDEg=;
 b=lbsclcV7E40iUQPic0h0SGiQeHj9BRsETqdGiMxqRGttVxIiHTw51zFRZMH+E/viUwTDRGCa7bKdRx1e2lltJUOW3TmOFBkisMHqiBf1m28lp4W7e2lcCKViEIc8TVVq3keP4o/j1PeeDp5JMCtRh+knPqbwNV0ygbo5nyXNDFs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6475.namprd10.prod.outlook.com (2603:10b6:806:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Wed, 30 Jul
 2025 17:10:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 17:10:58 +0000
Date: Wed, 30 Jul 2025 18:10:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
        Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <46973236-a53d-4d1c-912c-1e3dc08e4160@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpLB5oMc1tSq1SP@gallifrey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpLB5oMc1tSq1SP@gallifrey>
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 1365ceec-65ca-4491-c689-08ddcf8c0d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VipQKp1XyaZTwMyY4TMDUTDYBNXOQmqM/t0ky3j571D+qIZLxX+lhKgN5YUe?=
 =?us-ascii?Q?z+wWMe59DVNHRukIG9vAxwqw3ydAv2HwqOQQVwFZXFJYLxKvvzoAdjGORnsp?=
 =?us-ascii?Q?7zn411L54ePn0RgJPuLI/AHwl++fldxFab3ISSSxUtht8SJEgWt/OfAziv1P?=
 =?us-ascii?Q?ElEljFZDjIM+mS1yh8XjGxvBZeCFLfq5/cotDj8FpfZdL6YCgH5NLC/8DZtg?=
 =?us-ascii?Q?X2HuQnD1+gj0SEW/IcVzrJY6jDndh3/YyKwxDZVYNNptwq+E+dtjpMmPQopx?=
 =?us-ascii?Q?zFlS6b76km+wZGX36l9dJV8Tz+Zl6IXqcnzzb0gqOBdm1EtUuict3diyFiuo?=
 =?us-ascii?Q?ZbWzsVzOl38e2gadH3W3OSKNjyV5pkLFx+ncW/LnZu/ZHUoLekf800m5ZZhv?=
 =?us-ascii?Q?yMSpJvhUqkwtK83I2bEIFWU8LYLblp18YJgLWbjy2J+SU64uZ90GfyTwgMJZ?=
 =?us-ascii?Q?jL/NMiA+puFLsTutN1aJCfwqDboaQ3NNRs60YH7Zboji75FSR6Z+8ENmF1Pn?=
 =?us-ascii?Q?dWBJH8T6mE0dJEC4/f51c5aEmC8LHkbX9n/xV3g8Wz9zNJqNGG3YZVuulxZ1?=
 =?us-ascii?Q?INjm3P7bYfPVmd64m1lPQsAV5TRyoKfZ4AmC4MGl9HVbJq9OEES09YseXK0F?=
 =?us-ascii?Q?SwLsOOfL+0EE/lWWu5gkp4fIwS4vEXMB3qm9Cw59Bw9yEsbR5aFZM2SYKqpz?=
 =?us-ascii?Q?IaX3VN7WbhnPeOuczUBUl01k/xmLpCsTGovT6CtmyoggOy/2wceJ1LKYW4RJ?=
 =?us-ascii?Q?qa/0kbFwXPHFQ1J4KHXpz0YLhGU93WNleQ93zPWP2jNfNf8nBaG6NN7A1Lg4?=
 =?us-ascii?Q?VSdIHUgW94ENFl/UYsy5fQXpAHPYVhKje9y8LXZK/ovM7TVefsoeVKCMIwY3?=
 =?us-ascii?Q?FPnBv5Avc6UQK6AfjMiLcALye/X6XALLeuz5U9ligK07M/rmFkR5jHJXSet7?=
 =?us-ascii?Q?gV68/V+T+G3Wq+NeJar8AAZ/+EUqh1uAt1N0DJaT3r4eHF50cSAr7J+kE15g?=
 =?us-ascii?Q?55GgT2ch/Pt2mtV96FDv5UyjIBHBSBDmM5N9rjJt4eu+fDnenhQc5/bxwKf2?=
 =?us-ascii?Q?czCe3LrTn5i2J/nrudRclrMEhA/U7cfb+GhbJH+rBLdi0OIMiQjwDRHqqJVQ?=
 =?us-ascii?Q?D9Y1mMhy7c+lBRxlHtv5caA6AqB9abTxSktKVrKzOZkSE8oWyTb/Yv+iIrbj?=
 =?us-ascii?Q?IKuG08BRwP1O42ehiVmCGjzRPiBfktNY3NleH/spCWzOyMGcVUXD5PaxAnsW?=
 =?us-ascii?Q?8okm+o5V/P4AK2w/bt2dy3BpazWea+C0tz2mWLtPxGv2IN8f2IgYz1lLqA8T?=
 =?us-ascii?Q?Or7BCCXDJ74GyhBAn22Tokzh0p86PQg2RK0P6NBNAe6UfGAVZspAzNjYJkK9?=
 =?us-ascii?Q?JhjF9xZqv8bx/d4lFX44hAT6doeKscv6RyJyfT8Z2GSj7B5kR05FbgTpiW1Z?=
 =?us-ascii?Q?sG/dh3bivu8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXXr4wlFGBxLD4SeAqtV0p6eIdZHksJBg4ikKUQB9EK3TpVemahGnf9h4Okh?=
 =?us-ascii?Q?IyYF5IMmsuE3vcHFffHs+F8NujJlZdk2lhon42siurrQ2Z1kZf3KES265w+c?=
 =?us-ascii?Q?5LvLIqwD0z4nLoEdY/1f38bnVqtOndXteQBw1g3V057DN9zQsO4cn7g+rJAh?=
 =?us-ascii?Q?wJ3EOQVx/iHOjzonDFKmM7ipw2mamVKWOK30WS0iLOoHGC/jjviBugHkAAqO?=
 =?us-ascii?Q?WT+uC4wwvtAF5pmd+iOGyWvVkHA3q/Ai48NdIlGCUj4sR1bgziTNoJYnibH3?=
 =?us-ascii?Q?S4Fc+0R8pNEwrU+iV9NftHND68wttGoaia5yDPNBJeE3AyRcsH17FOJjGlge?=
 =?us-ascii?Q?Eny764mC21oknV55G4Ps9qNwn6q6Bs/J+IodKcTd+qxlJrDI77GQPuMZ4aLk?=
 =?us-ascii?Q?y0aaeEHoead/81kfSrYeuHuiOE5YUYgbo+SKs77gRTPnbbPhtYNyfs+0ezaQ?=
 =?us-ascii?Q?ZBhcCN4o4vJ7uJMjLOSaGRW2lty5hu4cPItxG9lL3ugx0FqrYIrHM1sEPe2G?=
 =?us-ascii?Q?IhvlQ1Xl14Kevt6/Oij8yPgylZB7a5hdjhkHgBBKDubuW2nybDI7/xGPsQ/y?=
 =?us-ascii?Q?6ahNDZhVgi1+ZJ+MoExGuQLXAocDXgYh+sliPRp5Bj90U+KDMG7U+6im0T6I?=
 =?us-ascii?Q?OhPU872xA8ZQ3xbCRoH0E8f7c3qkB4kFb3MFPi56TrsAG3d2VCXoR2PsCsBo?=
 =?us-ascii?Q?vfwJa6QNupcB1h2o5opsHgqaKxJLGXE1iGF0v9160s0zUoi1PUZPlZSchm4F?=
 =?us-ascii?Q?AUGvhpjB90lFf01Ix6x1cg4WURvCGtpay2oh2tdjrI8LTwDtmUzimJmT1z8d?=
 =?us-ascii?Q?mcAhRcUEryQaLIMFhTrLYLsOZngHK5s9ReGGSn2pl+YUgA9Ob8WvAiOVU7Fx?=
 =?us-ascii?Q?IhMkOYsRApJx7M9gNZ3SOgnKe1Oz8e9B4QWHHnvJh5h1Dg3Jga0ixYoE8VPz?=
 =?us-ascii?Q?+bng69O5rBSE2cJKlVXPh9iXcsF/xSGmDywX4tYCiE0IUqsbXO3TTYZ0HuMR?=
 =?us-ascii?Q?nA6DOSRTgOk/kw7w57Eb7Tp8t0DZooVTZHzsbp97pubZ95jbDdlmE9ZjIncZ?=
 =?us-ascii?Q?ODgep0Mj2LPhnPdaIzUpfaoaAJ8hLt9dSMDBeA1haHIqamKvz5NyD4OC1+ZI?=
 =?us-ascii?Q?imuWHBuwl+/pC7N4wXoCFukosRQ+olkkdet3pThfE/4FZ6mHH0hUiiPrDc3b?=
 =?us-ascii?Q?2uwlZkNTCjMKzGQEeaPdZucB/eiBdBvO2+8k9GJuVtoTgmseLAerY/OM0Kgp?=
 =?us-ascii?Q?MRsxL/GjmRMpcXTdm4aRVPStHv5dPYpCekLgeYXz4/Gd90RkmuvfuXfj6JyU?=
 =?us-ascii?Q?9DnF0MFB0MsJeHggxoN4bXiN2kM4/FjSzT0FDO0Cm8hBpXOhYkXBUTgmpd/z?=
 =?us-ascii?Q?kQfEK1AgWVA3SJVVQOs9ime9D/OPucyTE199t6/1OF411dkPJr44kKUX0u/r?=
 =?us-ascii?Q?AkO0bI41YM1ncAW/CA5ukcjkyEs5vUr6DbsFRS/btYeLj1/ZY6EspMpJfDp6?=
 =?us-ascii?Q?ApaVcYTzsljgPwX/MpCwiLHIea7a5xieUgIG5XuiV5u4/+OScfZ3CQJtyJ4P?=
 =?us-ascii?Q?kIsGQBuqFcHx2U+PJQXfnzzHqDg5Lxs31h6pN0+KOywmZTh+lr4fbzh+b/yD?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sywv3ruUU8R+xZcS0buSsyX88nCpHUqhhWHZ4Hcbh3iZAW/0X+sSiyqAKHOBw+RnlN4mP/kbvbxo8WOnuh1RBDXN871cBESoAjyZXM67+7Cb9Fu9KXfT2D+TTr6jSiNt2EjOX41hHjJe9H/GAMYfhB1NrkPTJgNVJdXP2lHn4peFksbKLT6/TkIWO57F40jXZh8GtHVqwmkQJH1NJPobbRbHeFtM94lmujxXv0J20GYxZJd0h6NpFkHYCam2Ae9zx2pwP1Z97Goo9YWzlyGihXal0J9W7SbHIutkCxF8oo3q1bMIE29y0fOoezvPnMMmV9VC5Av3+7yfjrI0ePs4mjpUWYv8wfcUtkBtOh2LimzNBftb6ZvsvWe1dyQNVSOTp515lxE/4gJNUjpHYXKaKfzpLo2MrX5COx7n3V8OCmQDE6EFn4/YyxUAdMJIUeCr7feJyua4rjWwgO2myRZiW4aUlSW9iD9znQ3clVcio4aOEYDhYXbz/YjH/Q4t5IkqWzVdhLEDvOJR7RrkVDxRxZ6CF61X3e/GZrdjTmJ8Q8qq1jdV3IJQvi/Uq/rmmjzFGbt0gILG+hlBy0jitdvkiNelakb9nH5zGcsYbi/7W4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1365ceec-65ca-4491-c689-08ddcf8c0d3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:10:58.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQQQ1GX2TVpx3qZ2FVIdzF1p2URadN+6L0YE87CnC7JEke0xPMWlgAxppQhYNDdiAdbEVXmjlbX2a3OfKCY8Ie+1W5/MjoxKlc8P2Yt7oXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300125
X-Proofpoint-GUID: 4nG7KgtwAyiYhebbLv_LFN1t8RhMPq7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyNSBTYWx0ZWRfX/XVs4tHhLO1e
 6iVc0LG3pxl+4igJvofBeTh5Jo+WVJYDlw7imMMYb1Zq7A1PtTaVZVUl3xeW1bJGTMfRDQQrx7C
 tkWqbNcHJTxelEDgNprDKq06bpMBpSdrVt1YNEKjS6K1nf8fHMd3l6eAp/HB9ffKfsTd4HUmzMY
 Lx+rRhevukVlzLc1KniUQd7yLt7W1TCAGLmgDVLsAmou5krYgs5KkFYdrVmOP5qBSfV3Drp50ke
 hIpoLvoAfFG1e2YMlJotyYSbMyQ4Q4gLMmKwDrjcy/RA7WD8gUIiMxgMfb5CvKkgTZYPDe7wEmO
 wzFJKU65nu7s5ZR8jyVBTO6cxKOo9p0GEBs3LLSJLlLQ1TNbler8OqsTJOhWOXL6kWfC/YlyRGZ
 lP///gnWha8f2eO9RiHUl1cio4eSRMJQ3zpEKl9NCiJdFkCs2lyLyn7dy4LFrp/5aEoi0LVY
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688a5227 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=meVymXHHAAAA:8 a=yPCof4ZbAAAA:8
 a=Jg1ScXHO7bcAMM9p7dEA:9 a=CjuIK1q_8ugA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 4nG7KgtwAyiYhebbLv_LFN1t8RhMPq7p

On Wed, Jul 30, 2025 at 04:40:39PM +0000, Dr. David Alan Gilbert wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > On Wed, 30 Jul 2025 16:34:28 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > > Which looked like someone else (now Cc'd on this thread) took it public,
>
> (I didn't know of the tab discussion)
>
> > > > and I wanted to see where that ended. I didn't want to start another
> > > > discussion when there's already two in progress.
> > >
> > > OK, but having a document like this is not in my view optional - we must
> > > have a clear, stated policy and one which ideally makes plain that it's
> > > opt-in and maintainers may choose not to take these patches.
> >
> > That sounds pretty much exactly as what I was stating in our meeting. That
> > is, it is OK to submit a patch written with AI but you must disclose it. It
> > is also the right of the Maintainer to refuse to take any patch that was
> > written in AI. They may feel that they want someone who fully understands
> > what that patch does, and AI can cloud the knowledge of that patch from the
> > author.
> >
> > I guess a statement in submitting-patches.rst would suffice, or should it
> > be a separate standalone document?
>
> If it's separate I think it needs to have a link from submitting-patches.rst
> to get people to read it.

Absolutely agree.

>
> To summarise some other things that came up between the threads:
>   a) I think there should be a standard syntax for stating it is
>      AI written; I'd suggested using a new tag, but others were
>      arguing on the side of reusing existing tags, which seems OK
>      if it is done in a standard way and doesn't confuse existing tools.

Yes.

>
>   b) There's a whole spectrum of:
>       i) AI wrote the whole patch based on a vague requirement
>      ii) AI is in the editor and tab completes stuff
>     iii) AI suggests fixes/changes
>     which do you care about?

I think any AI involvment that results in _changes to the code_ should
require the tag.

>
>   c) But then once you get stuff suggesting fixes/changes people were
>     wondering if you should specify other non-AI tools as well.
>     That might help reviewers who get bombed by a million patches
>     from some conventional tool.

I think this would be useful, yes.

We'd had isues with this before. It'd be good to standardise, ideally.

>
>   d) Either way there needs to be emphasis that the 'Signed-off-by'
>     is a human declaring it's all legal and checked.

This is also a wise point with which I agree.

