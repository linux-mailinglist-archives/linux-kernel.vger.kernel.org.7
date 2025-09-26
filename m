Return-Path: <linux-kernel+bounces-834715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8109EBA5599
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBBC3211E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18C280338;
	Fri, 26 Sep 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CQiNTdtY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288EF261393
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926210; cv=none; b=ecMc91ZCW8tc6pB9x7GJGccgX7XWYyGkS1oJMvHHAoS1Bvx8xg6gpetlqHnOpMDWLY1x+sUoduFKmZSFLXPXHsHmKKqf48cOsVLDHLTjq9qsoBjMjoOLMQzMqeNu3KyxHluRlihHycfVrWatSG6tjb2WIBOVfbaLKcHp5K+7lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926210; c=relaxed/simple;
	bh=LtDarIZoiT8w0O5sJbCrOHrzGdFAgoPYvGGnch7FhWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfawZyoKh17IymG/wSI/B8naZF6qgeJBcsHYVRHXP/7bVWZIqBT21TZ0Ss0kbO+i2cZ871S3stE15SR/6SmcJCz0hILRcEPDBcITcujZakdwryuarL00C9j8K87l7Q3UAVkpevCYgskSZfXvDYC1yZdZa9VhVxPUMWqf05TBHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CQiNTdtY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEXNbt017425
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZLSUvcCXErFMAa2Q2lMIRtHl
	4lWxdH0fa1UAKAdTCQI=; b=CQiNTdtY95/oqBY14jdxzCB/FODcD14EBxyK92e9
	pYgq7LkBwEWHJECiVY9S5MBspcP7Hr1XpT66Qd5ElEeoRiFhNu5W83wLIYG8KDTn
	1CsI/9TQfPEvvRcXVeXoFYvbYsXgWSYvxhC/Pq6AUZangYhEYcmJT9ccCRPfzcba
	OjLezSP5ux8960lM6KZ9cPs9Sa4gyFkfDgnQRia0wrNjrsD5A3ciD+Ij4BBSHolD
	G0vWer46rUVY+9bAv/hfnHo+VdtVRRR77QOSfspIT9M3pnnlw4Mo6CBxdQguQZqd
	N3PbZ6xEz5WEq6IwNGX2njmSa3+V7ommfa/dChqPwQOC+w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u4ah3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:36:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78e45d71f05so50220136d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926207; x=1759531007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLSUvcCXErFMAa2Q2lMIRtHl4lWxdH0fa1UAKAdTCQI=;
        b=BKr73pA39w0kUTfXqYEfmUK41hWhJ6yUxN1ad0T1RZ6AW+RlzmnDIwm9Cdog5VQMbW
         B+MH/4ZDgtI290mhbbquKgWWxdo4tzZDdIqalSmxHxboc9eGVNmaeTzeBIGJ0dQvMWxG
         nPnszYIC0CgSZmHHj/H4STa3BFOI3eb8FSM4vNxC6jHlQAA+M1T/P/7cvYcPHXNxs637
         Ql6ThGWOwfrZq5wcuIzIetuuup9OQdCWH+YgC9hEOkEwU6/Jk4LxphvaaBMkXU8FglCN
         LCqTbl+1iYvw4aS9qBKHod2/lSJ6d99NAqDPffdj+qWBbVHVpMpIY6+Tr82eooPiOO33
         HvCA==
X-Forwarded-Encrypted: i=1; AJvYcCVOWfsj2h2pcF3dT6RS4+YDlxHEzn3AitbqsBSUecCnAC96C5ObY513SjgZxsN7FGFfgjSPhZcvFvM3LJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPw7jtYs0D1COQmbTIM0qrbpzu/nXmHF1mOY/D+USIr5Vx0ez
	uhkieq3sl76tILAePOpQZzbr3ORU1IsYREFEVo2uOPtkVDwQBAe3SWDBcmekF5YopOdKe1kEG3x
	cBJ0ctQS24rAGLyOaiTRDi7NTKAbHqzZI8Fz9qrzfVFHGbZXNYD299VyCmnDA1yslwxs=
