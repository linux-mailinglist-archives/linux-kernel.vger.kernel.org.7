Return-Path: <linux-kernel+bounces-842625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E3BBD2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A53714E81E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6524BBEC;
	Mon,  6 Oct 2025 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mG+cJSwf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o/Vqt6fQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A451ACED5
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759734435; cv=fail; b=WHyMVVYSpud5eXYLTTx4MfefU7jeDuvGrwpCEhqX/rVVW3SEBiGP6yZIchnpChVKSEGMN0uF3APTmlQFhXO66Kr1cF0QqiWoqCgESb9vm0f4ThdGYU5r09WlQnfSTZxxh1b4xk9zTG6Eky6f2yp4pe2ZEl9c8alaiRyx6c+GkaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759734435; c=relaxed/simple;
	bh=kAY7c62Cgxi4DqUpjqzqbGlwZoatvCLTkHr2wCj2EC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=JYPSMmPdjk6hOl1IjDVs+A4ps1xsUpGF9L8X6Sx7vrkG5yGhUNjDLpD80GQLxSwBfEQexTYVg7/zVCumjBZT52hZFuz1pdKFWUExNd3RSuPhEV3+B629jlETGx83S/FIeuzeVzfAI7eiLkSPg8BJINyjR5yrK9c2wuWwAifIPkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mG+cJSwf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o/Vqt6fQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59661RGk026782;
	Mon, 6 Oct 2025 07:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=kAY7c62Cgxi4DqUpjqzqbGlwZoatv
	CLTkHr2wCj2EC8=; b=mG+cJSwf6b3e9AGmXZ2x6Px14hfr/p3rrLzaLZJskmUNx
	AClOH4DmlABCkt1hZIfZ+MMXYkH0Ds+YLGcFSmpam9oDp1ZfGvv6iJOVoJxViFAG
	1Zw140EuvDM6ZRryfxZwA/uIXa4FzBaeALaECO0oRquLR8SiP6wjWONx/r74sbe5
	05otLD5BDCIrkMmnPUn/ABhy97cZW4cxAbylWFAGLemAL/c5Wa/fEcyM4qvNXsT7
	gXtC7J/nd/Df8aUtYFJOliL2mh/jtOzWBHsFzuXSisC83+GWhqD+1LU2Ga3iyeYk
	fTyWwQlevIEfNSpblwCAsCLvkemEla3YWNo7l72gQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49m70qr61k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 07:07:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5965QNVv005890;
	Mon, 6 Oct 2025 07:07:08 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt16q1vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Oct 2025 07:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcufWGWhQfl3lghdD2BaH1o50EukEik7htYZdQYJj0uXOIS9P4H4FPa/Dm/v/RGKt1v9QJjkG90z55+NzkFvRXvW2YXiGgzlVEQOkmf1+O9I65oTjzVm8td6NiP2QSCJKGe7k/67TNy2xL3yJRQnAS60bzIYVYK3lW91GX3pFCknFfEATebZ4sxzByNHeO2mDZiHmnlO7Bw3vh1CYuoIU7yuX8s4lQROO28MCnlb7YRtGGn04xpBlHRkdOLGWj9DKfmAuNiCY7lAzkwPAwUQ7ZYomtpWUFhBplnraD9R5p8j970wPR55OvUNBG/7u57sqeSzxcO8WfHucze09dK3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAY7c62Cgxi4DqUpjqzqbGlwZoatvCLTkHr2wCj2EC8=;
 b=CtEoocB6uvew12vsPC97FbgBfoMIXjbtlAhxRPS3oIUkBakL1u0g4KBbrmJcqgQUUA/SLibr+hlQBmucU0lCv3rAqPWMW1sBAybDRhMHIjrh5l5kspy3WGXmiwuY4QIy4QVvvYfTGksaZL6rHg1Hh37LCWFiaCimPopmo8wXqZl8kDWEKjvwDp8GXllLCCVvZPLup2ez5Mg7172jKWwcLuuu021GZx6MuvTfiy7QXU1wXkAWtyPLAQxt5aOxKOIDa1rOcK+REZHhYDDY+8Bh8UIWqibatEo/VdAhCZga3GKaW/bWcLPe59fcZQxsFMNRANhATQJ7iI3rXZee+b/eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAY7c62Cgxi4DqUpjqzqbGlwZoatvCLTkHr2wCj2EC8=;
 b=o/Vqt6fQOZdase1BdZrmEI8ZLGeKwerPnWaYnDJ/m76wJN0WFfTZzJKUirLAh4kj4BpdVu4nBpA+QJtsSnDHjhjQIgS7mRLR/DBv/pL78RuOECsMnxDy7oQCTooqaTDmr9PaGtYI2NuCD3CHIKIFTE+HH2F/RfgU6Ey9l5E9YQc=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 07:07:01 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 07:07:01 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "gregkh@kernel.org" <gregkh@kernel.org>
