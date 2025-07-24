Return-Path: <linux-kernel+bounces-744118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF442B1082F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB8F1CE71D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BBF26B747;
	Thu, 24 Jul 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOWzxsHW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NgtBo5EG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0C26A0B3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354406; cv=fail; b=bC5hA5hj5GAAQMeuduSAzpU2DYtj9Q7UUA+QMFj0+HaJRB36g4YsG7eIFe2zJEfC5nTwOFsEb97bh3XP0aWeO8KN0W6pTl/WH2VcYSbeh6PKtnnfOXM7FiIhRG9WiqSb+x7pg1uayHE2mfYOBQqEwMJdYJ53de3mqNptdyuJOSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354406; c=relaxed/simple;
	bh=QoUf+bv/+/8ojon2dkLCy8zKU9OkUyCEC7mQJRNZ2KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f13UWyuWG6wnhecUXHinwMh9j0ObV17isAGycqfIQoHqyR7xTA324Gnsn8wv8iebYw0IC5b1vVrEeYYAFh+YU9GfmqLqs4tPb5CKvh9TC/v1+W3OZeGm0SccR2LLY6wl+LEW9R6v/oN51QS1CAJ09tccXIZQSC1ma41hH/RAgtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GOWzxsHW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NgtBo5EG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6ttSH014653;
	Thu, 24 Jul 2025 10:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QoUf+bv/+/8ojon2dk
	LCy8zKU9OkUyCEC7mQJRNZ2KY=; b=GOWzxsHWsehS3XmoSPGBBbdMJdq0aXmrtH
	510z+v0j+e+wKBSAApjCqWdWGWk4Du5Pv4mtymHS0UwASa+2vaCxc3obbLfaKaQW
	Wu0D3yJmk0LyysDyDx73FeZYVoWKpAj57Aoz22WEG5S1BjOjHhRk5gihq9zpS6qC
	YzzWcSNnDnpqubNwBy5PcxTgn8WVefNWF/XrhxLbBJtCnpAIgyqLU8ISbtXsaasH
	KaFu5UaVGAjP3vxelNBIu0resjwVpVzqxuF3+eGAZkUldh3um92E8hUay/GoroKI
	gOkHizjbrC3VFJxrNkHkrAv2DNnMzPtESz6SBUBI3WtTuLs4dK/Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9sbec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:53:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9XY4D038427;
	Thu, 24 Jul 2025 10:53:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbr9gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 10:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZpD89d5Q4+YwpQ6serHgSNn5z4LkP+z7HvhzVQZRXvtUC0hmgr1OUB4geaY/A432TfEczFZ3XMdbYVBfmoiUkYYMIrh3u57hSkR6AOsMqOO7XnUFzeLdMcxZDbxeNHFtTDwqtEhmAjoLJLdtTdUWUXgXkM28Z+9CswtBHpW9KTunB+/Xji9/xvCzJ1X4CrdIDMDz/dIBSgC7Jvro06o2gZsUFjurQysxifFueDAw55aRgq/gENr1Wl+wGD8HPh4NZLR+IW+zsLXQY5Kxw7Rl6/terCbYSwma5nShyeCSdbV7sMSBsAXF5YpnJMm9uJ/pxpsDvOWGXpzDO+jpTRrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoUf+bv/+/8ojon2dkLCy8zKU9OkUyCEC7mQJRNZ2KY=;
 b=m+uCXmjTCNyxmul1zrg8OwMo3S00S2wPrOI1wXXvnoKsvfWXjtPkqe/DKBaVdd5BOBckGu3lcuxknt/Zp3kpWdI+R3mm69kEHu1R4nyL4iQUqo7rdrQBhfPafdajsMTwTPkjpR4quwOXP0YyJRz5oYB5EIqz3SX/Ug9wUtvyq4qLhCmpouViYeX5pfbfrcY/sWRYqQ9wtOpT685FHBrp8/xRKZopi26XfOdvoml0TcCdxF66a4RWUeRM7LwCMA2h05N9ZoSXt3AyCrDvyN7epdtXYSimsp4Bn7D8cgHunz6e6ocDs9DH8G5YuMZHAJMiRL/O95iYUBClz3ecK1mRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoUf+bv/+/8ojon2dkLCy8zKU9OkUyCEC7mQJRNZ2KY=;
 b=NgtBo5EGHwly8guYMDvB2jkcM677tWkJF9rY+2ZdZ0SRo9DnPxVz90ssp/lnEPPW/eIaEqen4sVADP04WzUlZ9iHoGwMk/4+x3OacdafgzmP6p6zQfSgDSpPZdg8tm8JZplXKuNQPGfmWC+aWpCfvRJYDsWatCueYPrRNRhN3sA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.29; Thu, 24 Jul 2025 10:53:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 10:53:08 +0000
