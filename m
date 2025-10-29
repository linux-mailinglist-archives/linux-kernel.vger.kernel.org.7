Return-Path: <linux-kernel+bounces-874938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A039C178EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71E264F44D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C782C15AB;
	Wed, 29 Oct 2025 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c42zwcBD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="awTYaufP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC82C3277
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697856; cv=none; b=Wr/zttv6uL6iNe94DPiGL3nbvM1psoEdvXxXOdlowc96XZpiSfWrFll4u9uU/LCTlRczi/9koNJK1FTQbqH72/tgvEV8urVYyEU15oe1EKjFD84odkP+6G/ak3Gh4L0i8rX8nNnD4lnUuKFIa3h2eGcuyVzLIkFR0WOZDlFXZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697856; c=relaxed/simple;
	bh=vD1FNylVI27BhcdTuI6IA/Bp22wHmgL9sOtPzIZmtPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4jGks0KCgdErcK+Op9LBx7WJSdOxqmhE36FFgvZVDoRRs9DfMYKCtBlnx9y4kFNlCTnGpjGpETtaOrwuxLkLzjGVCormSb868GanvcB0qPDRmMoOfZ3hErbcs9i3rINM8D9IvMPFgkhpOSAwkglLjXbnuZZYYbTqJvUpm/gR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c42zwcBD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=awTYaufP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlLWN2575180
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BA3mJgJEALDSQIU7lzkJCNPe98ZeA1NlvvJIGteEvDA=; b=c42zwcBDAPLZdF1u
	rm7Y3eie3KqdnqllpJIswgqdZu3BXIkUFqJFdU9XgoJgNd3bnPRnFaKyZCi+O24J
	94mhNFH50rJ10UJfnxKvoodqMfG1PjKrUxjnzc0FHZ3PCifct8LtKR9LtqgBHFsj
	divbCHAV8gjOjTsY3TWQdopUfvjm0CSEDiWM11WwWGEPQHirMfF7BQH1YCufGiEP
	85u+89F6fXxKrxTnhLdCmT3AhNX8DqEcfSh3OKIP9DGucnyLJYkTRWdzo49gp6OZ
	6oEYi4ypzPj44bNQI3pyYfTmsLg05ymnQooqI52RcE2sVA2t7/+0nskUp/y2X6sP
	H8TOCA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a20nf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:30:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87bf4ed75beso148313286d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761697853; x=1762302653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA3mJgJEALDSQIU7lzkJCNPe98ZeA1NlvvJIGteEvDA=;
        b=awTYaufPzN2tOFb+qkTnGfp5gCUai01PwohNeBZ0nZMeSSZ5hbLtbEQV2QHcI6gMsC
         i71zncnoCjeYOKHDWMgaxI26eJzC7lnnqyb6WXKrc1hrpBaYmqKEyQL7wEuPd1ypiisr
         hcgQyxsAiyiEELeLGgrjvwxUOoGUrWsdPLe/owoVuCoNLgKnHVge2K065Ndz8mImbrhf
         ebhCZX4MXRO1ldKPgKEWyTNV8L899koszm12QHMp5hYCpk3ObTc4cF0Geh8xzfwvuniN
         7LdAqS/jDb8mLemSNfj8Ob+JGO1evg8tk2+Hs4vrHs9UeFTj6tJqQpcWD9fTMXbU65p4
         tmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761697853; x=1762302653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA3mJgJEALDSQIU7lzkJCNPe98ZeA1NlvvJIGteEvDA=;
        b=wZ0mkFArwL/JJMRGKaARyg07cpSo/abPA2qyaQTq/c544UQYKkCFElOqieSacflmSr
         e41RBxux0CSpaYfZGywCOrxhP7Lt9Pqion2zSqhwujzxetsj3Zi0HLFRyNxE9+HAyBJK
         72vwCkVEW0a/AuZiF/sRS1FY+fHTf1PEjx/Ae/dfEPeEN4UfVpROtpbgRQCVXPAZzxc3
         OUIPp6669QGYRFR5pAUV/roGyHMG4ABAQiLvA4gPdCJ8mrP9NGokR4G8qcFpVMs/0/r3
         dxVep18oifyObqE3P+50oy69j5WeS7QTmDK9aXECBohENpZw/FS7Qt/NZEADuphel5t/
         J/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfjcXVS/23wkrhmqDGu+aK/MKECH2v1chE/ffiwpwhCkhvkZjP4FGergkeQ7tdIzgZz8V47JGK7IBKadI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJip27VIFbjYej6Kd2C1OfLLGxdo860PWIIpMQSHW7BZZJutO
	gqDs0XdpvJ4m0yLvDQJv9iPtFlTqZz/clq+IZ+mW9HzDx0UmXTxugyu5epLqQ7Wrma4OE0Q9yJM
	U9/GDxVJzbXOj1wRjLNcaJI66Eo6ThTzRPi5EAAXrLFeKDETQLTQn08Sc/BiPxMUab4Y=
