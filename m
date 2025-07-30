Return-Path: <linux-kernel+bounces-751182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BC2B16622
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B83E3AC925
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1642E040D;
	Wed, 30 Jul 2025 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cA3J6Xbm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LdOAnMd0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2501E008B;
	Wed, 30 Jul 2025 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899546; cv=fail; b=gI6+8iDg9GCYq3aRXNI5UHMmVLRFf5zLPBDFuoPG28Cl3KHMDwd6Xipl8qDd+3EW7jxnymbhLl1iglDuN96s6MeB1BrkkN6v5xjemT4OmeRkTt8NA40NCJIgb00SsIZ2aR2itCvsPZMXF+waHyUVpg/PHsDRkqHjpYXYGOLpvgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899546; c=relaxed/simple;
	bh=NbujEaiEMrPB8ThK9BC4JGNgWmwElRNRg2ZPi+A7syM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cc62nRpJ50EgaYQQkTra0856SKaO4hG9ad7NmuzfBd3H5fup+PSo93xm19h5qUGVNZo4VQpJ3OyZ2Igv0Gj5S88cFG4rkHg7RjWH1ZSIJDLEdS/uhcEx8I7jdXKzByT23x6emF2YGqmuwVg6CFSCb2TOOHTtsPjoHgOSxNj+8J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cA3J6Xbm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LdOAnMd0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHN5g3008520;
	Wed, 30 Jul 2025 18:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NbujEaiEMrPB8ThK9B
	C4JGNgWmwElRNRg2ZPi+A7syM=; b=cA3J6XbmLYjArXpyLFLggXVkvu5HEn3H81
	nEDgE5E/Mq5I66YIv0lK5J827+fA7k5D/CRYgfDdvsz8lmcLefe8/o7qME2aWvka
	Go0bzFGWu1kRRcyp2ufqQlEmom0057XK/BRtnCidlPfFGeo/81p+Ep3L4Qm3b6Cm
	Hbr4BQiDkeS2Mwq4pN4DfHL8py/ieLWuiZUUrfqfkawOwxmLc3CZGreGCMrd1/XE
	wPXX5ml/1kU6HVuecxD2HckhRExnVoO2l8npkh6GwUmQM5XpjbmUptUAksr34h1a
	09Y4lK3cGndx8g60gO4n+JRqjdovYryHBYq2cQOEAbbXCqTmpIEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5x2cp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 18:18:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UH9Oic003151;
	Wed, 30 Jul 2025 18:18:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbj1rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 18:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMYAVaetcqGmxYuY5ln2K/rUtL7kmOBkVVXagg3ylZ1wdghuJR12nRsEs/mcN7m6hMLsRefX9i2xKQvCqIla0P4EslAz2mVlHrZxJ5eXe/SvImLSOzL24/0BFKr0c6fWsMPYvWgdPumrn5v2MW0wZkJAE5hFyaaUkfxOufV5Syt9HIa5vGIzyMMN12vDZpDwknIfVr0s1ije0JtVIe4Z1h88LMJvA2CZXaaeKTuE6fdIMM+Fwa6ixWHe4vN+YsRv8OCPwkRoKp8YWJv+mAUeSzDEKVuzHtCiCSBixbNeTxxy1C5+mIeKxCPGKQKx59B7c6zZJeFVAG2C/PSi5h2IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbujEaiEMrPB8ThK9BC4JGNgWmwElRNRg2ZPi+A7syM=;
 b=micjtGaQf79kfORMAYDGO32g2PaZbHXrBrmBQlAiA4gXnOKXSBb5k4+3mpTODwqYjSc0Qi7X8ldmW4rbok2RxSHf1Fx21kkkpBJ+XhW1a072BJvpKt+2mmiuAQqyY/X8RqAzuhJlagtk/x16bt+YkrVHufqgcVjueDQcLbQBeFSPM2nUetbKlAXYyfMxinL6TsZ96v4C1VD/xI+6GKGvIBtr1n0suuo/In7fRB2ke2Eto8NK/NDX9Xw6f4683xzKMRfmKjd6wrQe23JZ7mXimyjdWMd6rAD7vUxt480WMJfoV0MzGqoq6PJLaPhqdInE2GQxS4R14DlwLIckLX6jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbujEaiEMrPB8ThK9BC4JGNgWmwElRNRg2ZPi+A7syM=;
 b=LdOAnMd0WJtFBK3odFP3krtzWWMVWYgrJTm/P7y5i3knmtf+iy1FoMhfaNaL5KU1EblvXv5Q7vfpGVBFJV3qwfkkNOuVPPtvjAzZDHhczHdfcBIEK0nCttzsTO7XFUAnao+9GYtEJtTI0aB8WRtTqi1a7IV1V/bWLboaGdoB/rE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 18:18:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 18:18:50 +0000
