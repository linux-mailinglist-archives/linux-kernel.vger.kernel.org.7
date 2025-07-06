Return-Path: <linux-kernel+bounces-711979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4244AF02E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960BC1BC76C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1C27934E;
	Tue,  1 Jul 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+Xc7rXO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IABKwDN9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B701E1308
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395232; cv=fail; b=ryjahXJrIw+TlYn135j2IoNNdVFIFMr51sFuuWDSmpHx8nr4HXyJZmbx9L+JpROvXWZplho3JjnzRZVfbfnq4570EZs2VLfHmytTmkxKItx37qxPdYte+ivtbUVp5/L3RLxOUmZdd0Ns53M6KUxJQv1S2F4BEWooeBEby09sOrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395232; c=relaxed/simple;
	bh=55U0ERJ80GcnyQBWwZawuBARvg/69QswLrlxpRBQS/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U/cGJ6O71mGH/QwB0y5NZtHTv41uhlMgI9WSpizdu8AcLZwkV0gaCMuhMFNRPiVGaXXMVcjSLl9n+iG5u6FCJEdKc2P4rbOTysbum+A/2ALMz3S4PifMrtv4r/q4u1U3w1IG1kGY7yRtjEyO/DKfjoTW83o26g3pYLCwqlmzYc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B+Xc7rXO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IABKwDN9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561GfkKw020013;
	Tue, 1 Jul 2025 18:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=55U0ERJ80GcnyQBWwZawuBARvg/69QswLrlxpRBQS/k=; b=
	B+Xc7rXOckw6KUr2CQu9kg2c5QeKyin4IlgN9+mmGEP0HcFn003waVP0nK/TnzhP
	Wd0WRL9ywGE1HnWFsCFnYqj+7jIEJO8zHeNsQClrhwi1oHRzgDVWSZOWevdMM/Ne
	I8SKv5L2rIuiVYGTHQVb5p6GjarWkGNLC6dXyoiWG397lOxcZjxlatTuKhO0etBw
	cVw/5Yk/PdRy9SGYPhqhZDI8ja/SwUXBc3Mp5XFkYWX9KYIIeQ1aE8psu/p4c8kw
	+b1kAIJtJIJahciEMfJWziEGy8IdoDgo21e2Nn5butyB6VLcn4l0/K0Q0u0/s+GX
	FyzbBU/SpqMznnAa1fxc7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef5erf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 18:40:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 561I0u5Q019551;
	Tue, 1 Jul 2025 18:40:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9xkfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 18:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efTd9eXqsp5ujKnjEO+vUrmusHjClowd3R78uLKrmeUw6GcWPfj4hUL7fW8HwNDbdW1CnRAiBG9sdKaQBZGlPNVC74NNb/mXAP9yi1ijuKnqDpj7KImVm9uRbSpgUr6VJXD/AjYUqb+xFQASrtPiwNKbvFw8GNaam26WWQAVtn+4eS51CXKverEX3wU88GRfpa774mI/UDLtepaPlJpWgoJF/cWWxx9gpVqhVA6L2bwxqNW+eZu1LBn4EMYzZshq9fYBtPSeD98oKxUsF9Upti6pGbNZsrklDSXDom2QTrfheSo4Jh9etkAgijOFC8rWstBnPNfsqIS5BKIunCh3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55U0ERJ80GcnyQBWwZawuBARvg/69QswLrlxpRBQS/k=;
 b=V9yyGRuxpxLDXwuPM4eNfTQhaqYWUw0wvUzd4tnlD7elH0UYCoKtfEdycXNDb3n1CjkPDZ73GgURVu/PyVYJnXp05ut/LAVqMN3r6lqSVLFo5PpUDn9X/8ftBoYVnxHd2E5Jy29tdSgalII5GusPWLB3gEnv4HGN72VY+bWCX28Ep5Pep9ETLCbyTZYb/eKHCdv1gNkYi2FW7xj3Pd41dj64fFqoOcq1pZ5D/Bz11Nn2kujzuVsTe+N+byk3jwgyytGtIJQtK5xfkF9Lt9q/lrhVqt8E9yxDHPmxkQ1coy9BCLhHD/OrLt5y/9nL/xppPPgzB4OUdEZ18Cl47Zc1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55U0ERJ80GcnyQBWwZawuBARvg/69QswLrlxpRBQS/k=;
 b=IABKwDN9VnVFhtpP+lvKgzqCBz0+/au4eQek7ZM+h5vzWb9Ib4q9VTbRquy6LSgrF4ymEBRzGLOOjY8fz4KebhRnnS2U+KgiyMXwzb/iQrsMW44HOg3DNvgXpZTd7rxqiL5OsUhzy8TuWZjD1rMJOJgc7zgjZOahAKZhcU/bv7o=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 18:40:13 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 18:40:13 +0000
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
Subject: Re: [PATCH V6 1/7] Sched: Scheduler time slice extension
Thread-Topic: [PATCH V6 1/7] Sched: Scheduler time slice extension
Thread-Index: AQHb6mQg8fTfviPDoEajr7rQRNefB7QdmlMA
Date: Tue, 1 Jul 2025 18:40:13 +0000
Message-ID: <9238C4ED-6F19-4B25-8AAB-BEFB16A705BC@oracle.com>
References: <20250701003749.50525-1-prakash.sangappa@oracle.com>
 <20250701003749.50525-2-prakash.sangappa@oracle.com> <87cyakmhdv.ffs@tglx>
