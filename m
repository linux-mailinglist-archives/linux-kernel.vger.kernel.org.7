Return-Path: <linux-kernel+bounces-766648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1034EB24973
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D75176531
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA02193077;
	Wed, 13 Aug 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QvSShsME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZpupQ7sO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF717D2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087673; cv=fail; b=gz6fOt7/fyXEyVl3rBH8urAeQKgH5H6YVdTm45ohVYwiy8hfADpaZcXS5wjZFVhQ4G8g6gFdOhvj6scfoq0Azc47F/KqMeEtnNw9riw9SUKBqc4uzYaWf8IZ818h7eGWi27ZA8AyhLhHTwu+M/bPi3auQF6u0EyHzqqYEIk6CbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087673; c=relaxed/simple;
	bh=Zt1ga4DvE1zBOQy0Nq8nHCBGDOKsJX6eAv7KGK8Xtm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vo33u6P53RwscK82+2DIBpnsspxJZBC8RxhmUOarnGsILN2Guo9hevOo0RtpPnWcyT96PUfUIyn7AHLdsiZxyyk/IzDQrBk93xuUavxK7hxSLMB+HyUsv2gNhPMeDYjT3I110qOn331nLmk58dLdsO6bruzqIQKHxwkZBNyEnYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QvSShsME; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZpupQ7sO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAMvwc011688;
	Wed, 13 Aug 2025 12:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=haLU4jkAUCUWAVh+Yg
	MjFPW4VLODS5m74FzP47QZRKo=; b=QvSShsMEKJsYjy388okQfAzFn3ICVeaHEu
	dyek0bARmza4LuidJXC0WRtWw3+fDFGmwN44gcSyQHEMtoih8nPRmhRP3QqAfHdk
	PHnrZfsmGT2r0OBC9QFPx4v6JmSzKAajJXfJ0DAf1c+/GBHTBBOjKnc7Ct+xAPud
	efd+3s7n9mrgrMBJ8YaHdRMTJYEBcE1CbH9CLF4g6GR4Cy78T7rp9lhppv8xHOjl
	LqxX6oxeyeyDdo15W7t4m0CMjWcT+XLLQBWzV4XcouYl/Zr/3Fp2iFcvASEypl8A
	hI+YV9k75Srqcp4JRA1UeDGgWytmu2v+QNpuPxDm/Wc63G/ZM61Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44ydft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:20:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBviCl029911;
	Wed, 13 Aug 2025 12:20:58 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbbahf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT2fU/vdi3+ePfep/IAIfv9CLljCXRw7H4lKDOr4WwKp1UOmTpzb4P0zxPh7syZGl+PkFNEFt88wgJEa4RrYfiE7upko9+blhOlzaYtVciaj21KFBsX/37g7RE4eO3wF5IcsMjs+PCseIuAC8kumcW+FhS+V1RPDA5LtTAv9shXoKk/yZkOjxXpBGuj5lRlK4rZWMF2GxPVeGPwZS1pr0jsEBdCZ7c+VgHb3QhXrirLxpeSSLtBUrbhjoiB10skUBJmi8t//D9mOzB/dYAfmf797MRaeQI6SCVl3jOCI1Pt73Lu0n0FsA3MEjpNN2XLwqu9A73Pu7O+sLVBuaNtBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haLU4jkAUCUWAVh+YgMjFPW4VLODS5m74FzP47QZRKo=;
 b=MYt8Oivf5yZ67+mB8OCz2yGSD2vmspJgDr5q0nvegJ6WWfxw4ySXc9pPchk507l+nWwxCslhg/JvOnYIS6N40GDViYiUTBMl8x3MdE7umo2Qboe73YBl/AD/OqCkzTuFD63afZTJFwF8msJMv26BemSdqgA+NbSFt76k0aP6K9ecdn+9IBWv9ooJLCZ26fAzx2wyyLHYp914pr7NbCdNXrH6msYrhcl7IC+yerR/iDqDd3CNL8uK6eOZ/KOXVKHLVHvElpCZKUNVl5DMJJDb2ykn+zV6zfn5qO4yE3vPn7V14Beon+JEWh4Mw3QN5nMhNCpBReAj06BQyKYeOc7NHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haLU4jkAUCUWAVh+YgMjFPW4VLODS5m74FzP47QZRKo=;
 b=ZpupQ7sOz7llKz8ewfBsmjAQtCfh1MX702TQ6z96zIPAMohZNo/Tr9a2tox4sFqwX3d2gSSd5gvj6Hh5WWW74akibslOcdPUru7yikjSyKOBfV3YBgOG5lWDiFj7DxWU+k/1aPft2GCJDZIDW2uk1whohmAC3+CSkSuUBOuXikI=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 12:20:55 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 12:20:55 +0000
