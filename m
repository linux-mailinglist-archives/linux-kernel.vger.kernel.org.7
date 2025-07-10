Return-Path: <linux-kernel+bounces-724731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA7AFF645
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD192561FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF312701BF;
	Thu, 10 Jul 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IphdlCWZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gSoO0Lve"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376026E6EC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109224; cv=fail; b=pYX98eW/5Ax4GCzI0zoaR9eke3VrXoR6UI7WWvscQfUipzpN7NdrOg+KUYg9KXwuEjdeJYRd6D5rnRkuGtTQz267jvwoa/AiaPQB+bVUZ4pXPs9dNIMnBAgtsvTbrhB3fg1S5tw/PVPxGDmXV6CiNEfYKk0nfTwXyWaQWCeu7zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109224; c=relaxed/simple;
	bh=5nrfBIJfgxqP6l37g99TVCRMaU6LTpj+6UiGEvLXX5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIsEYOPvllA9fh9cAuIoGs24GNPSpHqkU8DDUxyAFQCR2iMLs6l5vuY/eZGDFp+bWs2lP7JV0FKyTTAMwD1bDXjzR2wE79puZYNcYLVCZZB0YJ7APa1uzXGdxa5kr6ebOtEs3F50vEtEIBXqKgTCahnIrUjBZeNoen+7HJKHQpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IphdlCWZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gSoO0Lve; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0ODM0031877;
	Thu, 10 Jul 2025 00:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qo43vqftUePyxrf9SqCufITrE1OEyy+j11QwKYC/NuQ=; b=
	IphdlCWZmRGAQcD3Un5ti1xKHVIDmHxLbm56Tg5ch9Srg12BVD1rIpJyWyz1omT/
	kkwFcwCucjeXOwjlkfEykwPB8inlV2fhTwpGFY2e5htt+ThIsjlTLBrAxNn8Ocrx
	wCILV2cu6NO2J8i1ODNaL0IiQmJ6ht1u9MSDNN0MkBWoPwKW7/DWaC3TVY3I6Xc2
	Nf0orfROIH1xmuBiON+TFXjSzdv0D++R+Wxvpjt72Gvl8ZRFDAz9vna4AcIBqz22
	LBSHTW9i30SVJZbeHioEuyMdEygn7fxE905QqHxTQKyWF0++KjVz/jToO0h79No7
	6LK+2FkvahGBTSGi+iOMdg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47t2wn8183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0AoXn013986;
	Thu, 10 Jul 2025 00:59:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbndh6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 00:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM6C2RgNhgB17RNNjeyzrQvbrpPv2nHEhUEPqa0Rn6ZqMNBIm2BDXAOh40rz/LRkZzLauX11qrMpfNDHPdhz9ZYnLAySoQVyn1SDgAdOajjqXyzo/2B0zgevSoBouFbn27t83y1M3rp3olb4eykXuKog12PEJ7++Sm/6UK50EgJx+G56QzjEGWKmQ2s2eTDscc+FIDfjHztThJU3el2KAIPc+JvHkC/dNKZv+hG0HB7fTEjG1tAPSHH0hwLPIcSKA5jtM2GZcqRZv7KkAgfLqiwMtrIoBmHMigp6bi1vUNT8tw/ALGrq1oBM2Br4TsJDvxxdL4CC7Z4iipn7mHJovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo43vqftUePyxrf9SqCufITrE1OEyy+j11QwKYC/NuQ=;
 b=dD6cMsfSRFbQvGZfh8RYbuhGM4GseRPclAiPg1ElpApCfa/TZsHN0pzey1ewELG3SdHC88Ifn45XdxcoPu70PW+V7O4lE93Lj9jQGTrhdZCQnhA8cojDY99hQgBhahNnKz6PU+km1Py4apfGKttoHC/0Yjy+6OpU5/dyBIX/eAkO+HVa3mkOyOui4HY+d5ByczGpo+F0ToFxSzXPSBoxbRmmWalwRr4Hdqm5h+ULA14jnvKSMSZ+htyQIECvhUwIYgxcnhfUy9BESTvHh2qEQbFj2AwY5uylMNEqFJ0871KsdqU3DosZcpkAgDfOF4uNlPmo2KL9F5r2VA2CtGvbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo43vqftUePyxrf9SqCufITrE1OEyy+j11QwKYC/NuQ=;
 b=gSoO0LveNaOuGjaImpqr54hahMWSCpW4xYQCQ08EuSyBHi8i5bisHtY3NOaHQ9yK9yanfJNuuLchmy466Szj7fphpEg5cKXxCdIUuR1SDKIqov2t2igZTJGlwXp8SFz7OEphQzL1drYXg5OGuTfDrwtXkZbQ7MqFiZjAETSvfFw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 00:59:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 00:59:30 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v5 02/14] perf bench mem: Defer type munging of size to float
