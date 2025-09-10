Return-Path: <linux-kernel+bounces-809237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6CB50A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916CF3A7BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC19720F08C;
	Wed, 10 Sep 2025 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOGkSiC4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0PnPvVpT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6E20487E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468412; cv=fail; b=kEeEP+drmPLX0u3Iy+f4kgpMb/bn7UZ/pbeLCyw+2yPPOCh0jcrYKrNFJr910+HoTwwsuTYwb9bXEaE0zfakzjy3AVh80eXydFOmZ2EUy1MEej46ADlzpW1B4jfpN7V6Ll+4i0lmVM732yETjSv3cpNeudUvRqEvZNL5MfkS9kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468412; c=relaxed/simple;
	bh=QcwB9WuaCHJORvHe4v5xarMq4wNX1Bk4e7yFMtslpAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/BPVkpIDzVfZYVAyMyGLwpXokQ/hXcMpkuXgg8F0Qfq9TtpU/5VTdz5Y4GegPyzEQF6M7K7utBIwYiaSoME+3RLPckkDpODah+KfPwoSWacS9fVsYUHrHTPmHXM9kB17n9fOaOsg1WHsscWb+98gQFZHfbLhQWud4SynKkgz9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AOGkSiC4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0PnPvVpT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0XLQ030303;
	Wed, 10 Sep 2025 01:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YlSNEocJQj8gw6n3wG
	ceZeD7kAOBQsVGJYhdD+sXteA=; b=AOGkSiC4c3SgdHtqHKp/ZDgQuUNwHZXHUK
	BLTqNns27u78d+il8gRKNmoKllwR6UMb+Xj3ElJUqg0EcCYnjYj32tzDBFyuc8An
	IkDaX3u4Y27aJjHd9bd/m+PPBaYE3C2JRn1nPVDgZAhpnBq/elE1lh/zQWtvr8Oc
	WekB7Y3bMoUgVvtrGTenmgw2JKhZ6T2riyfo6hCaX7R2gGwrMG03lX2M5LvJ6bey
	HCtuLbH9fw140JZH5RXe3aD+EqVew1ilJgN+4DCJGvTIpd+fia5RU3jzpOqu2ufm
	dNe+kG/3YZV9zNBRFEk5qYEkYeXkTnDW3f3jTnZwweZPnQdez6Cw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1k9fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 01:39:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589MpCr4038916;
	Wed, 10 Sep 2025 01:39:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdacme7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 01:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtI6xsohViBKTw7XQLNdbutJr/mryqbNbhMKu5Pn4rZqih0affMtT6JPoxU9kRbVlHGnFjYBm3HEakIjj0mLb03InSS8WmnRhZKKU/XvUkX2UQHrsMWX4zK+Yj70Yoev1RBzvJkPN38AcoCkL3EADjY2O3uzcQCzVV7LmgYl4KCrmPDKyiigcgTZt7yQPmcs1E2rhLoZ7WLSQMlZx2p9ZOwaZoluPgtnnv3eBGeobtaHxWVTKlpOg3SxasH8VpWZ6145DVxGP5b5rrgqiLj4MortLgJJES7gPCK2JspMb+puM/wNkWIygxGDuHN3iz04lEptZMi5DXrr1ckH5O7rpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlSNEocJQj8gw6n3wGceZeD7kAOBQsVGJYhdD+sXteA=;
 b=eaz5NmrDUOzgfg1DMXfAIeQaHh50nKN/6t/Yn8e1LNV8lNPRz2sD0UhIs4V0tCsDwDmkALBwL/HoquqTPp2cWV+bZWjgILx2XZr/yAopJEtIorZP+dkAyFzr4rAQLAP/QMYtqz44rhYHCAyJn/L7CmBEg6JSi5+bxi3GkX716PAxt5RvO/kuJJIzM6OGGJGBKU48qgGis35d6VncjhZJLm+2R6nwB+6pAWLLoBoi39Sv0CBJJe6LyiVhvEMbhS+ZcPNb/WDZ+OBjEEYW8dPIzsAsriDwZM/xKnGRG6Y05rlWZCuNC8nNsQ2uvUaoG2mHec+Up9PmVEGPi+W8Y3aaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlSNEocJQj8gw6n3wGceZeD7kAOBQsVGJYhdD+sXteA=;
 b=0PnPvVpT03Q9JxvoItLhYv4F4dJ8i1FmcULinYG6tsynPDJHjgmnCHB7Cui+3h17jmBMeN7oEhVkyTEFvg8/fSY1NAfHav0jWp8yRKbV+A6uiOgYp30R7EOMoAVCgI9ZHkgPVjIy6hQgjH0joeuabKGfGSU8aS8QEQcnU0fvneY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 01:39:44 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 01:39:44 +0000
