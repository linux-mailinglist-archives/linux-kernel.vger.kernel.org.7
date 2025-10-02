Return-Path: <linux-kernel+bounces-839833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4FEBB286A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A5642307A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541C127D77B;
	Thu,  2 Oct 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQB/Yh1l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ed8JIuW9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966CD23185E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759382675; cv=fail; b=CWhh+qnssP4G6KLi8mX1ZFbZIRFggcZSfg5lo1gggcnuHwxjL11heoL1IYEkgKQmjtx0ufWAxWLw9edgVq0XfaFzuDqPHYaJ8JenNxzFP1fZ2Jr2jE/wpStuyKJEnHFKeNUXFYzTjJ+1SPP41J+PLCkpAHgZGqRIXOHSMlIWOsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759382675; c=relaxed/simple;
	bh=/SHmTc3R70jCZR5Bg0IsQ/l8BRM0j72hwhplvBOQTo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQiqzYI01Tvya1wGy+i2giKnYTpg32+lw/fZaBhkresueLMEGD4yNrBWrIVQbUkYoYjiPETV4B1+PL16rDEOnSZaGnbStDvCU7z4Bgg1mtuzePquM6TaVJ3WAM04yZCGvNwBPsD+uMSB6b5tOt/xJ3MuEuYPGEAKvYmsacX0do4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OQB/Yh1l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ed8JIuW9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5922Mvtn028539;
	Thu, 2 Oct 2025 05:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=S+ptFUHzAeB+KExlQVxXtn8lTbr88MM9nvfDyTIUCBM=; b=
	OQB/Yh1lOQC+1CDyAvpVAN9KbTdgkDLrbRWYKs/awUixsOM1TXS262hyRHxlcxr3
	FnA8t7aculQprVj3BkzLu8rM+9gDfuDtLis2+EbfsOgu9vDIJpODHxLOiqRCyGXO
	eyIxDIRnwR7Yu4oCdDnmqwGubai9qgTX8g7UhYYjXe1vZLNcVkzlyEAO7S7JS8r2
	VVi+mejsleCdZgRjhgrFzORX0+T6gZsUfk0ZXNDPg+uBQG3QFvfm8dLH62MNIuEq
	QGGYxCa15R6oXwB+vKPeCn4v7gBZ6yqRGHsmgqv4UC+WFxvror5+JWVKArXPNXwK
	fOFVehHZh1vmvgUpM1FGjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gm3bjrst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 05:24:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5924eF2Q023209;
	Thu, 2 Oct 2025 05:23:53 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6cb0mbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Oct 2025 05:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4rJ1CMFGAt3X1U+RzyhQzpK9wcGoYPspg8DvgvvicCF9VUwVnuDNS7zupQczh3kmSdwGUuNYVbBgVEV5O+W6LW61IuoBj9ZHD4JuVYwGnN0Jsu4mZGBEI8yMVajwVU8euZpe6R3C/kaghHpci/xytlFeyKe44hLa/uaJFCmvg2QgApnxE7TmE/+ZPyPbLg/N4Vxobf3MtRKMDeqMDyEpxw3sNYcl+EB3qJSvORJ3crcRwKzP4G9UDHnkw2ZoJEE4qW2RiKrEnqDnCAB4n7YHv1AIe8MasREX3pFhp4qQZeePkirlOOolNxk/Z/EHUQRIT6iiWk3AqMoES6BI8w9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+ptFUHzAeB+KExlQVxXtn8lTbr88MM9nvfDyTIUCBM=;
 b=mmK5E6Uem2ZFmWnz54RN4NvlUWuUaZjW55TfCdFbF2MFtBG1uSoIG03xDtPat20wGwNwfKDk/yxGOVYeppqmFUfIDDz0XCh8GxCTsG1udsV7FZvp2OuSl33oPZSJEEMn1Cy/QlEGg+/4crwMvN5WPhHgnkS9nQ2Ei9CFn8F0zAJCmd+eZaZCEUX0T6eC/W5y3UBJEBblAvKFZ0+ypHiPqocHKhi3gS4hGQKvD3AjA3zrjXDDqLVwLUrshvOuqnzUhoj9HhBmLmQm99j58u5CjD+X4GqEREhruBPZMKBc8BDP0UjqPf76osxvRKSr4pzbHYG8xMCOBlN0r+JfFL6Ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+ptFUHzAeB+KExlQVxXtn8lTbr88MM9nvfDyTIUCBM=;
 b=ed8JIuW9mYN2tLfIgW9OG8xPHf7WXH4MBhIYj9WOUj5EmPzDswumZVMH8pZRl6VBUCj6CVONmb1x5q/PWHpnDMETVD4i6tKK3dZWHfyX+rXlqxW7eB0xFiUMT9VJH1oTRSS2jb5OcSbRPRQ8J9LP2iHp9Ze0ax47rDolHEFY4KU=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DM4PR10MB6085.namprd10.prod.outlook.com (2603:10b6:8:bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.18; Thu, 2 Oct 2025 05:23:33 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 05:23:33 +0000
Message-ID: <57d9aa32-2fc8-48d2-b68b-3308c7d58125@oracle.com>
Date: Wed, 1 Oct 2025 22:23:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: Zi Yan <ziy@nvidia.com>,
        syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Cc: akpm@linux-foundation.org, david@redhat.com, kernel@pankajraghav.com,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, nao.horiguchi@gmail.com
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
 <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
 <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <A4321695-9F12-4C7C-ACC9-72FD84B6DB2C@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::24) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DM4PR10MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b7eb6b-ffe4-49f6-c323-08de0173d466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUdZMXZES2tMempoNmZjNWx3dVhBdk1IbVl0SUN1aXVzcUM1dC9GaGtBQjBH?=
 =?utf-8?B?RmRDTGRGa2tYUGFPeGQ1RUlRd0NXWnVKbVhMRXpBTEtjbGk3bXRUVkVNcGhD?=
 =?utf-8?B?dUpLOEdBOFF5Sk9qUUxtRXpacytyTUpiL0lzQzlGaEU2U3VuNlBQR2dXWVpy?=
 =?utf-8?B?MVNKRGxIUWgvc1NUSW9jVUlqUFZVTVg1TlJRWVJHMmZ3bGt1Y1NIMVFQVDRY?=
 =?utf-8?B?dy9od0xUQWhEMzdaV1MzL0ZyaS8xMHJvSFFLRDdiMlBYRHhBS25LVitiWkFr?=
 =?utf-8?B?UlpGQ1hKcjlxdjhMRWxweW42amRlSkJIR1B3UFdTdENRRUsvYWFqV2xRYWFk?=
 =?utf-8?B?OTV1Z1Z3SW1sSkowUVpIL2dieWJPU2lHS3NMN3ppK0xBVFFYNGFqQmVCczFE?=
 =?utf-8?B?VzBzcmdEcjBlczhVUFkzR1NqNStRdjFGV0V0Zk05NHAveS9VR2MzRWZOY0sy?=
 =?utf-8?B?NkV5cWQ5ci9ma1luVEpxNXpVNjREc3NBcXFTMmY0NXdpVUc5TnJRYlM1NldS?=
 =?utf-8?B?L3ZyT2QzaUlsRWpRV1dqSWIzRTY5RmptdWFwWGVRVlNTUVhTaW1QcnZDa1FX?=
 =?utf-8?B?YTJ1MWNnQy9YSUxDM1IyQVZTYlBzN0pzdXBteWxWQWMzd213NW1KVUZvUFZZ?=
 =?utf-8?B?RTlDaGxYNVp1K2pWRng0QUNuZUs4amdodkp0cGRGVWNKdnJJalM0ditEOGFj?=
 =?utf-8?B?cWJkL2tmTm9MUVNvc000U2hxUUhFY2VuK0lTNGkxU1UraUQrdU9iUFhlTEVo?=
 =?utf-8?B?THFJRXJCcE95aGNxN1ZScm5hMFpWZXQ1ZUlQaHV0Y1ppbmdxYlk2N2swT1Uy?=
 =?utf-8?B?T3QzdVdmdUwxSGJNQ1RqbVRQL1gxSVgzdnZiZThSdFZvVnhUU1JpaGtvVFBh?=
 =?utf-8?B?dGlESTdreWk1NlpybVd2L2huTHBSVzVRaU4xTFFZOCt5K0N6VkFIME9pSGhl?=
 =?utf-8?B?QW42WWxXSmdEZEErWnpOTUUxcVpKcGcyQmxLK05mZE1XSDhzaHI5Y2QzUktU?=
 =?utf-8?B?OWI5Smt3RVNlTFFGenEyUFpXMFNJUmQzN09RNWxFQkVaYmJrTWE3UnREOGVh?=
 =?utf-8?B?QmdQby9FOU5IT1hmV0ppRUNIM1Z2S3doNGZES1ozVGFTYWQrZTA0U3BSQXFi?=
 =?utf-8?B?UXVoV3c4Wld3alIzZHVaWFViUkZ4REl0a0xneUV2NStBVmJqZTRITzZNMjdG?=
 =?utf-8?B?eXRGeS96U3lCQU53M0NveUVTMGlPdFpuMlk4bkQ2SlArQXkyQjA0QzRyUTlh?=
 =?utf-8?B?aktJZmdGVHZHbExkcVl2eTBXQ3hoY0JyNTRWUHNkWlZmZmhHWjlHUUNFQnE4?=
 =?utf-8?B?aVZFcURGQVl2dmN0MkUrWlJyUlEzSWxZRnd0MlBZaGZaeWovOFlweGRuVURz?=
 =?utf-8?B?S2E0SVNGbUttOVlxSDB2NUF6eTBmcDlUcGU2dnRMVnRoZ1NiVzdwVFY5QThC?=
 =?utf-8?B?eXlRQUNic3IyUkdLQm5lQXBkd0xVUDYzZHZHRW1rY3l2ZWU5a2F3bXZndjh1?=
 =?utf-8?B?ZTR5aXE3aG10YUZvMUh3ZTRtNTBVRDI1cHhQcThIWlV0SWdRMXF4VzJheWhJ?=
 =?utf-8?B?ZHZ1MWFia1pkenc4YmlERFBWejdQelQwQkNrSEFHczNBTHJJVVgwRnpNWjla?=
 =?utf-8?B?U3FPejdJZ05jcEt3eTl1Q0VNQ3l6SWhab0w2SUN4K3FQeXluV0tpVUJveVJV?=
 =?utf-8?B?ZFhzTFdzeVJaSUVvZjJqVkhvb2hVditJWjk3ZERsQ3ZKWmZPTUZPUGxJZElC?=
 =?utf-8?B?TEx0R0lub1FEbEEzRWJzMXlTMHJaUjRjQzYreFZyT29rYmMzWHpJSUZjTmwz?=
 =?utf-8?B?K2FoMFQ3a0hEbFc3eE1la0orZk1xdnU5b2VhME9ra0RyL21WSHR6QlVwL2lN?=
 =?utf-8?B?TWVGRkRkcWZIcTYwWTlSdHNhQXdwYS9RTzZoeXJ6bHZ6ZVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2s0c2gwK3MvQmdxbCswNHpQakNHd2lIVnJhVjJFSW50QWprR1BTamJpTko4?=
 =?utf-8?B?OWk3ejVlYUtCckwrZE00dFRFc1NMU0ZMdjkyL3RycVZLV0pQN0MxWTFwemZq?=
 =?utf-8?B?MmYwVEJ5L1U0Y1JrZFNKbzhqNU1IN2ZkN3pFNnhPRXIzVVBpemxOMkdQT1RJ?=
 =?utf-8?B?QUJTc004ODlMeUtaVnA4UStuWDYvR1VBL2prcjJBYUZ3RHJ0blBCVmUyQUtG?=
 =?utf-8?B?QXNXcktWZjhPcHNMempVdXN6M1JRQjdFUXRoTktSZmJ1TlRUZjhUNXRyRXNL?=
 =?utf-8?B?cHBpNFVLUmZneExsTW1ZNkQyd2doYUVsUDJYazMvVUxEd0QxYlN1Q09hRkhG?=
 =?utf-8?B?NG42OHg5emZXaXRaRWtCckZOSjg0MURycWJYMDI1eGtZTDFxU1QwZWVhd3Vh?=
 =?utf-8?B?WExpQWhNRGFUZlg0SHNCcnNlamJ6SHVvVmVIR2kzUk1LZHg0YUpOeHI1V3RH?=
 =?utf-8?B?dDFUb05RYitNNHRXODJNM2dyYytsZzBmSlZJVFlWaHNnL3Jlb3IwNXVLQmJL?=
 =?utf-8?B?WnFNeHdkbEpwYmRMc3E2dkdHSGZnVXU1T3BEdWxxaVIzTmVHMU8rd3czMFFB?=
 =?utf-8?B?WnA3QkNiQ1Q0NnFOdm5rbUdodFgxWWZCTm53VmVHME4xdUJqTC9HM1Azay9h?=
 =?utf-8?B?TElqQWZFb1RKN0Y5bldzdmJxa0VoWUhQaFVVQlY2b3lyNnlrR0ZBa09zZ2dr?=
 =?utf-8?B?eW9yY1JyRVpKdlZuYjFITTNJakdlaHNwVW1HVG9jSFFJdXNYaHFMQ1kxM1Js?=
 =?utf-8?B?SmZMaERPVDVtWExLSFd3UlZFMURxcUJqd2syc3FHU3FQbzZhbzcwdTAyL2xw?=
 =?utf-8?B?dnlCc0dGR0dkQUF0bEN4MDVRdStmSXBTYXBXUVRRU0xIWGpSLzBiMEhYUFRG?=
 =?utf-8?B?eWw0RHFwbXFmTDl0M1ZRMlc1MmhWeUF1cENBbURjaUlrSHZFOHQ1VUZ1VEVN?=
 =?utf-8?B?UjdNR2hDeFBHTDQ4NmgrRFQxSHB5aytqSUxHT2NucXQ5SFZWV2dta3ZqOHlq?=
 =?utf-8?B?eWlNUmxRRWFCQUw3OUZ5dkZNdkZneGdJdDRrV3VIZU1JVmRUOG1wU3hQZWl1?=
 =?utf-8?B?dzZHVjIxcEpBaDZ4WjQ2aWkwaVZhWnNMUUlSb0sxTTZUcnFlbk9INlNCeFBG?=
 =?utf-8?B?THJCOVNOZjg0SFZKSTRnTG1XWTRjd1hSbmE5TFNWY2RJRWxwRmdKeXB0Q1JG?=
 =?utf-8?B?dVJuZHJGbHkxQXErSURrRkJ1cStRZ01mNHFXZHB4YlJJNk1VYThZSWFZaHc1?=
 =?utf-8?B?cFh1NHhIYngxM21xM3NBaVlmVHdoWHBqNHNNSGducGdTRjNhUElmN01rOWIw?=
 =?utf-8?B?RTNBSlBXdUlXWlYxRDdQTWFzOWQrbkdYNFZvaWZmS3VkWndXVTBGZTEyOFlB?=
 =?utf-8?B?T3VXaHduelRJZXJUVWI3RjJpeG5tSCs2dzYzbVQ5RmNjTWdTdk9HdCt6VHdz?=
 =?utf-8?B?aXNGZ0hmdVZKOGc0QU11Qyt5QlhWVVhubjFVYWg4VW8vYlQraWh3di82N2RL?=
 =?utf-8?B?N2J5TWEwNERtS3doSG5SMUZZYXgrdWlxK3N3SzYvQlFFOEl2RkpuWGFpcVNp?=
 =?utf-8?B?dVhYUFZDcHppVjhsTjdZRmZQdVRSU251MlF0UkVGdVNIblQzWnBEN002RzVw?=
 =?utf-8?B?VjczaGlGZDJ6ZDZ2ZTVlZkZkVk52M3RtYnFXcHFlY0I0UXkwcGd0Ym9DNkUw?=
 =?utf-8?B?NDcxcjJUUEtZbVhSL0VkelpNckw2QzEvYlltbWdYZk5VYWV6VkhIdTg0YXRS?=
 =?utf-8?B?aFVKd1hBQko5T1ZWemFwQlhnVkNmSGl5a0ZNOTVpd3c0cXppSE0rV2dFNStE?=
 =?utf-8?B?c1M2TWNUWExSTUg3OUtZTXpmR1IwMThzSEpmZGIwN2w2WlJ0ektDb1NNRGlx?=
 =?utf-8?B?SnVvWldCSVU5VmozamVqTXBHZEkyeWRxQzBWd2NybXBoRko3N0g2SG1hOVNu?=
 =?utf-8?B?WUV0WEZNWitYUWRGbVduMjN4M0RCQVh2L2ZNNXFiR25NbDZUWUF1cDM1MkJz?=
 =?utf-8?B?Q0cweEVxWndXOGROZEVTd0hxZTNaNlNRZm5NdXF1YXM1ekloWmtHcW5Vd2t6?=
 =?utf-8?B?RTU2cWwxWTRMNlVyTHpuRmlsbzZiOVhaTHJVSloxQm16OWQ4eER1YklNenpa?=
 =?utf-8?Q?0QMPxsOGKG2eJMpAnYsB6Frcs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rRnA1bk4Hakau3zeWWsDcVasQfb3/9M+cSgFCAmmSaS4uArlHqDTaZf+xDaOhUfKyNUq/1BUuR/l7PeJOzPTxmR9PpAGvsBXlF7jANoy5qhjeKgxGKFz5J0t440WZZLRqhAwI5hw8Qt/qMYoHZ7wcjUNjhUBpw0H1t6j7Xay55XPO5MlGoZtLkI39zGRX4Tm7VKmasJp1HsPCmS3hEm3k/ViFMwLG5fa95L+3Kp/IkyYRFl4ni+QbtAkozYmociZ7C+Qstfq2WQ2hV1ba6W9Cq+/Lsw+MM5vckAqthwuXVQs2SibD2HR+O7voQm+735vq1UAHET8jUKYwUp/kuPcI0KYePbdelfJbLPvu1DBeH+wOmnjXJ6gQUCYFGZ/Wryfpq3XNcchtDAaboZ9T2xNIkFGYoUH06gu9aGxWDNk17oV1ZCZcskdsayWMepSPPeh6oewEHo9FPEaWw0N36UPUPmpeL7l1kAzY+qlbEUdWjhJV8CN8t2GNraKiBKlpO8pHGQfmiFve79dU4Vbe5zWgcgibAATeyBiQO311v0u0rpwrHmHGdAj//KfpYF/ElkMW3WxR+JGP4Vy2CA2XwzPQTUL6v8XnNxwgc1wHf7QFk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b7eb6b-ffe4-49f6-c323-08de0173d466
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 05:23:33.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nlbWQRtdcUK8BtJWMr5VuxhcKRRz2r68C+BZM+fogv1M+i97eADToGKEt/5ny/dL7zjSRxnyqE7Kit7wGonMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020044
X-Proofpoint-GUID: nZir0sd38VPwvCHda6lP3Y6Ec8Q-eHNo
X-Authority-Analysis: v=2.4 cv=GsJPO01C c=1 sm=1 tr=0 ts=68de0c71 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=edf1wS77AAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6BapH0Fc4dt6a8Lr7CQA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MiBTYWx0ZWRfX/pkUfTqbuTG7
 IzOUioKbLCaIYZacxALF0Y6dFZso5JaT5dJWrgaS7IenYIuvot5RxJJUhvFN635gHSeVXqjl0MK
 v51wYaUn4UaX3I0y/UlejYR+0qJ1aOHLdtA81dqsot30rl7e8jUGyhXqg363vJTZiUM068Za/6b
 AXBZP/W8Zzdxqz985gGxMnQYttWYnVu6kGHklST1ijO1+6RqqImjzjoMgMYjtCMo3fh9w+GpWQ7
 YJAVWE6BXQoSoScjMfLPCP7KCHhf/BCWLd38ZA0hz0LnLwCEtYF7hlSlinyNgx83opL/QWvJ/9p
 TiySibubn6/Em7DxZy6z3xewzBDJfnRpx5UW8xzaadNLGvqnacKqIiRLAKI5+aUIqroGvB9dam1
 kzRkc80/B2z3u9CqfPfsCLy0QinD+w==
