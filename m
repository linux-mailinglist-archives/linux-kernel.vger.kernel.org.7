Return-Path: <linux-kernel+bounces-842744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8B5BBD71E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041D9188FB0C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CBC269AE9;
	Mon,  6 Oct 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLW3i2li";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xc7qa5X5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1BB1A9FA1
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742953; cv=fail; b=NUEsHWU6a+lDifIdqi5OY48vFPHGR/S/In5xFT4kRlJP33HlOl6MwupXbcKmoLqqwwufOSg0gCm1Ze2HNO++/QzRcaedXp2SKG8K9tXNPGEErRKUUVJofeSohNs+9j+KXpK5jKaII13U189n9yej59tPAkf9G2fcGcNybs7DPhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742953; c=relaxed/simple;
	bh=xafSVYw2tQRms3x6rIeCCx79WbmBaDFZKVE+DzOmU+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sl+zuiJZaaaYb3dR+2Q54YmS/faMzBrk/p/8rIvbaD6i5drykTfdQ3tXgzYg07Hd37pRFaw+E8piByJDM6XGejNcH/umzh6DtqnkyhT1EVGkqB6a7WunDbe1fAwEmapMBvNDZFDDM/R4mgSHIqiqjskT1Z586EzxpmMicaksde4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLW3i2li; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xc7qa5X5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5968xmQX011787;
	Mon, 6 Oct 2025 09:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=seVjb6WTbGZd0C6qsa
	gadjWpHlRjVPAsGklE6AImJd4=; b=hLW3i2liOhIO5sFB1FZtDnCFYt4BC4fuf+
	KgRZptpwsViJ7R4D//M6GV+RGSGWgqvgHCol4hdBNgIZ0sfZhURW1qFVlQgk5J8E
	/VzC2Xzrl3+3jefzRjMxLoYfcotRAc3GCv7RDUnqQplUfgKhWmpm5Nxp0tj7l6GB
	7eXNH5eNLtToVGfguEgd0H4tyC4CobCp85K2nuCFjYGHSw2BVRYQN/SgPyDDESPX
	P46rp2yM6lG4F3w5hSWmJ+3Yjb4P8N0uod561FhfUwW/HsNb038xbtmoZg73d42v
	JaoM6lj82ZN+0myowavdqJ4bBWXDWZp+x/JIty05CXGKILkp4hbw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49mar7r1xn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 09:29:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5967vBbm021368;
	Mon, 6 Oct 2025 09:19:50 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt16tue8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 09:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ3HeRoRLOLDwo41RJ0rZcXkqrUgwjC9hgLyF4wYLLTqx59ipghENb9SzuJ6Ksb+B4t/L6ZqFkT6mzeZlWErCv0EGqE05J40J3PDbbP4eVk20DIS1AltqO8R7bY/p9PKFvzI7Nf4bupXEyZKwXZvITOHf1W9wKWjQQEE2J2WQAg0dx9VR+jS1SgpJspEHMwO8KVhdtqncm8yIYxNn+yDJqTlrVNn+FtbnPnjG4F/gNisoIhMOM2pIKzhUCX/+swEfa0KQmrVLGjRiDxHxdhqLZ9clp3yPYRj/pDFlbuGwLAC/gLrMksrreDATkbtJK/26S+a52n/lMh5xdb601nWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seVjb6WTbGZd0C6qsagadjWpHlRjVPAsGklE6AImJd4=;
 b=NIZs8DVCSEjab2dOELpDgOSdVLKSeep2ryWyb/zkhgMfztaKhHUpvGI+s3orOhB60kyTjvI3lq7oj1AIVZQ4xQGuyRyKr7vgieFPf7TaQkc61eRmFZejlKOsS6BW1L7n1X9xtpJdFsogZU/87nVStoWnIWa6bTURPPIMRHL0qpZn5pUMsbv8f8350U163pR69NrmDuhVfHAGiJ7D0Q+jW86qlYLY+X2o7AXVq+0XWfZbP9W/kjOss5wkZ9VuEQk1puf2sn5C4mN/nTrtIhAexIUW+3Eb6EGjbeRpIe8enNDcVcJO00Txgwwjk7WLHBtb553Tw1WHJYLTebrDe45OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seVjb6WTbGZd0C6qsagadjWpHlRjVPAsGklE6AImJd4=;
 b=xc7qa5X5qxHh8Cm0EcHCxYhZUZRttQ9BMx+IcDLzBRr4omaXhfoYSs+bk22LQxhET39BH4aglArry8mMQ+KGjnJt67VygXrr1Nb4tTDxmrnjckxBytIx2ozjeqw8+7A9HCaDS4fDR0/+mK+i+QUUG5A5BtGxdSXsUV2Ecy8FN+U=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 MW5PR10MB5761.namprd10.prod.outlook.com (2603:10b6:303:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 09:19:42 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 09:19:42 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in
 add_tuning_control
Thread-Topic: CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in
 add_tuning_control
Thread-Index: AQHcNqJZuCxSHyMT/0CR2eymtYU7iA==
Date: Mon, 6 Oct 2025 09:19:42 +0000
Message-ID: <b12d18b040c39eb361c0f5aabf290236e3d0da66.camel@oracle.com>
References: <2025091142-CVE-2025-39751-c340@gregkh>
	 <f24f4524894417954b9de4ccec69c2e17aae3d5f.camel@oracle.com>
	 <2025100646-strategy-spindle-ae8a@gregkh>
In-Reply-To: <2025100646-strategy-spindle-ae8a@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|MW5PR10MB5761:EE_
x-ms-office365-filtering-correlation-id: 0dba1440-4280-4128-3de5-08de04b97bf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007|4053099003|4013099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0dPVUR0eGd2TSs3b1dOVDEyTUIybW14eEtXWEhnYU10U29OMXJZMGNrczlQ?=
 =?utf-8?B?T3JLK253aHlqQ012MVBKSUhKb3VpZWVHOEoyTnZWSk9QMXpQblBxVlN1TWtN?=
 =?utf-8?B?UVA4R29PaFYvZnArVHBHS2tLVTNLN0s2YytWUUZKU0hRS3Q4bnhXNWhndHpR?=
 =?utf-8?B?RzBGSmJ0MXN5OThBQVpxMC9CLzloMHkvcFVVSU1vdUZFV1BaUHBPMXpXd002?=
 =?utf-8?B?a2RZcU5mM2xhdi9TM2dWMDN0Y3M2dGNrYTdUZ3AvM3kzci9wL2Fnb05yaU1H?=
 =?utf-8?B?aEUvOUNLeEc4K2lHdHdMYkF4ZjBXazkwaWxibllrRE1VV29hdXRNZTVhMzQz?=
 =?utf-8?B?bjNTNi9oREZhaWNtMUtQS0NVQlQzQk5KYUdKVHNHWlU4M3dZVEwrSVlYc0R4?=
 =?utf-8?B?QktnakZtNmlBVTRTSVRmbmQ5L3pMbjVCRmJtZjNRNUVPOTdFZUxiSFFwVFhq?=
 =?utf-8?B?YnN1eVg3Y2JPT25neElkSGlvUXRLcG1RZWxTc3JPZTl6OEFlSTkrQmhwY2x6?=
 =?utf-8?B?SWRFOG5RcTlaU0QwZ1YxeWtjNWhvL1R1KzFDNTJ0Ymd6eDVNTkRrU0NFUThD?=
 =?utf-8?B?OXVzeXJqWDBodGNjaWpISldySHdIdHRFV0Z6U2QvTDcrUzVsL3ZrbHN4em9Z?=
 =?utf-8?B?ZjFCL1gxa3NwWGdVKzU5V2dGOFFJQ1gvWGREbnQzTGZSNHBjc2tSK1pHZDg1?=
 =?utf-8?B?TW5CaGcrK1loMG9zcklqeUhLdW9ZS2ltNVBHaU9zOS94eVdqK2dCVDVqRVFM?=
 =?utf-8?B?WlhnUHFsWlZ2eGNTMVdKdlpqSVJ2cEJjRG54U0FpelE0SUZuM1VyaDZqS3JC?=
 =?utf-8?B?Tzd1Z3VzWUZaQktRNUlxRU12OGRKVmlKSlB6R3VRcEhIMFgyRVV2QzZsUVBE?=
 =?utf-8?B?ajFTaHNJODJ4bkxZaEVpdTNiQmNhemZGRXVkdHVRbkdYRnhEQzVXTHI5QWZs?=
 =?utf-8?B?cXY0b2hiQlhXN0VpQ1Q5c2pUYlRRZGw3aHJhdEZQYXJQWCt4TXdGZHk3Wm42?=
 =?utf-8?B?WU92ZXdxczYxWDR6NjYwajNPT0NRTndzNHFYUkUrckRYWkNXY1E1bDltencx?=
 =?utf-8?B?L1Q5ZG16MGZhTi85eXZybHFrdnNsVWFiZ1UyMzJJVVNVUWhvT2NIbjY2SWEy?=
 =?utf-8?B?RkFNVFBKZ1BKbVNSWm5LcXNqcVlzSzJ5MDJtaUNBdlNqRnNaaWllNG1TTnZ3?=
 =?utf-8?B?c2NBQUlnclk2bkNKL1pGRjN2Kys5U1VLTlE0eWEzVVJTMDg0WWJuVnFpRmFJ?=
 =?utf-8?B?RHcvbW9yTnBzaHgvQlJIa1RPclFOelpJbnpIUG1MMWY0YUtLTFIybFZkRWdJ?=
 =?utf-8?B?VGd3ck5zMjFKU2Jqa2I0aVBVcnU3YXlnb1kxZnkrS3BPTE1qUlQzM3ptL3ZW?=
 =?utf-8?B?UXpwTGZicU1IMHZGWkE3aG55bWp2U1VKTEEyVGhRK1h1S2x4T2s3VGkxZWlX?=
 =?utf-8?B?TWRZR3ZUVUVhQ2NUS2ZZWXZYNVF5aTNqVVo1ZTZsZnZ0MEhXczlZUFVRdUZO?=
 =?utf-8?B?TEFwRm15WVJyK0ZuWTN1VUVrdGNxV0ZHdEJjVWNZTnF2aHdmZURCeFRkVXJI?=
 =?utf-8?B?WGdvLzlyc3VhcE1jblkxTHkrbEJtWmM4Q1hMUktDbDFOZllpYlQ1T2praVhw?=
 =?utf-8?B?dDBSbTlPdlJEcVo4SlVYYmRsUWIyMkE5Ymx2aDlwdjh6c0ZuZDJncFQ3NEhw?=
 =?utf-8?B?UlR1czRxR3dWbjVHalkxSGJtOUJzYzdNOWkrMGVSZUVzRGUrZ3JvZ2ZuZ285?=
 =?utf-8?B?SmIrTjFqaWNSNFJ2dmc5UlAyL0lrZHg3QytJdXBNZ013Z3VzSnFiNFBXczNz?=
 =?utf-8?B?RDNvNnN6dkRJS0hXWldwaWpJeUM2anZWdUNzYkIxcG94L2U3SnJLa3lpVit0?=
 =?utf-8?B?WGc0NnJrbDlxRnhSSHg3SkR4M1NPUzJRZk1HUzhDU0JvYzlyeUhOK2grNTdr?=
 =?utf-8?B?VC9UV3FpYXBBZVlJa2xnYTc3NklJQ296TXZ0dEhVcmJWN3FTR3FhaWJjUnpl?=
 =?utf-8?B?VkViZzgySTBLSlVBL2JoQVFkMVBRVy9wcUNlbW9LQ3c5Vk1pa05iMFVvNFlW?=
 =?utf-8?Q?a6a2pd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007)(4053099003)(4013099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEMvYkJQSW15dGl0QlBxL2U3UkpKUjU5R0pzZDdUZmxhZWI3eGd6MGFRenQr?=
 =?utf-8?B?YWFhK1J5azRlQnpId0JWTUF6dzJVZlRsVjl0b1RFR0ZmZlRnSGRKY0VDTThi?=
 =?utf-8?B?a1R1ME02SkprMG5SVEVEZkFyZmdObUN3cEU3d0JSN2xNOEk2SzMyY01WWFAz?=
 =?utf-8?B?WGxmSFZGNVp4d24raEtVYXdDdzdYSXloVm1oalpVb01pOVlMWDljQ3pyZ2pw?=
 =?utf-8?B?VDBhbjZma0lua29sekpaLzcvTU1qTVVHSFBaMG4wbG5DM1ZFMmRHNjNRQ2ZI?=
 =?utf-8?B?MUtlU1lCSytyUXhaazlNRmk2cGQzTndWVHhQbDJGbW9FMGhkNTR2WE51c0ky?=
 =?utf-8?B?NG02dVFJcjQzQm9ENit6dy9nQi9WZlRZU1ltbjdqWTJYMzlFQ3VEa29HQ05R?=
 =?utf-8?B?SHdVMi9TeCtRLzk5dzk4bXllU25rZWpLenlmeXlCQ2FwWVYxd25vYmRzY1VR?=
 =?utf-8?B?OWQ5LzdxUDA4cFFvdEgyM24reUw3b0F1N1FQb29pU0Eybmk3VkExY2E3ay9W?=
 =?utf-8?B?cmZSK2Y4OE9nV1cwWFJrcWFUMFB0QURGTWlERHVkOU85RXBsd3JMeXFNblVW?=
 =?utf-8?B?VXp2dFJFb2dINlpSeCtrZWRrQXRQWUlTRWNibGhOT1pGTGNDU0cyaEEwVlBT?=
 =?utf-8?B?N3RJQzFqcjNHcldjMHRrcWZkZDhHcUgrcEdSVXl1b2U1bS9paW5rVzNjcDhq?=
 =?utf-8?B?WkJBV280Z3VURHNoV2R0MVo1OUxIRkZUYnhrdDdidzF5U0dyajlKLzdtbHp2?=
 =?utf-8?B?UlBaeno3SC8wK1JkZWRjT2J0Lzk3U2dXMjA1WkFBY2tZRVBWdVlCd0tSNFNV?=
 =?utf-8?B?cG90cWYwOGJ6V2ZPQ1FKYlU5RllFQUZhSDZtMVlLOTFoT1ZWY3p3c0tWTFRO?=
 =?utf-8?B?RGZZUGdKTlh6MWwzV0dzM2E0OGFueVJNTVVZR0V4U2JHWlVuallyanNVUG1I?=
 =?utf-8?B?V1d4Wkc5cS9PY3FGRG4raUk4c1hTL3RlenBBellCL01YWDJJUE9jaVlqTGow?=
 =?utf-8?B?aUtuNHJFaWNEaFhsMDVEWVN4MDN1bFpZWFJiQlJpMjhseWltb1BneHVNTFh4?=
 =?utf-8?B?dWlDd3diMVNwSmE1amoyYWVweFpTU1FlcExYMXpWc21KdjFZeDU5Mk5JejYw?=
 =?utf-8?B?cGlXalo0ODlCbFFxVktVZlRCYzRLVGFnQ2lQLzdkVmdnYzZjV0FaOVFKS1R5?=
 =?utf-8?B?T0VRbThjTHlLbjlLUkNaR0ZvbGllL0Y1SHMwUzFzb3grMENMekhjR1NCQUJL?=
 =?utf-8?B?dFl5eUFoaURaSWpSRVQrcTM4eVZrL2hQdloyV2V6b0hsdGM2THNGQXFIN3gx?=
 =?utf-8?B?NzJXVzg2WkwvbmJKb2piRmZrOUY4UnB0WHlORkRUMVVDampUbStiTEZCUVdN?=
 =?utf-8?B?bUltY1VQOHFhS2JLSEVPaG1xMHdtcVczQUMvcUh1bUoyUVRYcDhuemUvWXVM?=
 =?utf-8?B?dS9DcE9WOHZQRnNibVJIYkNQY2FmWHhUNFB0R21lbVlUZlRhWERYNmtxN2U1?=
 =?utf-8?B?Yk1WTkordU91KzFub3dtNmtjM050cmFQbVJnZXp5YUo2alRHQ3NCNVE0Y2ly?=
 =?utf-8?B?cUE1Q1hrcktIQVZVL3dKQVFBT1VXRThEaDBzRlNxOVVCSWxEK0ZDTFBJeVNT?=
 =?utf-8?B?N29YTmJVVzU2TnVkYzBKSk1YWFFHS211cDl2TmMrNjNRWlE4SEU1c0dMMlBK?=
 =?utf-8?B?bXJFMDhlZU5UWEpHczh2OXo2UkdqdUlvTmFqSElHdU9ZWDhvZ1JHbnAyUTVF?=
 =?utf-8?B?U0g1L0dZY215clVYaW1vT1FXdndTc3hScmtYS3B1cFNsMjRGVExYdk1NK2Fv?=
 =?utf-8?B?VWlrcWNQMk5Vb0R5RU9DaEFoRHVCZXZta2lwZGgyMGFwSUVuSzcwNmRBMnVr?=
 =?utf-8?B?Ujh1aDRkbjRDeXA4U0hMdTNNd1hpeENsZm1FUFJHcWljRm95RUVScjRxVEtY?=
 =?utf-8?B?UEkwUldwZ2IvTFlJNnk0b1EweHFtNU95b0hOSGR5bm96Y2VidkxOcU5mbTly?=
 =?utf-8?B?WWE0ejgwcXZFaEFJazF0L1dkVzRpTDliblNBL0wrcVlQQnVSbnhqQWdyL3Rm?=
 =?utf-8?B?eW1mNll6ZVJUcjBrdU5hT0hCZzRFV1hMMDdMYnhoN0dVcGpaVXp0a2x0K1Er?=
 =?utf-8?B?eHZHWG5VRDc5UTMyRzBDRzhMQ2V0ck52d2IvSllVaVVMRkZPU2p3eUc3NFV1?=
 =?utf-8?B?RFJEUVl1Y2tSQlV5N0REVzBvYXZMS3VhOXdSV2xjSmhoYkVqVDNXeCt0OU8x?=
 =?utf-8?B?bDRaNVpXeTIyRGR1WU1jMmFPVzh3PT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-+qZktK6ESfmiOHGPR+Ry"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sedlg8FOEyjESkZQ9t1uChGSixltIVVXaCcwg3XswB+CvNsxyiqF8ynewbhILvZi3J+ffd6YQIzYhs6W3qugN0VWkTruvuRGClbPUgJMSuHxsBOtcCvlzrxM7i/81Xo7XYBludcuQIlPZx5n8fla0/dU+HN0DxNDykZhCyB8OgKUWQlo8t5jowSZpGEY5DDupH38eaY2nwdjgqNlSvw4gJF4VfJb64y4mQ/EOIBi41/R55MzMhmBTAvo88x4XXq3pZbNFcIIHhAWnXaoZAXbkncOBKjg8TS4Aui0usb72jQ9MJnE/dVN1A8sfuKK8uuROsCxVBUOSN+9uSpVCHdQL7fVRctRf0v5FzwikLs/AKJGm61So68auX+0GuEXYouZsAz3OE4kLuj5cM+gQKdZK/6AwGgzIPyAYYs1O99YyyitbJxyTUx1KVf+O5YcBDV5a9ObKkNIOGA3iQuPMtbNCZ9zEUjpFmHcVICijTYpfcaa0Z5VWGEy7OKmhpLEdtPm5SC25FMgjG68WW7VVCaLYEM4FZoHZiUVzzl0oT5rL3ZwnUr4l5X7U5y13KoxroPj63p68eYY6JzVV+l7F+BUYwnUlKtLH12+IbETLaw5QuY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dba1440-4280-4128-3de5-08de04b97bf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 09:19:42.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6hbpxw9b11ySb9N2+G/TNnM1mhRyaF1seEoPDzFLD1tsE/t2uIHBvcIUu2JW5ptLjC4xH4lhWzNLNSwAlvkNr+jN78Z6dFHFspKmYpM9iA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510060074
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDA3MiBTYWx0ZWRfX6tZlPDnDR4Sc
 CGtqOaIbc2zUHYiXjEInCY5+1rXmF9pANsAo2NTA/9Ecj7gfLxrO5D54Jx09yWd5Q7gPWTahqW6
 xY0wpDJfoJLzP6o9/nENRX7FbUZU46102SDxG5XZbYH775IIrbtxO0gt+xd6TShMBccGYxud5nL
 5erUQDjXIFwN1QVA4XPBAJmn4pLhop+GKM8tx2YbhGOk1zUJtwB+81QfV5FiZ0lucePm0TA+f2e
 Z8MILfSY553GxWO+vINlqnt/dcEAkFUpxnzrtI0A47l0tKs6evwLt0JHfDWjqzV9ssnPQja+MaF
 hJJQt67uQ80f/MXOwWIdGT+Gat1xfnazkyp7kcrMI22RLhGie0zULqaX0kKmLQp6ea3D/gB3sLI
 O4RF6HTB9cM+8u2Ea7XOuDtjq3HjAw==
X-Proofpoint-GUID: wg_lMy4jiCf5rvQx7qOGnY0W9ECuOfHH
X-Authority-Analysis: v=2.4 cv=G/AR0tk5 c=1 sm=1 tr=0 ts=68e38be0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=ag1SF4gXAAAA:8
 a=gsaGz37JQqvF1Ji1QfkA:9 a=QEXdDO2ut3YA:10 a=56lgg1AOmzJTZHvT7MIA:9
 a=FfaGCDsud1wA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: wg_lMy4jiCf5rvQx7qOGnY0W9ECuOfHH

--=-+qZktK6ESfmiOHGPR+Ry
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06 2025 at 13:44:23 +0530, gregkh@linuxfoundation.org
wrote:
> On Mon, Oct 06, 2025 at 07:07:00AM +0000, Siddh Raman Pant wrote:
> > On Thu, 11 Sep 2025 18:52:52 +0200, Greg Kroah-Hartman wrote:
> > > ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
> > >=20
> > > The 'sprintf' call in 'add_tuning_control' may exceed the 44-byte
> > > buffer if either string argument is too long. This triggers a compile=
r
> > > warning.
> > > Replaced 'sprintf' with 'snprintf' to limit string lengths to prevent
> > > overflow.
> > >=20
> > > The Linux kernel CVE team has assigned CVE-2025-39751 to this issue.
> >=20
> > While the change is good for defensive reasons, there isn't actually
> > any buffer overflow as it is to "fix".
> >=20
> > The largest string possible is "Wedge Angle Playback Volume", whose
> > length is less than 44.
>=20
> Thanks for the info.  What was the compiler warning about then if it
> could detect just how big the string would always be as these are static
> values?

Probably a false positive.

GCC docs does say:

	-Wformat-overflow
	-Wformat-overflow=3Dlevel

	    Warn about calls to formatted input/output functions such=20
	    as sprintf and vsprintf that might overflow the
destination
	    buffer. When the exact number of bytes written by a format
	    directive cannot be determined at compile-time it is
	    estimated based on heuristics that depend on the level
	    argument and on optimization. While enabling optimization=20
	    will in most cases improve the accuracy of the warning, it
	    may also result in false positives.


> Should this CVE be rejected?

Yes.

Thanks,
Siddh

--=-+qZktK6ESfmiOHGPR+Ry
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjjiW8ACgkQBwq/MEwk
8ipTug/9Fsmzr6OYhT2VOoi6U7vY9QS05l2ayEBB8RjkmxvhzAA51geau9LBQr6Z
3IM+ww/ENJe5qty8B55VuOhI0lU2beQ5d/DlA9kjXNtcxfuuJbT7cTJuzxKlUDyL
V0YhcJjhX63QFmonPVlFW/CktWVV8sSJfU7A4mflG9jfAQyiXV/BPo8ZwzQ/D7CF
YZdYpk+axlUZ1iUIJKEAqy9n1/jT8LfaSF+8aXjyeOvNkMfI+8kGNX3S1RLOafVp
JIc73kRLiziH2EpU3C7LvDeUhzikSnn9mD0KRgb9xNoUPaFMrklbKXAmup0/WYlO
otcU2jEr+IcuWyiNiIBk7zg6h1uTOMmDoDk3BZHmKTC3dX/DEq54F2jkXfnFsVIh
ZrHWaiWOZOLtjpKCjGIEfxbHm38SiUp8qhbXOifxYGffy3WZWmE+YkAwieTP1YRk
Rqnwtv9vk4aNHoU3z+EO8NEnyQLSUxZ1oMvhQCIdDoeUcw1i/vq0gtBGaun1SOYj
4JAMdgc7QtWMnl1rc2h3nWVLM7VeYcjOzpJwj6uAP6atGvuhNreQk644x55tpaPa
leOhTovEOu/oTqqzDduZQ1ZdA62lC19gbrsYXINU5USDOmiH8oqxy/CaNHQQOhmn
0KKNNkGCbKDgU9f0V5KRy+KLIeMZ6Q0DWV9pn9ggZ1CjijT5GmU=
=6+j0
-----END PGP SIGNATURE-----

--=-+qZktK6ESfmiOHGPR+Ry--