Date: Wed, 10 Sep 2025 10:39:34 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: JaeJoon Jung <rgbi3307@gmail.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rgbi3307@naver.com
Subject: Re: [PATCH] mm/slub: Removing unnecessary variable accesses in the
 get_freelist()
Message-ID: <aMDW1urp03myzZFi@hyeyoo>
References: <20250910005957.54108-1-rgbi3307@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910005957.54108-1-rgbi3307@gmail.com>
X-ClientProxiedBy: SE2P216CA0005.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc1f3d1-8f4a-4cda-47f2-08ddf00aeb1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8245S31JO7B4Wr8mTUL+Qc9YueBErcexDeczXIMN0Tl55717mvVRxM8XuMw?=
 =?us-ascii?Q?I/t5WIYCFp8WoKjbKpyekTigcUngnw2H4aYw+KkJcLsLwS/H2udcaiJ9OzA3?=
 =?us-ascii?Q?5ix5wR0voXv0/w8n4ChQ8XGBFOGgqEtMWkpzC597TERjCcU9vkAp4DRWjBvZ?=
 =?us-ascii?Q?KTWxVoANtXdDbwomdC+F5JYMZEs01z9Cmtg7OM+SjZfk3up5kqOwRl6fyTOr?=
 =?us-ascii?Q?eLy1b/qBVXgcE8Y4mn5c76WwMx6FKZc1QQ51SfvKbK6Pcawz1XgCd1oUsXv6?=
 =?us-ascii?Q?IVpqzpuByM/o8U7DOK29j175e5imsV2XkUEzQRPGP55oDTo8lge5hfPMRKwj?=
 =?us-ascii?Q?jvhlOC4SMGQPLXvxHCAkAuhLU/lAlwsbKuJIH2oLKTpPfLotkbYUtqpovWKS?=
 =?us-ascii?Q?KMRxBBZwnrqEkmrb9SP4qNHQXQClwP+8Rdney8+SBjBsPlGwftr45S27zH5X?=
 =?us-ascii?Q?Q8r35AZYbsNm52YzWjaAKrKJtB9KlWOipRY8BHZN1jr3h0eq8jL94x2BdJkL?=
 =?us-ascii?Q?jm9IgDL5DYqyMNZc1yiDzbuC8kakJYzSPJkhuMxuZxcTygjfj3n0c0oDpd9j?=
 =?us-ascii?Q?m7OGtIAloX3ODLzT9QjBDx06CltXQzecbTIeE0RRsEwEhM95a+JiJ8ANxT6X?=
 =?us-ascii?Q?6COrR9MDDkfljKG0CDfA/bwVNsZDnsI+DHA7AnLzL8MWJeWp+h94HxdH53sG?=
 =?us-ascii?Q?JG/M/kYmVqu29dPFkPFL9tsJ+pluPrCmLbhMJiX/AZmiCj00nf6yM1eYYPbx?=
 =?us-ascii?Q?0Y9hxYzhXJwPa/tjoPZ6Qbep04ThKRIb4CH6WC7MCSdq0wXzRPge9qRtw6vq?=
 =?us-ascii?Q?F3h1Lxd3z3f0oEW6aY8IXWGEN9Rrj1UOwW2OPQZRrFZCyEzxcU8zzcCm+viE?=
 =?us-ascii?Q?mlwDNRYWxZgyBVQBlPh+g5u6r+tcUYx3TgRivu0LEESENlfKXLmV5PIKJ5TK?=
 =?us-ascii?Q?B6AFn0vrAoeqyet33Axq6DlgLeR+BRyI7wuwScLJK9Eb10guimLY4cATXtHl?=
 =?us-ascii?Q?K1WiWj8FFYR0b7M0MQsEHuX8gCPxKBn/yX7izqqZ7uQ9qQ+PqNblO2pBN/Jl?=
 =?us-ascii?Q?WhzKZlN4rOUF/LL29URXrXN+nP2s7Vq++YkeSRRD5UiA0mnpq+Wr4pSkqMS2?=
 =?us-ascii?Q?8zu2oDiS2R/PvaPUa2aYJwDo46jC3VhwmMbDcNgc43oO29BZFS5nB4Gf+LVH?=
 =?us-ascii?Q?2qwZd2Ku1xzVYvcVjpgTfZQhOedTPuwZFZap0TZpjd9NJ/8hbIpMCSusEFlo?=
 =?us-ascii?Q?tTz9AvfCcr5H3rpyW1JwFbozD21XmT4sbpYYy442jrDkEFE+Tw6vP5oH0PnI?=
 =?us-ascii?Q?9oAY0gaESEvojFIIJpEJUyyeU9Nz5NazF4NqwAYOJySb2hyOsQ0RCv02sVT+?=
 =?us-ascii?Q?cJLtNVvrKbJ8P5L3xTTM6Tmr9rSK7NmMuGCHlFFzHA1ZtnsY4p3d/2pZT3n1?=
 =?us-ascii?Q?37F9Gdcuo6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2S7U497461TtERsGRY0XRu4iI2Z4BV94YecLJBnDuixlpyy4AA45Ea4TAfiF?=
 =?us-ascii?Q?8zx2SQsWbaUzqXxs+QZBE2UjVsR5wXq51OPZAnIX8U/OJgHrCNGMgx8E4RgO?=
 =?us-ascii?Q?/kYmWBV9vuCSEjEzXiD7MM3HIUFrFWyJD1+ZjAUgoMlpFAlkA2clSdFCbhIh?=
 =?us-ascii?Q?gORoyFvkK6KWWUm5v2HSQW3pHocVEeZvp/qlZlJjmPQFx2M0xkyj2xX+qwoV?=
 =?us-ascii?Q?u7KXS/DWL5os13utzUBCHBSeQ9k6P+Eqi1ItmC3q7NvamyW45wiD9rteuWH5?=
 =?us-ascii?Q?QiwF2sDkCdy1VNmtctnrwpHZH5VjuKH5jakwAMDBuITpuwyIkZU58w98piRw?=
 =?us-ascii?Q?Tzad1hdQ/mEwT90Y5aaYAw+8PRGHDusC4fZ6FfaSE8VJOwgwp+blsIg/DzSX?=
 =?us-ascii?Q?0vTLuQfQ2tepJ1d0NGfn9hwQdaUB22iFYCwSq0Rttr/KIJd9S27rSmsjC4Wg?=
 =?us-ascii?Q?NhHXyiHZ6iuO8B2tRiYz+SbuRSgGoasKSDK/kGoxWqeDyXaBqhso0Wz5O63t?=
 =?us-ascii?Q?jYxpHF68hVYY69wt7lr02fb9jUK17ztlTz96KbX7jB0PmoVQsX0Jh31mSQZi?=
 =?us-ascii?Q?w6I+5+Je/mV0tei6wsGU4GJuTW2dqUpXGojcihnfM1gBwYlin5sOR7wKu0j3?=
 =?us-ascii?Q?TRgqVgLfroyoZSQYe0Xw/q/aWR4z+5h4IGYzA3hzrU72QPJSDPTtt7n41LRh?=
 =?us-ascii?Q?V95ajumPAMn/PyB1JHOiPH978dPLD9lRkMN3TwiL8aZgI+vgemSTYSKG81ao?=
 =?us-ascii?Q?QOAOVKLGtXJ9nRKLdCyCwcXZcHTlEGKuLAXw1+c5CEc4KzPumH3wEw8uZILO?=
 =?us-ascii?Q?cdW57MpYP3Ojn0YwdpKE0ssVmbzX571mcyUj2PMHc7Ya9ujbu+KXLfxC1gCH?=
 =?us-ascii?Q?vfpow90vZhAA2B0kA8hkFLV7Yn6icjnig23DqeKLQin41yfnIepKt+Qgh70D?=
 =?us-ascii?Q?ZVS3jperIYdSE76sRj6ySoShSH8mcBJO/PpgT0mvB/yt6BAh6cxqkK/tTbho?=
 =?us-ascii?Q?lh5gwLPHeVSJOstGKkmdzaT76JwAYZH/yo0ievHLhsGp4YGmRzc53aGuZos/?=
 =?us-ascii?Q?mLxzatkTVpkR3PvSUvjp+8u1gRVqwQFhM2i5WPAvFPmdnh2Kf89UaewbSrrG?=
 =?us-ascii?Q?UzemGJmYHJRJFZiivUfiqN4sKr9YPph5OMVFfPC/g52JoueFE5jVmAmFGbth?=
 =?us-ascii?Q?TdJbcMOI+nLE5ak2YJ4CauXHOMYhznvJksKSMjM6pV3GI6u1PyVSQf1UPztV?=
 =?us-ascii?Q?NMbbHf0BY/ZCeEHpUhYhBxA5n8XHP+Xo3f/r+woKQmjYGg0j3OPFmbAgbVJU?=
 =?us-ascii?Q?xt7X63q3qgYIaexiBG9ndVzbZ7ikA9bfgWxXAVONFrnWUduPrJ80uISpj0oo?=
 =?us-ascii?Q?5WZ2DEdeYUw4cSw/MmYLLwUPoLYFTLN3uTcm4fZzMY004tc9NH+G5eOBmtO2?=
 =?us-ascii?Q?nH5RZsdLEY5N7nZ954y01NM8vQ4paJPoWmDyokPUaRDzgng6ecKHDL/xaKH3?=
 =?us-ascii?Q?CZdQqzy+rfwz6ZTBruRvC7XtWzgf2PhgNY9VoYmFeLH5tq5SQd8QCoL4WERc?=
 =?us-ascii?Q?aFGdx3m146A2l/4WlldQrOmoKkFq9dawyCeXPynn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MQ7dRilhwbEr7ujUsONTyEJ8IBaiH7rbubdV8+U1jp2sNsk9DWlCR76JASg7fZkPQQC8cnoAU0HebHV0AzA4RmswUm07Yi8Z6yvrQ9m/EGn4HH79xesy1GP5ZJt8Q3zGyFpQrP9IKm07vWLFl7fbxoqUg9Ec5XGhc2ZklhwuZtCFQmRF1wHJ60U5OJBG0QUGLlFZ9V5ckAeVD2dtkjBrdFLpYzHHL0R8deuCfPXw0vp2GMg4uGQce673xk/jvRm35tOTPSnGhcr0TmPoOSaFxC+AQoYWV0XqTxGtFW5fUtMLKpDbktb30wsUvXyKH11CVCx1zvHLXI+pPuUErcrVUe/Jy+4rkr+KYEQcuMvrtCB0AF3bsk+Orj5WopGRPAb/eQjndKb4BGN6A9W04dUl5amsykhIxBPTSo65R/dPyumu2ZCJibCoSpmmBBAkjDb3AnNfbQAxgKSA5wu/tC149NdvMHlE+ZNJBUGE2X52a4ENeLYe1eSuJhNJ3tADA5sMJKfjhJe0lO3Yc44qdxKeKXbGBc93S5ebT8U1K8RRpWB1rGHL+TjH7hr0e7BJidnp6hMoZJzexnrZM1tLZr35Jeicc+WanSRI85RFVjQO3Uo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc1f3d1-8f4a-4cda-47f2-08ddf00aeb1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 01:39:44.4956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRx0KQWE2MnlzMRp72rYZ22CLnxzUWHixYi1AJfBS2/G+bjvFmoxv4ahk3x6ExXgJsB3TVQirgV6gzse3NC3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100010