Date: Wed, 13 Aug 2025 21:20:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: syzbot <syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, pfalcato@suse.de,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] WARNING in move_page_tables
Message-ID: <aJyDIAffgcMf6y0h@hyeyoo>
References: <664ea661-081a-4040-96c4-26307ba020ed@lucifer.local>
 <689c1db2.a70a0220.7865.0047.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689c1db2.a70a0220.7865.0047.GAE@google.com>
X-ClientProxiedBy: SE2P216CA0109.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ef9e7f-2114-414e-86d5-08ddda63d94c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYXedbkFSizRZeZ8SxGtfh0W/ROr5+SjoEXcoS9xMgWCG6OVpcDZyXRvJqCj?=
 =?us-ascii?Q?9PtdGWUFwXchTlSs9Dx2SndwAMx7S0rGcWyWx/rc03Jf/RG5LS5b9SQO4iyL?=
 =?us-ascii?Q?SIxu3SSuMTyrNOKkkOhYl0V54RWxD2avWgK7OBVI59oAwel2YUJmKOcx0hS2?=
 =?us-ascii?Q?mx1YuJ7Fip1Da4e4VgQtYlM2SxvyQSe4/UAUToePWXPCIVmg2p89kOKWhUpu?=
 =?us-ascii?Q?fTjJU2hTRge4r9u3BGBmvA/3YOYLie93N7f3oyOcRhh2IiTX+zCI4PbKi+QQ?=
 =?us-ascii?Q?F2Dn9cSZCJYSBNFoXwhig/E5empIhJQSwkum5R0iQQiArYLZNfSn46AFR9LC?=
 =?us-ascii?Q?8Vp8K8+uW0vewc8zCJeKPWbHndv9maGlZmOmZrhBhEtV++zuNZgP6un+37s5?=
 =?us-ascii?Q?OREDZ0cPIBH3ISxijHS9+BYCeNUeDuqAZnCgW5E2KV4bR2osFrzPWZhWUtJH?=
 =?us-ascii?Q?eq99N3CPlHicsnoefV2/Xmk40XmSeE1Ocn2eB7uhO/rTdKrMe6CW9781lrEE?=
 =?us-ascii?Q?+hIGY745HP8HM5CLUPEno5G+2RBCLW5OuIjccCMQUHgDW2C0w3wrqL7n1LJH?=
 =?us-ascii?Q?REd70lZjrjS+2Fx1WiTQKrTIKJB9KsC+2V/1Z9hhyrvAZiAH9rjKSOzVpA5n?=
 =?us-ascii?Q?S9dMQDAM8J6c3r7ozvvpvwfD8xsjOjiNsit4+sfIeHc4ctTG9O/8mD6/KPX6?=
 =?us-ascii?Q?wbStlUwbtFi0mWhrc7UhT0eH1tSNNR52KqruRAMQNRYtK0uM6ONFt+8Jh1Rr?=
 =?us-ascii?Q?3Mi76IGHN64XlgkAqkqF0mjLrZH7At2dopAxRb9vHC5SCU3vesJIyp7ttG55?=
 =?us-ascii?Q?5WDKCVQd8HSVEk3oNxOOiDo2qir/o+fJdwC8LNx6rCe2jLn/zTFm2LE9gRfg?=
 =?us-ascii?Q?/LihxV94OUhdKj1CRmBq3tvbKWpjXPTg5HwgXq5rHxzr5/oO+vPP/h6ByLsI?=
 =?us-ascii?Q?Yl7EL5cKINP91SU3el6x423SEU8RiBtSKSs189NtS9kov8dfb5OG5Pw4Ca/Y?=
 =?us-ascii?Q?URExh1XgwEEINjQrOVrsPwCQJBaBkXr0Y6T84LaSy1csUMdAxJmnAkTbyx/B?=
 =?us-ascii?Q?xjpyWxNKmcG+Mo6t/3x4O0xgi9rPCIkbYO4NEyjNsZeBSBjVoa60yJeYN06F?=
 =?us-ascii?Q?235rHRQsds/e/Oe9+JFyLc/bAv4nhwtfvzD6bqcrX0IXCb2niHPpDkS+WjnZ?=
 =?us-ascii?Q?DD5NhaoWpQKdX/CQpV4sR3339Y3k6/8/QJrfIlTjp3/822a5fOEYqM8Ov+Ow?=
 =?us-ascii?Q?FEKCv67erdgHhhDv8Izm4l9Zk42Rz1aaA6hFaCEjCzaTqpmWy6FeZ4s+/Pb6?=
 =?us-ascii?Q?rMXTICx+fiBOMNSexvLWhdwuMyR7mL5wWNkc710hrvGOp+ZYcREJHhCCKrhp?=
 =?us-ascii?Q?6MCJvqsF3qOpZFZyV+oaGlUAQax6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KijO0zqjx0D1RESmffzCdPANIsOv8yDK+hE7kLG+kc9aiJYtc4zW8xyUiIsO?=
 =?us-ascii?Q?jfOrFST0sc4qVjZKar9xv1yCDszcEVfAVLO4YlkRjXfXXBcSZnq2KwFV+qbi?=
 =?us-ascii?Q?wWRlpJJMWvIy/c5Cq31R6BrFhfmZvPFWYl6tog37MoEAhcDuhxmyobxDMkS2?=
 =?us-ascii?Q?55kKEj88DMVERPjeTHKQZ4Iy97zzggTJyi1y51ifxjxr7h09qk+7Js0aqDmQ?=
 =?us-ascii?Q?GPeGxe/y5VTO0FXbr902+5Jd5wg3nYye/6X2RMEMjoW3PI4nFAzLWVM7J4vq?=
 =?us-ascii?Q?kFzjmhvTyIiWf8OdvVTe1OrzW5FmeIXWSyZp95AJYdO2Q35t/4E+3Q7OVqe9?=
 =?us-ascii?Q?X7691BGEWO0pEGDPtugxEQ4h4zWX7/o38azLA0qYG8Akc3C6SmNzlOlvYgva?=
 =?us-ascii?Q?eSujrddMaceAP7dxsxuB2svE0jryE69IojTw5WI8FTc+xNLACpk46h52ITsx?=
 =?us-ascii?Q?LVbWsMxFL61VxsU1SuF7EMDfvmBQ2XHiSawepcKwXagEOLArC8jq6cxHMls0?=
 =?us-ascii?Q?qYg58lDOH/376/fKy8rOalwwIaQ2PNNJO6LxmwDO6Jw6+6rc+/gt8oQTXwrY?=
 =?us-ascii?Q?NEUJ+mLIrOyBLe23AA3tSBQUtqlLI29+g+9Io8jXCqwa2P1z1gOlu2RxByzY?=
 =?us-ascii?Q?FRS8VYCVj+VdzFcaVLuBwe4Jr0EcoUe7cj142g28gZEVKMk6xcBBShq3NDv+?=
 =?us-ascii?Q?sS2zQEETdaxcWlC5hQWltEDJE211RkPRS0JhHeGNaZz1XIdRrW3d1HPktQ0o?=
 =?us-ascii?Q?+SH5cp9ddMyuCIhk6vsevXRmInS2zjDP4jVxxzWS4Xh0K93rcO3EyfIOuQ2w?=
 =?us-ascii?Q?Qg7aZ9alzvNhjstcd0LGny8grSeP09gnT/Un5W0W0fpRBeSaHrUH1Tpn0KRI?=
 =?us-ascii?Q?M5rNmIIDOEdkp5YXvxNZmkHN/E3mS5Dh0fio+BOh23ldKZZPDbIAueqlWnX/?=
 =?us-ascii?Q?VAQGwtQKdXcJbPpCoTRmpudgBsfT+h0ii65mzWzAhrewD4GxNoKYGqRXM+0c?=
 =?us-ascii?Q?dyvNDMz+4TPuKFDOoyPNtgffAiyBg9iDIRU/D50G+g/O+YlGLZO7g308c6ps?=
 =?us-ascii?Q?YHIOtyfX4Mbtew+h3SwEK/aLt1PhgJtLDDbRJR2pCqixaAAK1stXvfPyCqS7?=
 =?us-ascii?Q?R0xSg2SN0yLBmGo5eicy+Uu5cEUIxG538gnYENk8L4sXyEqaKzLJOCaCPUmU?=
 =?us-ascii?Q?tLjtASuOP8ZVTui8IpJcqQVE3XR+YLiC2D5RRRtZcAWlx1iKr1TLxQMEqFwX?=
 =?us-ascii?Q?PsxLIcXN57MV6wNA2R4okEfa1FJv/Y/pRK5nFZoZ/WIGQtoZu2JkcRgDyVQQ?=
 =?us-ascii?Q?SE4tSdc1GFKyO0+oeJScpbYMyjP2+XOnWJsjpZv1WXYddm17/cCXksf8paeb?=
 =?us-ascii?Q?VfSDAKa0yzOv0K14QY5LgGlxxZbVNPZOfcAmEAEQkMzPS8A1a3lidPRvkysu?=
 =?us-ascii?Q?DByUnjbJZf/YVjucPbzIPNV+5vJ/lk6nscZ1dNyNfB9qF3Mp63fZvhHHdCAY?=
 =?us-ascii?Q?mS1sSP4s+2h0S7Ll710T6eKZiJWrpN4MBuYxMfZa2uVcodU3FrnsOi3RT6Fu?=
 =?us-ascii?Q?GQ5VxMKnooZrv1rxg4S5pJTKoGAQ4oyHW9UETmww?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L1OostEzJIf0dr5ZcgjbLaYUIm8nrWeYYRc5QJlp4owJ2E3a5wej/pB2fo3pAJ1pxQLwJ+yAcKBK6HbAlc0A92Cz+2xr99iSYMcNV8/cNx/kadVpHrZYvgMhH/J6b+MaOD0tOrr3B4bZ+A6GkGcdc7irVDVW41KDSLSCdRre6a5H6jOJwDaipuzTttnSyhYtl4HXLP1f+obTW0JrEmbs98ubJUOk71WI4kbh9GFBM00dKgF3ehoXVryHHSTrI+IlZ/YpA/fkss8jtn62WTRuPKX/zb7Gbnj+QSxdjPOfzvySGloNz1pnl4HAUCvNyZ2zVnIY8y0UUbsz207Gk0h3mwaSCKE5wV5VQHQTM2UPxcSQuKezg1SkgGDo08oo4vkV8eCmj+eHEOVhzXEbWgRwNSQtqG/vjuFaDqP8MZh6FUtNM40mIy4J3XAFD5I5s/pTjd+Jf9H+5KvvuKd9J+4oDju/QkxGDivnc8z51raqwRlZCCgtRt+JeuS5AVjbk8K/Spzbx5t9hIH32fYciNjTurY3KBZGpIVHKSiuYQx6A6f+DisQajH8tSMq4LWqCfZvuzQtb7VdrLtrK83gRau43+PfumgepHo+3sC8uhpsF8E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ef9e7f-2114-414e-86d5-08ddda63d94c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 12:20:55.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukeRV1MxbLyOKOw1jYfNlPDC1urttgD+Kdmequ5TMdsbyVjCd23vuu92/eY3RPbFtmlIVMlazKXB3JO5ElQQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130116
