Return-Path: <linux-kernel+bounces-795784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E472B3F7C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4C91892951
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7F2E9EC6;
	Tue,  2 Sep 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cEvG5y4+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gu1URsgl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF242E92B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800550; cv=fail; b=hpWN4lZ9S/2K8zkF95i72s8EJQBPE1Whuhy19SD19XAjAAiR0QmMON8Ezxdy7imwA57Ae1h9gSUJ2mJOEU9eydcjxvODuTTQeldva4mSq6U67dKGLD0wQSfv8N3AhOzHFIHPCSYXQRNaYXJZc8sCMZolAi74/zx2WehNzEdkKLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800550; c=relaxed/simple;
	bh=B4kiYTGQPD3SgOo3QHO5VlMcEln/1EWfOVRFBwKB+/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=na0AlxFOIw0ppCtTp65DVIvMDlJ2n1FxvYFnS2dGMCvKq4LP45VRVw9MxMOSKaHnwqFt2lNYve6dOx5elc1VM0hF7CuLWCzkF5hH+QScnDUYhCS1YzRftX0hczVlaH9BtdfP6SxpjCU7VDIVCnlL195fsRozPCdLp0xlpRwYQyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cEvG5y4+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gu1URsgl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826fgwK032056;
	Tue, 2 Sep 2025 08:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=h0fVgE2QNAmmfDUSmTW0YZHjzhHFeqVG2WDGnOC0Yzc=; b=
	cEvG5y4+ptantpLJ2B5kve1BUfh7MrMcHRyNXg6DIY+YUBatMC22GXyI3jzsICD+
	2z17hIrfLShobgEW/e1xuUdUwGVOeVxPC+hHUByr1fPu4BM8Sr/1q5p/2lrMR9+d
	ZOB2m7vpfG2mAC0RBDmYpkbsKpFpFlzMFRTSwhOx1Qjthc4R4dulq0CzU/wZjz8a
	rATMEhfIYdH/Mr/a00ArapgAG5Q0+Q/r9vb7BJOXyyZRAoKTVPSHhVmSC6WxS7kv
	fjjcvEcslHYwfY1o0pc4lluPPD/zd52oQIKYJRdFPO+yOuL4gHjiO9sUZ795o1/J
	oJ6P7gvTw5SNHC7i3n4Vug==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbbeyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5828067s011816;
	Tue, 2 Sep 2025 08:08:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqreuksj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4zembOdlxJyEfmBbOF9iZH1y3atCKcz8bNRohmUQ4/fNU2mzL/z36dIpnVwrKL5L4YuTJj80OTG9MzU+ILPERr/E+CIE6w0LeS2p2bDAJrT/XuI1buzzZzxt4oaLkvaYG76ckXF5f3bMQIwtH5x7pa6YpM7ulX9j1fh873ob7vtXt4WhinQrw3c7MMlGmk3TPWT4Jlsg2+vDaneiMeojpwA7ofR4g5S42sa8EwrG0AhU3mcC3aTL/YNRekePRlnfi+eR3W2gvHuQWemcizNqTb2tnhF+pMNNJbBGEI9BpnQlaWe+t3/IXUo2FWz0pvsoQKxMm6Amm8wrYHV3Z/ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0fVgE2QNAmmfDUSmTW0YZHjzhHFeqVG2WDGnOC0Yzc=;
 b=rgUuoFWo6IS+ufF9mrfjAwlI7+SqVEP4MwJdeoFMMzsiluCxuJnryR2ZVtD+1d4XmYJNy0lI9HW8IyLyyLEtfGdDTxPJIoLuuwFnsz0uowoIgpCatx64XeRau/EUcbnFCZRzxxidP9sif8BgEydeMZJBpJ1JhGSZUWss+HtP8Pd4Bk/0HRyKqL3/qyTmRE/gR+AwLcb3WnMGQgPSjmMjfggpi2JX/CIPd3vexrVpHuEBtZoC1s0JVNrD8iWv5paS7TfeL53WMIQXkrAtamUFp317kB9cM7xs2vuadBTGqIHylTuQ35iWpmr/QSa4bGa1C5crm7M8r6w/TiJsBFsskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0fVgE2QNAmmfDUSmTW0YZHjzhHFeqVG2WDGnOC0Yzc=;
 b=gu1URsglz8oHgkF62+sxH7d3leJSgq1Ar+tqPmiVf1POIxMWzEGtjTMuED+3e9lZzxH2iZI+9ohwOop6sthL2PILP3U9tTSeqCb9NoCHLyzCw7EROk8T/Z8lf1Q9t85rB4uUNFTXXIFm0py2MCXGoNELn/PVkXGo9at0jq7TTJ4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:08:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 08:08:43 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