Date: Wed,  9 Jul 2025 17:59:14 -0700
Message-Id: <20250710005926.1159009-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:907:1::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee17625-d4eb-4dfc-20e6-08ddbf4d0691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AuykVPjXmn1lOz6EzhjPwAS5YyWrr7XzmpeYjj9cNskD5Zm1e/j52Mc0nAkT?=
 =?us-ascii?Q?uf/eYmoMMT5U21ycRemf1/YoixK5iIRUTknETQur1TYbZdzx3us9N+9PtBer?=
 =?us-ascii?Q?6U5fjIqJ7g6fC/i4Klk6yfvi8IPvyZSxU2Eq1z91JCus4DBfURkWsQd1Iu++?=
 =?us-ascii?Q?tQ/tsl5GSQWnWpxkN7nwo12XtD6LnLyTgHZ3BPghTU1r2hm5FNHv1wSrx5VK?=
 =?us-ascii?Q?lcxpfY6qxlzRGQvDSqPLVYxlGIkvGKizmcIRaZxFJwXlYZyvuSXLjRPPiaT1?=
 =?us-ascii?Q?KrNJoqlafCUpezW+1aWQbUY1AC6dJPZJLPnl5KTlOK3gdVTmzVgK6CGfM2ml?=
 =?us-ascii?Q?AQWE2upImTouSXtH1y5FLbk8EkAgt044Kv1b30AEHTXladIji0+dCJ916zIy?=
 =?us-ascii?Q?A4bmVUHa0GM+UntnuPmZqbIxR5x7C6tCbzWx3tL5ldcKD4UldXNrqegz76AU?=
 =?us-ascii?Q?uI1I+YHi7f/2Lt2DnRdvdhD3c0nuN8jCCFIJ1TBzVxVSBLg2w7qHGOlyBezy?=
 =?us-ascii?Q?VvK8m2vwjpzpzzKaV84v1A6VsX+0R/n5Li2ci1VCwG9CGig5Ty18Z4W+geBw?=
 =?us-ascii?Q?C0MD14+fdtMA52AUoflkxu9os7QGldYMuTVvbIQD1vDqssv5SbymV6dU/+J/?=
 =?us-ascii?Q?oC533NZEprreCBL+preGCA7sW4WnsebDjtsv07jGc2Rg/he22UBLlJD/JTPw?=
 =?us-ascii?Q?Z98zqkPRh1SzhUejpzL5LXBYtPeDldpF651vtgtKXNZtQSRlBdDfTL5AGkLq?=
 =?us-ascii?Q?vY3mtkKRNEyqBGw+k+vz5kTgEk4DgGE679C1Nn6ES7/PrIG5IScnMpvbTs1G?=
 =?us-ascii?Q?TF54MLIpvnhFRjux6L+MZT8sCQY0V+ZKwPM3LN5bpRT7HNE52fSDVwW6doS7?=
 =?us-ascii?Q?qRkzjyHRDauGWjHlHgONIvjo6eLy8bMlunqwV5vLyIyfxohJkfkzz2Ny8kpy?=
 =?us-ascii?Q?9FQRmQLYkdCB8AQTb0g93p9lVMI17IAih7Pzn8tLGbBliGfsXSXTmsbZrg3F?=
 =?us-ascii?Q?0LgBQfFl7x1xa3+6l+sYPIDUtWBZDTxTsPIiD7i6TP0wcPfCxGVdpNhCvUO7?=
 =?us-ascii?Q?i94NDloVoFpuYCyrbZEZ+ubkX1zCRWwfWPvc4bX2U/4xcMjLLiu73PfOYYs+?=
 =?us-ascii?Q?+PEzVkANAsd6t6FFfDKZl4vDkMhMFYzkbrryVhk50RgVEB5ng+25MjMI1Ddb?=
 =?us-ascii?Q?BpybZk/GCvyXMzrf4H5R09nMa6DIRBO9ryiSXF7qywVBjOOgURATPdGUnzCR?=
 =?us-ascii?Q?weB58m1HFDxEXnBQ/vHE+KD4Hl8lZ5nZXAYTgC4arkqcg57KJHkOKl4uJu7C?=
 =?us-ascii?Q?ex/HrV471KHmdVpn7WMKqoi1tt1WF0++neriUg4NhVLnhzPUYClpHbPdExG0?=
 =?us-ascii?Q?6eyZJ60dwfjAP1BaIwVQpMKzxrYa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wfn2tycQu9+QVU9U1I3KVBgJFnKgIY9xMYh9KIjs0q/s5S2ACkI6YQgTl53t?=
 =?us-ascii?Q?AmsOcfZdMBwflAr59sXfPfAKH31Tq3PP5fDwg0V1OwsKuLRgeKcg972oiENt?=
 =?us-ascii?Q?fIAOFvjtIrDWRE6WD736YLqvODYTybmaHG64+bZReYLSKHX0yE+L2UXzfwL3?=
 =?us-ascii?Q?VL5oxQhXFF44yRoi11fFPXwsn1RcwPXQSEb6aHGuhmm+vxp82QOWg4nlBbLt?=
 =?us-ascii?Q?cQdyyk5dNRgz+0mKpFBl0T2xDPOp6O/ruEhZmpDGDW01UgN7OcHGyluI1CCU?=
 =?us-ascii?Q?DFGggfHdpLGigBk7U5pVCN8x2TbKW8+UVquLDAFF9Xgt5L71R4YloUCxyPOv?=
 =?us-ascii?Q?DXaz94yU/PBjfu7GII0oFAJFx1ZI/sWrv3cDhazzuMZ87VIpsFvw5SH6tMQl?=
 =?us-ascii?Q?0AsKbbH/VzvLU1jiYiANxOeWgyJbFi1uzTKFhtrTGiRgIMHRemOXneKJ+UAr?=
 =?us-ascii?Q?6ycQDUzRGeCzbCDMhuGhrJIV+syAS5YbDPD049rolFbNP4ORBbRNklrCG+Wj?=
 =?us-ascii?Q?L0bmdAx+QUuFWKOdooyESk55LQcm9JpJpn6n6KRV/x4kgKZsKygKPvlj1Udz?=
 =?us-ascii?Q?yE++OjMuTxuVjWaUOjAO+WUCdYpDY/GAnjGkGPVyaBZ1IUcA7qBB/nYwy1xt?=
 =?us-ascii?Q?BY2OT8+jMaEe2FWz8rcCRKBCa/UCeOAYiVtn3Io7zIl4o3LPRMESI9H+mcpL?=
 =?us-ascii?Q?G894jUCj+DN1YNGCEbBfS+p3rR9PEbmMSEFo26U5K3g9wPc1mEDG4DKQN2js?=
 =?us-ascii?Q?67y+NMv/dEfnFjXQz8yGv9NU5FJaMXUODRnOr9vyHsdccboE3X8z/MJd3ZRG?=
 =?us-ascii?Q?6pzXB3e2Ebkf0Qec3ruFFlrrHyfUqMHIQbmV1SEkeRbcylh+ihoKF6jYGa+I?=
 =?us-ascii?Q?AMX7qRhk1pJtIVvBd6TxJLp0Cqo5ou+mQzWTBhnWbzKvWdzLuoYqnZHIXN93?=
 =?us-ascii?Q?oN1HkIpBUiXsivXOWsvq8jiMyC7UR7dyaA5mvgq8a7vvNgBP+z9VaaB69MOx?=
 =?us-ascii?Q?+3cp88F/eulCXDVOpEgLYUiB4m+rBhozMvy8NH2P6syvCLVVz7QK1rZzDdpw?=
 =?us-ascii?Q?rOXe+S59vuq6+Fa+H6Betkc+rTKuJybZsjzZfglIPiewphHlXUP1I4gx3FOd?=
 =?us-ascii?Q?VoqlB+z562Rkj9/x6Za+Aug9CDxvQdDyeC/LwIhlMKv0AYMOAHOcpPq5S+ye?=
 =?us-ascii?Q?qP1N6ODX1Tp+aURNpFDly/fZ8kV755JG5VcfBmOPQlYRnMcnK3vYRfnHmiWc?=
 =?us-ascii?Q?xKTZHrB7it/HGW4PUO+M25ZiihfGfz/Jd5gQhtNV70I0m6EPSBtTI0ocbKl4?=
 =?us-ascii?Q?ezkkAoI/NnF7SlNyXJhomNnrvDWc7dJLQSKGTHnwm1JV0Ce6luoK1xGDVe5O?=
 =?us-ascii?Q?y4LKyXZvPxDzPpOGi86rV4CxfVuOwh/W6HYqLQpt92uGS0eaJ7lfqPwP7p4W?=
 =?us-ascii?Q?Pg+EuzovnszD9aIVxM3MnbMSozIVqgiVV/umdIlqnrsMZe7l/we76iXac2ct?=
 =?us-ascii?Q?z4LdBcgBDMnWdzvEIfwDS6PWJlspNThB8liZzmq6inT5ucUlBHDG0zTxbAUU?=
 =?us-ascii?Q?xg7bT6Yybn7hAFka30m0VmR6uIH5/RquoPcqB5GRZnMJf0u2ChuBRN0h2aUA?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bPuUF3W5tRt2xAq/lVFWudLd4VOLwC2c+DKIKVq7zVtaRz0KgwCNRxE32y23ySLaC/lqIQBF8Xypxn2JauLeJJBPZgePeWxyMh1dtdw5VmX5cgYdKNCdLl/tsQbEunNbe2XRKaarv4lpETR9GLCMbPcRalGQIVRoD67rcYdF2BxKfJPQ/kF8fOltS4OeuW0hOFH4ORasHE6SvkidjTvxA+4fUk5/WBL5qe338neJFJm1QizQpXViBDTZLx3Cs2TsZvPPoXqMHzn0PZskTI/BilH+AIgq0dUFjdsc8tPtp5/s654B6Zz4qsabqVaKxl0yfLUSWotxZDb3JHJN5SVNJL8kwch28A06UFxW/84HIr4JsIsDHACIBVTHqV5AId/yiSu7sxs1y/sSwi9OPTnNnYw9Vnmw4aI90EK9pBWc+Dzm1t53A1/e1MhHq8whjB5dbFRSW8EFvbyqH45xQPwT8V/i2RHHnhOmmjFKUX2O9e996QCtq2YMZendu8UnO+6plE7C0kI4EUrhGit3YlDiAQ6BUr5fzy2kY3wLt5Hgkop8lwV/9NNntFlqV5erMbOz9LFAq5odYY7UgOeSUrSpLD3nsHxGj8job3hJSXp7fvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee17625-d4eb-4dfc-20e6-08ddbf4d0691
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 00:59:30.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaYYocKlT2b71eTskYBpDj4l3AhxS3e6HLg+qhYNaRdA4LdJBg9o+w59Ouql6bLLrUGf+W4/4son6aX4PuU4oRmpsP7jXacEbJw7KIQj/tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100006
X-Authority-Analysis: v=2.4 cv=WtMrMcfv c=1 sm=1 tr=0 ts=686f1076 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=X4Au_8HLBps5sezr5J8A:9 cc=ntf awl=host:12058
X-Proofpoint-GUID: 360PNtXG-1GiRyNNTwBrHfZGRqhIb2mc
X-Proofpoint-ORIG-GUID: 360PNtXG-1GiRyNNTwBrHfZGRqhIb2mc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwNiBTYWx0ZWRfXzlNkjzSsCTzk RTtKyRXdlPsF9kLuyINsQNyprlykpLtBldITW6EmT4drqOi89VaiXs1CyNs9FyFbRKZNNpdkxJe W3JdY/6Qrg0ekaXDQUtX7JdVMrFFMMwNtPQm2UlPiyf0H17kNSJUL45V2D/y/EU34+x7ESPXAen
 nmUdouWkyHMxTpe59r67uWtGuhYEYi0pi75BqxiZ1Ck55gL5cjFVbTlfQDiWI+l4S1becH23/AF kTFTiTyKpBT5dB3vIxyI+qrfZnDUORNbqd8fyN6gdRhuA38+l7cTSYvRUzc17hntBt28KxiVWMV dkGEpQjvB0yCU4AA7yz5JaxnDnMsME95wUdN7cKU31Z6YdOGbcK2dHbiupGhg0Dmd6zT/JhMNy5
 +O3hIVjxo8v0dRbio5e3x+eaM6cqXPzXzGYUs4SOFpZ+h5rsXprxcX9079XLGQiAxedIIk2w