Date: Thu, 24 Jul 2025 11:53:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pfalcato@suse.de>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hard-to-hit mm_struct UAF due to insufficiently careful
 vma_refcount_put() wrt SLAB_TYPESAFE_BY_RCU
Message-ID: <dbc20783-0ff5-4902-bd73-e9282bfd87ba@lucifer.local>
References: <CAG48ez0-deFbVH=E3jbkWx=X3uVbd8nWeo6kbJPQ0KoUD+m2tA@mail.gmail.com>
 <16c97e30-19c9-41e8-b73b-c0b3c8eceff3@suse.cz>
 <CAG48ez1qhjQNHC+3572udqVWHTANFpQ0ngxn_4ZDC9F8NCXsFA@mail.gmail.com>
 <c53b22c3-9f7f-4793-9d10-f4df861a3e32@suse.cz>
 <CAG48ez2cGX3e5bqgcw0OEnho29+YhwG2eOrHRgNwGAA_Nb65nw@mail.gmail.com>
 <CAJuCfpEcjH+W83At8WSkgzO=JvZmapg6dPaXmuSRS4ufhSha4w@mail.gmail.com>
 <CAJuCfpHk_k5eVhAZTK=jJvES9311Hyo_YXxY-S56EAYSBuRVRQ@mail.gmail.com>
 <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702ab3bb-db4c-49cb-bb77-4e864cae610e@suse.cz>