Date: Tue,  2 Sep 2025 01:08:12 -0700
Message-Id: <20250902080816.3715913-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0306.namprd04.prod.outlook.com
 (2603:10b6:303:82::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e673d5-1111-4318-0b68-08dde9f7eee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PC4+J5lASGQqJEHpdDFbVXg2zvNQSRFGDE55B+97bHLD2nPusJukj2R0d7sx?=
 =?us-ascii?Q?EQq7Yi7ifuBnfam2rnA6Xdp9U55x2z++KRjlKJ5LoXCItRje9NcHurLc8+4b?=
 =?us-ascii?Q?3GUC+E98JmvRvylb691yuT0K7piLRkpUJH/i4u9nXd5Gu5o8cMObQBKea/pV?=
 =?us-ascii?Q?sC8DrrB4RtNaP26vKYvytdTfwmgeaswwTriPG4gOIvaO7glOkJqb/qQY0Txu?=
 =?us-ascii?Q?9f+desvttyMT9kCKoyuOJipKNgTZd1APuHHWPDou8PtofrmwGg9Sun40F3/D?=
 =?us-ascii?Q?Nc+ZWe8fWyUnHYv4Hp1mhnepzqOuC+yRY3QfQyr09whypZrOu4L4FgHs6wfA?=
 =?us-ascii?Q?qtD5p+uEFHHnPNF3e7lTpzU3RdBlKHzVSdiPb67nPpQ+33oy54TC+HwHGRK8?=
 =?us-ascii?Q?7+I6TPXdQa4X565sPnw0t5/MgRTflyZMWEemwhx+znpMpZI8ek2QG4ZjzLtc?=
 =?us-ascii?Q?PqYuE9fGyPw7m3M61r80gxxeVhwb0gx4nASBrIBOdtKErcdNDoWEjFSeBJ8f?=
 =?us-ascii?Q?aedF3JpIlRM68D4qVTsi5gNnXUvI8MiM8ANaIhlqRM9mfjVsM7ujr/E7lnd0?=
 =?us-ascii?Q?AKHRmkaNfwWtEFk0Wu7q8KLJQMuHRP/nh7nmEdd6IYvpSkdTBAih8iVk1KK1?=
 =?us-ascii?Q?ROcOV40naSt7akFCUTo1HLR6LWIgJF9qNzL8V5SflCLJ272HyjjppUrCn1CU?=
 =?us-ascii?Q?pmTEcQlrtD8L2d4k/OfoVToaQeTTGWpoSg0s/3BBT7DxmUmUxprjwtDVIJx7?=
 =?us-ascii?Q?SRL4OAi0Z0fl5oSjjv7mAV8y/Rw1e9s6BK20Xa989xSswEGRbn6h3m+7oF5f?=
 =?us-ascii?Q?eLbY1OghfQ/X0Ze4dsejkdqKX6B3FtQn5XMGO6NaQAubtSI4rOrl1Xld0tae?=
 =?us-ascii?Q?HmisZT6QhGpQEzCsIvYf1wftd0u3OmMXLIORo4t584lgZ393SoNYbxUqSuSo?=
 =?us-ascii?Q?sL8pc1V0oHEQTKIc434rPI9v/0p4sPetQIHbzYjDyyD+CGAf6RmF9tOFBjdB?=
 =?us-ascii?Q?+CdHrhxihbLLmAk8qB2Om/WovNJg2r88BKy6tVzZwLFzI0b77wHR420IHJlX?=
 =?us-ascii?Q?O6Z3BWfqm28KS5d1TdaFkyz6PWWCIwCAgkULm0GXpmJp2qSiU+y0AW9nTgF/?=
 =?us-ascii?Q?x7TUbSIix+Ol5JrXFrMzLWQp/J2gurH6iz8LnkxICsp/w0GYDntI/VT3Q57z?=
 =?us-ascii?Q?QWRe9mzGM+ygXsqdyT4Oy9I3N69AnwcfldOTLgcR/wMNiInf+H9R9xMmiob6?=
 =?us-ascii?Q?EvbxqFA+/gIsJ80P9c4xc38f6YPVaBvYBKf6e9d8UjdtqLtNAKa6XKSPE3Ln?=
 =?us-ascii?Q?r9W9epRAycfZWkcC4WXKaJIgW6jrOA+wCmlQquB9ITg45RuQlge5opVAeH2K?=
 =?us-ascii?Q?XJOLB9usIa1hIGB1GB8f97tv0BGRHMGZdTQb2axAAe/SHEYZOQjMsrcZBCWr?=
 =?us-ascii?Q?wdtEOpn+tKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fImZz0rJRfluAlnovz7Bw034JRjq61PFfw/eyO7p4BMzJj3cEE7nBGvGCLl?=
 =?us-ascii?Q?vhcfafLPb0bSWsjEvOh3Jx71HAf8QolVdwZfV5b2UxLEjI6mhdhEsWipk5GM?=
 =?us-ascii?Q?UkmwBgipQpdVU9BdKuANmz6csQ+0nXgprL7RllFDlXrB5PblayI//jZ+rnaF?=
 =?us-ascii?Q?f3Ll0aTjHWZl2VzxZXTrP3+pL4OXUUyqTgsx88aJINZdqSG9bshDHV74oJVh?=
 =?us-ascii?Q?4RS/ajsu4xzpZInLQ6S+6kVyCkw7t0Ah0nwET6+UQFB/fd/4kWLYT58dVJSF?=
 =?us-ascii?Q?ebuwMXiH3c369oiIPHPuUG1dIMo1grKwcOKnGcSObSvuPz2Dh44D86Dzzsr2?=
 =?us-ascii?Q?QSWgRRHzT397FcLZ2EWQqDuuLtBODdhxzvfCzEbN+ERiBUUzFYcFKY2qyM12?=
 =?us-ascii?Q?0Epwtq4NcVPflK7Fw28RNd3mahRMUoJnYvoCt3AKRi1tkwfR5nbvpO6nQcfm?=
 =?us-ascii?Q?4V48UXk6+++Soi9t9Zq4jjgdMsyYmFsCPk5C074g1nV47lIeXzYheA5Ektwl?=
 =?us-ascii?Q?0xtrm7et4ps7MZebJQZQNSzqQs29hn/H9AtfjlvA7Yf4iSdQ/BSOVbhylGrg?=
 =?us-ascii?Q?hA/LS9IRqxDgqk+EvuiKvva4S8lHRTfa3flIyMIhawpf3NROSZtYOrn4qw4f?=
 =?us-ascii?Q?NTluCFXiV4kjDdY5hgy023gf4Vwt7b6sJwHoZ1TA2hHMobhZdfthgyRRzYUz?=
 =?us-ascii?Q?ytlQ4IXlV8qSyHYPyvI/Qa7V3yj/DbG/AXkx/6eE4qZfMudVgticz650Qabm?=
 =?us-ascii?Q?7/M6MOAKNZFrnXe+mZsXXZMsvxVy7Ujr+D6Ecrtn1NHfjbBgMqZBhadL6fDw?=
 =?us-ascii?Q?oEzMrE5nr0UURQTlHqGlgkqmexF3Q9raSoxz4hEpAAq1pYdarWOTy2CVSAYR?=
 =?us-ascii?Q?dEVSF5HQ2EhRk17p+gRKBLqOYmyXvYPbxkYfC3w5U2mdFlmAJ5jS3kcX20+y?=
 =?us-ascii?Q?zjmFxxsw10jZv6IsJ43q/Ltl6ViwpNnWoMt8X/bDKkt4FGZRNpSx0RgS19uE?=
 =?us-ascii?Q?zMiCmUN5buusXqzfhsR6wRDwO8XC3k+5pes1swtUImBtpg7dVwI8yT++a7Cj?=
 =?us-ascii?Q?ryOXipviMqg1/2GZbYenrZuJ7NwCWxtDwmJ9pmTVXC5qCurMZTR+MNaI7aJT?=
 =?us-ascii?Q?au0q5UyFTz+YV5L878kkrf0AZxAV+3+UYl8FmKL8sSZTUt1/GBBa9oFiMGB8?=
 =?us-ascii?Q?EbNZwSsxG/560Zz1klgz96pELhnYtXDTPmOXewpvKHz8UF7AYrFQgXVTyS0y?=
 =?us-ascii?Q?pzobZDBY7t7UJ6Qs+lyUi06RxxoaShmMG8RIX+vVUsvEkb/ZImyTnNqY14PL?=
 =?us-ascii?Q?h5bJbEHEOWazuUMURNGkB5lmGQSSuxgh/HOScbvRXA1tMgvpTqoJCMs972E+?=
 =?us-ascii?Q?VUHsTuVwOJt0qJFve40o8Wsww+TiVNwFRw5wcmYi0RTTIJdofhnJB60cXVFw?=
 =?us-ascii?Q?sA84MhGgLyr4JZx1pLHHbnV5N94eHw7Zanrkg01LrDINugty+MVf8r3HSND6?=
 =?us-ascii?Q?Xnt7s7LSgcWOrwGZRIJh9+XfwyytkY1f4TsVOK1Xwzr5GJaZebULhxDvBT+C?=
 =?us-ascii?Q?/seT0IXjQqm38CPtDr7N1Mk81e0HkqD1h2qyj8p7e9aT2KEepCe0g9p6houW?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GmEp7nQpFcHOjWpRzRKzzYkvDHtHGeQcbayn1dEw703sWTu6mcmo7jEPCEzOhnuS05UcpjyS7WUQ4NxOnxU0/jJ2qW7gZ5rYmb8G9pIcRjOpGSWoqoCgO/kPiT2fPy3kuz/mdk4HEB8/7Ht85wiA11S/g6qWkUj0LWuMuG64l9Q7yg4MvJtqz88NkQdOuzJTCqGKfjtXIsBVnaWUX9QfPiBJOSmVzWJcX1haZVDYAVH6x1E9FVdAVmFIcscKxnGkRe6/07yh/Ey2GhlsS/dQ13QKQQ6hioc1c5IbAjgRTWpsgVtU4jCwt8jDzerzcFZ33HMitHHQv2UvdviIPkeNm8Y0V9yIv/rtslAmKIlNhjuaB4HCrsTK1E+Zw7ZbvU9EB4oB0skyOzsWLlLmPzgfUw4o/7uFCNwwA1ib+Eo3V2vSn/y8JccksM0wiZvnzdr80YOcTDWEzvro7Q9mbfyuw+8YxOoTmBFEpYXIM8o1VERRAvlmJMuSmntcAbiXndlj2l8hfgMxWZJnE0Sv4wr06vusWBLd1beOKZFlWLwbxu+p9ROedD5Zchk7TqZ8KlmCluCaLvYeoVaSJ+s5mgi/25L9yXmj9pmpQvnsJYCFN4M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e673d5-1111-4318-0b68-08dde9f7eee9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:08:43.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xOc+JVHdUlG4iyUGOsKHyYtk1n2gXcHoOsy6Lhz+jQGQqxvSDQyX8uKIIUI15RpiVL3YeKNHDjL7nsFIYN2ZChkh2VP99ENpc+0ES8NADc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020081
X-Proofpoint-ORIG-GUID: 0Jb-lxxl221et8ULHh-w1DGyajowfusM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXzSCPJBsgwWGC
 qIYunKqS4JxBgF4+1RT1IvNkFJuOUPazRHYBrMgCb943NRGS2tAgB+wheG1vlWWpJS4u8mC+E+y
 1rqspHcXkh1wQ6K8H7nDu1gtk1kdkR4oUAzoECMFH4cXRNgJTN0VsP+niJb9J2OMIxdtnkAqaMt
 J9RiG1/rB2egJusKAlXRsloh6MfQ1INQicLn8C/uT+NUfzWKtrKDuM/rDGJQdFD0EyMca1pjJWy
 9H0iDQjJGulZ14S2iV6qxSVzQoNd7w3/fLbJsymB9x8/Um5LdgDutXVdeidsf18gucnv7g5mq4P
 nPliF8GBeD0HY7xzR//zQkhllz0qI+dukFeNkHUm1gBA8Yit49Pfwmgr4U9tsUDSRtkYiBkksPL
 htRXa1ecY7wI4qfV+O81Fk7sSo3bCA==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b6a60e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7XdPRqDjOAPL5xnB7twA:9 cc=ntf
 awl=host:12068
X-Proofpoint-GUID: 0Jb-lxxl221et8ULHh-w1DGyajowfusM

Define fallback versions of clear_pages(), clear_user_pages().

In absence of architectural primitives, these just do straight clearing
sequentially.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/mm.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..b8c3f265b497 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3768,6 +3768,38 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
 				unsigned int order) {}
 #endif	/* CONFIG_DEBUG_PAGEALLOC */
 