In-Reply-To: <87cyakmhdv.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ0PR10MB4704:EE_
x-ms-office365-filtering-correlation-id: 03dc768f-66bb-41e3-f3e4-08ddb8ceb71c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0dBbTdOUHozWDQrM1FVdzZnWlBDaHdDUXd2bjd5cTk3SllnUnhHMUx6OVVQ?=
 =?utf-8?B?NEx3Q2tVOWtpU1BGYmJTbUNnc0RWYi9tcVMzZGpOVzdaRXdMNjIzaXJCNEtq?=
 =?utf-8?B?VVM5UVpnbjcrSGNSNkViSitFTFJCb2diUUtQK241a1pMVUZrcWRHcmFMdmtq?=
 =?utf-8?B?UXpjTnRXaWhjS3A0K0ZTVjhmSGk5cFlpMi8yTElXbVpXbWtZWTkrSlA1R0dw?=
 =?utf-8?B?V0pjRXgrdXdKSGc2NTM5alA0enAzaWFKUyt1WUM0dDR1cWQyRUF1QnRFdTZy?=
 =?utf-8?B?MEUrWTI1cS82dlYyR0tkNDk1ajduZmkzUWVtT24zRUprSDV5d01JSk5aTmh0?=
 =?utf-8?B?bnRLWE15YlZ1R00xbEpCTm5lUnB2enNDYVFrQmMzUE9vUlhvVHdGRTB1OWlM?=
 =?utf-8?B?aGlqRmhTYXVySWx2WkRuaU5nZWl3b0x1R0NKbGRSUlBabWh6eG8vdWwyUmtr?=
 =?utf-8?B?WXZZYVpNZTBtZHBRSURPK3R3NGh4cFhyZk1nSHRmS0tLbVN6N1VXZlpleDcz?=
 =?utf-8?B?Yk9YWU9KcFJvWG1qT3VZT3hNb2UzMXp6Vmp3TGNJWXBXc2toNXlqY1R0d25j?=
 =?utf-8?B?TlVlODB3c2pwMWhiVHZzazVVL003aURjR0ZXYWdzbnpHaTJsMlVha1h2MDh5?=
 =?utf-8?B?NmV4RGVoejQ1UVBLUHJjRzVIZlg3Z3ByUURYMnhVaEgrTjIvYVpsa2hWaWZS?=
 =?utf-8?B?QXBOZEo5MFVrMjJxVVZxN1ZxdkVySUlHdWo2ajkyWklDZzBqT1pZMHh4TzR0?=
 =?utf-8?B?bktzaUlkbUh3dm9pZTNRbEFEcTcwV3FldE1NZDg5VGNMZHI0TWpYNWl1dC9R?=
 =?utf-8?B?Z251MWpSS3piKzFNczA4VjZISyszaVl3MHZiTFQxY1Y3bi93cjN0aHZ5RFFZ?=
 =?utf-8?B?NU1DU3BadmxjN1BOM2NWU0dEdEtJamExU3o0R3lCcFYrN0d6NFRSY0JuZEd2?=
 =?utf-8?B?YjdjR3JKcnVTUTg2RGlJd2ZGUTZCMTdCblFGQjhUbEhJbGZuM3grN1lxMXpt?=
 =?utf-8?B?L1pTeFRGVmFJR1NIT3hpbnd3VG9WaEcrRGlpRlhmWTUzb0U5OFlOK0dpR0tS?=
 =?utf-8?B?cHRzQTdCTS8xTXVPTWFtaFZQcW9iZTV2WjBlYXJMWVBocDY3L1JhaXp0STB4?=
 =?utf-8?B?Q1VZT2dJd1gzazlSMjNuQzdYTmFHYThVK0hDN1pZNUZFd2E3THZVRnBwWFh4?=
 =?utf-8?B?RUx4MXlNQXl3Yzh2blphSlhzTHlDVGxUb0VaOVAvNDhWQ2gxTVFaL2JsQzEx?=
 =?utf-8?B?OEVVSmxSQlN6MDNlNzFBOWkzRUVQNXFia2gzUWd4ZlVtZXIwZisyS2VPRTQw?=
 =?utf-8?B?cm9jWUZidFliRjVKdlpSVGN4aEoyY05EMllDQjZsVUdUNDl5RmdIY004eU1S?=
 =?utf-8?B?QSt6dXB0S2RpU0lvZThNMkJ3bUFaMmJHdUhrMEdGTy9ZQjF5K0NVbzNna0V3?=
 =?utf-8?B?YWZUeVBJcTZLeVJ1ZytTb2gxT0dTelpmMnBkajY3OFV3dkQzL282YThyKzNz?=
 =?utf-8?B?YzNieHNDVko3aWNXOEpTQ1pRQkpCd0VFOHBsM1FjblBHcFhEa0NSRDhqZFRp?=
 =?utf-8?B?azA2dUN5eTdPT2pENVRlcjl4MFBRWEo4a0w3NThDNmpuZlBnRFYwQUdFK1Jx?=
 =?utf-8?B?NUE2S2tnK1BmKzU4cjRxRjVibENSNkd1UmxrWkN4UWhJS3NRZ014bkh4R0pz?=
 =?utf-8?B?MDN3SHdyeDdrN1ZaUkR1ZkhlTE1Ub2VlUTBlQUM1OU4waTZOcEZlV1lIM1kv?=
 =?utf-8?B?eEtVUUpYZkxoeWxKT1FKQkFoN0pPeXB1aGY1U1d4TzF3QjBuODVpUXE1ejla?=
 =?utf-8?B?WEgyK0lHMTUyYTdjckxHd2F6RFNkb3Iram9FQ2dQYUN4WGJNSnFsVEZnRnRl?=
 =?utf-8?B?WUVkYjJaL1VzN2VQMnZ3ZEtkYys5eXRqaXErbjNCN0huSHp2ZmFyME9taG1n?=
 =?utf-8?B?R0U1ZGpvVXJiTnFLSmNaUERHRmRZMHlOT1ArbHA2YlRlb2hFeEVjbHVNbWIv?=
 =?utf-8?Q?bGv2mN7sa0TAmoOQtsxe19qC+F0g+s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDZMZEFQVjVnclRYR1h3MkRDNFhnYW5PcXFTNVdDcmo3aHE5V29HOERrVGFJ?=
 =?utf-8?B?TEhhNThKbWh4LysxTHJtbGJyTFl5ZzVkK3gwN0pac3VuSzh0MHdVeU5JMWVa?=
 =?utf-8?B?UTYxTjl1TkVsOXJqQU5jYWpVNGFYWWNoczdLT2xtS3gxTXR2SEl4Zi9qQVZG?=
 =?utf-8?B?Z0NWeVFEazI0NDdTaWNEM05zU0dVWHZScFI5MlV4bmpNK0svMVFxMWhWemNM?=
 =?utf-8?B?dEphVjlqdmFZdmYzVXZhQ3hQSXhkVTc5N0dnWTJCTFZ2bkFCcnhJSlFuUU1z?=
 =?utf-8?B?R3JqMERlbUNwRzRnR1RKWGVJaVk0Qk1nTlRKOEVEVFZWZExoTm5LYWIwbHFp?=
 =?utf-8?B?d2FQZmhIVStCdjNSc09QdkRBVzdYY2xJcGh4dkh6dW1lK0UwSVplYkI3WUlw?=
 =?utf-8?B?dm51N3VFelp4N29GdFpqRktXbmxuaHY2SEhYOExiWTdIZWVaS0FpUXNmRHRG?=
 =?utf-8?B?V0Fac3Zma0wxa09VaXlleGNyUkFvdVl6YnA2MTNIUURLRXpldFcxZFlEeGpB?=
 =?utf-8?B?b0xtQnpCOFFiZnl0SHlRUk9YM0Y2QnFDM1gvc1VxZG9iWXQzRFk4MEgwMVFQ?=
 =?utf-8?B?ZU9zMGtYcHo5cWpMTWJmM2tZTlAwYmZwVzgvbmVZNTluN01OV3l5U1pmSWFZ?=
 =?utf-8?B?d3VpMEU0RFQzZk4wcVdnQ1Z0b2pZNWs4M1NXc1B2RmJOdStVa1ZrSTV6ZUxR?=
 =?utf-8?B?MEJ5OWRnSEVhMmZJTmZ1bU94aHk2elFqYUpIYUlGMVEzRlZsZGpBZnRpSjYr?=
 =?utf-8?B?a2VlUVFuTVZJN3YrNGR1VElrR04zTCs1TGNNVng5SlM5TlY4VnN0aDg4NUZP?=
 =?utf-8?B?NTBKMEtVMTFvc253SmJVTkRraHZjQllhejQrblFoU0J4L1ZhdzBUemtabHR6?=
 =?utf-8?B?Z0xnOVREbFRMMjRNYWFZR09PMDVVbmV5RjIwYk9SNlI3bitReG43bytNSjVn?=
 =?utf-8?B?NXdDc2M4RHJldi9KbEQvV0dzcHBqNzd4bEMxQlFnNUVyR2xUZWpHQURKU2pN?=
 =?utf-8?B?dmxHcXNQSHhZSys1THRuMHhEbXVibFcyM1dScFg0N0NzajlJUTdtT1ZuYlRz?=
 =?utf-8?B?Q2tJNzY0bnEvR3VKUURESFdSS2tHakg0RnFqWmFhSkNJaVBxSSswL0R1aGE1?=
 =?utf-8?B?OGRPUkROVmpNSUdnMmR5L3R1SEZwRDFNWmxpMlFPT2VXRUJYU0JVUWxxY1FM?=
 =?utf-8?B?RWtQdHZDd2EvWi8remtuVlZVMG5mVHhnUGRtc0xJc01qbHBPSWd2Z1FqVEo2?=
 =?utf-8?B?Qi9TeTE0OHZhYWhaZFB2ekdCaTBpVkNCUys1L3NJaVlXM1NmcDZ2aGEyMkxS?=
 =?utf-8?B?YmlkZGJSMXMrRzU1V2M3TEo4REpkeEE0Rk5QaTBEd0tubHR0YmRxTDZUVmtx?=
 =?utf-8?B?VjdnYjRKSEJJVU5wZDA1M3pzQ25UQzFIUXhFVnRjNW1JRWxQcFc2bkI1bmN2?=
 =?utf-8?B?bU9oYUJNVVVsR3dSMTMwV1MzRkp4WHdIUStOTnNiRGZ1M2UrT1JyVXd2M21q?=
 =?utf-8?B?ZjZjRTFrWkw0Mm1lYUhDai9ZSHhLdklPV2k3cGJRTHJNdUFXRWVYYncyT1ZI?=
 =?utf-8?B?ZGZDSkcxQnRQSW1uSlJKck9VRmxBeUJGQ1dUbmxDbTNKdVN0b1kwUGdRcE83?=
 =?utf-8?B?ZHZaK2g0N0lrci9BUTdEQS9SQ0ZrTkNtaUNUcnFZdHd6ZDZSd0c4TndkTEpL?=
 =?utf-8?B?WXorR1A0MHozWVlYQldwNktqMktuR2puMjNLRjQyVDAveUlJSlBsZW9GanI4?=
 =?utf-8?B?WjFwdjBweTdzcEpkY1dlSmpRR2tlSEQwdEVpN2c5b1ZYdk0zLzhDYjJRQ29m?=
 =?utf-8?B?VjNTb0RRcnVma3lENjhYcFRBa2tVdy9mRUJuZSt1MytoRGptUU85OVNocGY1?=
 =?utf-8?B?ZWhHLzJQMzVpTFgvdVg1NGxIWDE2VjYyT2ZGbTFaWHFXVWR0aVJtSVNtbWdw?=
 =?utf-8?B?SXNpdWQ2TGg1MEt1bk9VNHVQMlFXTTB2R2dvNEdrbUJvVndNck10bG5IbEJz?=
 =?utf-8?B?a2VyS1Zuc28waFZOS3JhdG50VGpWaTBvcURpWWRLZTkxdERORG51NXl4ZGwy?=
 =?utf-8?B?YkMxU1gwS1Rqb29sM0xmNWhaTitEdGJoRG1NaVlvbjB5L2N6YkRDeS9JbXg1?=
 =?utf-8?B?RnZsOGhJbG5raFl6Y3FreW4vUXFxbzY0MGdzMUlnY1FGUXB0ZXRwblFNRXNW?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FACCF0CD690E2E43BA04D43043E95275@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s6bAEySs8Q7gsCC15gCWbnevW13nHcGHKFTsdqreEXVlwPGNF5/E8czoCexaN+YuqLQYTB0fwa7A+Tb/FiJhbdi0r0Qg1IjNBmZLuB+1F8tr6au7gMHsozJ1NDdiUp2BvwqiKm2pHTZYrl7YlFmxIo45qhaChhD4p8SJODtDD04vCIUS1bz5u+auH7XXRtUaGiBjetaMQKQ7tvWuh7tZR3xC7VQh+d1Ub8nSJ1/abTTP7jNwEXdhfypKoqCFqnaQ23bEf+6dY5hZhtP4O2WYdKRMhjW2+3uq9JO12fHbYXSkGM/DPn3qoPLxEzX/4Udg2iB1ytNMoXl/7QVr6T5xvcDbLAWgwABQ6cTpM3ONBiERCXxhqS1Z8ExB7W3wo1JgQnWDH4jt3ltvJOKf9on+mow27EE9ic91TTZ0wVUZVQEX6VlaroK2QfXLF5lvHdfARiGEI1lcmKTe793lc95DbZJCXR0gNk/pli0f30FvtP6wRm+NEHyELmIxXn+gX0EDJnulzxaYHDh5CSqh28mt480cEog7uuGJ5LdkyKdsEqs1z6Wn5n9wDzXbqKpeobpRZc+vGFDM5CXBMzbytRnoIX4fesIYDzBn+eIw8oEKu58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dc768f-66bb-41e3-f3e4-08ddb8ceb71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 18:40:13.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csSnVKUlu/F9Us+LHpoyUkrq+XdMC3qDTudijwotV6eFA/WfD/56iBXZPVLgb8GbUAFS8vJKqr+ffzm6wohR58j33JupRXOLi1r5wJY+3tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507010128
