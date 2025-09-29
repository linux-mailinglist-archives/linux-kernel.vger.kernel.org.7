Return-Path: <linux-kernel+bounces-836363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBCBA978B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2181719DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF1308F36;
	Mon, 29 Sep 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rqgSe57F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="smJUiFoy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B029BDA5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154698; cv=fail; b=aqZ4URrTazk+E2hQ5ki2MiDwzhTuL38/t0JAOsAX2I8u0uSqWwEZvgZEOcC9u/pHbAdh62s14k41zaLqOuc1leKDOd3KgJDc5K8qL7utsSCKuWWKSzMyney5LFF2Nh8/INUmO6JpQWVyL63rKIY5QqwkEF93KkmLUqMObqb3rIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154698; c=relaxed/simple;
	bh=bSlCiKL6XEZGe+JsHYhkN7f0tyPkMHUkdYhWYvlQu28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i8WoqngZ/chexWtYDLjoYEghq6ML+38E0qHTyGFt+5ZFs94KiogQ+99j4511u5zOxMB3IN1bDmFuQAavw4pGfX99Vy/JaMmj5YhvsLlCqC0Qdrxfwr2lEmUKIhfTkTDPSqddqRFfEGH6uR1Q608X4Uti02iqN7G+6mXcDnE0lc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rqgSe57F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=smJUiFoy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TDOVXI026329;
	Mon, 29 Sep 2025 14:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Oa61n276xq9RwTLwJ3
	gndaaSD+rTws9gLDsly8WBQUA=; b=rqgSe57FVB/nCPE24DRuLQWTGM/gcTIn47
	TaJCDGDp2hau/p7t8/1mIlboDBWQlIdQ+ZrvDqjwFxxMljWnWMVyXfg+rB7K2xXY
	yEwnyX1ZaCH1OaA8ECr58EyyfKA9Csffk//y+/fMNmc86HU2CG7P2MTKaYQfC+vK
	vHsDr8tAUHLmgnCH1bH1fPVtOaIvcQvjRkzUck2xpA4WHX+WZNNh6UclCBFp+wKX
	QUfX7c9BwILa7k0U4EthFU3QcLjbUrLXpnLwC+JWUpbhBJnV4rJ6ie0ufyp9QmiW
	ZBooNjOTTMUcdIiPYc1K7x14uTaYHsfM4UvneD0Q8wyVTQAfaS7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ftye838x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 14:04:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58TDHN2Q007187;
	Mon, 29 Sep 2025 14:04:29 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c7g3ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 14:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Ls66irjjo7665Vwh7N9JMXGTUUqnxXazMfu9+4b+R2DHB0/+ap+4NX8mbFdha2xZJt60tuv18qtXr28rTnE4wiqHrxA6u2jdfJiDzi6hfbdChNUlYLAvfIVFGkQ0kcTxYtibNpUaMFTotIw1/zwzfSaUcgMKZTT1FA4om05oe40Fg1bFgcz4eXL9w0jR7JSMdXNBjIOalEvqVpm67AmZqnH/pzN0MYIcyrVWCfjJeIlOXtyoZrWmvIQQlXz44lhYIntYPkyJs2aTTkZ4cYMsSxVRjvLYE4qQXsvrrGljRYIVB4fXyEMOZDEe1qyu+4KY/jA83xMs/RyXTMAJGexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa61n276xq9RwTLwJ3gndaaSD+rTws9gLDsly8WBQUA=;
 b=PelATVBrVUEmnypFWdjvXLYsfBMwEl5CzIiK6UpxYGCb41Y7v2nFbsuuTeHuzEhP1Uz4hgAPDtusBTQIma8BlEn0yo3Z2XMEYgkv61MYytVPm3KqP20ESf4MV0uAtCVekBZta7ug+g+ZK0MD7MYdqZ0EBKjdETFRWb6dlSS6FpuRosvx232Zud4XhQCl1kUpBCpjrNjJAxToZDRgcCWb8ivj0bqiaTUcvSF0zEZOuH0gP3R7LFfK/guzwCtc/ObvSZ6N9esvNQUCNWYz6hylpd7FTgWrvq9axQCZPls2yRDt92P0QAuYve+VeJrsgUfa+6wn6jU1CUfWGw1eFY0tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa61n276xq9RwTLwJ3gndaaSD+rTws9gLDsly8WBQUA=;
 b=smJUiFoyBq5bmMuSV5eRpE0Y+3toaZxAc0C0GQkSezsAr7Rj5vSUuuz2fQSAnUiSVYCxViJMyZ56p/5O1wKT8LewmLvXRaf8CMuSYGS8ACX8L9sYWukCWe5d6iueZRSKsddQncZ/qNrB0jB6GvxGxkeHAtlBKebYWHWNXHy2KYw=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 MN6PR10MB8093.namprd10.prod.outlook.com (2603:10b6:208:4f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:04:26 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::156d:21a:f8c6:ae17%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 14:04:26 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stable@kernel.org" <stable@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "trond.myklebust@hammerspace.com"
	<trond.myklebust@hammerspace.com>
Subject: Re: [PATCH 5.15 2/3] NFSv4: Clear NFS_CAP_OPEN_XOR and
 NFS_CAP_DELEGTIME if not supported
Thread-Topic: [PATCH 5.15 2/3] NFSv4: Clear NFS_CAP_OPEN_XOR and
 NFS_CAP_DELEGTIME if not supported
Thread-Index: AQHcMUn30/LW39Rc40GXNX8cy6Vg0w==
Date: Mon, 29 Sep 2025 14:04:26 +0000
Message-ID: <f9a9080e416346d38d9a68ff560db4cd25601a56.camel@oracle.com>
References:
 <1d4bbe4e9b6e6909067d8d5ab704e5392ec42bff.1758805195.git.siddh.raman.pant@oracle.com>
	 <2e811427a30b62898f63bab33ec07d9253061a33.1758805195.git.siddh.raman.pant@oracle.com>
	 <2025092903-plentiful-banister-9ad0@gregkh>
In-Reply-To: <2025092903-plentiful-banister-9ad0@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7505:EE_|MN6PR10MB8093:EE_
x-ms-office365-filtering-correlation-id: b961e644-3240-434a-d1af-08ddff6119c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?cmsvRzlmeTFCN0oydEdrTVVvKzdndUJyRnpQTkF3OEtMNVI0MEtpaERxVnQ0?=
 =?utf-8?B?cEU0ZTBpTmIxVmY5STM0MG1QUmdIenhzeGFteDNpUmVoUDFNemZqbkw1SDBa?=
 =?utf-8?B?RnVhd1dheXBYTCtEajlLUWttY2E5dHFiMERnUXBqL0xOaDV1SkN3NkhyS1Zq?=
 =?utf-8?B?bERNbkMyeHhjdUhSVXpRK0ZBcTQ0NEU1VHhMeGhrVVJZMnBacEZ6cFNJQTBW?=
 =?utf-8?B?UVFyU3B6RlRmSHFEaUs4U1BHKzc3TXhGNHMvdTNIL1paZDNOM1Uya3BER3RV?=
 =?utf-8?B?RWNaTnhFT25tTzQrUXVvY0QzcXZZWmdkemp3azRleXg4aVdSRWF5K3ZiRkpQ?=
 =?utf-8?B?RTdWOUpUM0tKNGdvRm0xQWlKZmdkRFM0Mm9ZY1NObmE3RG1kcGxzOElUMERT?=
 =?utf-8?B?dFVWNmd2UzRGYld3bEcwZElPaTFFTWMzVUhpMmlwZFdyS2Q5NXd4a3RqUWd5?=
 =?utf-8?B?aG00cWYwb0FZU3RycFN6T1NKRFpQTmM4NlRKUUMzbzU5VldjaUNPV0s1aG9B?=
 =?utf-8?B?RFUyN3JLbFl6RjRYZTdQQWpjRjA3cjVHN2RJTG1QUzd1NkZNcEpEbVRxL0pm?=
 =?utf-8?B?SXVmTzZnaUMxdlpHU0o0Sm1rK20vcFJsZ0l6UXFSeDFoNFh3ZlB3dDlTYjNr?=
 =?utf-8?B?dmsrZEdIdy9wcSs4QWlXaWhLYmxBRVQwRHh3QUxiN25HVjNBZ1hqVlpwZWta?=
 =?utf-8?B?b3poZWszTmVMVEtTL21QZHpsTG9hSnM5VmRiTHlTUnB6ZjhlcUZPMEhwcDB0?=
 =?utf-8?B?WHFFT0ErN1pmTERGQXdiV3hacFFydEVqNUM5T0FWeXdmT2NIL1k1NGNPci9r?=
 =?utf-8?B?OEU2dkMxM2pVOUdwOFpFcnoxaWJwTXc0aUdUWFQ3WkpCendoTzFqS292cHJ5?=
 =?utf-8?B?bzBtTkp4a2piR2NSdXp1akRCVDRQSG0xQk0rc2IvUzlhVTVBQ0RxWlBuN0VZ?=
 =?utf-8?B?TnluVUYrWVdxek94cFFCRjNSUW1TdXNwbkhMRzFrNUN4dlJ6MTVQelBQZ2FV?=
 =?utf-8?B?MnVMY3NtdmU2K0IyUERmaWxMTW91cWJZaldGZnRKUFBUcEliUXNlZXlyNmNH?=
 =?utf-8?B?R2IxVmpjYkdPVmtLelFTY1dzNGVEYVZTOVIvRFQvRFFjWGI5YkFEb3Z2NCt6?=
 =?utf-8?B?WHlaTTE0TmhEcWxVanQ5NDJ0M0dkMjJiZ3YrN05IOGE4UDZrWFFnV292K0Jm?=
 =?utf-8?B?SzlxS2NEemNHQ2p6QkxKRkIzdXBPZm9waTFVNHlXRmMrdERyYjhvdFQwTjRx?=
 =?utf-8?B?dkRtKzZrWjNKTzhZOUtMOGQ4Q0FkV1ZFQVU0WUtJbmhJeFlydFVBUkhiRHVl?=
 =?utf-8?B?eHdiVkJMTklTK2dwVWplZGprRzFxNXZEM1ZtRnZTNWFNcUhEbml3L1lkVjhT?=
 =?utf-8?B?Uk5YWVovZlQ1WGUzS3pKeDM2RHVzVis0VmJEdnFNaDk4aThOdENZQU9XUmhD?=
 =?utf-8?B?N3FicWpzRzhGQjM1ZGI3ODJXdkVkKzB5N1ZvZlRRcXIzQ3c5ZkZzRlJHSlZI?=
 =?utf-8?B?bGtjNUxtYVduREJrRE5oandqbm9nRUdzeVBZcHZZbmxDQ01NMmZXb3paZVdT?=
 =?utf-8?B?OEJmMUkwNS9WRGdXcVJGM0hrOFIzWjEwU3M1RVlBOEtoejJXYjZhbUorUDlh?=
 =?utf-8?B?aTRIYVNlTlVLZVpOU0cvMmw1c2JXSDV5dms4aW45K2hhT2gvSmw3RXJ4WVNX?=
 =?utf-8?B?T2dyL0JrZXJuTi8vUVc5eDNSNUd2MjkxK3lmUEpUeEY1Rko4RW0vMkJ6STNC?=
 =?utf-8?B?M3llSnFzSnRwSWh6YUlqMGVpQ1VCUldockdJRHY2WjZ2a1dieTNLTzdrZjBi?=
 =?utf-8?B?U1lXN1dsc3ppZ0dFcmwwdi9Td3VwMEkwc3p6N2tFdGdhOFhjcXdNUTlRQUFh?=
 =?utf-8?B?bUNYWU13SDk5MDhaNnlTbUwvbVhESGJ1eGtNM2tIYVBlYWNuQmdJUm5NL3hG?=
 =?utf-8?B?TlVDbFVMcEZtK0ZlU3VYczNvcDFUNnR0b3FPVkdSb0o0bjRLQUMrZWhXSnhw?=
 =?utf-8?B?NytZaHpSYVA5Q05CQWZxZ0JsRUYvRyt2SFpyaWh1cm9KcUI0WXdQYnFzSlVW?=
 =?utf-8?Q?7hCU4m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUtaTUpMM0NiQWdZdjFKajIzZHhrcGI0SFFpODRmekkzTytaeUZsMTJJd29U?=
 =?utf-8?B?L20zb1gzVk9NSHVrSFhoakQ0eElscS9EazJORm9rOXhWTlRML1JhVHdrNXFj?=
 =?utf-8?B?OXowWkVMcVgrNFNIYWRmWDg1VEt5dXVwcWJBanRwNDEvbGJ4R3NwSlJ4b2ZQ?=
 =?utf-8?B?cjdZOWdhR0xMY3lNS1BkRGtpTkdSdUQzRnpXd3NVTm9wa1pNY1Q1di9WQ0Fn?=
 =?utf-8?B?aEpsdVR0UWdrNEhJbk1idFhabzJ5SlFWYXk5eXRBVWpOc0xkY1F5V2RNd055?=
 =?utf-8?B?Ui9QRmRRUTIwcHBnaE5XL2NXdElLSGJNTFMyK1htRUlaYk9zUUlRN21ZeElh?=
 =?utf-8?B?ZnlERXAraEZvTy9WT2VjUUZXVGFlWDlVYmoxMWVNSmpGTjBza0lMaVhmeEFB?=
 =?utf-8?B?dDg1bEhHZmxFdEVRRDBIcUUvWTBwR3pSQmUxV1JKUDZJa0ZQbUZ4MU92dUgy?=
 =?utf-8?B?RlpCSkxVN21kaEpxVXVnQ2lmZnJrNDQzY1JkSVEzZE14MFV4Q084WkZNeVJh?=
 =?utf-8?B?MmpzNTMyRW84cDR6SGR0bTdzVEJqZ2ZqVWtXcFMxSGg2L0MrNnQxOWNvNVY5?=
 =?utf-8?B?czNBUklFNkhreDdnOTBpUHVJT25LaHhxeUxTUzZuMFp2ZlJBeUZrK0dPOXlp?=
 =?utf-8?B?V09NR29KQnIvbVFleEJlYWM0bkk4SDg2WkVKNHBPMVNQamJxQXBFc2lVUVpw?=
 =?utf-8?B?NnVqVUUyRHZUVVJLeVp4eTFHbmdtMHBLUjUyYnc3VjlBK0RtNEZLZXVsMzdz?=
 =?utf-8?B?K3FYZGt1aFIxSE4vZ0Y2QW9uTVA4QVBMUWJtQ0wvRHJ6L2tTcnovZld1NnlO?=
 =?utf-8?B?NDV1bTh1dUlLamh6LzJOa3o1OGpSSGRUS2hzbk1mVWUvMklvQ2JNWXlYKzg4?=
 =?utf-8?B?L1MwNzFacGo1L0hMbXRBMXBkcnVVVjVIRXovUVRtbTNQUGRHU1NzUjRPWmpI?=
 =?utf-8?B?N3FlSXRaTVVjREdrb1JLUGFxb0JtckQ5Mzc1dmtBOWhwRFhZUVVHdVd6TXRD?=
 =?utf-8?B?RnpZbXFFTm9BQzhWK1dRbnlOVkZFSEhyZnRnYXlaYVIybDhoeGZabjBDOHBP?=
 =?utf-8?B?OE0za3hHcW9UNzlNSTVJZFhKc2tQNjBJRzBkTGJXY2xxY0lhbC9WQVg4enUv?=
 =?utf-8?B?L1plZ1NtdXNKWFN5cEsyMUxnZExWbnovdFgyWEwwdUlUZjZ6SU5ob29HYWZZ?=
 =?utf-8?B?U0lBVFhGWmZvcXRWUnE3MVptVDA0d3VaQ1czbDVackRKdDJENElTbXplYjdv?=
 =?utf-8?B?MXZWZUJhUURFOGQySHZZUmZGeDEvV21RSFZLMUtKdkVWVi9EWi8vWTZVYUsx?=
 =?utf-8?B?T3BnYk1yei9LZWVpZjl3cURHUG54K3dvZEJ3ellHaVR0TGNqUFVUTGZ0TFdt?=
 =?utf-8?B?aGZxUnM5eXZmNlc1U2RBU2RYaWhJQmh0NmZBRlpQaDZzeVJLS3JtYTVwSTFs?=
 =?utf-8?B?UFRKbEhpMVlJenMyQXBaOFNjZEdwWnl3dGl5N2tTd09EUUZwOUt1TjVod2xw?=
 =?utf-8?B?UlJ5M1pZcXpsd0V5SkQyYVJWZG0vellQbjkrL1ZtRXVhQnhiWE5JUGtJZGdh?=
 =?utf-8?B?S3UyVU9qcktOa05xb3Qzc0o3K2hBMGY2ZFVIWjd1UXJuajZ0Szd6SkphdFlx?=
 =?utf-8?B?YUJpMTREekhGWTJVQ3UxTVlnYW1mYThFY3VkNUp6ckJ3Z2NxWklBZjVUVmRn?=
 =?utf-8?B?TnRyWGYwR0NkOHlaWUlFOXlVVURVQXR3OEFONHdsYkM0azFKSHhzS0loRjhG?=
 =?utf-8?B?K2IzUmloZ1lRVVJHcE9mdHRUREhBU2dlV01ncmcxMm9TU1lYNzJzWEVvVWpP?=
 =?utf-8?B?WHhLMFpHTkgvZGFsa0xoT2VqdlhLUHB6ckkvZm1QVFl2Y1VENjZNdXplc3Vy?=
 =?utf-8?B?eS9aTmltQ1RmTHJTcFVxUWRXNHdIL2d1ZktoUVpQczFUVmpPU1dvUmdTdlBW?=
 =?utf-8?B?VURoSUR1ekl2UzVLdGdxNWE2OG5Idml5Zll0d1JhM2dSQy8ralc1dG5McW5z?=
 =?utf-8?B?UklJSm9VNjFHU1RlQXcyVzk0R1NTMUxzdzJuaUNwTmtyTy8yYU5hNTdsdW84?=
 =?utf-8?B?aXNrS3VkSUdiTUI5VmpOZSsyWGlCZ0RjbEI3VnByU0Z0NHc3OWFyZk55a0g1?=
 =?utf-8?B?N292eDIrSlMvMlhHUVE3OFBJa2lQWGMza2t1b1pqck9JQU52aXZtUXRqazho?=
 =?utf-8?B?NkluWXRYNXQ3ZC93SE9DZ2p3MWlnUU5TWlBtMUFTL3dST0ZjUmZ3MlpkWlFx?=
 =?utf-8?B?ampQNDNXZ2RiVWdiVGQzcjlpbjNBPT0=?=
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="=-rQhUuDQAGNv7sdENkSrs"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wpsa4hUZcIa1T+R/SszMDvH5jIUvzk09/gKp4nW1iczfO2xUuBw31hn+s6Unz4oCRKs2QZ9L1H3F3PqNe9dLU6tIEzZ4TG3QI/O4wxTqUhs65S86xagEx9NfF23tIq1OCUhYrW01xubL15uahZ4zl0lr7qsKp/JUzq+pe309DNmQMpZQ0hqTZ4Cy5s/LF40RegXmbCF0w1gfONNOqePpr/ikvpif1SfCkvwX85XXZ6JNpeXMD9VbG5oALJkBoa3Y3Owiuxr1D3jIUP+ckAOmLcDp7kF6Bd9Pfe3A8RPVAnBfAHN5XtBKjI1BFtHHk4XWcMt8udGH/Z2DN0JiAA9iyGD6339t0rz5O7PgZ4ZTryVIq4eC5OylX4M87PMo+CUJ5khNuUkj12UVC1UxdHGtX9JaWKHfMAr+lwPEx6Dpj/9luTL3DqYXYygk3yuFQga2rNAvG9J2MKtMnDvNn/ChmwpmthgAZfViaWG1U1NwIHbIsdpJy71Wj20LFbaaMlGhDCw+V8UyMpFxFFfJP4yhKV1Pb43QgSe3lQ4rnZTjwWcQUso7iAmekhSTUY3MCx/fZ4yjv9xcJxxPaO9J4sR7DhMZcaItc8c52aUpPCkR5w0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b961e644-3240-434a-d1af-08ddff6119c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 14:04:26.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFk/6pFhl6X4XlqpBNTsdESsJQe1lrnBihi04qopTOnyGYMLjsuNFVxOTIHypnV1TJCpEJA+W3IN23l20icAaVtnGXlXUKUkPyhN/QwNNEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=910 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290131
X-Proofpoint-GUID: fp0K1lfpZTpOf6KcJyRIjHnYpTeWVPia
X-Proofpoint-ORIG-GUID: fp0K1lfpZTpOf6KcJyRIjHnYpTeWVPia
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDEyOCBTYWx0ZWRfX5avsea3fYPqm
 mheId3SMSg2AFseCsQK0raXkTjSC/nt04ma/RJoBGMItdvcBLd1wQJ9yCs6HzSfskY/vJ48JbkZ
 wghM9jhwVDH20FGHhO+XfP3oJCQETh7ZheWBeH8sSeDsKeh4v0q6tTIcSLdC3r/mcOnJ5kn7WtS
 tIQV/nH+1MnK7bImHM4eTmJxzxg9dfPhT4HK05JMiH1e3lbK830oKYgoukQutTCJ7CzuUyTP9al
 4ACu1rUIs0r8sZJ+HlOYbbazgizFDdIJsr0rydaJfWSHNfFbxY4UZ79F8ylzIoqDm6cyE0atCTX
 8P3mUeWfL7ZlRhB0+LOsUaGFP/YCb2YJhKo9cGBUrRsiSiGwRqAPi7N14/UB7X1vDfixPlN39ki
 2gzsuJ6KaOVaW2CRqj/XcIP3d6bEhQ==
X-Authority-Analysis: v=2.4 cv=BYbVE7t2 c=1 sm=1 tr=0 ts=68da91ef b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=i3W2kiOVMfL5GqEymM8A:9 a=QEXdDO2ut3YA:10 a=UJGtSc-9GqAA:10
 a=1XCSa8nT9WsoOzAxqb4A:9 a=FfaGCDsud1wA:10

--=-rQhUuDQAGNv7sdENkSrs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29 2025 at 18:54:09 +0530, Greg Kroah-Hartman wrote:
> [...]
> >  			~(NFS_CAP_ACLS | NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS |
> > -			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS);
> > +			  NFS_CAP_SECURITY_LABEL | NFS_CAP_FS_LOCATIONS |
> > +			  NFS_CAP_OPEN_XOR | NFS_CAP_DELEGTIME);
> > [...]
>=20
> This breaks the build :(

Oops, I am extremely sorry for posting this.

Please ignore/drop this one as those flags don't exist.

Build succeeds after this.

Thanks,
Siddh

--=-rQhUuDQAGNv7sdENkSrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmjakeEACgkQBwq/MEwk
8iqBYw/9Fs6bDvtNogqSVes0ka4MEx6XdxmJStDOIIC8ATJ3z7X3IR8ueyeJR8Lu
UtWBkacsSuLXJEgUkkdwW6YD5KZP/b2OPurU8YIaf+I16SmOHrsHQtvfRB+Hj1kM
RgYuM8qYtnvTS0ERl11eAj7M5jKyEaXyGftsxRQad5iTg/ujIJm5sghaHybf4Zjr
Pqs/GiDiI/rchikoM1XSz9bubhSve+LAFWBWVF1WxZQ5bK/B8pMRdIa6H3ajK9ze
rkbGKyRhQ4JYkFH1LOWYbFJ+F4Ka4cs3XWb/tXnftKz4w/VMzpc0f6mps/YXglJg
vVqQmgLmf/vB2S66ccNq/Z9bNv9qO9BAdfyltoMDqPB1OOfF/aXe/k4FIXdlIQ5g
pE5tz20dv1zzbkGszl+TGV4uwT5rOBLdFF0l2XaPI5dALZ8p/cSCQFeIUZtoLcxU
DF7zCQvsFY0O9CXCkxuTw/B30Fu4bYHEv/YTBp/rYpb9q1NKMuIpKJG6isa0+LXt
E6C9DJT3HxqEVqrSxTC+QCOAs20oJwNn9rzZ2az8aQ8kRHHYU1Velw7wVQvJ8VVc
B+qefd7RiudT2KkZ+c92efSBg+yhdFh9FVn/LgEHTxMB7qfIgIQfMrLJj8L9UntM
kom0WIH6Uj6CaQjqEJWxDpPn2HPLX71dn4TvrTPFKm5t7mKK/fQ=
=W3gF
-----END PGP SIGNATURE-----

--=-rQhUuDQAGNv7sdENkSrs--