Subject: Re: CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in
 add_tuning_control
Thread-Topic: CVE-2025-39751: ALSA: hda/ca0132: Fix buffer overflow in
 add_tuning_control
Thread-Index: AQHcNo/PMUiwYSum3kmaKdsdekTDLQ==
Date: Mon, 6 Oct 2025 07:07:00 +0000
Message-ID: <f24f4524894417954b9de4ccec69c2e17aae3d5f.camel@oracle.com>
In-Reply-To: <2025091142-CVE-2025-39751-c340@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|MW4PR10MB5701:EE_
x-ms-office365-filtering-correlation-id: 06c086e2-9490-4d4c-958a-08de04a6f27d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEYyQmlVazhOeElhbW8xaUxocWpnUXFQV2VnODB3T3h1NTd4VjMva0J4ZXpn?=
 =?utf-8?B?OC9kNTZLaWNYNnlSalZPMXlnZG0rcmFkUWswSFZyOWc5WHZ0WGJQNTVqRStF?=
 =?utf-8?B?a2xmcFFWNkY3blVaZlNWVEU2WGNVaTM0S2VRVDNjcGsrVStWOEk5YVBvMldw?=
 =?utf-8?B?SEtwdHcvZ2dXOXhpRnRoNXBRTlpta0xpbjdodnh3cVhSazNWY1gySkRrWEwv?=
 =?utf-8?B?Z2lFVzNkTys2OHBSQ2l3N3NMSzYxZ3hQWXd6S1UzV0M1UGc5RlZ0RG4ybWZt?=
 =?utf-8?B?dW0xQ2QvTWwvOU5uUko4dXZYQWlqMHpPUGVUblRLUjlOSHNEUkZmTEdlTkhI?=
 =?utf-8?B?dWVxbDJ2MUZQZU5LYjk2ajhrQkNrRjNGVWlxTU5oMXJOV0hOV3ppLzBiZ0t6?=
 =?utf-8?B?OW4yU1FnTHJQd2lVdm5BWCtpV0k3bzNxajU5MjV1TWMzVjZMWXhiaFJCWGtU?=
 =?utf-8?B?dzdHdnZEazhzN3FPdlVjenRZTzZIS1VJOFFMajFyTklVU0kyRkEydUlmR0tL?=
 =?utf-8?B?b3pXREFVTkdNTVlyMlE5OHk2cjlNZFVkdzV1N2RKYjFuc3VPaGZVSU9QRW9s?=
 =?utf-8?B?Z1hCUGpLZEc4Yys0YkJYUU9NK0huMTBsUDBzLzkzT3JyN3h4b05KK09MTHF1?=
 =?utf-8?B?Z1lpOXhyYThuQTZKejlJb084U2p1d28xZitXOUhRd2l4cWpadFQyb3NaYkVn?=
 =?utf-8?B?aFNsTjAwMmJjdFA0eVU2d2hwa1U4aGJOdDFVTGhTeFhPQnRtOW03aFB2Yndp?=
 =?utf-8?B?ZVRPeG9ScEhiSWZheWpWSm9qUTVEd3hVSVNrMmF3TkwxTmRpeW5pMDdOL083?=
 =?utf-8?B?NGxpUzNqSnFRclFmcHl5NTBnbHdnbTlNdlR1ZlBpSlQ0R0VFY204R3pybkJI?=
 =?utf-8?B?M0J1SFcxWTh3OVAwd1lhdmxBcHVyY0ppQWhETnhXM2FhcGZ4ZXFXcEd5TWt1?=
 =?utf-8?B?MnpkN2ZXV2Z5TGJLU3J5cmJCemhtcGNsNjhJdkpFemxMM2dwZmF3TnpzWUdI?=
 =?utf-8?B?SVh4ZE15eDAybTNCMnFWVUJScTZZaFVtdmFmbG04NzBwNy96TEl5RlBTVGoy?=
 =?utf-8?B?bUdURTkwMDBtS1hudFZ0ZUJYQlUyd3I3UU9OVVVxTjY1ZWp4TFlEelArenhF?=
 =?utf-8?B?bWZva3g0ditSby9uc3hldUxMN1FyQkhkdEdVSE1vMjZFV05PZTZoVGU3UGRy?=
 =?utf-8?B?UVpFVjZMWk9FMHIxcCtBcldRejYvM0dXaWZuMlBpVHJiUG1zdURHSk9mZkpE?=
 =?utf-8?B?UGJrL3Q2THJIT2JPMWYzVWxqckZZOXl4Mk1SRFVGS2krSmhuTHBycndtVXdI?=
 =?utf-8?B?SWw0OHFsRFR4a05vTnpuSURIVUZ2UVY4RUFXR243TkJXUU9hWklrRGZETjEw?=
 =?utf-8?B?bVc0WGxJb1dYNnJ6UjUzcmd6M0Y3UlJKMDJ6cWxNdjNVYnlLT0t1TUV4NDBm?=
 =?utf-8?B?Y0tiRnFZRlNIekNSdDYrem1DZEExVDRjNDNCQ1IxclBXbVZ6eUgxcTEvTWc3?=
 =?utf-8?B?SVFLd0h5RHJUZWtObDBIT2o0enhlUjJzUFB2YURNc3ZCaXZCREUyQzQ3YUxm?=
 =?utf-8?B?S3dhSGxkaS92RTNta0xUUTMweElDWnF1RlpSR1pQUENpRXJoT3FCWlozY3FC?=
 =?utf-8?B?S2ttSTMwaDVJU29IeGhiVDRDQlRFYTlTNzVKNGY0cVBGbEo3SFUvd2QxNjdn?=
 =?utf-8?B?d2ZKUm90U3F5ZWF3M2FsWCtnY0RkOEhhcmM1SEplekdnL0JmR01INThNSHdN?=
 =?utf-8?B?SGQrTWQyd3pEc05jRjF0N3ZBS09Uam9ZRklkbExvN0xhT3FHL0VpSUVNK05u?=
 =?utf-8?B?T3IwRWZaNUtnTC8xSmZDK1NqY2l4QldKWWRhaFAyVHZKd003dzlROGRjaVRt?=
 =?utf-8?B?elJwT2FVK2dXSFRSR2NHOU95Y1FNdDg0eCtDamJSbXBvemFIWnJDRkkzMlpI?=
 =?utf-8?B?dFFQenREZXNIbE1PMjZ6VHNrcWtoUlQvQkxza0RIQ3RHbERTaXVONUVWNUhZ?=
 =?utf-8?B?RVZoQUVlRGIwb0lRbkdmQ1haYVdCQTlFbzFTUTZHY3dHeHJ0Rml3dmxzQmEw?=
 =?utf-8?Q?8hCM+w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(4053099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak1LZ0w0MnVMNTRRV09nZEx6c0s1Si9IenlMcDNuOVZ6VEZsblNJUDI5a2Zy?=
 =?utf-8?B?ZWF5aWJndy9yWFRlSEVZNzVyV3QxejI4VXVDTUtFTFg1Q1dtNytUbXVlaVNa?=
 =?utf-8?B?Nm1YTXU2Vmt2Mlhnb3k2aEk3L1Bxa2QzUUVBU0w5MGNtR21CMGZUc3k0THV1?=
 =?utf-8?B?V3ZHRTg4cEpnWElVWmhzMXFQLzJ0THh4eHJ6NDUxRUNsODJ5Q01PNWF0Z24y?=
 =?utf-8?B?SVgvcUpFN0JHOWE4N3c0dXhTNXdOaHdMc1doWHc2QkphWEI1a0VIbjA1SytC?=
 =?utf-8?B?YW9aSUtCYnZIbzgyTjl5QUtiWHFaRHVTVWRBbiswZU1RcUhYWnc0ZkFJaWVk?=
 =?utf-8?B?cU9xYW5WaU12V0ZXdHBuTTdENlFrc0lXajdjUm92TVdZMlFBWEUrNGNsZWFj?=
 =?utf-8?B?OVRKZGRMcmYzQjRmWXlveGFDRU54OUQ5ei9oUG1OVUNPL3Exa3dUWXVMNGxF?=
 =?utf-8?B?WDdVd05IdzcwS0k5M3VaT2p1S2UzUlRCVkxzYVVOOGcyRkJvY1E3b1JWc1pV?=
 =?utf-8?B?bkxXM0I4SUxxd0xZUkxBcFFlSFBxUkh5N2p6cUh3UmtJYjVKOGtIeTBMM2cw?=
 =?utf-8?B?RTEyeHBNOC9HNDVCUENYYU12SzBYdkdRTkdtSW5QaWY1UHVOeWg5NzgxT0NW?=
 =?utf-8?B?OTJiSzROSG8vYWVZNS9Yb1l6MlEvcWtVV1ZsZkxyWG5JWU82VGpPN2JBMGlu?=
 =?utf-8?B?VXUzSHZBbVQ3YkN6aGJ1NHhSTTNaeUMwRWl5RDd6NlpnSjNHeS9xYnV6S2lP?=
 =?utf-8?B?MXZXbDVzV0E3TnJabFNCNVdqMWRoMXZWOUFoT3VmRDk1eXRIbEdoZmhiQnM1?=
 =?utf-8?B?cTBsRDRhbWxLM0tKekRJOG1uc1cwTnFPK0xqa29XWGNZcG9yakNwRHNWVVh0?=
 =?utf-8?B?WjRKV2RUdEg3aEpsejlVOWQzOVp3TVNyM3ZlSTQ4d3lSS21tVzFKVEJJdlB6?=
 =?utf-8?B?MWkwYzNvaStMZWg2TVBXWHhvcWdvSHlmeVU1NnIyMlFSZFk0TXFRRVdVVXBM?=
 =?utf-8?B?QWlxaEpQQWFUNzZwbUxoWkZKK1Q2UGlEdDk4T0sxdXBaTW5vNENEbmNoVXdt?=
 =?utf-8?B?ZnZnc1JRUmdwNUUzMVFSRWJhQStnUWFOUEZjQ2hxZHpTVzRFaGUwcDlYbU52?=
 =?utf-8?B?SW1EemNXaitMUzFIMjF2ek9wMkhGRlZhTk82N1JweEF0UEZhSVZwblh1ZUxD?=
 =?utf-8?B?MzdPdmhrdUdxVXB6ZjJuczZiWldNUTQwTkVrU0xKcWJjQU1ZajQ0SldiTWdK?=
 =?utf-8?B?ek1DUVppdERNMUk1ZWdCTFFqZndzelB2WTNiSUFEd25vVFhWc1ExY2ljM09H?=
 =?utf-8?B?WHJXZ3VaL0NMeVcxcGdvMXZUWDVKNG1BVVEzR3Yvakx6WkJUNDlMZVJaOTN3?=
 =?utf-8?B?Q1ZQbTBkOUFGQ1h2NTZkTEZBYndYVERQNEhydytWZGRqSU9WejVxdDEyVEE4?=
 =?utf-8?B?MHNvSjEvMGdrNEhidlhJTWtqSnpVSXRUbjRsZGgzRlViL1BCWUE3QXFWSER1?=
 =?utf-8?B?bDR1aXV4TWhpb0hRbHluczF1NEc3YlJteEpZUEdZNmkyRU5sS2FIZk5Bdlpp?=
 =?utf-8?B?UFUxREVweWFXUTVwK0ZENnlkZUYzeHFvaHN0S1F3VURSTUFoekVSM2VSYlZ5?=
 =?utf-8?B?NWl3Y2NnUnpURG5vZG9nTU5nMy9JZnhwVTJ4MWR2UE9rMXNpMUZMY1RJQndX?=
 =?utf-8?B?K0l5SmE2OVRES1JIbm9qWXdBVG1YNFRhd0syTWFmK0tPSmJpL1lGV1lzRElY?=
 =?utf-8?B?bEFRT0IwSzY4cHIranN4ZTdneGxiL1VFWVhzV2l4azgzbGh3US9OTTFmRUcx?=
 =?utf-8?B?THNSQ3ZSUU1OQ3JjZTIrUGZRaHlsaFZEcFhzT0hwU05WdFZ1MlpDQ21FQlhW?=
 =?utf-8?B?dHdqQ0pQZlkzbHlYakNHaHdIeVV3YXlETkZVdnMyL3pqalpMYVNUQVBEQUw4?=
 =?utf-8?B?ZG42c0kxeEJwNmp1akczMlRyNkt3RFh3MkRjcG9lbjRqTUMxV2lKQXlNNzIr?=
 =?utf-8?B?ZytRVWRyTk5ScGFHRUZKRUVacUljb1d1NGdJaTNTT0pyUkhiNkRVMTZXclB6?=
 =?utf-8?B?N2l6WHgzRUtmaHBJMDQwQTJwU00wSlJGRFgxeC95ekJDbmRESnFaTjZzZUhC?=
 =?utf-8?B?YXh4TkIvaW9TeGlycUUzNGhaK2U3MnM4ZUFOZENjbTRMR2U1UnZVOHBkMVZY?=
 =?utf-8?B?NTZJT0ZrY0gyRVE2Tjd5OHpwYVdUZHQrUGp2MDNkZm1CNkVGS0d1enNqaGNO?=
 =?utf-8?B?eHlEek5SZ0xaVXcxSmlLZHZYbS9nPT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-nk5JyWSW3b2/jy5bcnv9"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tN2DS8m3ekvyPYUcRrdzCk2GrbCenpBG5w+FqnR/XKUKUdlDMa28LrU5wSrMQZ89fAeTMIWly1MBb8XSvmt9eFFX4ZNhOltaVs0GTTadhbU9kpHqdJ8h30UKDvXfervm1bzDrz8vUjV78wHNZq6f4s1LfJyakcAZmZp8BFSCI8V+NonLuO7x5DOdgFgtC3LFtaxobsE5himEng7MXff+/gHBXB735Wo8VlvM2ug6cJQKiBeuMCR6N5i+GET/4+BaKRG9GL+Dw1b9GnWheZSA9FijQhIHedTChMo16oJdVyGWfwZOu20zVH5PqN39JAZwg5Bk+RFi/krLeeZOr25K7L7YjoGGsNsMV18FgLx+4Mh5ccgDzukHd6FwAUllTKAXAKhS03ht2sv3bP5IEH7SzIjuntjISw0YRjjSXMiCKAtgj3aVbqPkt8aEiFT3UCJLvc+m9AnVuyu60lHEgY1b2k5PIe4pY/HgcfHH34rZcrDEs/nBcdXiQzWfQQ3kjD0ExVzF5s0yPPwZ099g6wa029USgCn3CyLQ4j0UlyAroKwZ2h6farAZ7qulZwwrL1FCJ7jXCzM099Qj1TjTYQwHBNV5erk9cZmsIooGt23jFjQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c086e2-9490-4d4c-958a-08de04a6f27d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 07:07:01.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEePcpw9aarDaz1RI9UyEesE4SiyZ04AE+IXAksC7OI8Y0J60xWOIIM1i729SvokxOJlu1XoTXUuc6S1el884/lGcDV7o2swRFCUOCIadUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=900 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510060055
X-Proofpoint-GUID: LKQvKWYWsShKbBN7d3d-FF7e8IBAfdwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDAzNSBTYWx0ZWRfX2BIuz9K5nlU0
 XoE2pdyhyPltl3oZ6K+Fkbhjc95FjTYbG3MVxR+DTYQsV7YgnoAKDIIiipEhwVre/PiSw8J2OSq
 sqv2tpExD1ksEADPjNgrBadAqYD1TQkozHQ8eAFRVAVppgpp25TIMu1Rf3H8WaSQBt0ySl2A8mc
 tG9msN2dI/WBf0bDVz4vK5xwGfxs4IktE1YbRDpVY4OXehDOahaRiooM/+Fttaz/sNBzFLdWHVk
 qkkI35kkFZdT5ZVpppJRyv4Ami1rBpnOr3ZdqA8jEJhxsdGXQ98ezTWtTDXcFcdKIkvbQ3bGtnz
 yt1FCbKiPbpTMAqAFlHF/agsSAZMOaqnfVQ2NkDA++Z0eaGHDtJBIQrF2rlu5w3BPjDGqQ59Dok
 u0//kW6YS9Gj8Dy9uGL/mBNbcCguig==
X-Proofpoint-ORIG-GUID: LKQvKWYWsShKbBN7d3d-FF7e8IBAfdwf
X-Authority-Analysis: v=2.4 cv=TbCbdBQh c=1 sm=1 tr=0 ts=68e36a9e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=04hOdSINBF_exIrXKAUA:9 a=QEXdDO2ut3YA:10 a=x6DlygLIsMDWzrr_XhcA:9
 a=FfaGCDsud1wA:10

--=-nk5JyWSW3b2/jy5bcnv9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 18:52:52 +0200, Greg Kroah-Hartman wrote:
> ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
>=20
> The 'sprintf' call in 'add_tuning_control' may exceed the 44-byte
> buffer if either string argument is too long. This triggers a compiler
> warning.
> Replaced 'sprintf' with 'snprintf' to limit string lengths to prevent
> overflow.
>=20
> The Linux kernel CVE team has assigned CVE-2025-39751 to this issue.

While the change is good for defensive reasons, there isn't actually
any buffer overflow as it is to "fix".

The largest string possible is "Wedge Angle Playback Volume", whose
length is less than 44.

Thanks,
Siddh

--=-nk5JyWSW3b2/jy5bcnv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjjalUACgkQBwq/MEwk
8ipzFA//UHc50h+2PV/pgMHuXh9ghwBXD5BHlNnUoRP4VXvEbXzVnks04kvOY0Fr
GZVNrBb6xWnnsHGkYoFKqj2SSu4GnHWnsuHeixCBTCsF7u+8vzmGioGkESfk5604
15bopKe3ZEymLopBqRes03iOXLlZ9Zjc1OIP8CTkSlVtBUrTsxp1R30wH+ifrEob
rv7ke5OIz/vJ7L4JoCpzL/hSfSnAxzhAeuRleMV4AeRqLA0KVBVdj6+vemUbmPWD
1lBYmnyKKxY4MzRhfXMGrWVtu/umxODIcSd/NA0boK/TM+iCn0tIHcdwqWDa3ngm
wOXM6jpKC5SOpaUH4F8AwvWeCHkJ4uXBVDZ+m5NeRwaxkFM74xfC26ZjzkkBY8VV
pDaK1+o2EHowh0MwLQRJxSmHIQ9r1e69iTB38F2H9juAivDCaKcWC948PydLu6s1
t9VGI+EeaqWhcMZqOKn3ZJlaNBFS+/AWBsKAhdNge+pBZ7XfuHl+G84fyJ8wvXYN
lr8+tjSIglJ13tXHe1U0QvR1xY4ou0QLRP7OFF0MnUCFM25qGd3eAYk0NUqodgmw
F5FTVVAccO8mw/WbeI7SvHI4uRhclL6tui/EQxTGa/80Ed5J2VQCDS1DyVjFjaBc
L0sB26C1CwnT4hdmQjfZKWXVNhcBAFfxngs+Vch833qraZbv4Qc=
=86l8
-----END PGP SIGNATURE-----

--=-nk5JyWSW3b2/jy5bcnv9--

