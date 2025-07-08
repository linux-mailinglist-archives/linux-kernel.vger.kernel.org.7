Return-Path: <linux-kernel+bounces-720875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B320AFC193
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A509D4A1286
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E694202F9F;
	Tue,  8 Jul 2025 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhITuDGx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9A12B94
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947129; cv=none; b=MvhkLJcdqhNZ7rKh6/I/EGOIpRkkKCrAmBv8GIO+Cp9yWf8wCz58aU1/BeVww7QSxS7UxVvUz3sFE0zJz9fVWhbQ42BgGWHj7TxKzcOSTwExBJ/7Ociu3F2Rg5NErCJ9CY8HVG0/lq0VIhSLCbNMbqT8VRcuvZeXYDIf/paAb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947129; c=relaxed/simple;
	bh=3AKkxcfvUlMu5TUYKLPTuhhBUALR+VAT3BG3ruqNIDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1jbBhlO+7r5+q1kcf8Fo9O/8zURtvjftKQIoXUd2suMMK5UHjo89z4/6sSdgVIqGAWYYUF0GoUGIbfpbsRrDHMlxhtntJDSPv44zQdCI2PL5MufeDgLcjFc+iUs0IJsi5YWYdobmv65OijsJ/Yp6j1mmJ1UOhpw4mrlRcqhbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhITuDGx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567JbYAR003120
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 03:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yVmdwoyRmqDc17tvesd0pZRhto/8N/zF0tcxD1+SpSA=; b=RhITuDGxVaX2nn3X
	I3OQEFd2qRV3Kz5NsAafp+ON6RCsUZKC4B2/PEnO/FrGl0an5Ym41eu1adpgG07X
	Wl+bq49fI/gfgZ+YQuHMFYbbDMrV/8I2pUVIEgYvBgb/gv4ewG8VusvkqiNVnk2N
	oj9qT7nKfu0peyx/Plqz32GFtLrZYN1k0/y2GjefjVfIbh83ouCrxJRtHIY67yIf
	3kc3rSjoBdD4Ya1dygCCSzaHHM/V7XySI7Ir8YzB8WZkRA1xdHmwzSr9gbl7MtQ/
	8ktNx9ptWCZXYRwfJi4js8DvJpTXmxLPS1itVWAKOu/iDPhCq//859dNnBIhcy5x
	FtVnLg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wac6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:58:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235196dfc50so36899585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751947126; x=1752551926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVmdwoyRmqDc17tvesd0pZRhto/8N/zF0tcxD1+SpSA=;
        b=L1x2haRWdkp6cONuTksXL0nISdQo+Z9AS/RkBiA7O9RLnsvXEX7n1CpXmdmIb/kNUH
         U/hYDBR0MDPeFXULCrh49rYPUEyYz3ihdn5la3+TffU+VFg56vsoRr5qoTFCybpNNIop
         A8PN2RvimfvIZYw3xkCsYedjae/w3hXwqJUrcQL6eo66VxJwAvpdpGgM/qflUMZHyrfE
         J9Zgk77uUexbq9rNnr3VM+yhGGOo7PC5x/szN4Kj95QO+RqT2/PSDI39n0SEh0NEsFxB
         VXZfgZ+zTR1HL0PE34JdFr70gKH7+36plDmLvCRxMLJlPpIadDW3TQOXOCr4emQZv2X8
         t8mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5YyAON1NmWHke9Vx4ioIz9CZpHBrK9kiqH9eCPADkrEb16BMhQS0UZCfrCv+lIB8Zdy9Amo1gNbpdsF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBxJ1ac1Y0PFVnxKBbmq7vtztSDpIqrbuPCZHxOLHmaPKITY6
	aO8lxbBR/c1/7cWAVrrW8cjJpp9GW+t5pD3ckmTqDyBPg28WvEhPYL6+7dDAt14gavhCUlJsAlo
	hS7S+1gNN+B0NBwCUyWfz72au6e2x+ByMmwtYoiKLTzPftrS2gT6HG2QEjMWbztK7WVc=