Date: Wed, 30 Jul 2025 19:18:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Greg KH <greg@kroah.com>,
        corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
        josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <30b5f616-4d0f-48d8-8342-219431ab264d@lucifer.local>
References: <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
 <aIpSlhPTC9G1AqvO@lappy>
 <eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
 <20250730133220.6e7e9370@gandalf.local.home>
 <aIpeera8s_tKAllT@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpeera8s_tKAllT@lappy>
X-ClientProxiedBy: MM0P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fcda5d-54a3-4fc6-a82c-08ddcf9588bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hWoqW/Qgz1YLQkQvlYoXQtV3ooYgTOzrQM9iqaqAlNE/JJxvTDazSoBilr35?=
 =?us-ascii?Q?G1ceVm6doZSmGk8HNlIhlZL6eNMYYgSNNVdk92oZ00HVFh6ILNp9VnR7zhom?=
 =?us-ascii?Q?Pyv+wLUw128U+Smu7PUGzg8sBIaUPP1eK2IJFsaqyF9L6Rc890QoNdy3z0zs?=
 =?us-ascii?Q?4A8qPqbLGtaaIBL1eVFL3Dx0SSswDn1UTr6MV3AhOInPoVmeNWEAgeIOKUQA?=
 =?us-ascii?Q?rPOynVeVX64VIbLGHNTN8VKGYvVa+vj2lGEyTx6pfanHbtF2OtuI+jVztbNk?=
 =?us-ascii?Q?kbnG8RMo7rQZIBvohI8s3pnXSoPt3fQeaXMnH8pYyv35eNRlTerZRKCObL8Z?=
 =?us-ascii?Q?DBu+THEIYx9A7VOkEdsEPdwu+11imlxD76drXzXjS6t44Mn3MRcStba0R/Le?=
 =?us-ascii?Q?YO9DYLhNNXgPljRlWFo3Lf5e4+AHIOcmRjwTX2VPEniuMSbt7nncZhuEWzkU?=
 =?us-ascii?Q?eU1dKXzcF9cQMWlugvqIiPcflIZimpmX6A6QrzM3zGvPlzf6lwA8vVbpXImD?=
 =?us-ascii?Q?//IdSpmXdY6fNUtAIiAdCt5ZWVgD2AcFVOTRTTaFx/Pcp4EU6hfRWaQ7WAL4?=
 =?us-ascii?Q?Znrd2uxodqzehQwK3ShOLllL7caN5xg7vtGsCgJtapyazfyMW8JDX5NdYx/d?=
 =?us-ascii?Q?5TSBx6TcbOreV/6mBLCYCGbuob92yhDfnMqMqaU1VcZ75k3bG5Fjb3HeckRG?=
 =?us-ascii?Q?qbAI1apw80fb0r2eiJ9uFXZt4ZuO6BvRrkg85JhsTKkLCCM++eWyY4Xv68xm?=
 =?us-ascii?Q?cRihSEjAHGasMtzTHxwNinAGFIkr8OQfGspyA5BEbfqND4VqZop6FFtL7qKR?=
 =?us-ascii?Q?CzIrttazaca8trARElofR1beylKRVRbJOG5K6/FgTrxSYrqN55z53B9maSiU?=
 =?us-ascii?Q?l2ZKG2nYi7OdQ+KFPKwyHEF8EdVhW3u/L1hB42FvZBtNiABvn8el3VggEVDr?=
 =?us-ascii?Q?fulL1oWpFCWYdckI2gNklerVPN0S3/8a9kxVQyMDydlP5xdpO85cIXqw0KjP?=
 =?us-ascii?Q?bsbJq3f+1UnHQxOqwIrNa+pxDLNcWJSRC2LX4hIJAbUx3/qZS2ih/R8kWhr2?=
 =?us-ascii?Q?lrc8LcQslsiLft0qdPRJyjC03MvjAxfgi/JrvbJqCmjVXL3Cv7zsukOheMT8?=
 =?us-ascii?Q?LcGO4dOQq+z37RngVf8oZcnX4xalLaTk+iQateBGoeqMYQKvwprIQN8D+a5K?=
 =?us-ascii?Q?5Nl1r0fT88suTbURQKgRri/uLc8aCgiw40uWJSoTHcbh2NPihp/09DVZQNHn?=
 =?us-ascii?Q?8TtZWsZZOFbroLx+NsiiIbeIuBYhi1S6souWzpuTC3oJfmZk805OJYTJPLDQ?=
 =?us-ascii?Q?asMkFlYMHRNDk7hTbynYUXqCE3jsH3udEQLJMdnUPOp+AylQAK+GM987zTm8?=
 =?us-ascii?Q?p7/lOwZbMkpZf0Yfo6mnp8Rkr6xMea/n+pflKTiAmx3bvp03bd/gO+af6LAb?=
 =?us-ascii?Q?AGFBehXf8p0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u1Y0/t9Mq0cJAZ+B2SRzMCqsrtu9oTWKKWgZ/isv/v1LvFn1gwPhw+9uzrcz?=
 =?us-ascii?Q?wtJuFcoU1J8P6ijyZSaeLvYtbGtVHIOpH57YXOhyVZ+n/AgyGkvfwbZF1U7N?=
 =?us-ascii?Q?Q03SwX51n33SVKwIN0jDElINoTKEBKF1C8I0Nx160EcD7E01JCVwWWnWVD3h?=
 =?us-ascii?Q?5uWrmn400mWMdxhxerMo1LKPYtpKgVmOTDpLM74wvH5WxhEY0Jpjw7R6KUsE?=
 =?us-ascii?Q?nTjcWcCL5Ij7pycO6fz1CsoDlLEkOYBamIR805ggYmAH/0WvhMFjjglSsGcJ?=
 =?us-ascii?Q?OgNOhu0+zyxWYC89oUkOBgrMUgQCEyUdmQvG5/wpE7ys5f8Vwps/wlXeOq4W?=
 =?us-ascii?Q?B4faqbNtg2Gr+QCOF/tlAMQuB120/mcsbN/SXj4qRzJfSrdSxglQFTiROPNe?=
 =?us-ascii?Q?zJ45GmrETvPmwjMWhJzaJ0wf0BPYRSoFuxRH+u0WWHilbz3txGbqxurohghB?=
 =?us-ascii?Q?UymajXZkfXzKM3baXJSAtX0FzzKAHq7K1w3um69gE6taZy1TmDgCprPVQcH/?=
 =?us-ascii?Q?h8MymsDSdba7vx7B0ntoIeQXrMq3mPh4r8qlmSgaQZihE2D8x9wPcEgON+MX?=
 =?us-ascii?Q?wNJ81pj+Zb+6lwS+I29Y3bUGN34jGPo9XI1Nvd0VuMVvRyWjkDNoqVIkgfR0?=
 =?us-ascii?Q?afBO0AiuSLet7W2fot9CdOx8lLmHmZ1chPfjs1cFxo0diIjUNHFmwU+QaDY3?=
 =?us-ascii?Q?GAqQI/DAJVaXVJ9ckO4VbIeXlcJBr7aOhYOGQwfgQOGX+eyq88C5w2DFTc9P?=
 =?us-ascii?Q?B3PsBGMD70c+6u/50e+B5DIahJiPC3aYppVeN84YdhR6yHK5/xejCvVwGzSI?=
 =?us-ascii?Q?jfDx9XBbiKrLLUPxAWEe9G7+UVIMXZSvNnPJvMB/ISh0aCwbeL5CvclTAzme?=
 =?us-ascii?Q?yJQozLXVw9FjCKwudotgwnK1cC3dwccaXF6HEaRgmRc8BpXfQiBYKeyj0ghv?=
 =?us-ascii?Q?OhGAzFr7LY1UUCuU58fmVpAbnUsN9Pd+UpOuwJR0E+svVD6yprDoBYlDPGTm?=
 =?us-ascii?Q?ZMes095o2ZGNhBH8i4O1LOlEaLLhathzJTl9l0O0HAVcJYNq+l4UgUFumVUn?=
 =?us-ascii?Q?g/MG2r+fU3UNfOBvFZuyqaf9bYg3SOeuZ7O8golVBmO5uaMSZ1ORdJWNS5WG?=
 =?us-ascii?Q?rE4OROg1O3NS2GC4LNzokcEOXQX3afUky1KN/7lNy2Qgqe5GMtaehcTezoK4?=
 =?us-ascii?Q?RzXY7c9ZMGmbriSMhbF7DafsLF3f68BJoMe2gBzfE28CRjskx78TPqHKB4Wz?=
 =?us-ascii?Q?hRWKG7U/5OKRCER+lme0yEyZudgTA0wOLunKaTvh/2W53p1X0+LixPFgeX0J?=
 =?us-ascii?Q?FklEIWBBGQalIwg8Y5VWtlAjvOIiqhbM2G9bIzxVkha85frDp8kO39l7VMoC?=
 =?us-ascii?Q?gzFmZmidkFD8ubFS5HODpqE99bKwaVEqMN2brFsWiL+/TqA2zwAc3emFn5IN?=
 =?us-ascii?Q?MdOaKXxitnlpo4SnqTFnVVRHFmp0V0+zHUmawRLsXQWYe1r7jYrR3s9N5lfq?=
 =?us-ascii?Q?TQ1+6mSu1I7adoGNtGP8dFFCXM17A1h/A9ayzUUR2Te0UB9kLAfsGiWnVjxp?=
 =?us-ascii?Q?4zHfL0zGxB3ZkWTCBPzf2FyhO6oJ9qqStbpuFbw/4XIWefwa1fjqTvqoqmNs?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J27sCR3b+TqIJ9BezEy1+gtFEPu5TC9g+5G/bXhHEPoeAvhUAT/wIlog+eYDp+wSWKoJUdmnF7E1JRkz4FlxLJh+e3BEQsTyaAORl3cuf0Fe8kF9ltar96DmJWVpfIig10yNx5qGPqXWLyhmAvQCSQcdatVAz0D/2QPi2/9fp6U9ncihmh+cxnfVStVJnfvKvjd0H+y/yKoL524Y48rCFXRn9JeUFkD5WfIj9K4yhxT6OiT6aJFL5aRT3dtCOWyxpr8NSPmy2WoNSvQqSHwKyB1VrJcV0YufsFks9c23EASLYvVDeLwGDVCRLZTXUsrneukTOsSz3LH/ueXD8Fp3HTDK1C3SSWVqEig+qN0DIma2rCcw9AWIxgQmRleYAphj5aWZ+xEopT3mckTeZ3zgPQ0TiiEXOwTIwLig366mcm+gWeXMFPnSTErtrB2tH9/3uAaSL7l9ej+9qcI4u85w7/uPpqG7Z5rotcCZvvfW/5N8hJpERIv/cdUtnu5WB7FKrUPwHkoixSUgcFeD6P4UYbQ4zMh2d1ZH2IwO9yih3wUuvFXJNQQVymx7sbHCX+lwt6dE3uS0hmWRiOIAJfG2ojbred/aLZBhaDQrekuE6U8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fcda5d-54a3-4fc6-a82c-08ddcf9588bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 18:18:50.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvBGYZBbQ3XvC1UKjhztfXfKKF8X23beClXOUS2Vg9SGUTqIQaTXUcdHeRivEI/bmoC/8zIxZQSaJ/9GILdED1zacgsuQE6P3Bue4clcmZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300134
