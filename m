Return-Path: <linux-kernel+bounces-739511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA54B0C728
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071CA3AF3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739072DEA9E;
	Mon, 21 Jul 2025 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U+ZA1H2T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCFE2C327C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110111; cv=none; b=h4HLFEVznMRah3sONzg0C4yt0zkpGXhgYL9ouS2fvaKBGjMLCj9Liq9V61TopEfhBKFtjS+UirTIFu/XsDgCKJM+PFmft7JFIriMxx5AVBdcCf06WbUTjf6XHAHwSWQgBu2+rQf5Dmk03RDEyAxeSkd/9suqxbLNE0xDlq7UdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110111; c=relaxed/simple;
	bh=XRkewL3soVtnrk2cXEW94xn8BBgLqnliEYBf9HPXV8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXaaV+jYaeyNWaXXxmyH8BWgA5M6+1Q2tKz05JiKHhRXJe4r1jwD3h/puqm2I3j9sj++Lf2FnPamKigitP3TA3MGG/QjQ7lgS3prpaVt+embQeE5aWzWVP8gUcYY8wOOmqypkDrixWQJBv1CewPRR/73VjGBkThoss6BU9IPrOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U+ZA1H2T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEeutk012535
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbhR7wgqAsdiZEMYBFwiyXJ6Odxv1EybtfjmhHzvafw=; b=U+ZA1H2TS/RL4aUm
	Lhxtrhcu3PfqknEGdYgI3QpMTr+O6n5XaOo0FL67UlrnbOxMQLu4SGffo15W3PpI
	s6KgEYtuQ+xejOKlUR9k7AinopvPt2RMzlWyoG9RsgmRaTycj0IcPqTq1cmJ+JQ6
	ZTU+P5VlmVRDhqdNBZTO9bxN+XjkA2LMEMX4TDv+vJ1W6MyAaHaUf/mOKnGNDbit
	BMBkoNuDDhTr6JynGLGridMPrI0pzIopDoINWpr/E+xYTAKBJ3sezRpDzCuFPWwh
	RHjlehTB8C3QTM7j51eZ1k4GTM13lBDs0S/dGH1H2+2XFM1z70FQGnr/SJRxzH8h
	dvou/w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6g2su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:01:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74ce2491c0fso6446812b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110107; x=1753714907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbhR7wgqAsdiZEMYBFwiyXJ6Odxv1EybtfjmhHzvafw=;
        b=bovnS2TIBixN0FiEOZiUNAzDZ953dC5VpHyAiJLknG6SJLrY3T/H9ZiEbOUjYRNmEH
         D1N4hpjIs3a9ZmkR/yNos4PZBsiZ654q3r5XY9etiExJqYGcX6WnG9c1w/gOibpEu7Rw
         Uh/xKs3h5SiAyRdkgZTe03Xy+N2FU51hG6hCATWs4H1eCImld/ysJcIFNd2jpKcef57O
         NXF83KNrnkYtoHTK1ENWh1vPm71YoRYHfXc6sSYqNasTrS6vrxfKZR77T2CMHZRgHA9o
         pJdu0Tbp+7BzDRR2pxF1m+6NwaIX/icO81mnjIKGADm1ErBWm22gkNvhAQ6tsmI4ifHi
         E1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV/na+/sd5bnSnPB+ROjbJynM2SsBEWsGfvDa367DkagspbRhmxiXvivd1bAO93R88hJyRB0fLBrpjj8lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5dyAapHR82j/1Q/1rlUE+Yjg+LtRlFjFTOeV6yfM2gNP7gxk
	5hGkCPoRZiGvJaG4jauGOJd1VNitm3PYiQ1eEV/vabFIdju/h5KLaRtj0M53Pk12LjD6qUZuGSy
	AOtXu3ZzVigRQj/AUtzShqxnjBFl3DhTa0fZkDD10BWIwIwM822TpFg0bqPSoicu145U=