X-Proofpoint-GUID: p30v9lZd39bG8GAjuW4WlBwcqhBmV3m_
X-Proofpoint-ORIG-GUID: p30v9lZd39bG8GAjuW4WlBwcqhBmV3m_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEyOCBTYWx0ZWRfX+tQEzG0/Gz6g xfD/YExxeXfmDtc6yYSUlg6THxSx8RMyJNzxJmQYc9LcNmrE7rMy+CZ2IFFSla2B2rxkbTj4sn0 xmLMHL4UI5AZymQd3vf4y6s+3VNVdAFboj8qc5oPVxVGhGgWJO3WAJok6wZ3vq97PaHgmnjJ6rT
 CQoF24ccPsWTZOUWcaClDXNjmWJ5S0PA0maOO5RsHZuNfHJLYijxd4JR6cPWPMihi9qmgYfY7pH VG7ZlnIlexlKbt86IYgxpieI5Lpz+J7gQvUEUGURLlHD9N57sHXreqDvVEjeQyLE5Kaksa7QPT5 /YuA9K4z8kNPqq5/65mRNiOxflwWkXGIR5idYmMj+1P/fC0OlBn7bNZBLr2QzSaj5APZbk7rtpl
 6OZ11tHwocH+A1DoQwNbz8SD02wNwuqbbg3wu7tnzt4HTBA9lU6RMz1IB+qugX8VCQ4525pF
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=68642b91 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Sflex7w6O9L0bUmbgKwA:9 a=QEXdDO2ut3YA:10 a=_BXbQ_c0VdwA:10 a=_wmjd-tGZtcA:10

