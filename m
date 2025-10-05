Return-Path: <linux-kernel+bounces-842273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689CBB9640
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 14:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6453B6B80
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B638DEC;
	Sun,  5 Oct 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sj3VIUwr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EJ5s+mH1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250334BA39;
	Sun,  5 Oct 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759667457; cv=fail; b=hili3jzjyNubmMGULOZRDlhoLjNmrZENrrgLCYilJmcpdtucIjpTH4EjDzbVzhB5sSj6xkoMlgp7d+B9Y4i5NkYi44yizq7XoNaQiZ12fiqKFGRSRDEbwa1ye2P7rI+lUevEoD4A/ynz9uyRNuF/talLBrN9zUrxeoDR6oULGn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759667457; c=relaxed/simple;
	bh=j3LVwC8GFq23YiXpVVLZjKnIIeEDQF+S5ABQ7duZTT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACOtkdbU8VXAViVmiMMTV1zrCjX9as2krErAA6cIF2GbTUZgbew6EmKLSUfKHWjp0g+HZzCwn8Hi4uJzUGY0//RlLIFEnQ35mitDLbTdJbulghMsJ1L0SkgIPPXpqVYZaxXuos7zF7kHgp3nw4az4wkXPunojV+UPCch7DIG9QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sj3VIUwr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EJ5s+mH1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595AgPFj014122;
	Sun, 5 Oct 2025 12:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4SByCc/OfzfZ7pp7L+TRj6jxvtrVJjQfGdV53nhWF08=; b=
	sj3VIUwrW7jmYGV3i7t8ytu9EkG2hML+vKUbl6RqIbSMu64EnFBEPQb9F3sywas7
	jrOTuoNR+PJympippG1Fvju9bzmkw6Fhs7xMxiXaPkx/nyQbk06vqcYlVspuv5np
	bRlnhAvvqjlAOLs8yK4jlP0vnoAQwL1Pk/6TVVGpNA8bSfUZbNgbZ0a7ukqlxpgs
	enwlo3eIbZQbBqAuVpbCTVRTuQSMLMi8p9SRSNIegAeYNsj8B9bnNS8Mc9DXRLEE
	cQBrJ06vzIAzNjE2n4bwPwSBk131OeeV8D/u2ztukrgoZlSxCE+wvSAmIgEx2Nrl
	XnHyNjFHraQb6dAuLUXerQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49kpqf01yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 Oct 2025 12:30:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 595B200v035094;
	Sun, 5 Oct 2025 12:30:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49kdp2jsve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 Oct 2025 12:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulUdGrh5FAyIB0AKdYC0uotM1Q+KtRsAErzBHSg5L/42QAmVMdswuqbnavQEbHHxvW5sV5TC+i2KFj4+WOgCWU08pVB2z/nNidjUqcNr4vN0TtIeUYAeciamQKuMYqbz2+J8xu88ZBFpQo3+wtFAue/Yc+0VtnKUY48dJaRK4rnIq26i9rq/nWmLucSUnvOztKbjNttz5cXtPgEZPg/paGtZWKH+ggan2wUhIQgAPuwK/IOusYcWaOZpkzemSweif00V4rDcZ4W1+/s4DIy46vrH3ALgsrQ7P/+jcVbPkdAvAQ9oebawBoBj8jeT/RUlHH3x7JAYPbJl0dnUun/J0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SByCc/OfzfZ7pp7L+TRj6jxvtrVJjQfGdV53nhWF08=;
 b=clM9vflLo2KrO9TM9uzKhBQ0SqGqfRa0KEvEwsHsVqb+3BO08GHdNUv7tFjfawtCIG0Fn/KFdR9CsfCVUOgBlS/99hnrv3NaKDcE0CoPmOy5DJ9OLQdOxJMj46yyZCEiZH5iofCFmFXpR9sAA8DUbh0PGcpJN42B1b2Sl1jT0Vcrizv+4Qw4xetKPexM60KplfYCeJmskxQYJLsOzQm5//Npr0/Sl4UIpdfXSYfIsCu5Pdj5n3ue0HDsAPPzXsfxQNeY/PF6UtVHWMEBDjU+lMRkA9bqCd6bUJRcT5L6Vg+cqjK0NXj/+5PzIUaAxJ32qY2hfR6g5W4RCaxE6gMl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SByCc/OfzfZ7pp7L+TRj6jxvtrVJjQfGdV53nhWF08=;
 b=EJ5s+mH12/K5Oz1MOuWJ6h73wM69TN3h2GI/PDJNpUj59M3jEdOrEE8MD8jqvU0ADvICLAC7CoMFhZZEM4TZJyRge3lMeadKb27EN9svR51T7K9bmj/z+TBvvwHIJ8FJ2qnZGHWPNoIofYGaGt0Zc4HFCwIceanzwl8/A3mEZVg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB6401.namprd10.prod.outlook.com (2603:10b6:510:1ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sun, 5 Oct
 2025 12:30:35 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9182.017; Sun, 5 Oct 2025
 12:30:34 +0000
Message-ID: <18fb538c-0165-41bf-adbd-596d75b5cb9e@oracle.com>
Date: Sun, 5 Oct 2025 18:00:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v12 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Luke D . Jones" <luke@ljones.dev>,
        Derek John Clark <derekjohn.clark@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
 <20251003185520.1083875-9-benato.denis96@gmail.com>
 <86282444-f489-49e8-892f-46ce655030b5@oracle.com>
 <34852b92-a859-4e18-ba2a-c3cab814c2b8@gmail.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <34852b92-a859-4e18-ba2a-c3cab814c2b8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0121.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3b111c-4cda-4dec-4cdd-08de040afb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2hwbkZXNGZoMmZzY2xwNzc4SERzbWpVODh4TXhRZkFWRmlwNGo4TUtIRzVl?=
 =?utf-8?B?N3ZDRFVQT1V2QUpPcGx1NVY3NG9oOGdxNzJldkJmUXVCaEJWV2ZuTmcwRzlH?=
 =?utf-8?B?WDVVVStFWjROUmp6Zmw2NmZLdkRZa2JvSU4rdGw3RHJBR1FERXZUbGdld0Yw?=
 =?utf-8?B?VXdBRzdISGpZWm85dzBBa0lVYlhVeG5POHBmOVhQZjZiQ2hsYlpScUJkVGlt?=
 =?utf-8?B?L0lCUkFrajIzTkkycnhNY3ZvTkg5dmp6OXZlbG52VEhkMGVSN1NZRnB4Q2cw?=
 =?utf-8?B?eWJacnJmdk9hcWJTcXA1ZHRoTS9FS251a2lyMkc2WHgyU3B3aDNaOXNzbDBH?=
 =?utf-8?B?eTNrTHI1NWV6SDZqcXU1dFFOZlcwdzB0T01JTTc0NERrRm9QRVVZNGF0UFQx?=
 =?utf-8?B?R3Q3WWdtOG1HeEdzb0w1cWRaNUlMOG1EZ1BTV2w5Y2VIU25USEhVbHBOSUZr?=
 =?utf-8?B?YWdiUXgyY3RNYXFxT0ZoQVlETjREa0EzaWIzK0RrT3JKU0xueG51MVZUcUJG?=
 =?utf-8?B?SzZKSkVKK0E1T3k3NmR0SHdYTXJuclpOVmFEc1duRU4yRnNBR25tZU5iSzZ0?=
 =?utf-8?B?SThoTVRmZUFHSFA1T085SDFwci8wTFladGYrOGR1c0k1aWN1YmNoZG5XZDc2?=
 =?utf-8?B?b2dsc28vVGpXSGIwVlZiNFg4eW91eW1CUEZTd1BsYnF1NE1QYjFmdTdhMnBS?=
 =?utf-8?B?TjZBYnFmWHMyYXFjbndFUGZ1QXp4THViUFFXaUtUS09FejlHK0tIYjVpSFhl?=
 =?utf-8?B?V0NLNU1JVVQwclIwclRwRERTTU9nemhKb3NFZEh3cmFNUUFIWlI4dTE2Sy82?=
 =?utf-8?B?Z3EvYnhLN2dSd3NjMll6YlNDc2RMVEorQjdyWnZnaWxsS283aFZucE5PdmhW?=
 =?utf-8?B?ZDZ3M2J1RllFOWNZYTkrTW1XMXVVc1FwS2tzdS94aTJXeXN2NExURTBLYXdz?=
 =?utf-8?B?ZEVPUzRUdG4xL216YWFtYlV6MFUxMUF6dUMvczZRMXFnRzJXYzVYdENDNkMz?=
 =?utf-8?B?MFhJajdmSGdRNXRjbm1QVjhBWUhtNjY1ejVKUUs2akd4R1ArM3BIYWxzT3Fi?=
 =?utf-8?B?SDF3QytpaU9zMEZGTDEwWWU1MEFRSEh1K0I1RG9nWjkrSDhPM09uL05rOWgv?=
 =?utf-8?B?SmJNQTQ3M1Y2L0R6ejBHV2VFQnQrTVBUenRDV1IxYTZYRnVUbk5obFptdGJ2?=
 =?utf-8?B?UGtJTDE3bDhmQ2RvYVRTRXp4R1J2Vk1WNFRDeUYzMFcrWStGa2c1TFhOcVJU?=
 =?utf-8?B?THNIRUNCdmx0TDF4U3d5QU9IS3hiZGd2L0owZ2svQmltSXpvdG1JWkNzTFJG?=
 =?utf-8?B?TjRZRDJ6RmdSdS9jWEVNZkhYRllEaDZnZHRnQTRwMkFmSm14NVhWRlV1WEYr?=
 =?utf-8?B?M05yZVFPM2FIYi9ZU3ZqUlJjR1B0VWNWTHlOYy8yTnhycXI1NHpoa1EvQytW?=
 =?utf-8?B?RDcxanh3MUdPdDBwbEpjQmN6T2NXVDlDcGtZMzFWVGw1eUF6bk5ORVJWdk9r?=
 =?utf-8?B?dVk5cjhFdzFJTzJmYmpvR0l5c1M2RG1ueVd2NTdtMzEzamNUTnBRKzhtRGNn?=
 =?utf-8?B?NkY1MTRZMjRGOUdJV1JpZ3NTNjJTdXBHNVd3a3h0OG9USmJPenVMMFVITERM?=
 =?utf-8?B?RHp1ZnM5VFUwWnErQ0dVZk1VMU5QOTl4enJ0TW5iSS9LZzgrcmdIZGRveUMv?=
 =?utf-8?B?SVVkUlpST3Mrb0d2Ymx3NU9Edkt6S2lTWDk1R2ZiQ0poQmc5QS9pT2Y3Tisw?=
 =?utf-8?B?OTBTUVY0alUvYTU4THMyV293U3FmM1U1MGVXazBiU0tpczNucGF2bU9hbmFO?=
 =?utf-8?B?NEwveFlDbkhsZ25XTklDVHVhRFdvTUY1OURzcjY3UW1KaGpwaGNsdkVGWjd3?=
 =?utf-8?B?YkNVTVN3QTJvOS82QUpxMUVBUmZFZU8ramhBWDFJejVGZEpxakxhVmVwSmJZ?=
 =?utf-8?Q?66RZ9mtL3+fWDKfValYT1tpRk779xfAP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJWRHNMU0xkOTUwcSs5TE0rMGJ2Skd2ZjYvQ0lXd1RsUlRaT0FZM3pXcUlP?=
 =?utf-8?B?ZGU1RjhMTForSlRkd0xTY1luNXFOSFFMZlVVaTZKQ245KzdMOGpFc2ZrNm9Q?=
 =?utf-8?B?U2ZoS0VjS1FrM1VXc2RIejNHc3ZlM252MWNuT2VnUGt5QkdLUytHdkJiOWho?=
 =?utf-8?B?RTBaRzFuNUpwZEJVRUwrb0pCb0FVRjNySm42eFg2SC9pMEJWa01BVnlkVEI4?=
 =?utf-8?B?d1NMNG9FbFFCalFjVThpejAzRHRwQjZzSWxBeFRmVjhpcjl1cmo5WVBLMlQv?=
 =?utf-8?B?NWY0RSt0TFFqcUx0OUMxdHJFdUhwRFVmZDI1Rmp0dFNwYXpPbWhTTEt4REVT?=
 =?utf-8?B?ODF3QjMvTy9UVXpRZmQySkpBTzI5VWlEV3B6ZzVibzl6R3JPckxYeGhRTGw3?=
 =?utf-8?B?VFk5ZStjbXh2MGQyUld2YTRuWkdyOUUybU9hMXYwR004aGh3OHg5K2lLZ1Er?=
 =?utf-8?B?aFZuWFlpdjhMMTNVKzVxdjNzNk5BamRLWFFkWEcvVUVVL3BWcjhNNG1kdHlP?=
 =?utf-8?B?VXh6Wk8xa0ZxY2tRSkxYSnlUTjZ6dVdSS2RkMDUvWU5RZkNaTFAxMGtpOWdn?=
 =?utf-8?B?cFhBUGV5eHVISlVRNUphWWJMRU82a2UvQis0MFBRZTdWNUdKVmd3VVNmLzlo?=
 =?utf-8?B?VjVKak04UnZ0a0tBaVVvS3UxaUF1cVZnT1BQcFJMTm92RTJwQnE1Tk1MQTIv?=
 =?utf-8?B?OTZiZDZVUlBpa1dUdUtFR2RWaUF3YkpkL0MxSC96NEhFM0VRelZZajJBQTR6?=
 =?utf-8?B?ZWp1MFpUZnVSclRzZUFKbnFxa3Nub3FjU0lDOUpibU1nbW1sdlRZZEhZcEU3?=
 =?utf-8?B?UUs1YVoxQXMxb3lJZU50SEt1QmFXOUV3SkNaYTZVZHkyOUJuRVltM2RCTmoy?=
 =?utf-8?B?cEJPc1hMTFM0em90b2l1bXZTcnZVZEk0cDRnekVydkN2MnlzMGRYRFlxUmFX?=
 =?utf-8?B?ZGpnc2pwRnN6VklQMWFwUWZUQ2lVT0o1VjROZ05ZeTJRQ0paNHR3dmpYcXBs?=
 =?utf-8?B?dDVySFc2SXlwRitkUVRlZW9rVW5OT2VoeGI2TDBQREpRVDBlMFFnWDR0R05u?=
 =?utf-8?B?dnM2cVowM1pBMk11RDZjRThQS0lKR0JiSXExRElleXZET1puM25YRDlMcldu?=
 =?utf-8?B?SDh2cDdDRmx5WWJVM2dEVWd5aE8wa1VJZjVjSHlyai9GeUZjRzRCN0JMYk5h?=
 =?utf-8?B?bGpOS1ZlbjZCR2QxVzR6L09PZXFpUHdXaU43Rm1tT3J6ckF2YjlOWFkrblJs?=
 =?utf-8?B?aFJYbXlQeGIybzZxTHcra3pTV1hzT3BFOGwxSy90V203L3l3WjI5MVRHeEZa?=
 =?utf-8?B?ZDNndk93dkdENU5PbzVCSnVHSnVZY1ZaNlpQb1drRWtISk8vcThlSFRPVTZl?=
 =?utf-8?B?NzQ0Szlha25GUStvMi9jMmhreS9Xc21IK3grQTdFOW9PSWlGSnhIMFZ4OUJu?=
 =?utf-8?B?QmxubXU3NTJ3dEUwZ0FwRWpJdG01Q0ZGYWhRaS96Y0VjNGVkWTZVOGp6c2cw?=
 =?utf-8?B?VXdicjBINHk5bXM4ai9JaHBmSVptb2ZnMWVCVmNINERGT3pnZ2lPUm1zRlBW?=
 =?utf-8?B?NkZCaFNla0REeitlQUlaY0lwbE1sTnJMNFp5dldXdUQvZis0T1lXU09iL0tD?=
 =?utf-8?B?b01uWGJEZUo3cUxWdFQwWmc1Ym5GaW5EdnZQSEh2SVQzUnR5VEJCSXV0eXly?=
 =?utf-8?B?b3VHS3NBK1c2b1lTaVFqaE1CS3MyV1BwWkovY0dvSXlxdWd3bzh3NG16SGZp?=
 =?utf-8?B?MEk1Uzd1bWlvWUc5SkZjM1hzWTFVdWZnL09UNS9UVlBKNTZTTHMxZHpMa2dC?=
 =?utf-8?B?U1hYMXdMeUx4L2ZGc01adUw0WktnMUd6Z05CdDZUbHhRNzhadjAycVVxbSsy?=
 =?utf-8?B?bGRiZmdRRmxPa2xvRnFRR3NaNjZSdEpuWUtzYU5GV0lOQXJaN2dlak5Xb2pF?=
 =?utf-8?B?K3drcmZYY05BMjhrN25TWEdBeDZPQ09DMFUrS2w5c1BMQmF3bFdJTUVseEV1?=
 =?utf-8?B?VjNHMEhiZXByYWRVNVlkUDlZdUlhY0dNYXVub2hnenZXMHdsRlhiNDJOb3VQ?=
 =?utf-8?B?NGl6RXl3Q2RTbjg5M1VUNTRWL3dzcDRzeFRoWVVyMHJDdkxuc0ZPdkNZRmJZ?=
 =?utf-8?B?Z281Q0VOK3YvWGF1N2lMcU83UnhlMHk1OWtBTThUQmViaGpoSDQxZjJERDRo?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WNpJoCFeaaFFt4Kz5jtGJ9c107FiqviGQ9fmG0sv6uri6zJlfHhAPEjnKYuy3ROeHfceSemcXq6Qn8oguy4Q/Phwiuh+ia0ptlT//ze8xxZXM7vagfmGA9w3OmPBFCBi14wXhDfUe5Jo39H9QaMvo3jHU2g5Qtqp6+74c8OVquftWt7f8M8TqUxP+iTwHhxCbTJ18PWmRKPrIOVBjO3HFwNYzhsE+YN4MmrbswAASKMjopkOJ3OZixIFYbb2Fc7hWnk/yAz3fGRhzgTei6uelE7OfRpNEQG4PCewkjJ1OImMPfRfXzrCxpRJFEqaOdfDVwF99HlMwDMFrSblW1zk4BYCDOAadQ1vxdxKfgEUNFo9jCSJElY0OTuxLjY1SuAk4hGpNc0ZydZ0WkGFZ2RK/nD09PKjewn1yXpWrt5KrNM6L3kXqt/73+q1mzjqxx04zeQvzuLW4wqZqHsi9+UhZkoIZXSj8bdnEysCoJEjjx19RCCop8IT7WFVkPDJ+yWg9aKR2Yb1s/KJOQWrCs2jSvV3AOxfFCUsnLrCoLaM+Xnht8KCYctl22C+3tRr2st2KSBbgED1YYhh8euQpcCGIGFdEDn6FI4qJSBtdB9WUjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3b111c-4cda-4dec-4cdd-08de040afb07
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 12:30:34.5452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRrgibgYIlZF4qRBxsPFRB0cARk3L3DmzMrLiaikrd2Nwrpk8W35AE5+cn8CaPFT/YWUux9IkcueDiQdwCr5E5huyhIsNPwD2TFuwLAxyHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510050104
X-Authority-Analysis: v=2.4 cv=G8ER0tk5 c=1 sm=1 tr=0 ts=68e264ee b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=UM7U3aLmj3c07NbzghUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: zF7MwNtx3WHa9BXTOn_UZnpH0MAzC59a
X-Proofpoint-GUID: zF7MwNtx3WHa9BXTOn_UZnpH0MAzC59a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA1MDA4MyBTYWx0ZWRfXwfRGTlvHKiBb
 YxIF35r9zWksj2es9Sb5h8Xg/9bVXqnTX0f2ADma9cZ9Goceo8EzJOkEOxqPSywax0QDA1uYDBq
 Ute+X9aE+99/0Kx6A7KPx1650wi0q5PnPvHUJwuTrlIRfh+gM1SRuUeVMmwoBS8BjqW3lPbJRqj
 hQjs01lJDy8GuD2ZVutLXBUUeb3nCZSTn1yIX8YKEaNSTbSr2iZ9wMs1yWAj5/O+NiyDjV1i2oJ
 zuqPagVkVU+qTXcbij4nofcbhdHeBSPFkN+4r35KCYQh+0ak9Jp6Hhra37aSRQhL09i+n8+Nmba
 PNObaOqlAnnxDFRML8OgURrZBSF9Rku/K1DY1WJpBtiyMN3uCegRUntqDbQUF0LjbQLJ/8Q1BWs
 cFmRfThQO6xHEiK7t5JUKZNm6WnzO2xMVpBfFvuXFU9Xbmt7BkM=



On 10/5/2025 5:52 PM, Denis Benato wrote:
> On 10/4/25 13:42, ALOK TIWARI wrote:
>>
>> On 10/4/2025 12:25 AM, Denis Benato wrote:
>>> +struct power_data {
>>> +        const struct power_limits *ac_data;
>>> +        const struct power_limits *dc_data;
>>> +        bool requires_fan_curve;
>>> +};
>>> +
>>> +/*
>>> + * For each avilable attribute there must be a min and a max.
>> typo  avilable > + * _def is not required and will be assumed to be default == max if missing.
> Hello and thanks for your suggestions!
> I am not understanding if you are suggesting of just fixing the typo or changing the phrasing.
> 
> Thanks,
> Denis

only avilable -> available.

Oops, I had a typo in my previous reply :)

Thanks,
Alok

