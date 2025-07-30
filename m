Return-Path: <linux-kernel+bounces-751186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AFEB1662E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2320218C46BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC072E0938;
	Wed, 30 Jul 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jLBcS5EH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xrsf1dSq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B82DFA38;
	Wed, 30 Jul 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899873; cv=fail; b=ZWIReknY96YLF0JW077zphDgPkbpeV4NSCzSVhSzkZtdoZZBx5yHZQW8pIL0hSNOs60UTzj5gSCuXQJWQq3sagfjZW1MUzi2FGQokf5MxSBsMNl8damdQbSCOB/ntXyP554q2W8NCDWd/kDgrNIgwQgEMTA/cSRJTRwIh641WZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899873; c=relaxed/simple;
	bh=hbnUeoF+T3wpiFuiqqa2IWtA8iF160ACTottPrYlTlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nBPnRFMfGzmO8gRv8mn6M6JOtWTh1gIKPI5jO3wgx9UInx12ZEkTTfvLparMbL+JyDRtI/OZpObA0RKEzzf1SlYaNwGYwfiLluVHDdevOIF5Q4Ez2nxymzYE704VD8g4zdbiOTroGcpIITgNg7RT7N7sWe1FSco+FagpLtfif0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jLBcS5EH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xrsf1dSq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UHN0cn012587;
	Wed, 30 Jul 2025 18:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dtCIUF7cxIP33j4yU1
	wJNCVoyvtKmKh6HC1I/1cNA04=; b=jLBcS5EHXrXqzNcrC+/V5OxNK6AKu/Jz7/
	7Qjr1ovySHOHfr0G4Gd0fL4KFHskhVJk7Bb6VUEvPBHYNVXShDR0fjfi02nETeFO
	jxbcF8j8DggaU45QvuyeRdlXlY9nU8SPaWDhU0aYXMex1P5x59QZ5QWfrCLTS6bs
	IfEoQorMyT2bnynhYcsbVwUF8OdtwEwNUpRUI+PpPKTTBeDT9ikJoDgo2uirZ6Fx
	3HPJatsAgB+5ydbom5IPAIdZ5qdavQ3LFm/zIvcQBjWKiqfXjp6jaEh97Kves/3i
	vT+ujf7G2Wzm5P/Hj0cejeLK7QB9t4GZXTKLohrjOlyUGyZU/Kaw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yjgw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 18:24:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UI4DBS016646;
	Wed, 30 Jul 2025 18:24:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfhujx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 18:24:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5LR0bIK9s5oZ/Bkl+44HZAUHUB/v7PZ1AgCeO7MULujyTxqGelN0vUPLyCMd8zkyfw8r/kWCaYjLuGRLaLr7jzm88jww+fUzExuO/dYY4/s7dn5CMapWTmXZTqpAJToQddLVjgHd4S6dmvi2ZKMEZyfwQodRzAMFTD8GG5/CHdy7yua6UMOnS2tqvTX1uqMlB0lqCMrfMTay/rx24MM4r1toUFyGyU6CzRhqMtXibpfNQ5TQ8YwFkI7m+0mYB8N7sSPkXkU6N1eB77ZeDmvvcAKsw23a0ZGH1j7da89O9AuU7WTIVY0ZnDm1lb4FKn3QPiwTrQlDoYqmvwy7iytXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtCIUF7cxIP33j4yU1wJNCVoyvtKmKh6HC1I/1cNA04=;
 b=Rv2PXfJW2dY8da8XYyWX0D9GgOlndI3MeqK8rZzXhoCVbv1ZuTmsTzCU2LOGvCoLVJJkVadZpVuel55v7K6BG6HfaUthsFvzpUQ6DAdQw+wj0T9ZvkbRGVRD5ljO18yUCAj2PgBFU7hqa9ptDnl4/6DEwuk+prBhMDYlPOgfGUS5W4cH8TO1XulfhI7uRADzDnbnbJkWSBT1OaK5RSsbWQYEPXMvmeinzOHrNZ1CQekveA3Jnh+qRRh/vUA9BolN6jprbzwOhqgIjdTvEyhIFfMV+Bzs6n7AGk9uYXTmknXP3lesCT6iskw2cQ4IOaxu5U9JVcKufAzLAhVRalwISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtCIUF7cxIP33j4yU1wJNCVoyvtKmKh6HC1I/1cNA04=;
 b=xrsf1dSqm3DZkW2u+WSOh4Gg+0k792YmV+cUCpQ0K8HwNeoDEMniZ0MhwUL7RB4spK5Lg+UPLm5VFfdSmw9lgQR2Ie/cPwQ/iZ1ifnl3ylZ47A4kQtQViovDllNwrNxUjfnToK4ksNBlNfeV2+cqe/EBZR2Uys320Kh74yo7Lss=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 18:24:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 18:24:17 +0000
