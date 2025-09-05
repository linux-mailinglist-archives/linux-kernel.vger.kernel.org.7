Return-Path: <linux-kernel+bounces-803387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6FB45E79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB23AB705
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90016309EE7;
	Fri,  5 Sep 2025 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldSFbhh3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18E2F7ACC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090704; cv=none; b=H9vKecE0Vaj3yufQoaPDuWfnkD1nFpUmtIZ6SpgteD7nLATQ5sCExHonNe6S6FfYYMbXZPQ+NnSbkz8d+3xpgvabEKwa9VUJDHv43C8fqdJS8CPilflTuZMT1fC3SF5KMF7RPi2JQ1gOsngP/55k2tbqBfihm7wy3p0DHJXCp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090704; c=relaxed/simple;
	bh=5taBZime/pvFUSuPIcotl7pYepsL1uGKb4MYEuPmZDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujBktXCTHbRdvX6OtWLygGS30Sp1J4LbyaSfN0YKuM6FDjzPB/68yjjM2chLwtOkcm65QdUwAHnEXnkiwvOrdTqlgjrIkMQGyxBopeMGAmexUquunbNGJiIxDsg7IX82L1ASKmZ9KMOy9RAAWRmcvSeATSOR4dZWXrSd7QWMjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldSFbhh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GVTK3031352
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=prGcEflsEAGkacTiIj0gYdNd
	T0AAZRAHRTty/ORi3tY=; b=ldSFbhh39LkQ8va4c+5m9N1qEY7bvQXjo7vcTmYa
	cMlFnDcXlXR1kp06bxhiVJ10wvNUKQez+bDERQrCPeGo6U+rsyxTmbfNhNlZSrC/
	UMm3sgCZL1XIiIbMvYxHAx81BdSuYXM/Y8KuRBBXNzhPTTy+etEeeauhoikPSLwj
	/2F4/90RZ7zv9zaCeUhhLjyhWWzbZ5emx4Bv7zxW78cvXBdRZR4eOaVYMjpNETKn
	Qpp6Zk5fRHRvPHtiWrswjIUaYWqB1ibcMs3TwvpsjOcG7JJXTM6d7d6v+Qg0QjbB
	xdjsetWnsbwLlm5IcDBJ9IL5+yeQXfCk0qGyIzmrQOh2TQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4903ev01m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:45:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b30d6ed3a4so51982011cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090702; x=1757695502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prGcEflsEAGkacTiIj0gYdNdT0AAZRAHRTty/ORi3tY=;
        b=DB64Mgn+G67YVAgxe/D6jnqLwEU9l5ebMlcOdYwPeNi+/8hsJMUvxRLQq2sp7hCUOM
         zVuNKnPabRh01eSu5JZm6Reyu8PoIj264pt9maAZRhjh+7T1FCEfUi2klLsgUrElZRwd
         mzvKa5WyOvypp9QJGHC+Fw01RX4oL4jDNkoW0bJbhGTWoNUjXBfGPQWW9niMPxTr96hS
         S588M1PI/IBsyPk4DdmAFGgevPW3EsfVYEe+TCynXKFS09irkruNIKbD4GqQgVcJ41qG
         CNwEX45God1U2+Q4JU3kR+ZbSO7RHlOGYG31AEJJN3enPlDmNOObaRzi397SznaVxk2b
         M4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV8o2wfJQb5YBdmmb88GUtXs6IrK2oPCYCFjHjSTHwytKhpVGibtRiGkUtWB/NthFp5WUu91oCxkp9EbjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfR0zMfLvn92GE5eu3zfjqFMYKQFsVWHA+BWBRi8BoAa7mHHt
	2Nu7bwOAx7UDKgtvVFL5tTUwBx9lX86jpScVFfKSwxeVbZXSLrj+xCIroNSwORMfWwfDjBCytlu
	j4WjFZJ194GsiWnKuy9O+TXHnM9uEExEdugG/htAcVrQoP4EmPCPWXSfngvmR8fwvEe8=