X-ClientProxiedBy: LO4P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d72c716-aa6b-4812-4c40-08ddcaa04680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L33O/D7oC52TB7WCi0uyWf4nmRuyGFUvv/ytfPB+cpHgKLRPXBmv41SMxVpA?=
 =?us-ascii?Q?4ram5LoOiyrD6n3cYb6l1ntg08LBPauhYoy1Xg9MxggZa9vuZ27VJ8c1dkKg?=
 =?us-ascii?Q?aGYvYzIeNeC8e6TXnGbf0SL8pyb/e1fQNgLPIYFWPlEfpgLHFFr/kOHivJL+?=
 =?us-ascii?Q?tk7tRcUGE8zjAGcIuH7VsJqpBzYDTcE6h2H97bBe4znNyNHzRMl63H6TAeMa?=
 =?us-ascii?Q?/kfHSJK0Rww7sZIaVikxLWBk/Jf8yk7ng7mCj0V8upabsvL26M7yBJ7MRzBS?=
 =?us-ascii?Q?42jETjWzCb4/P40nxv88t4rXcz13eqMi0g1SfcxU6OlGl/miK3gbYRPwaOrh?=
 =?us-ascii?Q?2rA3hin2WdjFtrJ26vuTK3vg6AirPBmjxnJRkkQz19JT6Su6WxqblluUyIwy?=
 =?us-ascii?Q?Fe0tIw5z5/p47+FY3Vxyivd/q9Rxwd9DunBchxjVSAhrp/0rIfiYmthvgW9M?=
 =?us-ascii?Q?BFFLWomETWSN+jbx1iL7hONVzQDEDwGP4KFgcZB2V1RqZcQwyHqIUO2yi5hc?=
 =?us-ascii?Q?dITJsYOgk7NzBHYJwSjFUZoDZ0RSIHSKM2CY2p5wWR3akpmG/URs9QGjaDW9?=
 =?us-ascii?Q?Spe48U5x//1Q7f7jvGeJWCobSLPir96fDD+Ek2QefWikKUoOI1ar1xj+qQRp?=
 =?us-ascii?Q?WKHTiOQWJA6mZohybSkxkyNNt/tcoJ8lS1vjtt6qnjihvC6L2O9BjhTmMpdU?=
 =?us-ascii?Q?5IFe6Fic1Gai+/gHd8tmWxPDD1SyehNJrXQXECeYQViMzEbmDyTo7suFSfH5?=
 =?us-ascii?Q?YR3GrF4rmjylnOVDnfvqnPZrn2lwvi9V5FK0WlWnF4OBykTTesZwkqm5ytP2?=
 =?us-ascii?Q?UQgzxV2FQYaH3+lJJ8OXujAToLQNDjOBVIXAerwOoRlGxuB7acz7rQBsegNq?=
 =?us-ascii?Q?xvgUtgbS+YS4XvnnmLs57Ckn8piJFgD9+X3debvKCjrzeI5e0RId6ajMHJHO?=
 =?us-ascii?Q?+Wtfq7FI/rcEGnONcu8wSztaiHO98aaoHFNbc8Jr8XtQjZsqQuO1r5h42zMp?=
 =?us-ascii?Q?vRViV1SCL4bdY52cu7rzu272J/3g+cDAOIs/s95impZuKf2CQCuJkUL5Alnd?=
 =?us-ascii?Q?Qe5KiXKWHMimq5wx0ZZiEg8vugmlupKzMG/6zkE9Jf51xhtTFZ7CyqYM+ZbN?=
 =?us-ascii?Q?CuJaLJ7Ksh0n5n+mJ2a2eakCwZA9x3SJdZ9fUa0ohL2yCjJ72389Z2vAoqwD?=
 =?us-ascii?Q?QzkSsoT2uH8FGN467FMzelC3s+l3gC8qQMxM7pJt+K8fxWG2xbktCAf3zH+l?=
 =?us-ascii?Q?Wg8THsNkAwwheFk0DgmXsOZdpXrAA2hns8Z7ihcywuOQVJjJ36xwArrStm/l?=
 =?us-ascii?Q?NmDEBJlFgternw0FDvI7UwiYwHHRe4/4dvyu0vHSHngL0tl2KjS7POveFFaC?=
 =?us-ascii?Q?Y8jCzXxFsxdihKp3MDl2S4wLcEbxsiKuBtzHptHB5AVQP15HKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIBNEM9exvyzXtDIkGpsREW+8rGYtkFvEeyTKTIaMuILSdFA9Zj/Al2cLueh?=
 =?us-ascii?Q?eWl4KgEMSC2hJEkyVie8T8nmSTOBme6RcybZeHhlEUZyy8mp8WrnWxiS2EwI?=
 =?us-ascii?Q?2ARy8/lnNBLOg6OGbutS2P6BisfZLMCOtIYoCyzXKiuAEZs5qstKKuYxT/VX?=
 =?us-ascii?Q?R3lwuPEdS/ReYeTPtAnrXjHFudIErmkZV6mb3E4Htwma9PH0ql6Ab5rHvlfs?=
 =?us-ascii?Q?XKvqts1ezemNeF6rqUBkr8fu0prr/HykSZnxo80VTpYXUHfsMSL7AZtSpq05?=
 =?us-ascii?Q?MgF3NCG+kSyY1fwWbsDxRrHC1tObfoRWtCDQeIWn3C0F4KaXSrqBVai8Rkth?=
 =?us-ascii?Q?fBL8XZu5jASlh3DH1260zC7lF2zOSOn0xV7SjWTkMQR8s4ICn/ai7D+Riycq?=
 =?us-ascii?Q?D66kxwIPlzWvhy9RN84RcFfNB6fSEyPSpDER5uBMP0ZeHbOA/9VdCtgBTjzM?=
 =?us-ascii?Q?OuCSUUw286iQr3RqjbAW09S7lGLwHSvMQmX/d7xilVK3bHASEgOhQ/7zy6lS?=
 =?us-ascii?Q?gKChxqzEPUMbQtIhXNt9Gc47Wds8a3Mr3R42FOZRc7BW8BDA0EVbm3dP1knZ?=
 =?us-ascii?Q?MjBU/Ua8rIkQzLHa/AXLAK+nVGkOUp1bcakK6W4bEbfRI5cIu0INSYAdVs/w?=
 =?us-ascii?Q?sd9B4TPzjlBXtUq4pqc2K1/wT6PpDnxwG24sNiIoAYG5f0b5XsUeh6IxMNaW?=
 =?us-ascii?Q?4iKOhoBQ4MC8LBuHZ8NvGUNiuhzKYH+gckFJ7it+rYGSyuLffFpIA+/Rafi8?=
 =?us-ascii?Q?eZJFknjRp7KU2X9ERLdkHPk4SFFxkkrlLk/+W9u9hgr7+W/VWLTqFjB9+g7/?=
 =?us-ascii?Q?wFXTTiqKqindZhNKAfrTAn4TqWj9pvwFEWKwrwAnRJDqEqAmxcsK//1Velt4?=
 =?us-ascii?Q?8z3t7/mf4q21S2qpWQgH2BRHKFRFepTsnNpWc6dwsS6E+0jm11w8fJYnRBZF?=
 =?us-ascii?Q?sLIPKotWBQb53MRSwViRY63OBxcvmU3vSDBqCzLJyaM+Y4flhMSHinlZ/wAE?=
 =?us-ascii?Q?eqCzV619e9VlkMSY7P+DnDc6IGd8XEnFL4ur5e0iiWe1QpyCq+DPHjOfO/BJ?=
 =?us-ascii?Q?y73iq39FW+DPGagUlG1xRAp5FxZNS6Z/yaS6W+JgAQHpGVVplAPC8EhG2OL7?=
 =?us-ascii?Q?KFj70lKotvK8t2PvCe5ism1D8ADShYdaMPUWz8h07ezGxGuBMcUSZ1SEGKtZ?=
 =?us-ascii?Q?eE3QvrhlU6qiv4G7jIzevw4nCPc8t7LNOCshpEuHDxHfjN9UtcYh/hZeh7rU?=
 =?us-ascii?Q?d55cRYZGjahKlAjG22olpCfmyEKxLmzo6GUpFKGLG5gKuymWiywo64corQh/?=
 =?us-ascii?Q?S9In+w4vEseeFgC4hVPQrlOCpYYcCN1leva3K3OZRHAB1HLLm+xZmwjm/LUT?=
 =?us-ascii?Q?t3LSTFnLmSE3zwgMY6vaDM7EXFBS6s52EEyvjXFV8+GalSxShED4zHrot4g0?=
 =?us-ascii?Q?g15ffKtcvsxPYzdug8TKjFgQFbrwEs+UJqU9k4x20q7hcHph/qFc9tpDSXt2?=
 =?us-ascii?Q?jPfR0n4MSVL507PhBI4n57qhzOuHzIHvi5cCbjbckkLj2LZJqvM+DSOiihdX?=
 =?us-ascii?Q?jUgcX8YUk368QXQCtXbwfFYH5cVu85IrbRc9ZoOs9GJ6FydmMP6doy2BVDCg?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YikLgBr8YN+u+nEiANgIS2ZI8okFHgkn9o4r5TGG60CRqr7LKJreFN/vwG9FdqFLxK5Lx1zpsSN/wMYgrdkCMRvQeAsmT0poyHCscgn72y7V5vO8oe9bg9ma8ffdY5zIAVT6fs5LThzGviG12iXJrD/W3V9R/VVYCd0MUM8BNgmhODwukQr9NthVJdIQpjaQH9nTqL+L7OwCRsDDfA4kNwxBoE4wC85zGJtHfs1fExW5LrglXc+QUKyU8WNfgIkE9+FLWhxF1T7zvJyQLRYfG9eNu/bWXVcIjwdMB1fhixUdDp1iqSvY11rbaRpR8sN75bxup3vb8PkDyrHt2v2/u2f/KhyReQPEbNxgB8OTO/EqFZhh9G2QZOeA9XY/C1eLloLymkaNVmrVWInT7L9r8piJRe/uhfnU1A5M3ijvEW/GC79+WFUHEyeMhyQCBA09Q5Q0RFW/pdKvZBTaqg//eThRkO2gyytMLORb3yGVkLzpICooFX3uizuREWY/FLeeGmb5fbjBhFn4csnV2KNTn0PHeL1rzKeg9AEjaCqxlP3dNyIS0TdZVNfrXK1JSMSJ9u8VuK7SI2qqE+2dNdqiH0EsYMmi33S5y8hONPCwg6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d72c716-aa6b-4812-4c40-08ddcaa04680
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 10:53:08.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmGbCHn5jv6KLGapli7mNZ5LAQFVqOjBb7rse5kqmP8NXyE4/CxrVBsjsyZ+1fYQmzLnukBgN2sd2RcF3qCYtr+YVHdnK18mTrvMyYmcChQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240081
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=68821098 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=OT0lFCgOtti0wwdvdWUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: WusaBInTis1wrdBoPw4WQ7J0OrfFrED_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MSBTYWx0ZWRfX18Tnam42NwN8
 D3K87B3jEEstObQg9G3lSyF4ENzN2dvOyo1XEXSJK49qHdoSXStiZc4XWHCs1B52Ah4qIVD5gKk
 AeQZDe0Mro9MmbSxrE5h+gKYqLTHobFTdA9nWq4RYUyAJa7/R/v7BkRSpShlWleJc4cGXj4kfuz
 I3h4JOLjtlI7S4pEBvzrCRrg05/mVvpUSRMMn7OWxEy+hWYTVzIXb4J4gjBsyoTQudHy1ntvRj2
 Ne+GVoIw4Z/A8ewHjGG+ttpYj9MOMvIorKo/O3x/I5NMZ5qOXqNB9u14irjhWbYy9RHr8ibmdb3
 Ls3XDVzp9FHZeFRsc1RSfkNhG6embUi2nBSJAqG1eUVuaQ8m+4CI8B8DljYFfk6Wc1zMRebLRfp
 Peh/8DkVOBHlh0JF0dDHQtxnOXhwGs4ODm+jvNoHHb7WnlaX5/17vRc2J+ryOv9h00uYot0t