X-Proofpoint-ORIG-GUID: 66ntTwUjZOUVAYpbPlN5A12eEr0HQlfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfXzKRh68yS35iW
 3VNPou5rTurGmutaWPXH+gdMd0JCGFby/+oVeNhyGpMdwQoma/9Wy8X9K7JvKOSeAeJ51DVNWv1
 KK44/tAiyMPQA6Chgc0hRVE8mzjaJ5WuBmI7b0W5kQtKz8AE65fRyvAWFcgohIn4r6UpuH4ALZ0
 B4LRFIMxRsEFxY2nBs3w//WIleUyQom+AlAs29QY5ZV5u2gQ33H9wMYUsTRNjKf91tV/LeYR1O4
 6YZqLlhkzx3XT7GnBLu8IXNtoMqC92GvCjWFE+W+yKMm8ytAz2xlV86IOBHopNKpis/VpxAL6wy
 6j5otcaXqJAdEE0aLZEvkUVSg13Fe6hNrrGCbmO4B5GHu3J2lbEGv5dOFCVOd08+z+5bA4Q9+iv
 8vlqb3RJJEYQ7jzlrIrx2P/DsyGpQA==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c0d6e5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=n_6nHObJ2uGg-0nPgEMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: 66ntTwUjZOUVAYpbPlN5A12eEr0HQlfv