X-Gm-Gg: ASbGncu758sGkPgmuGZgm6I8z8yD8pMI7tF1XjFwvdpBCa8pbdRUBM2K36rXkHeHC7k
	FramGss+pTGzxYjA3TegeLK0XYCBP0NEM/3wN70mQJnzeAf0ewNbgTRsI1abkgvtTNQh2N28oYo
	K6X1smaqqzQ3tILBngSrTYfhXfsI02EZWdpZufB8wZiSDZmtw/3lf8iZWzjYv7cvRrF5Iwxnxis
	TFKqot4MxmgHHdBmvZ/zpYJobggw6x/l4ena1JciYCP6zSMKJaEUQJ8dB58gLVjbKCZOJWOu6aC
	NsL81h0Ddki88Gk2MhjcWoUKVNDzBdAVJ7hMFZY2xSwnCu+sXOpC/QzKbktPP1thA14+zaWJhVH
	bui/cCchFhoHzPaXkuMly5s/8D3fVyT5NC9fdzZAzv+18HpreFT6S
X-Received: by 2002:a05:6214:f09:b0:709:12b6:5a8f with SMTP id 6a1803df08f44-70fac7ba44cmr313993496d6.28.1757090701552;
        Fri, 05 Sep 2025 09:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHADphYCXf8LFxn7W9jBvqaJTxDjvxZRV3ILFEB18XoXpLrtUdbQ1fD4T3t9TthbsGZ/gU9Cg==
X-Received: by 2002:a05:6214:f09:b0:709:12b6:5a8f with SMTP id 6a1803df08f44-70fac7ba44cmr313993006d6.28.1757090701061;
        Fri, 05 Sep 2025 09:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5619682eaecsm376145e87.123.2025.09.05.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:45:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:44:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 10/12] ASoC: codecs: wcd-common: move status_update
 callback to common
Message-ID: <7rizn5ckjyyxx3aabni3xgrxi3lr563q555llq677lcnehyowm@ys7uf3dlk6sx>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-11-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-11-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE2MiBTYWx0ZWRfX4pvuVC7UVLIA
 viOSFqdKZUPs19z631c9Ag1848i4SoiPhHiLJr9cXNqFzk0aseJ38jKCGsz4vDjpBtOboN1xAKT
 KuHcflDW1AqnVMzuJsDM4O491XU7U+8srzgQSUOJXdetXO6qr57r4Z9zt8kwOrTG4NsH/u1C6gM
 oMvtACe+5tdsFi9NAOIS69cayWE0zywYk4oQuSdcvG/g9KJH0SW73HMqiWawVhfYlI5UV4FYl/A
 CEps1tYexM9JaFgzI+mpEVNeyIcaTyTwUiq5NKVi0JRn5ZSdqtueo18CoIscg5WKkjUjwR7o6TB
 3H62O2RggrR8PsX06/5z/Uiqodmf1ANUAdUb9y6yF4ml46p3Ckzx26Jt+wBvV8aTd0MZB14TLmZ
 GmKmaPa1
X-Proofpoint-GUID: dp1Ywz7P6UTPgACqXKHRAFUqYKyQwd4j
X-Proofpoint-ORIG-GUID: dp1Ywz7P6UTPgACqXKHRAFUqYKyQwd4j
X-Authority-Analysis: v=2.4 cv=drbbC0g4 c=1 sm=1 tr=0 ts=68bb138e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=Wf3XbFnT1CmmG50OB2QA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509050162

On Fri, Sep 05, 2025 at 04:44:28PM +0100, Srinivas Kandagatla wrote:
> Soundwire update_status, bus_config and interrupt callbacks for wcd937x,
> wcd938x, wcd939x soundwire codecs are exactly identlical, move them to
> common driver to remove this duplicate code.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/codecs/wcd-common.c  | 46 ++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wcd-common.h  |  5 ++++
>  sound/soc/codecs/wcd937x-sdw.c | 28 +++------------------
>  sound/soc/codecs/wcd938x-sdw.c | 41 +++---------------------------
>  sound/soc/codecs/wcd939x-sdw.c | 42 +++----------------------------
>  5 files changed, 62 insertions(+), 100 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