X-Proofpoint-ORIG-GUID: WusaBInTis1wrdBoPw4WQ7J0OrfFrED_

On Thu, Jul 24, 2025 at 10:38:06AM +0200, Vlastimil Babka wrote:
> On 7/24/25 04:30, Suren Baghdasaryan wrote:
> > So, I think vma_refcount_put() can mmgrab(vma->mm) before calling
> > __refcount_dec_and_test(), to stabilize that mm and then mmdrop()
> > after it calls rcuwait_wake_up(). What do you think about this
> > approach, folks?
>
> Yeah except it would be wasteful to do for all vma_refcount_put(). Should be
> enough to have this version (as Jann suggested) for inval_end_read: part of
> lock_vma_under_rcu. I think we need it also for the vma_refcount_put() done
> in vma_start_read() when we fail the seqcount check? I think in that case
> the same thing can be happening too, just with different race windows?
>
> Also as Jann suggested, maybe it's not great (or even safe) to perform
> __mmdrop() under rcu? And maybe some vma_start_read() users are even more
> restricted? Maybe then we'd need to make __mmdrop_delayed() not RT-only, and
> use that.

Agreed that doing this under RCU seems unwise.

I know PTL relies on this as well as zap PTE page table reclaim, likely these
wouldn't interact with an mm going away (you'd hope!) but it seems unwise to
play around with assumptions here.

