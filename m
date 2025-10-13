Return-Path: <linux-kernel+bounces-851058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA6BD56B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B0194F8D87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D228E571;
	Mon, 13 Oct 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qkltn7cP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bIzQxDKV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF29428851E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374769; cv=fail; b=J1TGvpTA/KJOK513EDPjPv1Fej6Vj0WqChwC0EDz5lCOFgLQ1cMlk36ZrlDaeVsYA9bFXkmRWE56pEcyFxeHtrqRzLP9bgmVZrBURZBE4phhtTlcmamlQa2NiAaCkzUZWhZdJ40PQM4yUOFLOYw4omBYeO4usVwvSD5pGdl7wDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374769; c=relaxed/simple;
	bh=2D5Gjl5rnJvlaOv59a8Qej4/2W+033QfDEkGozNzKnA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XLEBVwLrchIzvARu0VSXP7egNW8usBDskxyApuEkXWJXsbpPHyIxxOYsMJl3aMqYqpfaBUTP1ujizAE0paL+6pXqfn/gvJB308knPpfilb/OulYEfSx18wzdN7vygu0ifyu+D/Z2+f+8ty7OPi1VOa/Mnh5WpAPKM+USUmH4okw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qkltn7cP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bIzQxDKV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu2DY013485;
	Mon, 13 Oct 2025 16:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=HFr+RylmOYdZAmjn
	cCPg92YEHEqeu4mNC3sR5hDHb6E=; b=qkltn7cPTrZFDgwp482rT3UIRY42XSoU
	85sVrLn4E7iFYpuvMt9EXDDQNB+78aU/O/2xA8xCc3l5Uzo3PBeIOotYQ62QsRyi
	yqsUPaqJgcU1pD+PoA1DZaofcbUVuOHIVvBoTmGEKXFGNvja3+CM4gH4a4TJo6a/
	DCAAkgZKRrc4tDCDFkv6esSXP4OgXl7+KdlUYim/vJ8/CgcNpClssH4GifxRKqW9
	VjqmQaEbeWBktawXERllvIgCkzXiyWTyGbm56/74GOltQZjuLMzUQnuM26BbQ1CH
	0yOWbGKylpGZySk+4Ncg4WMxeVDCnBGLifDesOy6slpWprrw+CxjhQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59aquc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:59:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFiS0h017139;
	Mon, 13 Oct 2025 16:59:14 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7sumn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 16:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV2FCeHzYhjQX+VhXBvwPSkCZR12i7iAg1M/uVs2YMi3PMuv20pvObNwpsgTWlWMUsbEyrlDim2bWPEl9f03R4IrJOZUQo+nSvAWK8JYeSSdKZe9NV5+a5j1rwLzxh0uFqxKZd7WdLkwIzZxfSsvsinLpibER1OfnMXoSVDFBCEdqQsjbTAtdVMKgC6WDHeKfNDuJD7OChwX4tpetewZMfuq+pyozluTz9EgOLiSY7/VczZFUrUZ1qn4xO544qlfMmfEKBWv3S/cki+dPmLc0n6CuVBKjb+X7XDEncIGIJqvPsPyaPlmQfkDv3T2QZjVjkiu1E5vMZyrxPKPxJ7muQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFr+RylmOYdZAmjncCPg92YEHEqeu4mNC3sR5hDHb6E=;
 b=x96srIvij1RK025I2AD9R9rCO1FtaGOZiJ+ld5eJ42z9Y9/PsWnTXrQTZfmqHDiDJRomFUTGr+RiwuYwzGc1ovpfyYUHF3vhXvzuH3JvHEKWH3vSxl5oHyvjIfl9exi7yQ8TRm4IGFNWT1mdZIIy+Bvxt2sC8tWwTgnpo3v1PsDICRzTVHrzcLYHj19ICmrN5XtmVU5yJ6yeX8kpGvSGe0aDTDkwxhBD5xAEMVOLEUpSufiJDTDwXUZof0zTUJ8BTO5679/N8PBxnrVO/oFpH3wOffWrW7I6WmWeFvj9+th3KbiKAT4fLw+YOoZZcQbAJFHTFh0mx8tl6Gd0c1d8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFr+RylmOYdZAmjncCPg92YEHEqeu4mNC3sR5hDHb6E=;
 b=bIzQxDKVyfv9UC91b5Gq2c7YaP4z9f6UCMxFTcVPwXfSb3Ht0pYbw0qQ0Z2h5LLRUdCsYy4terOMV21unnSBmkA3CJRI1EcoZZTHUw67Kcn/UHxNZVLz7bBkZrP7xZaj4R4irmWiOKwKXR7Z+GVpy4HhQL5SUIaI3UmihMr7ze4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB7203.namprd10.prod.outlook.com (2603:10b6:8:f5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Mon, 13 Oct 2025 16:59:10 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 16:59:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mremap: correctly account old mapping after MREMAP_DONTUNMAP remap
Date: Mon, 13 Oct 2025 17:58:36 +0100
Message-ID: <20251013165836.273113-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0442.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 882de136-34d2-4c02-1d41-08de0a79d462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0nrJSrmvs9KXKAzoL1q8ApbZNow8TBfcJGaq1ve+jF9Q8GcqeujqLqO0wArx?=
 =?us-ascii?Q?xY4aFRGivMQlI7iNVhU3BhiLpHy82qmsA4mmjYa35l/qXf52tlT6QD2ULBr0?=
 =?us-ascii?Q?DD9yCRBvSo+Ajf1PEko081Emiu/fXluWs6WvCUn90AjGcf1w/Bpr6BTw6es+?=
 =?us-ascii?Q?iexynk7clcFqorjU6ukIUzty+ILEN/2hPteLlymipup8+lwp84xEpkwvjp4k?=
 =?us-ascii?Q?gpz8v3ypECSHliDrvH9FvfhFvYe2hhiEMidUtK4VrxlHmDiEsBxGoJEg/vuy?=
 =?us-ascii?Q?m/Yc8tm8Y05kEDsFVS/fYYrdWjJGT0MUqRnAFXPRi9L4ic4HaXFkgLCvZtjp?=
 =?us-ascii?Q?72SRn1R/k7qfaWhQAVm2nC8XRzy9/SUPT4AqN7zK2hdeWtk9le8HJebKYX/M?=
 =?us-ascii?Q?GjL8LM0ofT3aERUGOghsjbwl75hIZ7zaE8gaxH8ZtP7MbM7twg9J223532Nz?=
 =?us-ascii?Q?gvirQoKrs8x4GO96Kh892fYJ1hOI6Npfpve7pmZo6XGVjduswt7P2d2rqlKd?=
 =?us-ascii?Q?w2dAt18SsfmQ4SDT4jPSdOeuOOUT2Rd+PF1/gWcIJwt+epOznkdPArMO5krh?=
 =?us-ascii?Q?ynIJ1gWYoV//ljwGFocs8DFrSIl/7Pji9avPo5xuhW5MovaGGQHPA3Aue11L?=
 =?us-ascii?Q?0OM+B6qWn6YxFgjD1ZeTNPUyPb2lWNMPmBea4zZ11T6PMw9RDPIjB+9mVJnc?=
 =?us-ascii?Q?GY5gR/fgQoDljdRh6htNXYdOUpMJzXaRKpMMkHO7jyXiBqmB7K5StLXRbJsm?=
 =?us-ascii?Q?GnQHzu9EbMWxOtnSb/Jnp/goYDy/Cq62BZ5JpbnYntlmxiOioRKCaYNJEDi7?=
 =?us-ascii?Q?Ne/9muHk//4W/dsc1ezDH3NuvaoWGTcMo4i9ag8xDRdgo4WDe1i2UGQEDpUg?=
 =?us-ascii?Q?cz/PjKvvkt8qaAEGBOuisbSWMfAP+H0MXajHp3K6A/786jss0/9+etpGIvz9?=
 =?us-ascii?Q?lgSqEETvvMVFHKYbdw9CRjEw9RAxq2gJAr3SrIVkF5Cro45foQfRjf6/CKlA?=
 =?us-ascii?Q?NodsmUgf7tlSWuQlmr8OkVcgi3HkmQMb6QwUuUuFhUTcZC558ZGsD96urlvd?=
 =?us-ascii?Q?VNd3o+4veBh1aTduBPB4RXrVmJOMKlydaMjT5SPh9qCP2uADc1wj2lg3DlXQ?=
 =?us-ascii?Q?vYX9Ox1W1PuuMgEwMGUIjqEEko8DUqLaKLkJ1FMNHtezIyAnMOhbEdClD3aP?=
 =?us-ascii?Q?Nm5JUHs9eCEI4+ukoxw1eoGwkY4ZHeOs2sjFgrczfscBYqbP0nnK2M3UaSV9?=
 =?us-ascii?Q?hD6MgVEROC3aJOkeH0sWHfTe8Hlma+tsm2leU/Yx7Z4bW55chp0n22BSv9sl?=
 =?us-ascii?Q?t0xc+JrYN/CPh9FBW6SQiTpvaJh44eZRGbtPcT6b8wj33vzkXNJmlMlCxzE9?=
 =?us-ascii?Q?72Z+0DdxRgzZ8EboH/6ZvLhXH1LsJBb+GE0v39Z4ekSgc5QytB2vw2hBVSg4?=
 =?us-ascii?Q?eHDSEj/ewTPjLJ+qK5DoRA6bmp24gRKm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gTkMPfm2g2yIAUJ2jIxejSc89JO7/Eg8+4mcvf24s6p5oq71vUroHgSOBru?=
 =?us-ascii?Q?cP4PzsvXgFFv5lbOyokwddYUJjy9ukpwr+EOiZ8bxU448EABqk8PW72h57XN?=
 =?us-ascii?Q?kNUGu+SZPtJyRTp3xbAz8cfw5Kx9xspapUdIycjMFfcm/DjamTJacl6hVhYT?=
 =?us-ascii?Q?6HUH7M5rbB0+I4aZdwCad+pBV5ofXUo2Ynux2KjpAcmVNl+amp9YA676Xdn0?=
 =?us-ascii?Q?u4l6AvfBEiv6lo/PjWL5cwoflGLvf6HER0EngNG/QHY66QUe1H+RqnQCOU7Q?=
 =?us-ascii?Q?wK+ERKNNf06tjyt16NZb66mrEJqc6y5YxBWcl2N2GPAN51lRVG9KY7t6g3Mk?=
 =?us-ascii?Q?IFHNcUTaicqEasVmB+Dk/9rpiVoCEqTQJhPPA2ktjZbIdRA+ce3STuUDlJAu?=
 =?us-ascii?Q?PMQygjWp3/RjJ1CQ/RCNNlCuPyk3W3stvoPYhKqHJeVDPVmHL56lcuWEib7o?=
 =?us-ascii?Q?X9yaa5ViXUaPE85GuWcA+z+9jHfymFgoSKPcvptJiwbiahQBZByKAU4iwnNG?=
 =?us-ascii?Q?uQ+2f/Tl6CBNe5YdbrsISRNMyBcLtHRdRw1J2kwBZC3SezCJaOd1DwDKodc6?=
 =?us-ascii?Q?GpjmRkmNVku5l/0aZhYWnRb9MNl3BYyRKCtuh1sV/xmO8wXPQRfSorETRlH7?=
 =?us-ascii?Q?9uSywviTvpxQRfGDVRuhvyL5d3ncTE7DM+uOFq36lHTmdTWiNDOaVLvnDKLK?=
 =?us-ascii?Q?HFFdUmb9l6c3x58AzuxqP2RP2h8MvjbbD/3/f21Xt4wxuIHUSG5P2ACqGaLN?=
 =?us-ascii?Q?IVVBd6P0rHWjbxJzVeV6j/fx8kEuuB9XmLJgxNK7s63xz/J6jFydXzILNV7D?=
 =?us-ascii?Q?olOm4id70dhlsCo8a8x5o+YAJRWNPZgFvmWM1UUxLbafr25Nu8iNYpMlxKhb?=
 =?us-ascii?Q?dUyi0+letYdNhgRYLSsZFz2nOKBldCzio8bnMtKSaQNe1ajv6h/IY9Gm2d+x?=
 =?us-ascii?Q?duysj7QXP8kXGV+1+tA+l7bcjwYBB+2O2Lsp9Fe5zSU3Xp65mteQTqu7gg/k?=
 =?us-ascii?Q?pf0DK+U3nqeHDx05tK/hgp7BfGQdP2+2Dm1Gmi9Vxb80+TsoSVSX9lxej8IW?=
 =?us-ascii?Q?hnSWrFfkIk7YiKZy57msnn4EgZd0SfhbzsH887grfwl0FFUDBrZ0iprB8fOX?=
 =?us-ascii?Q?Cl5gB5vEMAC9UNomi1F5tx13Titqhx8KXk+X8NRu63QTVKz8WWstr5tUQ6p3?=
 =?us-ascii?Q?pVCiuLvatLH0cVOIMFUWOakgce9NFaCqVbyA1dDmeexlQ0ymXPlcak+HD6Jx?=
 =?us-ascii?Q?w7yQTLIC/IgG5j1k+K5upTLRikGr5zqXEz/VLWK9HmjpExnBDEUYrft2t5Gj?=
 =?us-ascii?Q?vVwLVRxXNRuaWGn1eRXWM36SamK9IJQM2p2+CXq9M3gkZ57Ue9BTE8j1Yhyr?=
 =?us-ascii?Q?RdPgOTDe9gijOel/xlyr/Z/i9CUBqxKV56Q8hrME7WmxhsJje0oZoH97jb/F?=
 =?us-ascii?Q?We2SxCbEE8WQ1MzSzuUCOz/I0yJoqC/E7boB2WrMot202iNCPun4pANj5CSS?=
 =?us-ascii?Q?/LY27XEyQRVkFGmN679kkmHq51vbNHBCS3EBs1T4ucT8Sx8uKrDCjPdrQ9BP?=
 =?us-ascii?Q?rFFJAl6FudKajpDg/CJMB1UoRaAGT8imj6jPU3ERPUhzcJAyx7TsRVFuMGr7?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GeMP2NZ4Nl1lfLBi6Qj3aN1r4WkB1wi/TwQaUeqqmd+Ov6fuFz6p3LjEmALQtAWWe5p7bYotstC1q50Rs0x5YIhcl/w5GdYj2lQwiEr5Yqlc4jlwI1bZ3RylULCY/Sds2S5KXtBJvjjKyb9D3/LfGCpZX3LRrwO/XyizA5rT+BiHJwiXwRZrQFm015kEmiUokFyT0wmcxKJAj+ANBh1a1i0jpVNGmFrcmqwexCOEpcsCXMCODjAqA5r0CKk2FE44VtlliUygNFzbxcJofZwIFS66f15+wqJtxuR6G9aaEtaazy1irnYnkSdwsRzZo2NiW2g/htcxDKwu/OZyvdSYx1F+cgXSyXV5oVeQoXaitej5z7c5dvTsesGqauCCPf4Pw35n3uPVth2/nmzhlutt4N3LwW50gLN3jOSpMPZFDS95pLGl6pTBy6eOeM5HK6NSDYHuY5yJLq3oLC5LUEaWzduiX8Y9uzNQQKt7v6t7qDI+gPfTwMVfeX61SnaZbH6MJhTrRjPip4Wse8ugxP0fldC+PdVqlyjNHwxRiatYKP2xrXX76y51fYSZ2adQtQDcZ/ypk8qOH6zHCNRTDQF4p5Ba9KzYwMxpdTDvfh7yvkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882de136-34d2-4c02-1d41-08de0a79d462
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 16:59:10.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1vC2v+IkFcmaPHUHNvVVgFXttLqGKEoPBNjUCJvymrG9S62+BReHgcWcEAsIEwj3ToIxOSa8lOu7CqhhuqZnkzFTSKvXehnfPEjv9Dh+lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510130078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX4kdfrqprta05
 lq3nZ5OFdcFS6mdTRGw+UT2gAFg6MJ/TOETunb50lhzsjlgHjPb889Jrxpg6ziBuSPb/6bY5t4E
 CIgI966jAlUxLEn1AQ+16MlOUp1cVdkej404vdAmx2wgyvJUISC9ebt/WKIcTbtJllqFpjBDniW
 Mek3eDheDKBE5saF3r/zJFf+uPBsJygXraC4vWoslE0ikfwRSJVWZJYWhGeLu6CQYuYj03Rsev2
 47im9ci8R0C7tl5cs8GU1VcWz8xeiYYCO0dYi1BnQU45gkMAnaSwfKOlNFwMm30gTg4nx37AJeO
 xDywTviKcouwiJ5EyEQEM/HFbEoA3G00cfCoctiID5pqm56Qn5lXkR7bcVTzaNWPz5ApcClzseN
 iRvBuY3CUGs7qjrr/04bWkJPiU6zKQ==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68ed2fe2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=M-LluxK7W0UcZiuhpHkA:9
X-Proofpoint-ORIG-GUID: Z9Pyl-kDaQowKOYk56AeYd3nXf2favfy
X-Proofpoint-GUID: Z9Pyl-kDaQowKOYk56AeYd3nXf2favfy

Commit b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
mistakenly introduced a new behaviour - clearing the VM_ACCOUNT flag of the
old mapping when a mapping is mremap()'d with the MREMAP_DONTUNMAP flag
set.

While we always clear the VM_LOCKED and VM_LOCKONFAULT flags for the old
mapping (the page tables have been moved, so there is no data that could
possibly be locked in memor), there is no reason to touch any other VMA
flags.

This is because after the move the old mapping is in a state as if it were
freshly mapped. This implies that the attributes of the mapping ought to
remain the same, including whether or not the mapping is accounted.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
Cc: stable@kernel.org
---
 mm/mremap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 35de0a7b910e..bd7314898ec5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1237,10 +1237,10 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 }

 /*
- * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() and
- * account flags on remaining VMA by convention (it cannot be mlock()'d any
- * longer, as pages in range are no longer mapped), and removing anon_vma_chain
- * links from it (if the entire VMA was copied over).
+ * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() flag on
+ * remaining VMA by convention (it cannot be mlock()'d any longer, as pages in
+ * range are no longer mapped), and removing anon_vma_chain links from it if the
+ * entire VMA was copied over.
  */
 static void dontunmap_complete(struct vma_remap_struct *vrm,
 			       struct vm_area_struct *new_vma)
@@ -1250,11 +1250,8 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	unsigned long old_start = vrm->vma->vm_start;
 	unsigned long old_end = vrm->vma->vm_end;

-	/*
-	 * We always clear VM_LOCKED[ONFAULT] | VM_ACCOUNT on the old
-	 * vma.
-	 */
-	vm_flags_clear(vrm->vma, VM_LOCKED_MASK | VM_ACCOUNT);
+	/* We always clear VM_LOCKED[ONFAULT] on the old VMA. */
+	vm_flags_clear(vrm->vma, VM_LOCKED_MASK);

 	/*
 	 * anon_vma links of the old vma is no longer needed after its page
--
2.51.0