X-Proofpoint-ORIG-GUID: nZir0sd38VPwvCHda6lP3Y6Ec8Q-eHNo



On 10/1/2025 7:04 PM, Zi Yan wrote:
> On 1 Oct 2025, at 20:38, Zi Yan wrote:
> 
>> On 1 Oct 2025, at 19:58, jane.chu@oracle.com wrote:
>>
>>> Hi, Zi Yan,
>>>
>>> On 9/30/2025 9:51 PM, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>>> lost connection to test machine
>>>>
>>>>
>>>>
>>>> Tested on:
>>>>
>>>> commit:         d8795075 mm/huge_memory: do not change split_huge_page..
>>>> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ce96e2580000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
>>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>>> userspace arch: arm64
>>>>
>>>> Note: no patches were applied.
>>>>
>>>
>>
>> Thank you for looking into this.
>>
>>> My hunch is that
>>> https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
>>> alone is not enough.  Perhaps on ARM64, the page cache pages of /dev/nullb0 in
>> Yes, it only has the first patch, which fails a split if it cannot be
>> split to the intended order (order-0 in this case).
>>
>>
>>> the test case are probably with min_order > 0, therefore THP split fails, as the console message show:
>>> [  200.378989][T18221] Memory failure: 0x124d30: recovery action for unsplit thp: Failed
>>>
>>> With lots of poisoned THP pages stuck in the page cache, OOM could trigger too soon.
>>
>> That is my understanding too. Thanks for the confirmation.
>>
>>>
>>> I think it's worth to try add the additional changes I suggested earlier -
>>> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com/
>>>
>>> So that in the madvise HWPOISON cases, large huge pages are splitted to smaller huge pages, and most of them remain usable in the page cache.
>>
>> Yep, I am going to incorporate your suggestion as the second patch and make
>> syzbot check it again.
> 
> 
> #syz test: https://github.com/x-y-z/linux-dev.git fix_split_page_min_order_and_opt_memory_failure-for-kernelci
> 

There is a bug here,

		if (try_to_split_thp_page(p, new_order, false) || new_order) {
			res = -EHWPOISON;
			kill_procs_now(p, pfn, flags, folio);  <---

If try_to_split_thp_page() succeeded on min_order, 'folio' should be 
retaken:  folio = page_folio(page) before moving on to kill_procs_now().

thanks,
-jane

> 
> --
> Best Regards,
> Yan, Zi