X-Gm-Gg: ASbGnct7pbfqfuDfgbkHrzG9/faxp2eHjVaiWH7b8/fGZp4mRBWKESUs4pkZNkgXMHY
	1b8FQ7dihX9Ao598Kl1q0Y0zTDfA0o5pgp7QLC2tiAR5HobNrzBhf6F9O5Qn0EXfsCnHTsMpxKK
	oC4wBB07f/zrb321lhzht1HQzgcEcs6xjj23YIloyzYLyYpt0nWWQyXSpGusY6kDRgYJjK6De3H
	WaqASHxr4uOeE9eM6GC+uCp1WOlHYBdP4kVUjDehMekpcYpxKaTrfhRiIaXJO8CbSy/sX+DwXAJ
	EfZwq9ZZ6BrRg1+SLFJ99xC05n8+znq2GFgcphHLiWt2AiE3IFzovbBXuoubPB0/yXQFyQhUfC3
	9jxjLlnZRvQo=
X-Received: by 2002:a05:6a20:6f8b:b0:232:a885:e84e with SMTP id adf61e73a8af0-2390dc2f805mr27535058637.25.1753110106511;
        Mon, 21 Jul 2025 08:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOHmWE4iyguDMxAHTPOU1nCRim88f/pJDZPNsYN+kAb9LJOLyI2W/6u92FrBlgWXprwHe4bw==
X-Received: by 2002:a05:6a20:6f8b:b0:232:a885:e84e with SMTP id adf61e73a8af0-2390dc2f805mr27534927637.25.1753110105474;
        Mon, 21 Jul 2025 08:01:45 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.224.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c8eb0e98sm5977496b3a.66.2025.07.21.08.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:01:45 -0700 (PDT)
Message-ID: <7ee5f1fe-0d0d-ce10-2e6b-8bc9488289dc@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 20:31:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: bring DFS support back for WCN7850
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mihai Moldovan <ionic@ionic.de>
References: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687e565c cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=jjkvTE25TcCRIAzKtE2jAA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Mae7F14F_SpBrmaiimsA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: fh0EsvP4oNDoktubPDWvWOAoY4VMYXc5
X-Proofpoint-GUID: fh0EsvP4oNDoktubPDWvWOAoY4VMYXc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMyBTYWx0ZWRfXyuYEmcOBItoG
 WeybFCQFM4smjxX9aHYkzIsAL6Yx3xH48gmNiaPnQW2CLBe/WyM2ZQr52Tr/vC6pz0FRTe3gd9o
 8M5I1BfuqcLKN+7gVHkWrFFKJiFRwUvAea+VeOUiP3u75veNHm1/LbYwRC+vv2ZevCgODEB8s6v
 qxdWOWl3S88jEvZoMxoAKxkovykX8kns0aGwK5HwAE8ehg9rZbPRciEg1NchcvI1oiLUs+QfuQ8
 6Jvf3CX+RPRcwEEUOmZ6ZmuKUOlQU8X4pbiP4olG7gHz8pTyZiNAq8tBm2yRWkDpGlymixJA0TM
 vNGwctBmSb/oM15aTns+3/PPdvyENOQ8JEYtyCKU1XvXP1TcwrhNO7L9pcZSfnmFvA2TRNMkcT1
 gOyVeP+pmwKqqROuNZkmdKeru/5uz7piB4rdwmevWLmRXo05t1uWv6u2c8RSsQMMvtLYPrkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210133



On 7/21/2025 7:57 AM, Baochen Qiang wrote:
> Due to the restrict in MAC80211 that DFS (Dynamic Frequency Selection)
> can't be enabled on multiple channels, commit 176f3009ae59 ("wifi: ath12k:
> support 2 channels for single pdev device") removes DFS support in order
> to support 2 channels concurrently, making AP mode not working on DFS
> channels [1].
> 
> Revert portions of that commit to bring DFS back, and add a new
> combination to support 2-channels concurrency. This is valid because the
> MAC80211 restrict works on each individual combination, but does not care
> about them as a whole, as far as DFS is concerned.
> 
> This change applies to WCN7850 only, other chips are not affected.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 176f3009ae59 ("wifi: ath12k: support 2 channels for single pdev device")
> Reported-by: Mihai Moldovan <ionic@ionic.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220346 # 1
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