Date: Wed, 30 Jul 2025 19:24:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
        workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
        konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <9e471218-35a2-4e22-8826-40576919e737@lucifer.local>
References: <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <20250730130531.4855a38b@gandalf.local.home>
 <aIpah6DTRd99mMqb@lappy>
 <20250730175909.GO222315@ZenIV>
 <aIpgEpe6z2Ykyymh@lappy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpgEpe6z2Ykyymh@lappy>
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 685f7be9-02e8-4bc5-c1c8-08ddcf964b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1GuMDpksgcDLCJiLS1oopH+hfQQC1CK2h+O+N3hCIMQEmXw99vMk1bn0+4gs?=
 =?us-ascii?Q?AaSuCb6ckeaF/3654Nyqlfr7FQ10M1DzNuKXzNtXheVxunBORh0Pgp9d+drp?=
 =?us-ascii?Q?FLaB/tPypZt1Gcg0v4fb8lptQr35VLoA1I+m+CIlj8qRsbKbFJJEiHY3K0JM?=
 =?us-ascii?Q?i5G5CviKpM2V9yRKZzPXkwP/rgT1x3GSqn68yxay2uWN7JPbPHsmEtBqK//B?=
 =?us-ascii?Q?HDxCwemRXHSrX1wF8UorIV2/UVSoBId4oz7Okf0lEhz01tGLFGmlXuQEuLsN?=
 =?us-ascii?Q?78cwRit/zUWCYieL2+X1qhrGL7HhSdtu6nkwbmo2QxwZFKTo6gK5db5GOa/W?=
 =?us-ascii?Q?VyZcB23aezvgaIKd4bWtKxrauKpHuxnm31FXuGVQ4qAZ+C8MUBZONxiS9U04?=
 =?us-ascii?Q?0wWtVkHI+BDYGwyBV1rBJdJ5+WvwpcUtjfbRDxy7z12EgK9j2/eyxFkZT9/N?=
 =?us-ascii?Q?qqToh7Mb2PzQmrRO+3CF3MAybj9lR/YKjJ4GEslrnLosxiOHRzYxy70WqnuA?=
 =?us-ascii?Q?yupYxE65VBmyFqJOJ1l3VkzrW1PVIxv8fYopWQ4qXAThSjj9FCQDOfevTQMm?=
 =?us-ascii?Q?zRwxSkb9VV8twU6QBeUPnWrKYIUBXyKiPtSQNcRY4knwqLU/2ymsy50s3jT/?=
 =?us-ascii?Q?nZaLD7Fnf7/gka0lg0ASDQ1hBlcHRJXVbSsdPNS/lmk/KHf209P+fNjiFOtb?=
 =?us-ascii?Q?cmNbXOE9fdmpJwkT5ifI6OhriSU2gPA8Et+x6EUX/sKUw19stAZ/2k5L5VnA?=
 =?us-ascii?Q?qyo6Ue5JSjRjIuNfOqKgHv9DCFDiTofzETP3x6wGYkwPln/+8A1XIjOyBDIw?=
 =?us-ascii?Q?tkjrGbqXzhQCVi9fxQPuI9J49wNQN7dRirAvjliK8ko7OtAZwr2cDjazwUGF?=
 =?us-ascii?Q?NEfVXrC34HmS8a6KLWdhVDyBpdIo3z4xC66FY9grT9JtwvoUHAL10OxzlmXA?=
 =?us-ascii?Q?Fzfo1Up89rf94ykvsa1SSrAP0AWQZ6MQdg9ssUlrdYcZi6yiyLveZ2jCDwX9?=
 =?us-ascii?Q?zuO10MLbW2AovClXbUmsQ/wI1G8o5onBc3/7aRH0CxooOaz7faIRDV+QZZ0O?=
 =?us-ascii?Q?/fiBvf1ODkOGKGlrGppFNCjhkyeP+2Mz+8DrV0sJySwnzKaAYoTL2MVdNdYM?=
 =?us-ascii?Q?9QsijTYu5WO2UH9IqFxy3TgJBWv3W4PEIynxiHOSc17ct9K8k0TsQlx9TBlm?=
 =?us-ascii?Q?YK8GYaB2onVYuhyTlkgzRRSdIwhNUP1ts3qclHjdeNWFsYkV5dEMeWr0sEss?=
 =?us-ascii?Q?5gFb0Va9iNvnNzSEDpaqamgMNIaOqKWTsgb++nmYiyibv6X7wcqHPUCX9D+8?=
 =?us-ascii?Q?pB9JIpLIV0510Weesj4OjCgo2D3OE9/RJAa+NJ4VCtLnKYI+CDR2yNRLd8yt?=
 =?us-ascii?Q?3JUoX8zW0j/FXYYoCxbHwaH/JcBiJpcMjCYtumj5hLEDfnZNeQMtg3qo/7aS?=
 =?us-ascii?Q?uxk6PNkum0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5AvFKi5ZCFh2ZXaB9zUM51wRusFYB3yO+m4+lZo2RnAjjnPPxWYM98RNU6Tp?=
 =?us-ascii?Q?CDnVOoyGswQWQZlh7jjg5+kYHqcCq5UB+AIkH0/feha62SkaKMW/JPZo3KpA?=
 =?us-ascii?Q?llHrOmRLSymcUbJEk8SqzXyxbZKNfjtatfeEf7MyAPeTQNG/84Otf5YsExGe?=
 =?us-ascii?Q?DdSdqh69bTSxWIWlUiSZdQgK8H1Vl1Fxhhd5fTofoPA3GDbn2eDjz4n11FJ+?=
 =?us-ascii?Q?Q6vb5V19pZIPnO7SnymqCyP3rdGlx1OqhRCCmgenZJlADejnen3b7Jd3D7qx?=
 =?us-ascii?Q?AIuXL7xxtrczczEoYJKnLMxom1H0DyGGMoFWL43EO7zbAJ5xdnKdVbyALpIc?=
 =?us-ascii?Q?VttQ6EzWBOOhMySzb8ZuWW4dFGUVHEWxbkNmQbNSFwbUtfRQdoDLsNtKz2OO?=
 =?us-ascii?Q?C9ACoI9uUm3s8a/sCWrwfyZ03ZumAO6JxZhkWmH0ukNnjqLmR22rUuVO+OSL?=
 =?us-ascii?Q?eqIoJ4RSwiYmq/0qzb4zLQT7ffkc1+vky3pCkeJGENUehTYdj8l5CQRMt9jg?=
 =?us-ascii?Q?OD1ZBb2R25Q0JiftOoxU41EfYvy4QQV/9qA676YSCoLtxQ2uqLcByq4opBNT?=
 =?us-ascii?Q?oaTKQwWh7m0xcVLXQNgmLVxORK9Jm7AeLiow+qUFm+OK6zmSGU630PE6N4XJ?=
 =?us-ascii?Q?dvrwzCVLBkTbaq4MUMeuImYlPj1N7LHEvQvf5yMJ99ZVJ3NMrew1CgvgSDLZ?=
 =?us-ascii?Q?7hdT30z7LQ0tSqUo4PMHc6hjy4UVMECv7Z+LUzy2u3wk4WBCPE4bUKYx9zxI?=
 =?us-ascii?Q?SKBRL8vEExQJxrmm71u0kUPS9S7C2LokQJ1+DtJjw5hcColCd3BFKU3eJhu7?=
 =?us-ascii?Q?sWF2MiuA6gRSQKUDFDM2aqBsvnF/cb5Hh5cTRBu+OijivOZetfR9kfvl7iti?=
 =?us-ascii?Q?dF7jqYJf3SjbAyYrf2fgr640uYijbfsuw3YbV+hgDh7F10FnGVdTMAbRZIgF?=
 =?us-ascii?Q?oG0cq+Pb86OnfPyQdwu/pCTnFJxve5ErcUVZ3NHbxuapsPYczLCMl6wJYjOV?=
 =?us-ascii?Q?VDmKfC5syhbHObVAn7D0Y+2LeDT2szPJib7K/m+usWiu6c7LtXIAcXjYQTD/?=
 =?us-ascii?Q?nvSJ1aibh3vBKyOAl4zsLIC+D3rzcks6YF9fVRzeKzKnUAJu1gxSAYvQoL0O?=
 =?us-ascii?Q?8HErcaMFswrM2WnBE06B/68xAyHVQcXGg7M45QBLKW6f/x+qaf9gW+DHJRGZ?=
 =?us-ascii?Q?mC4egqt2f9eVhkcnVmZ14J7NfX/HYGFgs+vZ2zcKDKrWs0UeMgveLKnLubaI?=
 =?us-ascii?Q?81R90RmCIigyGQA3wP+S27siOj343vuk2M233Ig4RxyuSJ00Vr2rbfXTLp9q?=
 =?us-ascii?Q?P5iaxEFN7vQ+Hg7xO8HAUNYsVry/XR09tRc0HCnkXIWCW4DhKDJo8BxemmmL?=
 =?us-ascii?Q?ajfcv+UcpjiMkV10OGD5m25opRfhfjBKfjU/Jit/BMOMcttTjnhpyCRwKTwh?=
 =?us-ascii?Q?UcqS/O28nAJl78hyx44MubHUrBgHJrp5lWRIn9AQqOXUtlpNinRAYutHR+jA?=
 =?us-ascii?Q?yWE/r9iJ7/69zYN7nCAN+Ug7rHXs60t36Mu628lM82qoj/MhvDqaBTywYgZ7?=
 =?us-ascii?Q?Iw0Q6aE2Iqa2daTFq3BfhrI5wgnkiTvrDhFUacSjjWJFnM2sBimoo8mllGe7?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WW/+lzRLCKPeNuluBRiohJshqYFc9Nm/UR1pSo+qRxpKWtlPnibBkE6uoHipsvDUb1W7ylcDLdciWCApT88lOMafkZ88x+74hpuyXb6GQD7Zf6GlWLh4rjxtJocQxXSJMvfIZJccEgKcVv+xx+HB2P7llqu8xdA8w3UvMm7Vyu7snGYOYwbrn2Qqa78otKpXcDZho8dUq5xbf70jmJ5t4rPHxCHQW/RADuS4L0kHvq2LzQ3svZq0Hnh1vnt5jU8V4NSFt6NFVMYQkyWjUktp4nZoXw1m4zO/A4R52sAB0eFKnWeGahRY0ZsSRkz2uezi5QavDxAeT44kdpPcJ0hOIwPz6zxhQEIsAalz4MSbM2dEvbglNyPK6MOJcC4ptV7Gf9hvgOQkmXxBVeuIgR5HFZK1/nRJryn+yQVDF/yJaU/M6fEcFCfbUseV1frmebOBxS6s3B2C+dKY8+RgAAXs09U6ivF0j4NUSR7lq6hpFJfAGjkY09Sj5Tr1GejgVtqedf4JY58D08cwg+1WlULise9yfIAIQCnhSypNAm8+6EoYeGBFvWgQelUCDBFT1G76xldh0PkozY5QIBxqf2NmTJjNTrGFin0GCFqzzNdmyMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685f7be9-02e8-4bc5-c1c8-08ddcf964b4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 18:24:17.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZBzGRQJE4IUvuSh2i/J+khODUVvHKUMxnGqDnhQJ0x6qO8EJNwfqbK8NrzLOWKDAhvhGyzsXc4OcuX2d8DFszAQKgmXoH0n1TIxr4yJW1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300135