X-Gm-Gg: ASbGncv3Yd7c9w9bltsVhcEBPZPV0PjoolVI1Mo0xhqh4lmCd8cp1iKJ5t0Zk/V28Es
	uUwsMhaBXN16scza8sPyE/Hg7h7iR0yaKDJ4Yuxt/Ee10XDJ25OYZOvaHM+h2qoVzFKVy0eeoLD
	bawbqLJBdo/j9GLX63qUnBW+bxPeF3IQRgn5cNlNl5qgI5EfismkhO4dkmy5dlNPrqUugAMNjld
	5LSjdaCeUxg4Oo4aYcFppjUGznnJpfqHYrGHLPBGFFon1xOKOyA+oYG1lynbbkvTBlc0usPapne
	T42b/8AqevSjIhjQ7KDQYkvkY+sAnclQ9RcvG8zWdld89ErTnL3g0/ILwE/QSRbD
X-Received: by 2002:a17:902:e88c:b0:237:e753:1808 with SMTP id d9443c01a7336-23dd1b43dc5mr16754305ad.20.1751947126576;
        Mon, 07 Jul 2025 20:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEso3ju5zhTdAEFrj8mTebhXy+yfUOAHYYTDpHBwzag4yfTDCfvyRpYY+6PtKpu5KUVV20vmg==
X-Received: by 2002:a17:902:e88c:b0:237:e753:1808 with SMTP id d9443c01a7336-23dd1b43dc5mr16754025ad.20.1751947126139;
        Mon, 07 Jul 2025 20:58:46 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21edfe37sm824324a91.47.2025.07.07.20.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:58:45 -0700 (PDT)
Message-ID: <074969cf-676a-34eb-c2e3-219cab3658d4@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:28:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: pack HTT pdev rate stats structs
Content-Language: en-US
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250702-debugfs_htt_packed-v1-1-07bd18b31e79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eVHsU_miQ_hwgLJXVtR5N14Uv2ZgTYS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAyOCBTYWx0ZWRfXxRayx+0mTJE3
 xIiY7Haoc2pKfrFLNnCQBC7VeDOE4HpzcsY7g4O9KTSgU9KrDyfJLj4nkz4Hej6tJ5eriDUedgj
 qgXJpHs5Krd+8GJonLWXQ4OdBqXYwcy919q/DM+n3+mM941yXLJLwTc7NO9bE+bOPIUIEfMIkQe
 hi+VpybUfxGaIBo6kf+MsBJyc5g0Q+ybrV6cmVpzgBnZp94JazvXMplEj8Rf7yhQ8wdjKsIcUmZ
 JIyglcdjJfbhGMc/yO+mImgu1+ejWj8WrwhAe3bcfEiC4UlUzBsmmM4YoTiArEeqWFmgV2Avps0
 xMvoupwRrVMYokMGMfSQGdTX7D5yXdKF3Gl3fl1K47Dk6n5hug97mu81MJUa0cP5XCYFP4vS0IK
 Oe47lv22N7iyYc9jBR9t2FGhCs4Esp+nrJ0QGeNkPeKEpXb7jYqFEBmfrTom//kAli6YnmPB
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686c9777 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=D7ADwRd3ifBYD-KlsV0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: eVHsU_miQ_hwgLJXVtR5N14Uv2ZgTYS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=879 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080028



On 7/3/2025 2:59 AM, Jeff Johnson wrote:
> In order to ensure the HTT DebugFS structs shared with firmware have
> matching alignment, the structs should be packed. Most of the structs
> are correctly packed, however the following are not:
> 
> ath12k_htt_tx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_stats_tlv
> ath12k_htt_rx_pdev_rate_ext_stats_tlv
> 
> So pack those structs.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: ba42b22aa336 ("wifi: ath12k: Dump PDEV transmit rate HTT stats")
> Fixes: a24cd7583003 ("wifi: ath12k: Dump PDEV receive rate HTT stats")
> Fixes: 7a3e8eec8d18 ("wifi: ath12k: Dump additional PDEV receive rate HTT stats")
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