X-Gm-Gg: ASbGncuSO2rwZa46L96AnSvEoOsjJFmT+7NpckJPxI73EESyinfGA193iVQB9UQ/cUk
	761rdaN+7vOuzLU1o64gNwVVk/tEnS0LL3sxwDs7fifdTTiGzTKqmefJ5sQ+Lib+8OS4EcZD6zn
	Bk66EOXAPZWounEAfar1XaqECMfGmPIFii2vyJ5MGZFjst92ULdDKh4LnVMQ2dBIBwa/rzh0WXZ
	+Z2kM+n/kXG7dcFSU69prD5ey94djXw51As1TZvCYhdl9LW86JjNV2IdzmVcRUR1dFH+I2c3eXr
	OerUdk4yIsFpshJ3xOcSuqBeIpcJiQAXnXwZrYIkcaLzsBdKEJoF7XCGMY9MZCSiH7szieLueeZ
	KGYGewsr0YwjJFMbVNXh61Lznibz+/bPtb6tP2Eedq+KI02hJmBFO
X-Received: by 2002:a05:622a:a956:10b0:4b4:8dfb:33c3 with SMTP id d75a77b69052e-4dae3c29955mr91817581cf.59.1758926207264;
        Fri, 26 Sep 2025 15:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbe1wxhgonW447Fgu4TmABd4aTg5zyqFc7Zo18GRYrwhFmA693k/yaZQWV+62ImRcaYWFxNw==
X-Received: by 2002:a05:622a:a956:10b0:4b4:8dfb:33c3 with SMTP id d75a77b69052e-4dae3c29955mr91817311cf.59.1758926206763;
        Fri, 26 Sep 2025 15:36:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316656973sm2136641e87.89.2025.09.26.15.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:36:44 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:36:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v8 2/2] i2c: i2c-qcom-geni: Add Block event interrupt
 support
Message-ID: <of4bwtpgxib3emdltnnlzy74yips4znmjy37hzdljhssikt37q@m6guijrjuxpt>
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
 <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925120035.2844283-3-jyothi.seerapu@oss.qualcomm.com>
X-Proofpoint-GUID: LGdQLDfS_HNkUb3gDXmv_v1eybZHICR-
X-Authority-Analysis: v=2.4 cv=PYXyRyhd c=1 sm=1 tr=0 ts=68d71580 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=fvgdV2PV7z-sFcuOFeoA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXw70caMd0+n3b
 BB8Ag/ZJk0n0JxKpop9f3xYmgH8PsuaRzQtsxz0/3N57O6Cx2lhpjE4sttQ9xsbPHpqK/lOn0rC
 dnyfgvoGd/MuU6WjUL0bq6LRYEa9hiT9JddKJABKs34MyHo4pa5AWGiGGhWAiLXZoT4TU8A21lV
 nihgr50GKJi4kLhxrDPu8PcOXJMS3YiDZ+B1owlfP1nhm1PlfMF1Mv6W79irwQn+aXkPx5EdejU
 0bQo2SGzu0ZoIn1XfS6bv/XdfYFSUxA46SbEpUiuJ9IZlhh2zYp0jvTUFBhn33lFeb9iMomt4ZK
 C0uGhyzEaKf7PWNTGEP1midKDqOrw49VdqCTGTfwfQ+l7hUtntUloT83GuwDksBguHSWMhdCdZT
 5xhpp3X91cQHz3n+YGlXwPCGjcmDCA==
X-Proofpoint-ORIG-GUID: LGdQLDfS_HNkUb3gDXmv_v1eybZHICR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Thu, Sep 25, 2025 at 05:30:35PM +0530, Jyothi Kumar Seerapu wrote:
> From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> 
> The I2C driver gets an interrupt upon transfer completion.
> When handling multiple messages in a single transfer, this
> results in N interrupts for N messages, leading to significant
> software interrupt latency.
> 
> To mitigate this latency, utilize Block Event Interrupt (BEI)
> mechanism. Enabling BEI instructs the hardware to prevent interrupt
> generation and BEI is disabled when an interrupt is necessary.
> 
> Large I2C transfer can be divided into chunks of messages internally.
> Interrupts are not expected for the messages for which BEI bit set,
> only the last message triggers an interrupt, indicating the completion of
> N messages. This BEI mechanism enhances overall transfer efficiency.
> 
> BEI optimizations are currently implemented for I2C write transfers only,
> as there is no use case for multiple I2C read messages in a single transfer
> at this time.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