DQoNCj4gT24gSnVsIDEsIDIwMjUsIGF0IDE6NDLigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdWwgMDEgMjAyNSBhdCAwMDoz
NywgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4gDQo+IFRoZSBzdWJzeXN0ZW0gcHJlZml4IGZv
ciB0aGUgc2NoZWR1bGVyIGlzICdzY2hlZDonIEl0J3Mgbm90IHRoYXQgaGFyZCB0bw0KPiBmaWd1
cmUgb3V0Lg0KDQpXaWxsIGZpeCB0aGF0LiANCg0KPiANCj4+IHVuc2lnbmVkIGxvbmcgZXhpdF90
b191c2VyX21vZGVfbG9vcChzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4+IC0gICAgIHVuc2lnbmVk
IGxvbmcgdGlfd29yayk7DQo+PiArICAgICB1bnNpZ25lZCBsb25nIHRpX3dvcmssDQo+PiArICAg
ICBib29sIGlycSk7DQo+IA0KPiBObyBuZWVkIGZvciBhIG5ldyBsaW5lDQoNCk9rLg0KDQo+IA0K
Pj4gLyoqDQo+PiAgKiBleGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlIC0gY2FsbCBleGl0X3RvX3Vz
ZXJfbW9kZV9sb29wKCkgaWYgcmVxdWlyZWQNCj4+IEBAIC0zMTYsNyArMzE3LDggQEAgdW5zaWdu
ZWQgbG9uZyBleGl0X3RvX3VzZXJfbW9kZV9sb29wKHN0cnVjdCBwdF9yZWdzICpyZWdzLA0KPj4g
ICogICAgRVhJVF9UT19VU0VSX01PREVfV09SSyBhcmUgc2V0DQo+PiAgKiA0KSBjaGVjayB0aGF0
IGludGVycnVwdHMgYXJlIHN0aWxsIGRpc2FibGVkDQo+PiAgKi8NCj4+IC1zdGF0aWMgX19hbHdh
eXNfaW5saW5lIHZvaWQgZXhpdF90b191c2VyX21vZGVfcHJlcGFyZShzdHJ1Y3QgcHRfcmVncyAq
cmVncykNCj4+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgZXhpdF90b191c2VyX21vZGVf
cHJlcGFyZShzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4+ICsgYm9vbCBpcnEpDQo+IA0KPiBEaXR0
by4gMTAwIGNoYXJhY3RlcnMgbGluZSB3aWR0aCwgcGxlYXNlIHVzZSBpdC4gQW5kIGlmIHlvdSBu
ZWVkIGEgbGluZQ0KPiBicmVhaywgcGxlYXNlIGFsaWduIHRoZSBzZWNvbmQgbGluZXMgYXJndW1l
bnRzIHByb3Blcmx5LiBUaGlzIGlzDQo+IGRvY3VtZW50ZWQ6DQo+IA0KPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJv
Y2Vzcy9tYWludGFpbmVyLXRpcC5odG1sX187ISFBQ1dWNU45TTJSVjk5aFEhS2VIY0FWVEVna2tP
VElaQ0VzUllnY1F0RHdZSFo0czc3c2pPOWZLc2pPNTMwbTVtYXZSTU9uRE1CX3Y2Zm01VEJ2RWZS
UFYydGNSMktUcXQxODY1VlowJA0KDQpHb3QgaXQuDQoNCj4gDQo+PiB7DQo+PiB1bnNpZ25lZCBs
b25nIHRpX3dvcms7DQo+PiANCj4+IEBAIC0zMjcsNyArMzI5LDEwIEBAIHN0YXRpYyBfX2Fsd2F5
c19pbmxpbmUgdm9pZCBleGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlKHN0cnVjdCBwdF9yZWdzICpy
ZWdzKQ0KPj4gDQo+PiB0aV93b3JrID0gcmVhZF90aHJlYWRfZmxhZ3MoKTsNCj4+IGlmICh1bmxp
a2VseSh0aV93b3JrICYgRVhJVF9UT19VU0VSX01PREVfV09SSykpDQo+PiAtIHRpX3dvcmsgPSBl
eGl0X3RvX3VzZXJfbW9kZV9sb29wKHJlZ3MsIHRpX3dvcmspOw0KPj4gKyB0aV93b3JrID0gZXhp
dF90b191c2VyX21vZGVfbG9vcChyZWdzLCB0aV93b3JrLCBpcnEpOw0KPj4gKw0KPj4gKyBpZiAo
aXJxKQ0KPj4gKyByc2VxX2RlbGF5X3Jlc2NoZWRfZmluaSgpOw0KPiANCj4gVGhpcyBpcyBhbiB1
bmNvbmRpdGlvbmFsIGZ1bmN0aW9uIGNhbGwgZm9yIGV2ZXJ5IGludGVycnVwdCByZXR1cm4gYW5k
DQo+IGl0J3MgZXZlbiBkb25lIHdoZW4gdGhlIHdob2xlIHRoaW5nIGlzIGtub3duIHRvIGJlIG5v
bi1mdW5jdGlvbmFsIGF0DQo+IGNvbXBpbGUgdGltZToNCg0KV2lsbCBpbmNsdWRlIElTX0NPTkZJ
RyBjaGVjay4gDQoNCj4gDQo+PiArdm9pZCByc2VxX2RlbGF5X3Jlc2NoZWRfZmluaSh2b2lkKQ0K
Pj4gK3sNCj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0hSVElDSw0KPiAgLi4uLg0KPj4gKyNlbmRp
Zg0KPj4gK30NCj4gDQo+IFNlcmlvdXNseT8NCg0KV2lsbCBtYWtlIHRoZSBuZXcgY29uZmlnIENP
TkZJR19TQ0hFRF9QUkVFTVBUX0RFTEFZIGRlcGVuZGVudCBub3QgU0NIRURfSFJUSUNLLA0KU28s
IEkgY2FuIHJlbW92ZSB0aGVzZSAjaWZkZWYsICNlbmRpZi4NCg0KPiANCj4+IGFyY2hfZXhpdF90
b191c2VyX21vZGVfcHJlcGFyZShyZWdzLCB0aV93b3JrKTsNCj4+IA0KPj4gQEAgLTM5Niw2ICs0
MDEsMTAgQEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHN5c2NhbGxfZXhpdF90b191c2Vy
X21vZGVfd29yayhzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4+IA0KPj4gQ1RfV0FSTl9PTihjdF9z
dGF0ZSgpICE9IENUX1NUQVRFX0tFUk5FTCk7DQo+PiANCj4+ICsgLyogcmVzY2hlZHVsZSBpZiBz
Y2hlZCBkZWxheSB3YXMgZ3JhbnRlZCAqLw0KPiANCj4gU2VudGVuY2VzIHN0YXJ0IHdpdGggYW4g
dXBwZXIgY2FzZSBsZXR0ZXIgYW5kIHBsZWFzZSB1c2UgZnVsbCB3b3JkcyBhbmQNCj4gbm90IGFy
Yml0cmFyeSBhYmJyZXZpYXRpb25zLiBUaGlzIGlzIG5laXRoZXIgdHdhdHRlciBub3IgU01TLg0K
DQpXaWxsIGZpeC4gDQoNCj4gDQo+PiArIGlmIChJU19FTkFCTEVEKENPTkZJR19SU0VRKSAmJiBj
dXJyZW50LT5zY2hlZF90aW1lX2RlbGF5KQ0KPj4gKyBzZXRfdHNrX25lZWRfcmVzY2hlZChjdXJy
ZW50KTsNCj4+ICsNCj4+IGlmIChJU19FTkFCTEVEKENPTkZJR19QUk9WRV9MT0NLSU5HKSkgew0K
Pj4gaWYgKFdBUk4oaXJxc19kaXNhYmxlZCgpLCAic3lzY2FsbCAlbHUgbGVmdCBJUlFzIGRpc2Fi
bGVkIiwgbnIpKQ0KPj4gbG9jYWxfaXJxX2VuYWJsZSgpOw0KPj4gQEAgLTQxMSw3ICs0MjAsNyBA
QCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc3lzY2FsbF9leGl0X3RvX3VzZXJfbW9kZV93
b3JrKHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPj4gaWYgKHVubGlrZWx5KHdvcmsgJiBTWVNDQUxM
X1dPUktfRVhJVCkpDQo+PiBzeXNjYWxsX2V4aXRfd29yayhyZWdzLCB3b3JrKTsNCj4+IGxvY2Fs
X2lycV9kaXNhYmxlX2V4aXRfdG9fdXNlcigpOw0KPj4gLSBleGl0X3RvX3VzZXJfbW9kZV9wcmVw
YXJlKHJlZ3MpOw0KPj4gKyBleGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlKHJlZ3MsIGZhbHNlKTsN
Cj4+IH0NCj4+IA0KPj4gLyoqDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zY2hlZC5o
IGIvaW5jbHVkZS9saW51eC9zY2hlZC5oDQo+PiBpbmRleCA1YmNmNDRhZTZjNzkuLjliNDY3MGQ4
NTEzMSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KPj4gKysrIGIvaW5j
bHVkZS9saW51eC9zY2hlZC5oDQo+PiBAQCAtMzM4LDYgKzMzOCw3IEBAIGV4dGVybiBpbnQgX19t
dXN0X2NoZWNrIGlvX3NjaGVkdWxlX3ByZXBhcmUodm9pZCk7DQo+PiBleHRlcm4gdm9pZCBpb19z
Y2hlZHVsZV9maW5pc2goaW50IHRva2VuKTsNCj4+IGV4dGVybiBsb25nIGlvX3NjaGVkdWxlX3Rp
bWVvdXQobG9uZyB0aW1lb3V0KTsNCj4+IGV4dGVybiB2b2lkIGlvX3NjaGVkdWxlKHZvaWQpOw0K
Pj4gK2V4dGVybiB2b2lkIGhydGlja19sb2NhbF9zdGFydCh1NjQgZGVsYXkpOw0KPj4gDQo+PiAv
KiB3cmFwcGVyIGZ1bmN0aW9uIHRvIHRyYWNlIGZyb20gdGhpcyBoZWFkZXIgZmlsZSAqLw0KPj4g
REVDTEFSRV9UUkFDRVBPSU5UKHNjaGVkX3NldF9zdGF0ZV90cCk7DQo+PiBAQCAtMTI2Myw2ICsx
MjY0LDcgQEAgc3RydWN0IHRhc2tfc3RydWN0IHsNCj4+IGludCBzb2Z0aXJxX2NvbnRleHQ7DQo+
PiBpbnQgaXJxX2NvbmZpZzsNCj4+ICNlbmRpZg0KPj4gKyB1bnNpZ25lZCBzY2hlZF90aW1lX2Rl
bGF5OjE7DQo+IA0KPiBGaW5kIGFuIGFyYml0cmFyeSBwbGFjZSBieSByb2xsaW5nIGEgZGljZSBh
bmQgc3RpY2sgaXQgaW4sIHJpZ2h0Pw0KDQpTb3JyeSwgbWVyZ2luZyBpc3N1ZS4gSSBoYWQgaXQg
bmV4dCB0byB0aGUgZm9sbG93aW5nIA0KPiAgICAgICAgIHVuc2lnbmVkICAgICAgICAgICAgICAg
ICAgICAgICAgaW5fdGhyYXNoaW5nOjE7DQoNCldpbGwgZml4IGl0LiANCg0KDQoNCj4gDQo+IFRo
ZXJlIGlzIGFscmVhZHkgYSBzZWN0aW9uIHdpdGggYml0IGZpZWxkcyBpbiB0aGlzIHN0cnVjdC4g
U28gaXQncyBtb3JlDQo+IHRoYW4gYmxvb2R5IG9idmlvdXMgdG8gc3RpY2sgaXQgdGhlcmUgaW5z
dGVhZCBvZiBjcmVhdGluZyBhIGhvbGUgaW4gdGhlDQo+IG1pZGRsZSBvZiB0YXNrIHN0cnVjdC4N
Cj4gDQo+PiAjaWZkZWYgQ09ORklHX1BSRUVNUFRfUlQNCj4+IGludCBzb2Z0aXJxX2Rpc2FibGVf
Y250Ow0KPj4gI2VuZGlmDQo+PiBAQCAtMjI0NSw2ICsyMjQ3LDIwIEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbCBvd25lcl9vbl9jcHUoc3RydWN0IHRhc2tfc3RydWN0ICpvd25lcikNCj4+IHVuc2lnbmVk
IGxvbmcgc2NoZWRfY3B1X3V0aWwoaW50IGNwdSk7DQo+PiAjZW5kaWYgLyogQ09ORklHX1NNUCAq
Lw0KPj4gDQo+PiArI2lmZGVmIENPTkZJR19SU0VRDQo+PiArDQo+IA0KPiBSZW1vdmUgdGhlc2Ug
bmV3bGluZXMgcGxlYXNlLiBUaGV5IGhhdmUgemVybyB2YWx1ZS4NCg0KT2sNCg0KPiANCj4+ICtl
eHRlcm4gYm9vbCByc2VxX2RlbGF5X3Jlc2NoZWQodm9pZCk7DQo+PiArZXh0ZXJuIHZvaWQgcnNl
cV9kZWxheV9yZXNjaGVkX2Zpbmkodm9pZCk7DQo+PiArZXh0ZXJuIHZvaWQgcnNlcV9kZWxheV9y
ZXNjaGVkX3RpY2sodm9pZCk7DQo+PiArDQo+PiArI2Vsc2UNCj4gDQo+PiBAQCAtOTgsOCArOTks
MTIgQEAgX19hbHdheXNfaW5saW5lIHVuc2lnbmVkIGxvbmcgZXhpdF90b191c2VyX21vZGVfbG9v
cChzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4+IA0KPj4gbG9jYWxfaXJxX2VuYWJsZV9leGl0X3Rv
X3VzZXIodGlfd29yayk7DQo+PiANCj4+IC0gaWYgKHRpX3dvcmsgJiAoX1RJRl9ORUVEX1JFU0NI
RUQgfCBfVElGX05FRURfUkVTQ0hFRF9MQVpZKSkNCj4+IC0gc2NoZWR1bGUoKTsNCj4+ICsgaWYg
KHRpX3dvcmsgJiAoX1RJRl9ORUVEX1JFU0NIRUQgfCBfVElGX05FRURfUkVTQ0hFRF9MQVpZKSkg
ew0KPj4gKyAgICAgICBpZiAoaXJxICYmIHJzZXFfZGVsYXlfcmVzY2hlZCgpKQ0KPiANCj4gdW5s
aWtlbHkoKSBhbmQgYWdhaW4gdGhpcyByZXN1bHRzIGluIGFuIHVuY29uZGl0aW9uYWwgZnVuY3Rp
b24gY2FsbCBmb3INCj4gZXZlcnkgaW50ZXJydXB0IHdoZW4gQ09ORklHX1JTRVEgaXMgZW5hYmxl
ZC4gQSBwb2ludGxlc3MgZXhlcmNpc2UgZm9yDQo+IHRoZSBtYWpvcml0eSBvZiB1c2UgY2FzZXMu
DQo+IA0KPiBXaGF0J3Mgd29yc2UgaXMgdGhhdCBpdCBicmVha3MgdGhlIExBWlkgc2VtYW50aWNz
LiBJIGV4cGxhaW5lZCB0aGlzIHRvDQo+IHlvdSBiZWZvcmUgYW5kIHRoaXMgdGhpbmcgbmVlZHMg
dG8gYmUgdGllZCBvbiB0aGUgTEFaWSBiaXQgb3RoZXJ3aXNlIGENCj4gU0NIRURfT1RIRVIgdGFz
ayBjYW4gcHJldmVudCBhIHJlYWwtdGltZSB0YXNrIGZyb20gcnVubmluZywgd2hpY2ggaXMNCj4g
ZnVuZGFtZW50YWxseSB3cm9uZy4NCj4gDQo+IFNvIHRoaXMgd2FudHMgdG8gYmU6DQo+IA0KPiBp
ZiAobGlrZWx5KCFpcnEgfHwgIXJzZXFfZGVsYXlfcmVzY2hlZCh0aV93b3JrKSkNCj4gICAgICAg
ICBzY2hlZHVsZSgpOw0KPiANCj4gYW5kDQo+IA0KPiBzdGF0aWMgaW5saW5lIGJvb2wgcnNlcV9k
ZWxheV9yZXNjaGVkKHVuc2lnbmVkIGxvbmcgdGlfd29yaykNCj4gew0KPiAgICAgICAgLy8gU2V0
IHdoZW4gYWxsIEtjb25maWcgY29uZGl0aW9ucyBhcmUgbWV0DQo+ICAgICAgICBpZiAoIUlTX0VO
QUJMRUQoQ09ORklHX1JTRVFfUkVTQ0hFRF9ERUxBWSkpDQo+ICAgICAgICAgcmV0dXJuIGZhbHNl
Ow0KPiANCj4gICAgICAgIC8vIE9ubHkgTkVFRF9SRVNDSEVEX0xBWlkgY2FuIGJlIGRlbGF5ZWQN
Cj4gaWYgKHRpX3dvcmsgJiBfVElGX05FRURfUkVTQ0hFRCkNCj4gICAgICAgICByZXR1cm4gZmFs
c2U7DQo+IA0KPiAgICAgICAgLy8gTk9ORSBpbmRpY2F0ZXMgdGhhdCBjdXJyZW50Ojpyc2VxID09
IE5VTEwNCj4gICAgICAgIC8vIFBST0JFIGluZGljYXRlcyB0aGF0IGN1cnJlbnQ6OnJzZXE6OmZs
YWdzIG5lZWRzIHRvIGJlDQo+ICAgICAgICAvLyBldmFsdWF0ZWQuDQo+ICAgICAgICAvLyBSRVFV
RVNURUQgaW5kaWNhdGVzIHRoYXQgdGhlcmUgd2FzIGEgc3VjY2Vzc2Z1bCByZXF1ZXN0DQo+ICAg
ICAgICAvLyBhbHJlYWR5Lg0KPiAgICAgICAgaWYgKGxpa2VseShjdXJyZW50LT5yc2VxX2RlbGF5
X3Jlc2NoZWQgIT0gUlNFUV9SRVNDSEVEX0RFTEFZX1BST0JFKSkNCj4gICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+IA0KPiAgICAgICAgcmV0dXJuIF9fcnNlcV9kZWxheV9yZXNjaGVkKCk7DQo+IH0N
Cj4gDQo+IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQoNCldpbGwgcmVmYWN0b3IgdGhlIGNvZGUu
DQoNCj4gDQo+PiArYm9vbCByc2VxX2RlbGF5X3Jlc2NoZWQodm9pZCkNCj4+ICt7DQo+PiArIHN0
cnVjdCB0YXNrX3N0cnVjdCAqdCA9IGN1cnJlbnQ7DQo+PiArIHUzMiBmbGFnczsNCj4+ICsNCj4+
ICsgaWYgKCFJU19FTkFCTEVEKENPTkZJR19TQ0hFRF9IUlRJQ0spKQ0KPj4gKyByZXR1cm4gZmFs
c2U7DQo+PiArDQo+PiArIGlmICghdC0+cnNlcSkNCj4+ICsgcmV0dXJuIGZhbHNlOw0KPj4gKw0K
Pj4gKyBpZiAodC0+c2NoZWRfdGltZV9kZWxheSkNCj4+ICsgcmV0dXJuIGZhbHNlOw0KPiANCj4g
VGhlbiBhbGwgb2YgdGhlIGFib3ZlIGNvbmRpdGlvbnMgZ28gYXdheS4NCj4gDQo+PiArIGlmIChj
b3B5X2Zyb21fdXNlcl9ub2ZhdWx0KCZmbGFncywgJnQtPnJzZXEtPmZsYWdzLCBzaXplb2YoZmxh
Z3MpKSkNCj4+ICsgcmV0dXJuIGZhbHNlOw0KPj4gKw0KPj4gKyBpZiAoIShmbGFncyAmIFJTRVFf
Q1NfRkxBR19ERUxBWV9SRVNDSEVEKSkNCj4+ICsgcmV0dXJuIGZhbHNlOw0KPj4gKw0KPj4gKyBm
bGFncyAmPSB+UlNFUV9DU19GTEFHX0RFTEFZX1JFU0NIRUQ7DQo+PiArIGlmIChjb3B5X3RvX3Vz
ZXJfbm9mYXVsdCgmdC0+cnNlcS0+ZmxhZ3MsICZmbGFncywgc2l6ZW9mKGZsYWdzKSkpDQo+PiAr
IHJldHVybiBmYWxzZTsNCj4+ICsNCj4+ICsgdC0+c2NoZWRfdGltZV9kZWxheSA9IDE7DQo+IA0K
PiBhbmQgdGhpcyBiZWNvbWVzOg0KPiANCj4gICAgICAgIHQtPnJzZXFfZGVsYXlfcmVzY2hlZCA9
IFJTRVFfUkVTQ0hFRF9ERUxBWV9SRVFVRVNURUQ7DQo+IA0KPj4gKyByZXR1cm4gdHJ1ZTsNCj4+
ICt9DQo+PiArDQo+PiArdm9pZCByc2VxX2RlbGF5X3Jlc2NoZWRfZmluaSh2b2lkKQ0KPiANCj4g
V2hhdCdzIGRvZXMgX2ZpbmkoKSBtZWFuIGhlcmU/IEFic29sdXRlbHkgbm90aGluZy4gVGhpcyB3
YW50cyB0byBiZSBhDQo+IHNlbGYgZXhwbGFpbmluZyBmdW5jdGlvbiBuYW1lIGFuZCBzZWUgYmVs
b3cNCj4gDQo+PiArew0KPj4gKyNpZmRlZiBDT05GSUdfU0NIRURfSFJUSUNLDQo+IA0KPiBZb3Ug
cmVhbGx5IGFyZSBmb25kIG9mIHBvaW50bGVzcyBmdW5jdGlvbiBjYWxscy4gT2J2aW91c2x5IHBl
cmZvcm1hbmNlDQo+IGlzIG5vdCByZWFsbHkgYSBjb25jZXJuIGluIHlvdXIgd29yay4NCj4gDQo+
PiArIGV4dGVybiB2b2lkIGhydGlja19sb2NhbF9zdGFydCh1NjQgZGVsYXkpOw0KPiANCj4gaGVh
ZGVyIGZpbGVzIHdpdGggcHJvdG90eXBlcyBleGlzdCBmb3IgYSByZWFzb24uLi4uDQo+IA0KPj4g
KyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSBjdXJyZW50Ow0KPj4gKyAvKg0KPj4gKyAqIElSUXMg
b2ZmLCBndWFyYW50ZWVkIHRvIHJldHVybiB0byB1c2Vyc3BhY2UsIHN0YXJ0IHRpbWVyIG9uIHRo
aXMgQ1BVDQo+PiArICogdG8gbGltaXQgdGhlIHJlc2NoZWQtb3ZlcmRyYWZ0Lg0KPj4gKyAqDQo+
PiArICogSWYgeW91ciBjcml0aWNhbCBzZWN0aW9uIGlzIGxvbmdlciB0aGFuIDMwIHVzIHlvdSBn
ZXQgdG8ga2VlcCB0aGUNCj4+ICsgKiBwaWVjZXMuDQo+PiArICovDQo+PiArIGlmICh0LT5zY2hl
ZF90aW1lX2RlbGF5KQ0KPj4gKyBocnRpY2tfbG9jYWxfc3RhcnQoMzAgKiBOU0VDX1BFUl9VU0VD
KTsNCj4+ICsjZW5kaWYNCj4gDQo+IFRoaXMgd2hvbGUgdGhpbmcgY2FuIGJlIGNvbmRlbnNlZCBp
bnRvOg0KPiANCj4gc3RhdGljIGlubGluZSB2b2lkIHJzZXFfZGVsYXlfcmVzY2hlZF9hcm1fdGlt
ZXIodm9pZCkNCj4gew0KPiBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1JTRVFfUkVTQ0hFRF9ERUxB
WSkpDQo+ICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAgaWYgKHVubGlrZWx5KGN1cnJlbnQtPnJz
ZXFfZGVsYXlfcmVzY2hlZCAhPSBSU0VRX1JFU0NIRURfREVMQVlfUkVRVUVTVEVEKSkNCj4gICAg
ICAgICBocnRpY2tfbG9jYWxfc3RhcnQoLi4uKTsNCj4gfQ0KDQpHb3QgaXQsIHdpbGwgbWFrZSB0
aGUgY2hhbmdlcy4NCg0KPiANCj4+ICt9DQo+PiArDQo+PiArdm9pZCByc2VxX2RlbGF5X3Jlc2No
ZWRfdGljayh2b2lkKQ0KPj4gK3sNCj4+ICsjaWZkZWYgQ09ORklHX1NDSEVEX0hSVElDSw0KPj4g
KyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSBjdXJyZW50Ow0KPj4gKw0KPj4gKyBpZiAodC0+c2No
ZWRfdGltZV9kZWxheSkNCj4+ICsgc2V0X3Rza19uZWVkX3Jlc2NoZWQodCk7DQo+PiArI2VuZGlm
DQo+IA0KPiBPaCB3ZWxsLi4uLi4NCj4gDQo+PiArfQ0KPj4gKw0KPj4gI2lmZGVmIENPTkZJR19E
RUJVR19SU0VRDQo+PiANCj4+IC8qDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2NvcmUu
YyBiL2tlcm5lbC9zY2hlZC9jb3JlLmMNCj4+IGluZGV4IDRhZDdjZjNjZmRjYS4uYzFiNjQ4Nzkx
MTVmIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL3NjaGVkL2NvcmUuYw0KPj4gKysrIGIva2VybmVs
L3NjaGVkL2NvcmUuYw0KPj4gQEAgLTg0NSw2ICs4NDUsOCBAQCBzdGF0aWMgZW51bSBocnRpbWVy
X3Jlc3RhcnQgaHJ0aWNrKHN0cnVjdCBocnRpbWVyICp0aW1lcikNCj4+IA0KPj4gV0FSTl9PTl9P
TkNFKGNwdV9vZihycSkgIT0gc21wX3Byb2Nlc3Nvcl9pZCgpKTsNCj4+IA0KPj4gKyByc2VxX2Rl
bGF5X3Jlc2NoZWRfdGljaygpOw0KPj4gKw0KPj4gcnFfbG9jayhycSwgJnJmKTsNCj4+IHVwZGF0
ZV9ycV9jbG9jayhycSk7DQo+PiBycS0+ZG9ub3ItPnNjaGVkX2NsYXNzLT50YXNrX3RpY2socnEs
IHJxLT5jdXJyLCAxKTsNCj4+IEBAIC05MTgsNiArOTIwLDE2IEBAIHZvaWQgaHJ0aWNrX3N0YXJ0
KHN0cnVjdCBycSAqcnEsIHU2NCBkZWxheSkNCj4+IA0KPj4gI2VuZGlmIC8qIENPTkZJR19TTVAg
Ki8NCj4+IA0KPj4gK3ZvaWQgaHJ0aWNrX2xvY2FsX3N0YXJ0KHU2NCBkZWxheSkNCj4gDQo+IEhv
dyBpcyB0aGlzIHN1cHBvc2VkIHRvIGNvbXBpbGUgY2xlYW5seSB3aXRob3V0IGEgcHJvdG90eXBl
Pw0KDQpXaWxsIGZpeC4NCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KLVByYWthc2gNCj4g
DQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICB0Z2x4DQoNCg==

