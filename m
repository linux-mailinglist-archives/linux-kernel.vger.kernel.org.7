Return-Path: <linux-kernel+bounces-750760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755DBB160B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A22D3B6B61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E20275B1D;
	Wed, 30 Jul 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XNTxf3wt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A225D535
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880003; cv=none; b=IQFHAefp2PRvw4sNFW0VjKWmseM/OFFHXe0HWqw62/TsnwtQurXQ+Rm41Mb3xpcDsqa9CEopUHGG3+71c9zvKTSqtCo/wvuTk+qRdc6/RddPg+yEutw5VsVhEe+LF4VNiZXtlCgvcKPTutr/+bQZwS71ntolgoYj1a/133kbbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880003; c=relaxed/simple;
	bh=O5waUtiS1DG/Eb2NKnNA82G9Q+t+ECoaVsfmcPLBT+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdaDhbptBE/MMD8/nIWQNdW94W4rSFWhluuJyCihhGuAT5YgyLb+BUtA6hIhqYIEtS6dCnJNJGxDXbGRNIxwXM7LZYom9pkOZetDIDcnkmHyszyrVryF2/iQdwSGc2VtaLPG+HIl+9qqpdQHijwCJCr8HQCNLYopM7I27q/Pvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XNTxf3wt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbGFi030419
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5gxQPztQMAsZx5roYM/mBxyPSLwU6l2b9jc3C98wtqY=; b=XNTxf3wtL29mzUGE
	PeoxNr8UjQenUIfYGYTVRe4xQhJ2sihoIQAjt7I3yeUhcpV7nPl5nfEAjOzcZMpN
	a6b79mwM6ejGAcsT49Knh3iMHQCDRssPZHfvpJCek3r6+eEYL/pNgAp6pCviVo2A
	0TEKTw/6OKFNAigzL9c+TLo+5L/27NIWLeq4iqCmn5EqC3JbO0s2YwvnqsuEHGtj
	eLsE9ozDlr+vWOWU5ALvnLsh/9GTBSm79C4BOnuGPR8hcihTWLqMpnLzyzn2DEBB
	spAdyrk2Wzjvkd1YANg4QQxpuOxK1HpZ0lPMwD2KOwgsnN9zqA6ybTM8leQXpQXs
	vAtmFA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwer59v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073b0e7576so14161626d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879999; x=1754484799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gxQPztQMAsZx5roYM/mBxyPSLwU6l2b9jc3C98wtqY=;
        b=IiwsvUuEpgDJmPrUQcHsg/UYVsf9zRzn26m34YADCp6TjmqPdAyJ6x6UpM6aivkoRX
         mBiWP/OIvBTPtWwE9mNAPXJpB9RWGOrj2zBf9UJF3R/Te9Ih5BOIuO0pbFcOlU9QRwOk
         pAh30FXjpthhYxRLyJ0Eb6C6WboiRssB3onVDd6xd8I7Htd1nNTqaSmb3f036gPfGsyk
         syP10DrQB8qmcPVqWC8L70/vs9BqHFsHxi2XaQE946ycJf8Y6IN+gkRwEsP8uIqBiWJ8
         Fs7E4G4J9YZwvEVl46G1yd5Fy81vv6+wNzGxDh27AzPiyaXFSJC741hKqnkq40Qh0Aoj
         CTBg==
X-Forwarded-Encrypted: i=1; AJvYcCXIQKREooeF4GSf5hJ75iGMwzgSVCJOaSqEFRGCL2/+wcsdlrUJ37mcYnjwigKZcjuStUl5uGr3OQowKEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnj76U5qF+enC04dkrgTUrKNAjPP7qRJhSsM24t1ymW6d1ZEV2
	z6opweh6HxaZo/f/TbfvXy7BSeD/UBa6Xd4FHjjdd81Z4Hcdl7Il0bL9KrgK0oL1GDJ/prsw1zc
	uDhJTcnemeEMwdkHpnvpHDdhZQtltTYS3NFk7EB0D7qGOnfFC2na1edjSv7sGtG+WJSM=
X-Gm-Gg: ASbGncs/utaqsiquD95NzhP/ZgsuwTzrs0gVP53DbZRRWcm6ZGqQ5z0+Xr2r32ZUfli
	jLcXuR/YuKeiPqVKi5yXFDgAgE+R6EUkp0LDdOfhV+UmU+/tXu5F/oMLgDAXi7iHOFuD+UAoOWo
	R8W+p9l2nxiYp2WBtazzb+O+/vGXKT35VyVD+x00AGlcqMfob/UavFdCXQLz7gq9puZdoRhc2e7
	h39UR3vN9WNcYwaNYYAFc/7eRC0XGrtQ/jb1WywRwMpeupgx8M32TbfCet2IUeud0ZZGZ9BtGhW
	LwEddkzkv9oNPuadRmRcJp0OkCX2tIw5IMrI58L0pzJDqtroi0d4v3ojeIZmUOV3y7dy5jml5hP
	uSw1vSeTUygNjqpuIrw==
X-Received: by 2002:a05:620a:1918:b0:7e3:3384:4aaa with SMTP id af79cd13be357-7e66f041721mr221481585a.9.1753879999527;
        Wed, 30 Jul 2025 05:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8edTo7a2GExz5C3MxUcRuEGGikKsdBITLyPojp4jXdFSx12vSqnRAFako0z2oJUstWUxrbg==