X-Authority-Analysis: v=2.4 cv=X+lSKHTe c=1 sm=1 tr=0 ts=688a620e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=5D-AAeMe_93z-16Ew8MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: RNTh4tKHIWsd8eyfhcxDEo4MyeppLtsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzNCBTYWx0ZWRfX24L/fkz3xg40
 KLz4Wf2WkFABJCqK6R/MRq6MbpHa3x4sjLk9fkM8n3zjGddE2Yn32LAcp1w6LGfLoPi0ZGglb51
 oq7deXUlZgz8vH5bFmm9IyVBK6KjhQh/Z+H7vQiqCdCqYvQYlCgSYkoWErksjecofYva8PACDjh
 ChWNBf4GVySGz4+k3cT3rls6PfBZdYLDKdv01w5B/o4AsALh0qctWxebxstBVEDLQqPahjkEXsS
 nlClrh26nwN0SafukVlAd2F4l5qrRJB8mDQ9TikM5Gw6hm7dE6oTCh+C9Kg3TWWvcycDSPXf728
 +ctE2GZewNKu9jCUUlT2oblQ5TVPU7b6FQTeip+wbkiXlAbWYU8ygcXYPEHNtCrnj+ggKWauZEK
 1igCQuEe5c71/0xc1bCwYwW89E9HvQhd6auUD7FvH5wvFSHzeVI5bVgG90TwXNd8x+3617MX
