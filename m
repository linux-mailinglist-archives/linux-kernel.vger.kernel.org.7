Return-Path: <linux-kernel+bounces-832470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAEDB9F66F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E22F38617A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CAD20102B;
	Thu, 25 Sep 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LOpJ8lPo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SkrNglfx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD706137923
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805485; cv=fail; b=IRSpYlLJWX0G4+zbiM5w5A0ClT6Vh9tg9IIdU5EyCYD2CZzmiIMcuCZNTvgyvqd40eHTNO6IpV0EUneLHdkd6twIHvCgzGGfs6HVYUqgpFjxcpvfEbSfSHA8aganiBUe5DiGPwxpl34ghT2vb++/8ko1QjAMa1BCEoDDeLBzGJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805485; c=relaxed/simple;
	bh=8dO9DnQq+2zmA/od4p+016NbEf2OrVcBw4SalJpaqh0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NH1bj+HO9aM5DWM6iW5cFsz9IK0sjfivGfW7+T5PX0CsW3MM/pjsll8KGIbFwBczcoJlm5kHBOdBz8xVlPOKelHHg9qtCsR+dxJbz1P2NrIiVYxDZL7WvgwwgMgCjhe+mPONX97XwCh7Ayh4SNTz2WdoiwmF/fcb6Wf5m/aRxNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LOpJ8lPo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SkrNglfx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAtnYJ020244;
	Thu, 25 Sep 2025 13:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8STjDPIiqtkb/Brqmi/DaxYV4iq2NiKaPfgFwu9zB/Q=; b=
	LOpJ8lPoKLuab5TBKEAZHXM+vpE1g00sZNxIltac9Xi0oDWFxwRc6PsTPo2qot6t
	mMjmJ3kxQrzzFqw7aaa4sE4OAWJGk2iJvjRtzws91NYlP+o8Jl4TZsrlUMtn5lQT
	HHcwN0sVjghJ9HSEHZ/HfBYFsFvFwimAs9v19jKM78FKVfxtrDwO2yD/UytwAkxH
	8x1FEoqcn4VqHWXrsnKeALaJGFXUP3L8sYUNd3E/9XMUYIS9ZeAE0QOcK9Nr8OQH
	cT7mCKM27nTim4Vo4S5F5E7m73unPfyaJ2gtojPJZYKyjYoYDN0kXNQiM4rWm6L+
	C1r4FTCbKfckYdl9Q8Ro6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt9y96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:04:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCcc38040786;
	Thu, 25 Sep 2025 13:04:36 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jqb07pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 13:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb/dVShHyBLtiEQH4OKXYDDBJZA4oOENljUsmbRae/na62rMiAK8jIg+9GBKmt+ESyheqZA+y8LdWeG2dFGmUQtRlsUFwWsxQZrU4cl3UJnyR4dFmwMBWoClv56kdPsWr8N2xWXupTLi0qi/zAbcUk6VUGd31jWCa+WYgv65bV71v/824rqGhrfdSPtKCHk6alpACSDalvfJWdqmdImR7MPDYozwiC75NGJiXJWYeJNfZIDq5eQ/DyQu4IykRbi7WwaNEjfBZX1QXQpuebbU8l0+Fq0apsw6ul/02R8TJsIRne/5VWpFZdAuex0YLSqG6wS4bAOzPMyPAosjWWXygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8STjDPIiqtkb/Brqmi/DaxYV4iq2NiKaPfgFwu9zB/Q=;
 b=QPaheQgqIjYYqmrdFoVsEFHZfJGERjEZZ8zdqxywaQajTpJ4TUbxlFzxU5Rk/IDqMwgbwYj3WGum52R51P9jDymfXC8bO3locrZUW8wXTNGiZsqwvtTDJfYrjZn5PV5/F4rydoJ9WGvJSpp4FrHMWFPgr4rA5AvaJEcCZHDQiLXuhKzT17g+QlxIiI7DxLCLvSCDpWW7hwS62RsAK7dlKUcDk6FroPweJe/cVazY5qVVCQBnHfxNb8XcbiDK4Mhe0XyETHE5+ibyoalmcw5Lo/Q+IYDtRA6FOY3FO2SCQ9bRStql6mBRBTRtZDseC8kBUWklXtFkh6aTy3126qmBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8STjDPIiqtkb/Brqmi/DaxYV4iq2NiKaPfgFwu9zB/Q=;
 b=SkrNglfx4jFSu6tPIj/KXJeZ+Yin3xwte0Fhq2K2uo9EjwSOP8HZLxD1qgGGKeKHYfB8fK3CQEr9JuLC51hmG8sfnkFw7i1LvoeYGcR01/35HdI3O9+3NIsJGkeggTmHrmZPhXLxsrMVRkVHGN9prM7QzcJtpv3a86jta74VS8I=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by PH0PR10MB7061.namprd10.prod.outlook.com (2603:10b6:510:284::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 13:04:34 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:04:34 +0000
Message-ID: <7efcbaa2-aeb7-43e2-8aae-852b9c0f06f4@oracle.com>
Date: Thu, 25 Sep 2025 15:04:31 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
To: Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
 <a2f6775f-0be5-401b-bc01-effd3f428482@citrix.com>
 <20250925124332.GA3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250925124332.GA3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::11) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|PH0PR10MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3a8657-4a72-4779-babc-08ddfc3412bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFFJN3IrVXM4QTFGKy92SGFaS3hvcU5KcTZiek9zQzFPb0x3NTZOb0xsUHYw?=
 =?utf-8?B?RlM4ZXNveHM4ZjJMMGkxQmhUV0gvellFMEY0dVJkdlZQWXBwOUFFRkpJVTFC?=
 =?utf-8?B?aWtkaTI3OEV3YllOR2RMRnh4Q1J2dDgzQk1vYlhoNTN2R3E2bm5DZ1c0M2h5?=
 =?utf-8?B?Z1FWMzExMTRocFVXSFF4NzdWNUFPNVNCL0lhS3dmUEVPUEdydEtHZWp6eDZ6?=
 =?utf-8?B?VWp4M0M2bUExeUpuQXFIbTBiNFJwZVNKeEFZNGFvYVcwcnZUNUZtR3dmVU9z?=
 =?utf-8?B?cnZNMWFUVUVocCtoeFZiQmovZVNqb05vZlo5V0pHeGU1ekkvdFV4UW5UNmR5?=
 =?utf-8?B?L3p5STY3WGYwOHJYSGREQ3QrVjRkVmRKS3U2UVBickNTQi94VTZCcjRoNVhv?=
 =?utf-8?B?Wmg1SWJqN1ZmR0dSTlVQaG9iV0ZGUTVKS1djYlM5SDJXSXB5SHNqUEJ4ZDZr?=
 =?utf-8?B?ajZKZW9PK3FVQlBHbHRxTU1VUHJkcDNuK21XRXRxQmNOZ1pRbUVQSzNiY2ZI?=
 =?utf-8?B?bTY0YTE2Vi95cHNOczlXSjF2dlNPRzlSeDR3VFArSGxFMmE4T2loUDR1VWFJ?=
 =?utf-8?B?QWV3OHNWYTZlMytFc0NKbFdzbk5OMlhxbFV4ak8xTzMxbjZ4NFZDUU1PYVZF?=
 =?utf-8?B?RTJHSUkxZDFkMGFsbm9Xck1DOXlwT3MxN3pHWGRMMTd1Q3lpOVFkQlRCU3pj?=
 =?utf-8?B?S3NEbk9wTTFzcGoyVWJIL1hLQzNmamt5U1FYQzlXQXZGOUhFMVI2Y1Q2czQ1?=
 =?utf-8?B?UDBRN211Vks5azA5Tmg0UTQwNlJBaXJxbmxRN2EyZzlSb0lIcVIxTVIyUjdR?=
 =?utf-8?B?N0g5UFZ0KzcyWVNSa1hZZkhqMU1TSko4YWpmK09wMnlzMkpuUitxTE9yMWZN?=
 =?utf-8?B?R2ZBSklGRFlqdDl4OWMyV3BCZG96OTB4SzVaTHZoQzVjY0pndStPMnBray9w?=
 =?utf-8?B?SGlGV2l3Qnh6dE4xL3FuNnFES29QRVZEWm80ZW12TVlCemdBejI3UTFpbVh6?=
 =?utf-8?B?dFZySzVnRXkrY09FL0xmZzhhOTNLNlZEcHRtU0FlRTdUSnBvZ2JCOW5WK1NV?=
 =?utf-8?B?Z3h4N3NWQkpzSXVxUGdpV2F3MWl1dDdFYlFnT3lTZ0lVYUdjcmdvd2xWQURt?=
 =?utf-8?B?dTZUcW1LZ3ViWlBzU25iUytDK2Zzd29YQk90QzVjelJFNVAwbi9jNEcreE41?=
 =?utf-8?B?YU1CYXh5S0Q5d3F1c0ZUSlJ0K0xoeWlwN2gyUGxacHFzRTFsNXlPRFY2WVov?=
 =?utf-8?B?Vzl1SFNoUUJEOUtmM1NmdWVaZmdYWkRHSlZNYXZJUW8rcG5qbnp4d25IK1dP?=
 =?utf-8?B?MFh6N2MvTnNRQ01Ddm1FeEpncFNsQy9PeXFNZjhscEhPbUhJMGVWSmx4TlRh?=
 =?utf-8?B?TzMvNnIrbzBwY013bTdqMDdjTlM4WHk3WHFwM0lidVNNdGZ2R21NWnVubWNu?=
 =?utf-8?B?NjJONFFESGZjblFKdUFrckwxMWFEcndCZVY4SDladTlrWW9uamhkaTJmQTY5?=
 =?utf-8?B?TzlHZDVWVzc4bUFNempNZENabGdOcm9VQzFEMERkd24rSDlJTk5HZjB4Q1Ba?=
 =?utf-8?B?dVQ2QXp3RzFRLzEyK09zLzY5aFgvM2I5Z21ETE93NFRGQStyOVRjd1VHZTBI?=
 =?utf-8?B?amZxLzBSRjlvM0U0OERXMU1xcllVN3lIK09CYWRxazcyWkV4MU9vcVpaOEZF?=
 =?utf-8?B?TXNQeEpBZVRXRWU5VDhIc3Z3eWU4c3BqR2haemZLT2hvekpMeXhKMWdkem80?=
 =?utf-8?B?a0pHcDhWUFhTTW5id2RBTlBCcWFXSlVxNW16VmcxUG9ucHpQY1Yva3c5NXZX?=
 =?utf-8?B?OVVzSHB4UmFDeEMrOXI1V3JRNHRJNXl4cXpFbnVnMnZKTzV5UVRpdzB0b21Z?=
 =?utf-8?B?Z2h6NWhBR0JtemdWd3JVWlErSDlZMzdBNERhampyZS9lQ040dnhtc2FZVTA5?=
 =?utf-8?Q?4biCJkbAnxo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXpnbS9YMkVqN085YnRNYm1NdE9WWHpMSG1pUnNxcUo3QnhtdFR0SnZ2bm81?=
 =?utf-8?B?OUIrRE9EZHhDaDFKRzBuSEZ6VlJoU1RwOHA5QmkzUXNHVklHTWpmRWZ0dC9o?=
 =?utf-8?B?YTNxdHZiM2NqOExLZitYd1NnSWFJaHBoNE9ZcjZyYTkvb1lGZ3JkdGFUaHdn?=
 =?utf-8?B?ZkNEa1QvZjJLYlVEbEJEN1JnZWxXeXpLdlhPVkhOWEVPOGc5U2R3eDJZNVV3?=
 =?utf-8?B?SWpxeVpZeUZaeXNhL3dTbGpZaFpRVEE4RnJ2TVI5VUk5Z2twTHhCVWtxM0dB?=
 =?utf-8?B?NmNPOGpvVS8rNzJtVmNxU1RNQzFWVmZzTTN1dHRDc1NmRlZLWTBWblVrMXJB?=
 =?utf-8?B?c0ZQOFNMWTdYVld4T3RuRFpjaWpoOGJNQyt3eURrR0RicUp1OVV6ZWtQaHBo?=
 =?utf-8?B?TlNRaGI4bi82RnBJVGxEV2JrVThhYTVwU2ZLNVBEeHVqMXRWcjQxbmdzVjBR?=
 =?utf-8?B?aXdKNzEzcEh1ZDQyUVNDOU5JQmdReDZKVVdRUHZDWE5LYnFUV2JiN0o0MlpP?=
 =?utf-8?B?Q1ZPVEE4V3plSldEclNjbmRoSENRcVVIcy9wV0dLdUE1M2t2L2l4Y3JRS0Fz?=
 =?utf-8?B?Nm1HczRJTy9BVTNXVUFjMjkybzV1RTRhaUp2ZFROSzZCREFpSDdzWEI1VEox?=
 =?utf-8?B?RVFtSVdxMzREZUN3REgvM1pPYUJaaFBucDdVUWdRQ29CcUpSYjk3SldIL2FK?=
 =?utf-8?B?VThOOWxCRW1UK2tqWkVuK2dmZTJhNzZkVEM0RkplV3ZwV0ZjT3BSSFlEZkIw?=
 =?utf-8?B?REdCSFh1d1VockMxMXlLOVFsY3RzUlVvNisxZmxhcUF0S2NwQUJGbk5zQWhk?=
 =?utf-8?B?QVNuVHEzcHZ2NWtiZC9FbzhBbVE2VTJRTWl6Q2hTSFNGTHNudGQvc25kOWZQ?=
 =?utf-8?B?NVovdmZnUGpJS3FzRU4zSkpZM2FpaStnYkFmMmtlZjlkcXVxcG5aTFNhWTV3?=
 =?utf-8?B?L1IzdUFkTDUwMEZ0a2VnQnJBN0padTIzTmF2VDdseERVWmFDVWdNQkgvL1pS?=
 =?utf-8?B?RlBFNVlNWEVCeFJ2S3NnTkZXSVVzb3I5bnFDdjRUQnF2bkF6ZC9hUGl0cHNJ?=
 =?utf-8?B?MWhUMm5zdml0bFJpTXpDWkI2aEZTRFJNdUFselJPZ3ZLQUdCYm93djRaVUtn?=
 =?utf-8?B?aVFjZnBUbXVaSXVkNzJwSkg0NVUzUy9EN0xJYitvQS9mYXFiTGZVaEtUd1dH?=
 =?utf-8?B?ZjR0MnlqWGJkLzlnVkp3WVlkSUQ4RzU5MGZUQVdwRGNwNzRQa2FVVGFXaXQy?=
 =?utf-8?B?K0c2RkNyM2VYcUxkWm1sUThLNHE1Q0txOUxsd2ZmREVBRTF5djc2NU5sSldI?=
 =?utf-8?B?ZlVTSHc1OVg0STdSOUVvMm11VUhyU1o5OW1aM1dCQ1Rwb3g3clZlYTA0ajQ3?=
 =?utf-8?B?U0FWOVY3b3pxaEJwUm1nMHFBUkVyMGExb2lnejhkOXhSRk0wQ3kvN0oxLysx?=
 =?utf-8?B?MHFRajJtRVh1N0ZVdWU2N0toRXZ4UnJLWlZXczhwR1NrbWQxaSt4N3hvdlo2?=
 =?utf-8?B?Y3YwY2haWW9keW9oYUxSemtrbEVSR01obmJMdkgyN0YvY0FJK0E2eXJIOVZI?=
 =?utf-8?B?MUQzY2w3ajduRGdnMUFMSU9UKzcxT0lHNzB0OVA4Q1FFSnJSYndwU3c4eXJn?=
 =?utf-8?B?ZDFsdEY1d1RKTlloRCtDZFcvS0dRZkozSjdvTW5nQ1FkOFV6SkxWc05UOEFz?=
 =?utf-8?B?K2lUREIrL0VINmxVckx3WFEyakNBODdnU1ZEWCtWSnAyUlcrY2NndnREQmY2?=
 =?utf-8?B?WXIveUw0bXZvVFdoZFFKVnN4WmducC9adWZsdWI2VVJyN2ZYYXZ0UWlhOTU4?=
 =?utf-8?B?bVB0Y3FjdHgxeGpzeEJxeENxUDdjSWhvb1duaVBoMTIybEVmQndmYXdQZ21r?=
 =?utf-8?B?R21WR1EwbDF6MGRSeHAxU0FyamdZb09TQmFPdG1aWmZYaXdMaE0xWGpTVHda?=
 =?utf-8?B?QVZtQU5mWGl6WEpkNlFoUnlyVnpHZHhreE9ZZkk3dlU4RU1vbk1wdUJUUG83?=
 =?utf-8?B?bFk2VmV4L2hjUVlRWGlqdmdsYXkrWTZGbUNuV0RRdEdxRXZmRnlXeXZabjVy?=
 =?utf-8?B?b3lWWk1tS0lXb2ZWZWovUW00M0FFYjg4TTh1bWw5cHdENmlIR0RhbHpsbXo2?=
 =?utf-8?B?M2FLU1FVR1FkNStoWUUxenFKUWQvQXJDd3dRN0hjQnNsbE1VUWJidjNpYzB4?=
 =?utf-8?B?UmJCTFZ1a01NcUdNSkpQYnIrYmtVREEwZU5RZStKUEI2dEhPb0tSeTJ2R1JK?=
 =?utf-8?B?WE5UcnVubnpiTWM1NVMxQSs5UTFBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zt1kfUlxCtrPd7E8vP1P1PdtnSILV5+nYBeHlc3nWnk05aDeiWfXDk3viHAtdzf3+pwbANDYYHOBr9ThfZNQl1rTdRwPbmfo3dKwsNQMEUilkg/5VbA0h/+0w4DbreOJLxuBlLQ2tRskbcEoSPicCvit7m+zVnkRen1rYd1ei8loCDohtFPEhnKW1jIhcXhVssOqUhAIR6CEz3U4XnbJrxLIUadB8TFZg299VGhrR/HsiEam1yt7z95BE2dDCJP42yWoux4ngoy3g8Wyh+DCwOH3rtDoTIqqYuiZoT1+yCLTgHQzANPv/qJBRbWC5n6hTMz42hPDr16gm30bF0llzjK/6UmogK2oWzuUZOqIk/WDIvPIM4qg9aZzYbdpbOTJ7nyr1U0bXnBNljmMpX4a3pHRmU1IfJDemMoB5nVIonf2iqvr2AUu51Oh9fGJwyoDn26hKyYH4Loa08EShtqUbrywCCe9WmbzH4H1nII9NYhx5FTXsfPrb1FCpROC7H3u6XboNON+f0mb3qwS4X0pODBQQQ5B/buqCbKrrx62+XKxCfZtY/EaIWlXs5rsIw5k6GV7eHYpKSRrysIx1ognzImoML5AL5gra8nFdCaa1HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3a8657-4a72-4779-babc-08ddfc3412bc
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:04:34.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omhJk+BR16TtzCLg0mL4b8S2XgYbKH2ApVfrh+DlVT2lsFPWaRicWRGERDCMozRvvjvlZLKZbCpiGz4UP+RLFtj9Zxhub1Wnv225zB4pXRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509250122
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d53de5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=0oqpFwLfRYPdpCEDvRcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vHV6tGZwpvTHbQDT5cpdEMgeThPr1gD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX9SbswvGTiegi
 btAUK46eqNdtscFe3rn9RG9hF8xpZkBW3diiMxMHwkGr8xfqRnCis3PWBWMHO/HW/xt2lw9XtOv
 Il8K7FsQxWTNgM9ygPvLOZDnJGnN7+XG80wi4nXg0gqEovNN6Gy6bF4nWblYKv2yO5jos8WU84U
 J8SOAkbQfVlcKdQhfn/wIQI2hpDYrMkskufd0kFKLTOjePJWVxB8JAzMn5/RsubWWLXjI+1qyB4
 dawYKj2SMY3kvlmwamlekRxucLjfvxvqnj0ujAUE26K1DqSSQ1mAyxSuogtWumDsLA84j8ObQAS
 5TJq6oxmEOv7yb1sOceLI0VF/Q1//VD6/n5jhhEsdIfXce3+S8Y4hSpCWJGoxZ7Lb0q/D2G6xXV
 55ucSeXX
