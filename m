Return-Path: <linux-kernel+bounces-759281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63344B1DB7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F79F16674E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978BB2676F4;
	Thu,  7 Aug 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LnSp6Ra3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NmWCv9/4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A591E5B73
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583358; cv=fail; b=PBiRT32IxdjyjqaE8sRQ2bzCFpjmj6xRR4nEfdG/hiacghQTAhURr724Y7HrUL1ZJQupXs4eteI8FfMoY/xTEyFe63Xg0ePpf04Hg/2VK7R+ee2+LTLSb7ou4rldynIqJHMqiKO1nmLO2eeVH0fqby+z73PNE4cGcfFWs2GNqAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583358; c=relaxed/simple;
	bh=KiJHbYiVebakCVgYrYoRiONpcAht3sBxmMmuyjd1OtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bmXxxZ8oN1HDGpkUOWHShjnBjaAn0Kb2LkFrLBhgc6PQaAt+cy93KA/JZzU9YFJMWqZ8UiEYIFNt9RjYMJGSPA4AH6EZZ9Icf0xEryKRwcMtqanMBzyQvUM/0Ipw5F6bHyQIe/Ec0QDsY7kNabV1aeuR/VkZ54s0zhqDSNZYXww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LnSp6Ra3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NmWCv9/4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577FQSRx008758;
	Thu, 7 Aug 2025 16:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KiJHbYiVebakCVgYrYoRiONpcAht3sBxmMmuyjd1OtA=; b=
	LnSp6Ra3QBbx/D2J1D7sL0/JYEb6bfCaL+ZfpAj3wQmVoE0hpanuQBXww/EAtVAG
	YRk/WZFNfHukBGEvy2wA9Vrbe4HFpt+2cdMJPTC3/N2OLH/OgDkl0mZqbFUf5qYA
	VLBtgDnKgONZK0g9PNveEQMahpurYDYKBH7UsR3LFmBNSBj3bGLCAQI/JJJPQ2nt
	A96GoZCBQHnvrzv02kVlCwx9BTG4Gn68rMBbLvu/UroW8z3MAhiNggqzoSlzOguI
	FliJ0t3XSSNH3cxZOsitghxDFeFt+Ietjh0K+rfoBqyQOZSYAEX2uz62req4hUvT
	YeIRQNhQHMI1928wt+/c9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf4fav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:15:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FtVIF027106;
	Thu, 7 Aug 2025 16:15:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwpmf63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWykZ/3lVa11X983BjqTtPNWc//JEq6q/5LpYYYck3iyKeJ19YCbrfd5m39/9ddu+XssoZxBJKrTa30Qsyud0DBZtdILmYk+AwA2jgKakPAE06ohRYQQ/Uqo3Xn4mzbT8cebge8Rd5fksJ01NOc0MvRgIKsyPWeEMDRgNRK0qEVLjiSIeHebdi2k8UUV/Z4rpLxVNvaNX5cnd8jM62F7uDa52g/UcgPtBx5iKcjXpUDjHY7kbWW9S5IdqSNKspJQcXoN0OyFt9v2hoCqk+F76SIMvlKDStdIx48nwk5hBhabHDHO9c8qmVQr2e/+mXi/XinArNg8GQmYz6OR0CMjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiJHbYiVebakCVgYrYoRiONpcAht3sBxmMmuyjd1OtA=;
 b=naIIi7y8zGLcXearQj5Pzdvqr0yxn/Dh2vLDth7MZ9aXlQ3UKMdOVAuWSp/Lu21zX9f2gJdG8cLo6zPUUDSya1GAwV0YyXNYWBfKH4LYrc7yOI4GrsyKNpPkz6sOaxzuvd5eOC3ZJKp2VoM/STWjqe6LV8xGoQY3+uR0I4Wz+yC7/4Hn0x3ln3cUhUa8JYDJqK+wudsIXXI+dbknm56F5f7MRWNnEfttmub3YPOqp7w6yXH4Iinfj9QBDyz0eteNFZHh2cJlpom+5IcSid7UHeNAjuNU+0NbHh3xqAZ0KULP/fO53P1n1xnRIDv26YizpCA+j/x0+MYxfgBVPSR/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiJHbYiVebakCVgYrYoRiONpcAht3sBxmMmuyjd1OtA=;
 b=NmWCv9/494z8/sKGEvFW0d6zkCFfIyU7puVszn1boXFq6kJJyjkuD++Xis3srea8ci2qG52ncNaGphEOWH04cinTvBHmJMYoPlGfXTsGXTkAnS7ySedCaHrXhgexx7oqzNZtKY3jnVx+MyDXTVPuyGJuFyIG8frQsEBxCqlwt+4=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DS7PR10MB4911.namprd10.prod.outlook.com (2603:10b6:5:3a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 16:15:26 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 16:15:26 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Thread-Topic: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Thread-Index: AQHb/LZRWD4e8xW/kUajTV/4QLnjF7RXPqwAgAA00oA=
Date: Thu, 7 Aug 2025 16:15:26 +0000
Message-ID: <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com> <87a54bcmd7.ffs@tglx>
In-Reply-To: <87a54bcmd7.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DS7PR10MB4911:EE_
x-ms-office365-filtering-correlation-id: 7d2f660f-f52c-4c98-e7a7-08ddd5cd9ebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlhraThQYXo0cmM5U1NRUkxSakdxMGdBZ0N3aEpXcUFibUNTSUw1dDZvVjA0?=
 =?utf-8?B?a0ZXeXNldFRhbEVQeW55ZURVNHhrMVJDSG9PSkl2OVFDSmNnc2RMVHhuR3dT?=
 =?utf-8?B?VHpXcENGWmMyMjhLMmpkdUswNVE2RkhyaGhDZFNkWDV1T200RHlnNy9HZGNV?=
 =?utf-8?B?T0VVeG9nU2FrOXpETGRqYit1bWJBRWJrYlRhaGdBVGNrWjFJVDkxV0NjT1dU?=
 =?utf-8?B?djFENUU3U2w4U0wrZGsrdTBUeEVLUHJhZFVvOGwvSzU5b0ltTXZYZlJWQVNm?=
 =?utf-8?B?OW5LNE50Ly83YnZFUUU5QkMxMTNvTlZpV2h1MlJBUVdmelhUV1FyWmFUMm9W?=
 =?utf-8?B?QmNZQW9INUZ2dzIxTWY5TURacXJrTVNJV3dGVUpaUDB5cnZuYVVFK01vQXhy?=
 =?utf-8?B?U01QTFg2M2Y2UHJaYjNLN1BDRTJPY2NHaXZlbWUyWEZXUVE0bVlXanpWVDJC?=
 =?utf-8?B?Wm1MZVR1c0hBNFpMbWlFOFVPaEZEd2wwbU01cUljYzBKS2ljM1dIWjB2K0dO?=
 =?utf-8?B?NXlRSFJuN1ZGUnFRUnBQNkFPMm9uVXBMcmNNdENUeURPYk5xSjRTNXljYkZK?=
 =?utf-8?B?VmQ4bW12UzlNUXVJRnBSZ3YwNnVBaUFheGlHWTJpRklLTTJvMmRwMG1oZ3VO?=
 =?utf-8?B?emNySGFOYUpZZ1NDTnpranZzQXhOdXNlNW1FWHFIcm5yVGU0WWluVEMvWjIv?=
 =?utf-8?B?cW9vWTRxMjlWdDZ5T1d6VktnMGQzeFdLYnYzUlc1dW1iOWlXSXc2dTVsWm1u?=
 =?utf-8?B?T04rcG9LSGdWbTVZK2o3TTF2eFVMTzB4RUxaZFdiU1VHZkFweFA2UjFXWmRl?=
 =?utf-8?B?anZqWFRxUDNKVkJtTXorU3lBRno5dlVZQjgrVGo0Q2tkTytVNEhiTUdFVFZ5?=
 =?utf-8?B?WUkwZW5KdHlOb3VYRVpTVFVmL01pT3FUVENXWno2cTA5TkRwNTBvRGozT25m?=
 =?utf-8?B?djBPV2FCV25RdXo4RWk1SGN2UjhUNEdhZjZxVDQxK3NmTm9QMVd2UlhtWTZ5?=
 =?utf-8?B?dkgxMm42ME9xRVJVdDRBN2RZRGxTSkt6QTZINXVZQW95UTFVaHhPMjN5S0V5?=
 =?utf-8?B?ejhXUEJJUXA3U3VzdE12eGk4MVpzaEdlVlNLdGtrM1FXdXRMc3ZjeldoblAx?=
 =?utf-8?B?K2l3bkF3eHFvbFFtQmpqeW9INDZES3kwMThHckVCb3g2RlpFS0hqSlR0NW5O?=
 =?utf-8?B?L004N2VHUlV3TS9YcGVXbFhrcnBpMWtmRGJhelJWU0NPMm9aV29zcU14VXVu?=
 =?utf-8?B?WTFlZXcwUXM5Tmduby9YcTdrZ0xGM1FhYlhENDF6QVFwdzJOMzRwbTg0MWgr?=
 =?utf-8?B?K0dtNTNaSlAzdVhHY0lFSjQ0bDAwMVNJME5zdVV4TzdiQlZ5blgzYlNCeGp2?=
 =?utf-8?B?TlJvaU9EcjNUR0RCWllmRGZnaWlHVHExQWh0QzdNUExwY01hNkp0ZEFFbTNh?=
 =?utf-8?B?T3VFQXhjNS9UZE1MVDlZa21PQ2tCdU9RVWZNS1MzUXFuSWJJVmE2RU9JV3Nm?=
 =?utf-8?B?akdQMjdicVgycEhRbThkd0xUT2JXd1BSZEI5eUhoTDVaSGFnaFFHTFlNckFw?=
 =?utf-8?B?T0dNRVZrT2J3YXlRbnNPQitOREdEN1RsTVo5NE1nVTg2MzhkY1B2UVFDTVVD?=
 =?utf-8?B?OHdrYkwrK2hGbE92VThHL3JwYzVvTTk1UFF2YlhONmRCT1F4RXB2ejE3Q1NI?=
 =?utf-8?B?OU1hdkgrZjlnMGtCamNqNUlBTWgwZmlPU1BLYmZJSU1kOVNHU2puOGxRejQ0?=
 =?utf-8?B?YUphaXMxTGZ2WlpRWklZTDNtTXlpQmhsWlRDdVVsbWtvYVhMcXk3anNPc293?=
 =?utf-8?B?VUg5WnZtSm9zZmV2bUtHUk03Tko1SFdUMVVDeEhqNHdZUDdpRUZGaHlPTGtq?=
 =?utf-8?B?MEhibitlYk56d2VWUXU2UE5yMWcwVjhMMFhFN1I1T2pBeWRqRGVOQSs4VGk1?=
 =?utf-8?B?NXFmelcydTlVQkpzRXZrRHRGdmZBUS80OVlYaUVmeHZxZ0JpNERsTm0yNmk2?=
 =?utf-8?B?ekdPU2VsUXl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmRsYkp0K0Y4blpKaTdaWk9IRHpTQitwK05MNzVBQmtxQmN3bXdMYlYrRDB5?=
 =?utf-8?B?a3RTcThkeUppR3IxOGMzbUhYWFY5ejFMVkJCRmE5b2tMTWViOGNBOUhpTnlZ?=
 =?utf-8?B?aThxTWhqOGdtVzlDRTBTWGszcVRhMCtLU0tPWHJNemNLVUhEc2hSdlFEVC9W?=
 =?utf-8?B?bGo0bndNYldCb3FaTi81SmNoeENFWEFLYXRXZUVmMXJLb3ROdW1Na081NE1S?=
 =?utf-8?B?Y25yN0hGL1dqTG9VTlhMUDdXNHEzWmU1SVQ2UkxqRHhtZElDcWp3TE9SZ2JK?=
 =?utf-8?B?eHo4d1BYVkdoWTZ0RFAyR1p1VG5GUHBwMVdTWnBVdEgxNmk4NG9xM1I2Rmlm?=
 =?utf-8?B?dTY1cFRlbDFVb3V6a2pMbHc3dGhSdWdtVkhtZ3lQb1dnc3FlbXRXbXBpNUF4?=
 =?utf-8?B?WmZwZ3AyWU5xMHNHVGwydTZHbEdmMGFRVldMU0NDV0hJaU1hZ3BLNHltMkpT?=
 =?utf-8?B?RDZSa203eUZ1WGVRQkdockVNV2p3dXVvS0RzbWxyZFpoUldDTWtBVFkzdERE?=
 =?utf-8?B?OW5qdTErYjVNUTZ4YmR5U0FsWk1IVmNhaFBtakhIK1MrcjNPM1AxWmY1d1Ji?=
 =?utf-8?B?blNadGhBeVBVYWJydVkvYmhFMjBvTFNLdlppTXpsZjdvYjBSN2hCVythaGlN?=
 =?utf-8?B?RVJVb0o2Tlp5bWVLNWhOZEFXSzVzNGtReFBiQ1d1QitxWitrQm5ZSWtkd05U?=
 =?utf-8?B?S1Z4UldQYWozbEVJUFhBUkdDdnE5QjlxbEozZXBXODBlaGpYaWlxaXhhM20r?=
 =?utf-8?B?K0lhUjYxZnRqSno0ZnVacHIxL0poeFVKSnc5dU1NMERXRXBuZ0pjdC9McDVw?=
 =?utf-8?B?SzU4em5VdERuU2YxUk5oQmpaUzF0YkVTOWFjWnBjSFplN0JZU2srcW5YUE9U?=
 =?utf-8?B?SXFsTW9DTjFJQmJqWG5ocVJJN0llaEdNQXp6anZFRFJwVExRL3RtdENOV3Jl?=
 =?utf-8?B?SlF6c3pWZVVwUllpNlkzcHRZRGErcVBMTEppVm9ldlUrZ0cya1BzbjRyU1FE?=
 =?utf-8?B?dlhxZFR3dW5mbHhqRjgzVVFtQ0VlQXdLeWVza3d1VEd3QlNOSG9ValJ3VnBO?=
 =?utf-8?B?UEZYenVydGFmand4dk50UGZ0cURPa3lLSU5rdmc2b2JMcHhSRUJJQjZMYkhK?=
 =?utf-8?B?NzV2TTF5VW1pZjZpV0VEbis5U25BUDNoNk9qbjRWcjZ5S0l1eE9yb0hTQ1M5?=
 =?utf-8?B?RXVvR3AxbmNuYkR3U3FwS0diZXM1b1BWVVRjVFB0enBpTVRNSmtPQ1VDc01H?=
 =?utf-8?B?b2l3a1RuVkFmZEpaSUhEOTliVC9aVFJKMHN1enhYL1J0WjR6ei9Jb1FsQWw3?=
 =?utf-8?B?MXg5QmRjblNVSHN3Ry9uYzNoQ3Y1RHAwQUtxUjBwcHAxaTU1eStjZHFFSW9E?=
 =?utf-8?B?empBcTdEMDhac2I4SnFxazZOZFU3TFlEbmtleEJWaVErVFBPSXA5RHRGeTVi?=
 =?utf-8?B?UjRSMUtpRmhPcHdGU3BQWGRoYkNabjQ2c2ExalV2M3hOU0JFem50ZjluTitn?=
 =?utf-8?B?T1VsRzZrd2drd0gxTGNpbUFTM0R4dFJ0d1I1bC9OeUtCT1B2dHdXUko1SXF1?=
 =?utf-8?B?c0NXL21XOFF5YlJhbjhVMGRCVFpTUmcrdno2VDMrcytnR2RTeit5TUtNN2Q1?=
 =?utf-8?B?MHFYb25BeWtIZ04wS1BsUStzQW5vUXNuNThzT0M0V0lTajN6aWZpYUlWNkhX?=
 =?utf-8?B?c0pMci9NU3dvTDlUczI4dEo1SE5iWC9YV1g2aGRoZDk2eTFCOVE1eVNINmlH?=
 =?utf-8?B?cjVLWDIrTkQ2b2JQeG13enc0U2o4OGI0RHBNaGFXVkRheHE3bzdDRGo4YUh0?=
 =?utf-8?B?YUFNOWsrVWhBZHhPM3ZwYnc2NmN3c2JpdVJIWUNCTFZHM3ZtWnVuenZJeTRx?=
 =?utf-8?B?YlkxOWhQQTkwMzNKdVhrTVJvMkE0NmRXNGpYRkoxV2ZXQmQyNUgzdGszemQx?=
 =?utf-8?B?Ri9EL1lobTZzREY4dGFuNkJrM0JUNWh0RHF2RVg4OW5RSUF5eC9UZWp4STNP?=
 =?utf-8?B?cWFLT2NGZE50T0pvSXBZREZvSElmelFudDhkWnF0UVpITXI5WTlieEtLa2V6?=
 =?utf-8?B?SWVRRTkxYm02dGZhcjIyNnl5aytiYStuV2NmUkhRaURXNE9VVm9URWtFVW1u?=
 =?utf-8?B?Y3ZuSjgxYkgwcHF3MXJCQkRxQ1NhYm5qTFJFNkMzSkR2dmtObkJTTVNYdURU?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7707942235BA7445AE85C6A339203E82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ivf34e7WWCYapyE+mCBQOP2TWSenhuHdzUe3R/XF+mnjgI3bRZIh5nYO/V04G/GfY8RRuRofA6gf862nZuHnr7MFi1tNgAJfcn0polI1hHv5f17361eA4A1gXmewL7YsjKAkCCx/iIWFfPdcwlRCqpKFGmUUAzytsS01dWgBzWGyD/H72i6s0/c38ApRpF5C+3Alsda43B23VaQ6EK3zY1io0mQrYwcz4JjcYgvlQHHejHboCPZwAnkivvxHzez65nJU1puJq1fmsXwEfr4dTwcjQBsx8QWHnOXxOuX+qHrjTagVp7KME4UREpaqp4T6O0+lzMcHHbUWPvmcCzqu0L8OywUp8aH+3FCZDika4YahYOgSUVqasqUz2h2r6KfVRobwIo12LOK8uZplBTio6lBfW+kzUZbv+UrijW7GaDY7CRnq184sc+3cLXof9mlyHPYo4LxCZivKHDfPPeKNGLTJ6ykl6ajr3nQUyBZrlIRMONE4CQSA2/exdKCg/Yx4QE4q2Mh5dVBkPYLddlpewrXOLCS0AyQJcJBYXZvL683/NrLn6wyQPA0VumWXQZ/GGPZPGtsToqbnol3yzBd4LkGKA+P7QI95KBPxxnkBDiA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2f660f-f52c-4c98-e7a7-08ddd5cd9ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 16:15:26.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qY9/yNzSN89/zA6re0MndNiWb7wk2qBv6Rq/LG7Qp93yoKYuc0+68Zqm9CGPY5k+XgOAsQqd0qsIrplrbSm7La5bzJyDgbqkwKqOBnuCzwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzMCBTYWx0ZWRfXwawD75njanT5
 RunW88xN/C2jPoqDlBJ0IKYaXS+BMybHILmFZIjWKbDTDBkEuKAfy9r3jAbArEGd44sTaIiH7wg
 xlMDPJrAC5FEvCgj/VHo5hyqe5wL4dSjJn/7MRMtZsfq6vL+kr7lS+gzxHPJc0NXKvPwECqTBlq
 fB68EhV2qgIXOpxXOt+iCxq8FR7O9pxFRaJ1h1OrO0SLgmbYrN5MUPv6HroPF7eqB+82u3q7Q/N
 3kBBWJTZEpUunDZI3U5zwdo3wbps6tI6nTBMgmy61jwZYl/xSoMK1zoJRG1lD27K6eR8TLwOs/s
 MFTyTCt+WQ6Xd/IWfXk2W9l+1u58DERuxabnjQ26sH5ye94QWmBJeweVxeNl9UVsiDSkdvGlKgI
 JNf07PJd2fWqANXyCWWjl9dSAVHNL1vky+vbX0Hr/ZgNegyeU3mpHadUPpyUwXbzfeREPIlE
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=6894d122 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=puY78so4GJjFJ17zYcEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EundWYk3GP06X7_ExvBxo82w4jHtcdUx
X-Proofpoint-GUID: EundWYk3GP06X7_ExvBxo82w4jHtcdUx

DQoNCj4gT24gQXVnIDcsIDIwMjUsIGF0IDY6MDbigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMjQgMjAyNSBhdCAxNjox
NiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4gDQo+IEluZGljYXRlIHRoaXMgdG8gd2hvbT8g
Q2FuIHlvdSBwbGVhc2Ugd3JpdGUgZGVzY3JpcHRpdmUgc3ViamVjdCBsaW5lcw0KPiB3aGljaCBz
dW1tYXJpemUgdGhlIGNoYW5nZSBpbiBhIHdheSB0aGF0IGlzIGNvbXByZWhlbnNpYmxlPw0KPiAN
Cj4+ICt2b2lkIHJzZXFfZGVsYXlfcmVzY2hlZF9jbGVhcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRz
aykNCj4+ICt7DQo+PiArIHUzMiBmbGFnczsNCj4+ICsNCj4+ICsgaWYgKHRzay0+cnNlcV9kZWxh
eV9yZXNjaGVkID09IFJTRVFfUkVTQ0hFRF9ERUxBWV9SRVFVRVNURUQpIHsNCj4+ICsgdHNrLT5y
c2VxX2RlbGF5X3Jlc2NoZWQgPSBSU0VRX1JFU0NIRURfREVMQVlfUFJPQkU7DQo+PiArIGlmIChj
b3B5X2Zyb21fdXNlcl9ub2ZhdWx0KCZmbGFncywgJnRzay0+cnNlcS0+ZmxhZ3MsIHNpemVvZihm
bGFncykpKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAg
ICAgICAgICAgZmxhZ3MgfD0gUlNFUV9DU19GTEFHX1JFU0NIRURVTEVEOw0KPj4gKyAgICAgICAg
ICAgICAgICBjb3B5X3RvX3VzZXJfbm9mYXVsdCgmdHNrLT5yc2VxLT5mbGFncywgJmZsYWdzLCBz
aXplb2YoZmxhZ3MpKTsNCj4+ICsgfQ0KPj4gK30NCj4+ICNlbmRpZiAvKiBDT05GSUdfUlNFUV9S
RVNDSEVEX0RFTEFZICovDQo+PiANCj4+ICNpZmRlZiBDT05GSUdfREVCVUdfUlNFUQ0KPj4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9zY2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQo+PiBp
bmRleCBlNzVlY2JiMmMxZjcuLmJhMWU0ZjY5ODFjZCAxMDA2NDQNCj4+IC0tLSBhL2tlcm5lbC9z
Y2hlZC9jb3JlLmMNCj4+ICsrKyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4+IEBAIC02NzUyLDkg
KzY3NTIsOCBAQCBzdGF0aWMgdm9pZCBfX3NjaGVkIG5vdHJhY2UgX19zY2hlZHVsZShpbnQgc2No
ZWRfbW9kZSkNCj4+IHBpY2tlZDoNCj4+IGNsZWFyX3Rza19uZWVkX3Jlc2NoZWQocHJldik7DQo+
PiBjbGVhcl9wcmVlbXB0X25lZWRfcmVzY2hlZCgpOw0KPj4gLSBpZiAoSVNfRU5BQkxFRChDT05G
SUdfUlNFUV9SRVNDSEVEX0RFTEFZKSAmJg0KPj4gLSAgICBwcmV2LT5yc2VxX2RlbGF5X3Jlc2No
ZWQgPT0gUlNFUV9SRVNDSEVEX0RFTEFZX1JFUVVFU1RFRCkNCj4+IC0gcHJldi0+cnNlcV9kZWxh
eV9yZXNjaGVkID0gUlNFUV9SRVNDSEVEX0RFTEFZX1BST0JFOw0KPj4gKyBpZihJU19FTkFCTEVE
KENPTkZJR19SU0VRX1JFU0NIRURfREVMQVkpKQ0KPj4gKyByc2VxX2RlbGF5X3Jlc2NoZWRfY2xl
YXIocHJldik7DQo+IA0KPiBZZXQgYW5vdGhlciB1bmNvbmRpdGlvbmFsIGZ1bmN0aW9uIGNhbGwg
Zm9yIHRoZSBzYWtlIG9mIHNvbWV0aGluZyB3aGljaA0KPiBpcyBvbmx5IHVzZWQgYnkgc3BlY2lh
bCBhcHBsaWNhdGlvbnMuIFRoaXMgaXMgdGhlIHNjaGVkdWxlciBob3RwYXRoIGFuZA0KPiBub3Qg
YSBkdW1wIGdyb3VuZCBmb3IgcmFuZG9tIGZ1bmN0aW9uYWxpdHksIHdoaWNoIGlzIGV2ZW4gY29t
cGxldGVseQ0KPiByZWR1bmRhbnQuIFdoeSByZWR1bmRhbnQ/DQo+IA0KPiBUaGUga2VybmVsIGFs
cmVhZHkgaGFuZGxlcyBpbiByc2VxLCB0aGF0IGEgdGFzayB3YXMgc2NoZWR1bGVkIG91dDoNCj4g
DQo+ICAgIHNjaGVkdWxlKCkNCj4gICAgICAgcHJlcGFyZV90YXNrX3N3aXRjaCgpDQo+ICAgICAg
ICAgcnNlcV9wcmVlbXB0KCkNCj4gDQo+IHJzZXFfcHJlZW1wdCgpIHNldHMgUlNFUV9FVkVOVF9Q
UkVFTVBUX0JJVCBhbmQgVElGX05PVElGWV9SRVNVTUUsIHdoaWNoDQo+IGNhdXNlcyBleGl0IHRv
IHVzZXJzcGFjZSB0byBpbnZva2UgX19yc2VxX2hhbmRsZV9ub3RpZnlfcmVzdW1lKCkuIFRoYXQn
cw0KPiB0aGUgb2J2aW91cyBwbGFjZSB0byBoYW5kbGUgdGhpcyBpbnN0ZWFkIG9mIGluZmxpY3Rp
bmcgaXQgaW50byB0aGUNCj4gc2NoZWR1bGVyIGhvdHBhdGguDQo+IA0KPiBObz8NCg0KU3VyZSwg
SSB3aWxsIGxvb2sgYXQgbW92aW5nIHJzZXFfZGVsYXlfcmVzY2hlZF9jbGVhcigpIGNhbGwgdG8g
X19yc2VxX2hhbmRsZV9ub3RpZnlfcmVzdW1lKCkuDQotUHJha2FzaA0KDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiAgICAgICAgdGdseA0KDQo=

