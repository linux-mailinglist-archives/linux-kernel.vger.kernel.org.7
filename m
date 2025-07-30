Return-Path: <linux-kernel+bounces-751081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61960B16514
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EE47A29F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817822DECDF;
	Wed, 30 Jul 2025 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="poqTezxD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xPolFxvJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B82DC344;
	Wed, 30 Jul 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894751; cv=fail; b=de+aHjv30G9b/afo2w6+hIEYKyneXwoYoW6pEr/A2KZtlzC3I/xjn3L5702P3vGBqYvf/xjdpFc4v7aTFfUW3ftqOp3TM719Fm0P4skjSfqspCBfi5QpjF2o6YPBgcTOva/QBoidEjZD0cBhVN5P6JQlpVJS/bRLy6wUcnz9Ntw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894751; c=relaxed/simple;
	bh=PAaEKPFQGd5G644PvStIaklPOqPwOltnTj2S4RRSqgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQ3xn9kBNxtDa04xhp+RrQPW6puMaxpaAmJZx4WAjpvZiA/Vv5dxVmfnqFkz1aSjTs+0NXTGu8LT3EbEKEGwkJuHHs8I09QECHAR8QVcug2Mq8PfGhwl7UBUUh6+yeHw2NWj4oGFv8NDCAr5r0EMBMMt+s1ndbiI35u213uBcl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=poqTezxD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xPolFxvJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGN1lU012074;
	Wed, 30 Jul 2025 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PAaEKPFQGd5G644PvS
	tIaklPOqPwOltnTj2S4RRSqgY=; b=poqTezxDtTPc+mMhlTscWDZLasI2AIW1Ev
	tg2LjcELgiKaNqCWPLpez7rLS6EAaAcXK2Ucrw1MMTPlXhPcKLlwIvUMWDQD+ovr
	NHv4UPND9tuPW9Wi7ArlyYJ3X0RXlMZdDmb21vepcBTR+Z4YXCw+siAaTla7xP5O
	PcKBdnEcVJypARiXav/N1q5WTmk/FbGmgvzpj0bdj9kaiXecLWXr5SsPAsGMCEsn
	RaEdqVrbCF5eSe2x/qRfCT6psnMamBcfrHERWxIHcyj9BChukUEsn58bNl+HvQQO
	E14RDI+f0CCHCvU0qAW+Yi+oV4G3bwVK5G5p+MmJN0T6+OrkNwKg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2e2jux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 16:59:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UGoLwx020458;
	Wed, 30 Jul 2025 16:59:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfhrcje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 16:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7tHEGI84cbfxRrSX8sMoCVQqD05toN/lrKSu5EnkY4AFFrbd/HRgXiH8Bw7ccEmnG4NZwduDum7r0M2ulN7EbVmiYsjy/MCaBpFycle43t3HXRzLqBjwudysi7fsdmDPF+h4jE4Il3FhR5rca6Lt40AHYSZselK+zMDaPGnGBUkM/n8UEAxTFQjSIhSMiwskhartfqG9y254gbuawPMZx122Ajt1yzjsXAzT2dG8YU1RzSC5+ngmmrU06wKdGyosfjSYNHuGoBRvlgqXrwLdyV17tRQhoe7IZOwIiFpq/zJsj5D2JU1l1s5J2KW+z1drqrHvDlhDo/P4Sx+wlE8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAaEKPFQGd5G644PvStIaklPOqPwOltnTj2S4RRSqgY=;
 b=faaqN8Njw1ZiEwYGNib2/LtDuqs11FbYc4Nw3VfZCQOZVSWhB0MIwjlbVrGg2+dn4Uk3RJizWEsoWO4qt8N91WtsmdSPXTQh/Q6jnPC3gluna8M1ZYat0BVmDsT9AbUgsC1SUU3SHOqlwW7/mBSzLZQ3I+i//mZaS6jz0hypLQCx1cJ+H/brRgwgiZlVcFybPUTkacfwtL18kMsnStVOx9ScCiIN1SxzMWoKh0EzHXEEj3XHMCGXJWJmVjJySXa2DtSwOx895tRaU4QqfmgSlsUDTJ9V93gwnkiurNgskRyCwO2/9YhxlV082/tSm665k/8KZ7tEnQksTCOfiBE4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAaEKPFQGd5G644PvStIaklPOqPwOltnTj2S4RRSqgY=;
 b=xPolFxvJ2xe9B6ILwqpV0fadYra2GuI+n70ZqLyrU5FIGfOSF3duuUFeYa+g/8fJ/OhCOFLaqMo5XPmWhsh6xX5a2J1VQ0+g1qCTsKt77YISc9bbKPUa9ICKWV0FRBb2TFFD1kDuZhWPDYOda92SBz9l5oYFDAIQrysNCltMYNU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5050.namprd10.prod.outlook.com (2603:10b6:610:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 16:58:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:58:56 +0000
Date: Wed, 30 Jul 2025 17:58:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <e561eb48-7996-4c29-a802-fdd14154a810@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730121829.0c89228d@gandalf.local.home>
X-ClientProxiedBy: MM0P280CA0018.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 8366c01a-399c-4a98-81b0-08ddcf8a5f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EekKL3Fxcf88sVVo2Pt/WmWiyWLPn81M6CWQN+9PE12gzag7HOOvNOgMqXPi?=
 =?us-ascii?Q?HZrXxb0Qn2FD8zmfxOGcxZIUkBP1OAUXsFcSlxJVIbFcqPXgepTUqJcSlNwH?=
 =?us-ascii?Q?qDRdJovHQZoSXZTd/i6vQF3SBqTBlza3B2aJcGgKsKhbzLZP/tgeGsAWbw8n?=
 =?us-ascii?Q?ecQkmj9u3vunaCA6tW3n9PTlutNZL1cg1BEBfyROsHfsn4x0uUMk4fGyHYYA?=
 =?us-ascii?Q?qnJgElcJ+hYp5YS0G/C7tP6J8WpvdXyZVrbY5NK5q8fkUT48rBGlTklMu+fd?=
 =?us-ascii?Q?sDNpZ43QBVgo0Wwih+stvGkEuMKHOTM/HgoHYCgTwrUlWKFBH63bBiMOBWri?=
 =?us-ascii?Q?h0A7k4yzrExZ/JiZGZCCKZ/PmpgrD2PXNa+7ubT29Pgok9ooIhb5RRyubuT6?=
 =?us-ascii?Q?2tM7MjnQKurhwrtoHtpYjrqK6fsYa/OGpI8h7vNAKrSQQlyblhpG68UQLZRP?=
 =?us-ascii?Q?l80Txiba+Qm0kVjX+sqwZhXJvMurxiTJeAWRuraWs+1KrOC3Gc54dAp4Vh2g?=
 =?us-ascii?Q?LoR2bLQoQ/Umdw0I6qOJrTo5iL/fMtuHodPBhJsS4ptYKKvlDmiZi9n3w4h9?=
 =?us-ascii?Q?Xo/gulHuZ4G9ReNReF3hTsiWtY1AcYN2rfOWl4j+3Q2YFIMk1ePlX3TQYtaI?=
 =?us-ascii?Q?35cNV8uvhyFDvEAX4QfkjieazBgC1n2i3PCUlAnb6MyP38FSMC5iOISZclVb?=
 =?us-ascii?Q?QLuq7k/VxTCYvDoJ/upfgER8p5vCc0Y2N54yYyxUAIUtrh/ShtVwFOkNlglN?=
 =?us-ascii?Q?NX9roybSIkCBjL6d2Qg3koKBTNUbNPtGYaYIjz+WWNxxKKfe8pyLISHQKnwC?=
 =?us-ascii?Q?nVLuAJAaMUNV40dI0hdsi8IeORf8OXY1ITFzGfl0ngPVnrNASOqUCkPvMmQ9?=
 =?us-ascii?Q?KtHU4G0ubwwEFpslekNCCOojCwk9aVqcdkazpAItHuFo2J/Z3mhYvWuyFvgo?=
 =?us-ascii?Q?spPcigzEc5t+rcje/ynP2k6o8wpgZbWcPa6msqo6Dd2ksCXYIZ/qnIlZl7uI?=
 =?us-ascii?Q?/uFGzwxq+gG7UAfzm0yAUkifJyEGCiVKWcJb6FEEdr+1TktIdejzjkV4JD0X?=
 =?us-ascii?Q?9kC5MVLa9Ic1inYbn6M5S4HUFAlEGA93y1X+UKtgnIuezzZrHZYL1Vu1fETr?=
 =?us-ascii?Q?ehlrk6zs4oZHP4+mWqbepk/erBWOQMVad0deqw06jzJ4kF+gjFQ1xHJFWtAP?=
 =?us-ascii?Q?DVNUDdI4TL3uupyzZqg9Zb2FJ53CEjc1QCjnmqrb0Y2/EusSp5SAM1Mw26WD?=
 =?us-ascii?Q?MmxuqnnrYlt2nBtjWM5LVbBx5WMu9o6RQKgRuUrD8fPHYQAFZNb4Fmjr+swv?=
 =?us-ascii?Q?wKJ4UI4im+djxcjRjVSJQQQEp7A4uLBIKYCXjZseMoUGQ86KuUElUyIr6crE?=
 =?us-ascii?Q?rO14vKqv2e5/xmXYxuh2fkFcSUwP0Ne8cNMKnHkzTVCRH4cXdiDheMY3l2vF?=
 =?us-ascii?Q?HtqXqU0Laas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvabV5Sh02bUbjNj0ZCtHmWI1CES80MihSCRr9IV+MmqfYV9BAtB5l0oPMWj?=
 =?us-ascii?Q?WFcJUV0EwtDrMshxkwSYdRuCHmi9kbdLG7pULFRxt7jOaK3kCbNY4LU53s92?=
 =?us-ascii?Q?82umVmEJ8zywBa2/jHQYLUpcGL4KWWM1HVvCDLQ3YMicVtunaY4LzWYEb3sn?=
 =?us-ascii?Q?EolOmn+ghNlphaRVtEC3Is776iE48lq+2cd+QOwuJz/DyUgaj5lrtgcgEgvl?=
 =?us-ascii?Q?Eu/eLrNjWJi+OQZAh4K4NV7YNF0G9/FyBxawieALGCCCjDoUUKo7zx87b7P7?=
 =?us-ascii?Q?O3jHizAgCWwYgdVZC6pxNJ5cFT4U7l0b7HZP2QXZejvgprs0mAb1OX/mDNH6?=
 =?us-ascii?Q?lluRJm+Z3FYXAYPM6sbSfJsS/8Rj+oDzkfu71PPlZKe5iYO271xiO+/rx3La?=
 =?us-ascii?Q?5WZRkE773Oq//Y7BFo8UYL2gAqVvEbF8aoTF6CWh2ZH8kAhVDtuIxkkrdGLw?=
 =?us-ascii?Q?UxNer6b25XdEdnlixgimY9mAzyOaHivhkPtq+NoyfGn8K+uAVsysFz7robpH?=
 =?us-ascii?Q?r5mIj8u64LTVTX3ku+Q4FEFnp9QHxiYpy2dFovnS0Kh8W2TC1he+uUWlJnNg?=
 =?us-ascii?Q?TcrzdPVJMUNJoZLm7pnlz56AnMjHVxHTO/4DjmZ4RnDgS/JFGL24Z7qwOAY5?=
 =?us-ascii?Q?pTLMecHlUPRTsk+YJLNosL8KJd+v7us6OI5aXOcHi4D72za/0ur2ACQhszsx?=
 =?us-ascii?Q?CYdGJ5dEnEmJeAQHYRLuqjGEMTZtT8kDLRGqNEhC4Kq6KZeqkPHAazo3c7v1?=
 =?us-ascii?Q?dQYA4NQw7cth1yeznUJU/LCPEvF6FBy6fG/77JMjw5FTh8srCaxNPi2Bz/0H?=
 =?us-ascii?Q?VQVnw7LMyVDzjMmoV1YSlrzUs01kM8iKO5ZGMOgI9q48sEPFv+20tA+rZx3E?=
 =?us-ascii?Q?KFwTkRAzbr2K+woXysem4fAs3MLIrwUkwhb698sQQszzVY4h8+PfhVvdbM4b?=
 =?us-ascii?Q?6BcIWsRr5LLlV2UOqAGtnVER/yoJzhCNVfS8p0OqcG2wM4JubmxyTyk75EAL?=
 =?us-ascii?Q?PX3M0Vu3sfJoqSZwglpzGz2CBEMPp1wWbm1w2veZjqI0p1M+rW+35OXlC3FA?=
 =?us-ascii?Q?epjaOnMCUmERDsw5oBynAmsL5urUD9c/ijbD+RpmhOFsDcmoC7kvH1U7k3Ds?=
 =?us-ascii?Q?cWIhtqGXtDuQsMaPmRUdTpp6t32Tmv316s+CAec6XPtxe2pdoTpDiyuOBGLr?=
 =?us-ascii?Q?g09bX76kWkE1BPdQ76IeeRzzNgf85rJLEmrsFqfIAl/0WnXNs6zstnGZu0gt?=
 =?us-ascii?Q?OP2onMgLQin+hNyBjE45kqKMJMoqYMq/wWvqY9Dnhdk6an92Q+GXk5jOmjPm?=
 =?us-ascii?Q?PGF39q3tWkTvluaDPgfG6jQ91pvIp/zKhVOUcakzrJbHXQY8uuct0AYHazg6?=
 =?us-ascii?Q?cRB0091YOAf0juOCZ5pH44PyOUUksSbmUxXue9qwzd/i9UXWhphYSI/PZjHV?=
 =?us-ascii?Q?zjDNR/9+jWlBrhKdV4eRJfzA4nehfHC2FpemDWWgEIp1It54Rwy6R4ihQhlv?=
 =?us-ascii?Q?VWAjCYI6UauoFytOmuPLjOJcSRGEsuETJKJyuEdx6vMIzizIvDzpClchOlhb?=
 =?us-ascii?Q?OoCxN47mFLmF2WuLaRGsd+cqdZdFC0izK9888ambLw+4g+DREgcmAiZ1aq0F?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WjDMoDh6awohyUYxvjorFvjPEzg0mKJSgFEtwMhJ2+X9Yeigy9fwD7G/wXTnHn/iu3lcLrcNA+t6CwGJCDVKswKrc8/BtEBl4hD2LUNhPvj/zgaJqBXlXOHrp69au0FxrgpmBuIRE/zg7IgNy+0P7MSp9LYVUIetJevNJCgWOOwtX+rHHO4fDf65ItVlM9ILpWcJeP3auF+sq8xMZt2dg0BPAA2eWtFOHmrowzQem7Qd5JMHqgYvJwbcT5ZTWGurYE31QrqymDOdaxTQUNmBlMoMBgfBjqnlxfXxSwuEIcpMC5B+gNc1g3lAjHXx8tRcmHXKmwRJbssuMPieev3CTHrNtGahTkxLxBCbOi3/82O/nsyAVJpqr/Uqadf8ckhabFmvwN5AgQOXW2jQ7UEkfYyHmDN2sV3adbZHny7hG4MI55EESOhuCLkaN/5MJONY1ZZuQrF2PvcHuF7nMss32PbdTsxS8SpPKQ0ykhbaOv5Hh8H38P7NB5XWnZM/jTn/Ujd0kxsRbT0grOVwUZphJnB/Mirf3dXH0aYIkhSwQGI311TWfWVXfe6+C2jApfAXfavMDnzJH7PQEXrUuzo7GfudI6CRzdY6l9finfg10K0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8366c01a-399c-4a98-81b0-08ddcf8a5f17
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:58:56.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vo1tMdM6PjgCo1FkDZhDd71p2V3GOgTNYMlEj/qG4kPosU3dIt1Jd/+Swcp6R6EwpUapQrQ+gEdr2aMsN5WWSzA1LqwD30yH449ZpUUM+94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5050
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300124
X-Proofpoint-GUID: pcs_271ipCkNEcbLOySgSwkTMKfvVoTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEyNCBTYWx0ZWRfX7i2t+bN0UeYM
 UzIbOVZHd/dLx/HNBfyVdVJnrE2IwNvZl5Yoi27WDWBQf3FuaHEeDcCmoeIpxLvRgJLIxShbP9t
 Q2RkR5pH8Kv1muXWoI9WBxiJor/NHhZfOSUh0uAIZBTgCz7yhTwE+sEXoA7rp3bsWf/8dbttTFz
 3JlPufrw/ckHKA5JgWY5T3fCH9zF0Qq4bYjDPvEqxGF/PMmNG6tLe9EsOmDL209Dy+MDzVDCsGH
 uGT6ObKnxIbvpIh7la2O7AX9zuTfwIXZhDEs/GMRADGAm9/h3LB1Hqhn95ocxl3fmhfjftRGClQ
 VkuN+SzeED0skb3+pom/R7Z9as/VhRAQiy+Z3JpwigCttHrjvj5KwqSW7XiWEwueKXXx6oYg1Ft
 Fn8h7DyfNQqYnbz2p9xMn9D2PcRyDlScFlrA5k1QtnV2z2AzOjResfqaOZtGE7IxsR60i6vz
X-Proofpoint-ORIG-GUID: pcs_271ipCkNEcbLOySgSwkTMKfvVoTz
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=688a4f54 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Tw2lT9YD3ylMRrtC1YwA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12071

On Wed, Jul 30, 2025 at 12:18:29PM -0400, Steven Rostedt wrote:
> On Wed, 30 Jul 2025 16:34:28 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > Which looked like someone else (now Cc'd on this thread) took it public,
> > > and I wanted to see where that ended. I didn't want to start another
> > > discussion when there's already two in progress.
> >
> > OK, but having a document like this is not in my view optional - we must
> > have a clear, stated policy and one which ideally makes plain that it's
> > opt-in and maintainers may choose not to take these patches.
>
> That sounds pretty much exactly as what I was stating in our meeting. That
> is, it is OK to submit a patch written with AI but you must disclose it. It
> is also the right of the Maintainer to refuse to take any patch that was
> written in AI. They may feel that they want someone who fully understands
> what that patch does, and AI can cloud the knowledge of that patch from the
> author.

*Ahem*

You cropped:

I'm not at all a fan of having a small entry hidden away in the submitting
patches doc, this is a really major issue that needs special consideration
and whose scope may change over time, so a dedicated document seems more
appropriate.

>
> I guess a statement in submitting-patches.rst would suffice, or should it
> be a separate standalone document?

I think the bit you cropped answers my view on your question :)