Do type conversion to double at the point of use.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 tools/perf/bench/mem-functions.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
index 8599ed96ee1f..b8f020379197 100644
--- a/tools/perf/bench/mem-functions.c
+++ b/tools/perf/bench/mem-functions.c
@@ -139,7 +139,7 @@ struct bench_mem_info {
 	bool alloc_src;
 };
 
-static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, double size_total)
+static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t size, size_t size_total)
 {
 	const struct function *r = &info->functions[r_idx];
 	double result_bps = 0.0;
@@ -165,18 +165,18 @@ static void __bench_mem_function(struct bench_mem_info *info, int r_idx, size_t
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
 		if (use_cycles) {
-			printf(" %14lf cycles/byte\n", (double)rt.cycles/size_total);
+			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)size_total);
 		} else {
-			result_bps = size_total/timeval2double(&rt.tv);
+			result_bps = (double)size_total/timeval2double(&rt.tv);
 			print_bps(result_bps);
 		}
 		break;
 
 	case BENCH_FORMAT_SIMPLE:
 		if (use_cycles) {
-			printf("%lf\n", (double)rt.cycles/size_total);
+			printf("%lf\n", (double)rt.cycles/(double)size_total);
 		} else {
-			result_bps = size_total/timeval2double(&rt.tv);
+			result_bps = (double)size_total/timeval2double(&rt.tv);
 			printf("%lf\n", result_bps);
 		}
 		break;
@@ -199,7 +199,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 {
 	int i;
 	size_t size;
-	double size_total;
+	size_t size_total;
 
 	argc = parse_options(argc, argv, options, info->usage, 0);
 
@@ -212,7 +212,7 @@ static int bench_mem_common(int argc, const char **argv, struct bench_mem_info *
 	}
 
 	size = (size_t)perf_atoll((char *)size_str);
-	size_total = (double)size * nr_loops;
+	size_total = (size_t)size * nr_loops;
 
 	if ((s64)size <= 0) {
 		fprintf(stderr, "Invalid size:%s\n", size_str);
-- 
2.43.5