X-Proofpoint-GUID: fvysGOKgr_3yNdofUiR4PIJGa9knaSfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDEzNSBTYWx0ZWRfX7kM5334qPRg9
 Cwt2wrGuS04bYA2z63wkFVqy/BH1ndFDISUfX3ufK2Gt5Dxm7d11lUJocNtuAE/bNdXztmvW6t3
 TC3rdHX0jqx68lVl7ayrDGAq37kNi4ZveiLdG2/6pqlfsyT8CVuEbMpE6YhAHHlPBtI/dlNkoXX
 s7q3PtmjoBfgh3pw+ZIkS0hNiA60NmRz4bisJ/OD67dNILBZTMQv0oq5jNQnUCTPfbDabVzuN/b
 KSp1yveyQzmGjb/H078AFqKu9NSR6nR2fQjPN4teRHl/oM8mq9MURHSlDfw7v9idLehn6A75sWi
 yEU9k7IjxBElDC9KzftUlC3QEWVkz+m97W5bPONmifqjTFX0kK252T7IhkN2RWgYvtEPxDItdPx
 i9ABYFJozgmgUm4rlXsKWEr+oeCHnp5lfTvoZEwl/0rkZo/E2P96R8IPqytGqjvXSEQDMOXb
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688a6355 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QSDvsXp1Eq9gw7-0ah0A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: fvysGOKgr_3yNdofUiR4PIJGa9knaSfD