X-Proofpoint-ORIG-GUID: S4_pcGym4YK9fVVe9opLJW57mkgj62I8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDExNiBTYWx0ZWRfXxuJpWaswiu4D
 c94zCNbyTEAC3SDidOH98Qq8cujKUWgffpYDD+tLlO2kuF4SS2OrIxBAgKrlEHPQg7aNdegjmeT
 EbaTehu65Qm+UJi1hu2zxV0ilXO+y7jfFy5woOtrZ49yAOpYSv29RGdkkX2nV5hzGn1v6V3FOKK
 mKaNNt8Mz4PrFGjgNXZ+t4UqVgHp2+GKoCtm1oNrfERU4SoxDB/PYS/CW6EwblUJVxTTJ1WZw/8
 PAu8btd/zZs2RBRppFXjerfhzDJZLpSRC8X9mESkOYMIZe8e+5+WyEsBXZ6vgkHXbTQmsrNeXJf
 dkntycj4KGvERb5lh0uac7BYV4RIAQIkMuM8z0+3M9tgiV47373zJ/0Z5fBcCspf/+ZqlQthQLw
 J/XKoXAstmVwO3seAkN7KGSujLclJBwSiQkzhWuze429pb7fGgdoS/vehKXNoA/WDgRyWIw/
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689c832b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=VwQbUJbxAAAA:8 a=CWDjJPR4QouqDhruQ7AA:9 a=CjuIK1q_8ugA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-GUID: S4_pcGym4YK9fVVe9opLJW57mkgj62I8

On Tue, Aug 12, 2025 at 10:08:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
> Tested-by: syzbot+4d9a13f0797c46a29e42@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         0db9b72d mm/userfaultfd: fix kmap_local LIFO ordering ..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
> console output: https://syzkaller.appspot.com/x/log.txt?x=128fb5a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2323b2d6038203a5
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d9a13f0797c46a29e42
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

This looks spurious. I was able to reproduce it with the reproducer on
the same commit (the latest mm-hotfixes-unstable).

-- 
Cheers,
Harry / Hyeonggon