Hi Jaejoon,

I updated my email from 42.hyeyoo@gmail.com to harry.yoo@oracle.com
a while ago. Please check up-to-date MAINTAINERS file when sending a patch.

On Wed, Sep 10, 2025 at 09:59:56AM +0900, JaeJoon Jung wrote:
> It pass a NULL pointer to the freelist_new variable
> in the __slab_update_freelist() function so that it don't have to re-fetch
> the variable values inside the while loop.

No, it needs to re-fetch values when cmpxchg fails.
Otherwise it would fall into an infinite loop, no?

at a high level overview, cmpxchg works like this (atomically, of course):

retry:
    old = var;
    // modify some bits in 'old' and store it to 'new'
    new = old + something;
    if (var == old) { // compare
         var = new; // exchange if the value is expected
    } else {
	// if var != old, someone else updated the variable. retry
        goto retry;
    }

and this retry will certainly fail if you don't you re-fetch the value,
modify it, and try cmpxchg again. The 'old' value fetched before failing
cmpxchg will not match anymore because other CPUs already updated that
variable.

> Removing unnecessary variable accesses as shown below
> will reduce the code size of the get_freelist() function and make it faster.
> 
> Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> ---
>  mm/slub.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d257141896c9..2e305a17a9d7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3654,27 +3654,14 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
>   */
>  static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>  {
> -	struct slab new;
> -	unsigned long counters;
> -	void *freelist;
> -
>  	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
>  
> -	do {
> -		freelist = slab->freelist;
> -		counters = slab->counters;
> -
> -		new.counters = counters;
> -
> -		new.inuse = slab->objects;
> -		new.frozen = freelist != NULL;

...and the frozen and inuse bits are part of counters field,
so they are not updated anymore?

> -
> -	} while (!__slab_update_freelist(s, slab,
> -		freelist, counters,
> -		NULL, new.counters,
> +	while (!__slab_update_freelist(s, slab,
> +		slab->freelist, slab->counters,
> +		NULL, slab->counters,
>  		"get_freelist"));
>  
> -	return freelist;
> +	return slab->freelist;
>  }
>  
>  /*
> -- 
> 2.43.0

-- 
Cheers,
Harry / Hyeonggon