X-Received: by 2002:a05:620a:1918:b0:7e3:3384:4aaa with SMTP id af79cd13be357-7e66f041721mr221479485a.9.1753879999058;
        Wed, 30 Jul 2025 05:53:19 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa7582sm739237966b.99.2025.07.30.05.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:53:18 -0700 (PDT)
Message-ID: <f2f0f25b-40b0-452c-ad9e-01b84b32e163@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 14:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: Add initial support for
 Ntmer TW220
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: aliceryhl@google.com, andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, ebiggers@google.com,
        ilpo.jarvinen@linux.intel.com, joel.granados@kernel.org,
        konradybcio@kernel.org, krzk+dt@kernel.org, len.brown@intel.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lossin@kernel.org, mingo@kernel.org, ojeda@kernel.org, robh@kernel.org,
        sfr@canb.auug.org.au, vanyang@smail.nju.edu.cn,
        viro@zeniv.linux.org.uk
References: <de111b27-9126-4c03-a7bb-8cce9ea2780e@oss.qualcomm.com>
 <20250706034303.5404-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250706034303.5404-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ODVVUMT4KcNzN-bRPthtB_TjC6Y4Ljj2
X-Authority-Analysis: v=2.4 cv=Wv0rMcfv c=1 sm=1 tr=0 ts=688a15c0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=dEhO_gk0ZkCmvCEDGLUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: ODVVUMT4KcNzN-bRPthtB_TjC6Y4Ljj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5MiBTYWx0ZWRfX7KDEMOzvropX
 eklIENLnGlJBIDjmo/pKyQI+BT98bfNBExI+q4gyoKWQ29xdshQzj36Yfio11kxa43sB5IAxs6A
 MAXXX2NF56OjQKepZh2Km3MQYUMipEIt3SPXGhh8tDoTzzNDW/sUDswI3N45ewMyH24bPsHl4cI
 LY4aQ5q1pbYrt2UELxKSC46Mf5AmdBuUsms5eWHBvpnheHfosyp0z14CoWB2hhwRzxjvP11rG3P
 hVh4f5ULv3YDo6JU4oRD3JzIaPqYJmcIpYSNDUDZoZBE2SoeJHELo2j8lhHlUuS1pidPKux1b7d
 ooOwcYWeMt+RC0KmeavHyNdWynbfs22gQHCFLiaIz4yzyao2KQGv/6dA13bAnD/8G1BRVIKr6Qd
 rq4HuzartE21I6dYJUmnWYH94ff4cuV/ssRZyp9zewGREtHRBjh4U1xWFPu+ZHUUlgtuL9IB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300092

On 7/6/25 5:43 AM, Pengyu Luo wrote:
> On Sat, Jun 28, 2025 at 3:48 AM Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 6/17/25 11:29 AM, Pengyu Luo wrote:
>>> The Ntmer TW220 is a WOS tablet based on the Qualcomm SC8280XP platform,
>>> also known as the Robo&Kala 2-in-1 Laptop. Thanks to Hong for providing
>>> the unlocked device and early development work. This patch adds an
>>> initial device tree to enable basic functionality.
>>>
>>> Currently supported components include:
>>> - Bluetooth & Wi-Fi (board file regeneration required)
>>> - Battery charging (up to 15V/3A fixed PDO) and reporting via pmic-glink
>>> - Flash LEDs (front and rear)
>>> - Hall sensor (lid detection)
>>> - Keyboard (via Bluetooth or USB)
>>> - NVMe SSD
>>> - Power and volume keys
>>> - Simple-framebuffer
>>> - Sound (playback and capture; top-left DMIC only, top-right works only
>>>   on Windows)
>>> - Touchscreen and stylus (requires GPI DMA support [1] and stylus support [2])
>>> - USB Type-C ports
>>>
>>> The following components are currently non-functional:
>>> - Cameras (GalaxyCore GC5035; only sensor ID is detectable, no frames in libcamera;
>>>   partial driver can be found on LKML archives)
>>> - DSI display (blank screen with `dsi_err_worker: status=4`; primary DSI register
>>>   dump included below)
>>> - Stylus wireless charger (CPS4035)
>>> - UCSI over GLINK
>>>
>>> [1]: https://lore.kernel.org/linux-arm-msm/20250617090032.1487382-3-mitltlatltl@gmail.com
>>> [2]: https://lore.kernel.org/linux-input/20250605054855.403487-2-mitltlatltl@gmail.com
>>>
>>> Note: This series does **not** include any confidential material. Those
>>> who wish to run Linux on this device should contact Ntmer, as the
>>> bootloader is locked via secure boot.
>>>
>>> Co-developed-by: Hong Zhu <vanyang@smail.nju.edu.cn>
>>> Signed-off-by: Hong Zhu <vanyang@smail.nju.edu.cn>
>>> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
>>>
>>> dsi_ctrl, reg = <0 0x0ae94000 0 0x400>;
>>> 0xae94000 20050001 000001f3 0000000b dddd1011
>>
>> This is not something we want in the commit log
>>
> 
> I will remove it. I need help, then I attached it, two of my sc8280xp
> devices require dsi to work. Reversing and guessing wasted a lot of
> time. I will appreciate it if qcom could support it.

There should be nothing interesting compared to what's on SM8350 when it
comes to DSI on 8280.

I would assume something's wrong with how your panel is being set up.

Konrad