X-Gm-Gg: ASbGncu41GvXA8EgHn1wkXKsrKIetNUyGzCsdZOnBbuQ0ZHw2/j8akyw8h8JWCayTZx
	ngdxSYYBn6dxz+/6zvIW84eI1eigKmd1G5hKPEwIuSNrjqnJMQ/lwryHqs3ciloxHT0w4wnq7z0
	Rphb/b2wZPRaah63yq08bsnqyVQN4uRTPVHvHah81Epc1qlII1rwhRcbVQtv6t9QsCZIgJ4Exat
	s5WQJ2e7P8fgV3Xmw2R2NTLz0b9cc7mu9x54f6Dl54WTbl2ZaYGM+22IIU1IfQNS4WZVMdcuU8m
	4CXgvBHzWy1InAp4Gp+Eq1fDOUUQttp4N4oeAnBe0Jwglx30s7WCaCLj4jVThWMLX+gtGfy1jhv
	O3Vl2+NKolqSNy2eDyb726Iqm5P0S2zgX/zp9ovSUpsFyKlEzVohhE0QQRrb1MJqyVM0gM7UqLZ
	pAo5EXEnGmwLUj
X-Received: by 2002:a05:6214:2385:b0:879:d13a:109e with SMTP id 6a1803df08f44-88009c125a4mr16066326d6.58.1761697853147;
        Tue, 28 Oct 2025 17:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyr/bWQydXn9qOo8x46NrfEYfRXvfQLrxprPj6QzPNkBQLdmOHSiqC1X0kLR/y0Ii3Ai42aQ==
X-Received: by 2002:a05:6214:2385:b0:879:d13a:109e with SMTP id 6a1803df08f44-88009c125a4mr16065856d6.58.1761697852700;
        Tue, 28 Oct 2025 17:30:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee092042sm32141621fa.6.2025.10.28.17.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 17:30:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/msm/dpu: Fixes for virtual planes and 1.x features
Date: Wed, 29 Oct 2025 02:30:43 +0200
Message-ID: <176169780824.3761968.9764192918741349867.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAwMSBTYWx0ZWRfX8obPzDBHTJ9d
 PIhiv241o/QAzO+evPIeolxRImNqbcLTeWfSqNmyQomvytVcAb6+9/SoWzNoDI62Fddv+5r8Z0p
 zCr2xyyH/83xRzLKGzCxdvDDCQ8P0HP1UjKVLiI4FwfmwbJFhmjsws410Ub7W3AXbH3AAYle5vC
 pScyU7pZPyO63OXXczaQHfrHuHbmjT7PIGYEmgIpDQ+1kyvrGEna+RDhEgNUoQwiGybWFikDyFg
 70NNLGCwZtFvnFXhhU+LwzOfA5OboNV6aZAhbvWzjqW98SBOEOcaCHqYBl93APd8ueO7vnt9/qi
 6RupJsaOJIxWrs0Tgqs1fINEcG875JZTjEoZeBTcMRF9AaRNZwFyjOi2wmGvar7upN04/CWGc1s
 LvIkCwNZImjfalIJO1xIfIXlK18YaQ==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=6901603e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=aMyzyzqXAEIezWvZdfUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: xQ6OGDMeuFC2FJAsCV5m4etIbrZwyLEf
X-Proofpoint-ORIG-GUID: xQ6OGDMeuFC2FJAsCV5m4etIbrZwyLEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290001


On Fri, 17 Oct 2025 19:58:34 +0000, Vladimir Lypak wrote:
> This patch series fix some issues found during testing on MDSS v1.16.
> 
> 

Applied, thanks!

[1/6] drm/msm/dpu: Fix allocation of RGB SSPPs without scaling
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2319551e97f0
[2/6] drm/msm/dpu: Propagate error from dpu_assign_plane_resources
      https://gitlab.freedesktop.org/lumag/msm/-/commit/23ab0d6228bf
[3/6] drm/msm/dpu: Disable scaling for unsupported scaler types
      https://gitlab.freedesktop.org/lumag/msm/-/commit/425da3305972
[4/6] drm/msm/dpu: Fix pixel extension sub-sampling
      https://gitlab.freedesktop.org/lumag/msm/-/commit/2f8bed917542
[5/6] drm/msm/dpu: Require linear modifier for writeback framebuffers
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5e0656b12534
[6/6] drm/msm/dpu: Disable broken YUV on QSEED2 hardware
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bbc65d1bde82

Best regards,
-- 
With best wishes
Dmitry