X-Proofpoint-GUID: vHV6tGZwpvTHbQDT5cpdEMgeThPr1gD9



On 9/25/25 14:43, Peter Zijlstra wrote:
> On Thu, Sep 25, 2025 at 12:29:18PM +0100, Andrew Cooper wrote:
>>> I've made that:
>>>
>>> 	case 0x90:
>>> 		if (rex_b) /* XCHG %r8, %rax */
>>> 			break;
>>>
>>> 		if (prefix == 0xf3) /* REP NOP := PAUSE */
>>> 			break;
>>>
>>> 		insn->type = INSN_NOP;
>>> 		break;
>>
>> Legacy prefixes can come in any order.  What is F3 66 90 ?
>>
>> Also, VEX/EVEX/REX2 want excluding too, all of which can encode rex_b
>> differently.
> 
> So luckily objtool only really cares about instructions as found in the
> kernel text. Neither f3 66 90 nor VEX/EVEX/REX2 prefixes are of much
> concern.

And it looks like objtool ignores VEX instructions earlier in the same function:

int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
                             unsigned long offset, unsigned int maxlen,
                             struct instruction *insn)
{
        ...

        if (ins.vex_prefix.nbytes)
                 return 0;

        ...
}

vex_prefix is set for VEX/EVEX/VEX3/VEX2.

alex.

> But yes.. I happen to have an insn_is_nop() function that can be used on
> userspace, and that certainly wants to be taught about these... x86 is
> such a pain :/
> 
>> Is it really only rex_b which prevents NOP becoming a pause, or is it
>> any REX prefix?  I would have thought it was any REX prefix.
> 
> SDM opcode table and instruction reference seems consistent with f3
> only.