On Wed, Jul 30, 2025 at 02:10:26PM -0400, Sasha Levin wrote:
> On Wed, Jul 30, 2025 at 06:59:09PM +0100, Al Viro wrote:
> > On Wed, Jul 30, 2025 at 01:46:47PM -0400, Sasha Levin wrote:
> >
> > > Similarily the argument around not trusting the code is equivalent to
> > > not trusting the person who sent the code in. AI doesn't send patches on
> > > it's own - humans do. This is basically saying "I didn't even look at
> > > your patch because I don't trust you".
> >
> > One name: Markus Elfring.  Ever tried to reason with that one?  Or Hillf
> > Danton, for that matter.
> >
> > And I absolutely will refuse to take patches from somebody who would
> > consistently fail to explain why the patch is correct and needed.  Sasha,
> > this is the elephant in the room: we *ALREADY* get "contributions" that
> > very clearly stem from "$TOOL says so, what else do you need?" kind of
> > reasoning and some of that dreck ends up in the tree.  AI will serve as
> > a force multiplier for those...  persons.
>
> This is exactly my argument Al :)
>
> You, as a maintainer, should be able to just reject patches without
> having to provide a technical explanation for each patch you ignore.
>
> If someone new comes along and bombards you with AI generated crap and
> useless review comments, you should be able to just block him and point
> to something under Documentation/ that will support that decision.

I'm in alignment with Al and your view here FWIW!

Though I do think Steven has a point in that there must be a _good reason_
that aligns with the community for doing so, and it shouldn't be arbitrary.

LLMs do throw up an interesting new conundrum here in that they sort of
fall between two posts on this so we probably need to be explicit in saying
that it is up to maintainers in this AI doc in my view.

Cheers, Lorenzo