X-Proofpoint-ORIG-GUID: RNTh4tKHIWsd8eyfhcxDEo4MyeppLtsC

On Wed, Jul 30, 2025 at 02:03:38PM -0400, Sasha Levin wrote:
> On Wed, Jul 30, 2025 at 01:32:20PM -0400, Steven Rostedt wrote:
> > On Wed, 30 Jul 2025 18:23:14 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > You might suggest presuming a policy for maintainers is inappropriate, but
> > > you are doing so wrt the LF policy on the assumption everybody is aware and
> > > agrees with it.
>
> No, this isn't about the LF policy. Let's completely ignore it for the
> sake of this discussion.

Ack.

>
> All we require now is a signed DCO. The kernel's own policy, based on
> Documentation/, is that we don't even need to disclose tool usage.

Right, yeah, this seems to be sort of implicit though, or sort of 'by
accident' ultimately (I mean who could have seen this stuff coming right?
:)

>
> > > That same document says individual projects can _override_ this as they
> > > please. So the introduction of this document can very well override that.
> > >
> > > We at the very least need this to be raised at the maintainers summit with
> > > a very clear decision on opt-in vs. opt-out, with the decision being
> > > communicated clearly.
> >
> > Agreed.
>
> Right - if this is brought up during maintainer's summit and most folks
> are in favor of "red" (or Linus just makes a desicion), we can go ahead
> and adopt our own policy and set it to "red".

I think this shouldn't be an 'if' :)

I'm not usually invited to the MS so I shall leave this to those who are to
ensure this is brought up :P

But I think it's an important thing to get some form of community consensus on.

>
> What I'm saying is that we can't just arbitrarily set it to "red" based
> on this thread as this is a change from our current policy

OK so I think we're in agreement then that deferring to the maintainer's
summit or some form of community consensus is the right way to go :)

And agreed, this thread is more a healthy expression of opinions in figuring
out the problem space more than anything in my view.

Nothing should be arbitrarily decided here of course.

Cheers, Lorenzo