+#ifndef ARCH_PAGE_CONTIG_NR
+#define PAGE_CONTIG_NR	1
+#else
+#define PAGE_CONTIG_NR	ARCH_PAGE_CONTIG_NR
+#endif
+
+#ifndef clear_pages
+/*
+ * clear_pages() - clear kernel page range.
+ * @addr: start address of page range
+ * @npages: number of pages
+ *
+ * Assumes that (@addr, +@npages) references a kernel region.
+ * Like clear_page(), this does absolutely no exception handling.
+ */
+static inline void clear_pages(void *addr, unsigned int npages)
+{
+	for (int i = 0; i < npages; i++)
+		clear_page(addr + i * PAGE_SIZE);
+}
+#endif
+
+#ifndef clear_user_pages
+static inline void clear_user_pages(void *addr, unsigned long vaddr,
+				    struct page *pg, unsigned int npages)
+{
+	for (int i = 0; i < npages; i++)
+		clear_user_page(addr + i * PAGE_SIZE,
+				vaddr + i * PAGE_SIZE, pg + i);
+}
+#endif
+
 #ifdef __HAVE_ARCH_GATE_AREA
 extern struct vm_area_struct *get_gate_vma(struct mm_struct *mm);
 extern int in_gate_area_no_mm(unsigned long addr);
-- 
2.31.1


