Return-Path: <linux-kernel+bounces-768070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236EB25C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA305814F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF8266B46;
	Thu, 14 Aug 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNNdrRpQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F325EF9C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155087; cv=none; b=VQ4jm1afRHIQwZkuV5fhQa2hE0W1LwofVlo+cIbkjh/6zYXgV6GYBavkMWReMpAEaRAKdqVRT/5iaqNXR1yWEl75uuWSfhDS3I1FZZlhYgvypdx/FKIDdyoRKQgBURMTuhmlccFw2bpkLCFLzJFEmaMoXxHrjG6JnIUd5ag4pJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155087; c=relaxed/simple;
	bh=OPNvTv++d0Y1DCwMTZqTMCES5f0J/hlk6EFNeyS4hyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qncEi22kduVUCz8cvoh+w07J63TI4EElxnhyjFeafcG2QdbkyxBTHdz3pRKM5rtEtoNmoE5kpIfJuLmYozz2StnQUzKysR0LshjelDqK6CWzuSJR+XBuEcNptDjlI+Gug/IAYXtIE53Zuwjrp9x88O3y1MZbhFfgRoi91fh/n9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNNdrRpQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMFgYW002966
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZmTgSJksSvRsRHlh4lCCGxN6
	MG1QDdCZK4fWrb5z4Xo=; b=bNNdrRpQzXYPs/ayMZz46oM2FkiixC5Y6AUFBN6+
	Kdm5eGANHD1XRmxt5Mxt06M6At9w1ezphHaBefnK4/CVWQPlL4VjNtTdDzevnpaW
	BsVtgQ+kpAgX1HpSb51ttdWyDiYIedwu09WV7DEVwWnW6q2wyV43XAGH51nwlkGh
	aAqTzsJi8hJv31PJybLHtZpbkU/S0HD0UDub0I34pGIo08kQ1gjUXV3JcHI/ISNm
	q7WgS77xRtdkfzdGvlkutBiV0B0jjClIgIhL4SJSx9iSxdAJ1U+/wWGcsZ+cD4B1
	7qJQ9PVKO+Qk1uAp+n7boW4xV8uh5WZ8Dtl1gJHHDZ9iPw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv6q6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:04:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c5ac7aso15105011cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755155085; x=1755759885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmTgSJksSvRsRHlh4lCCGxN6MG1QDdCZK4fWrb5z4Xo=;
        b=krG72I71NiI+Wr4vB/vKkgM8QomgQHC8F0X7iiDDwz8fEBECRuIQMEnMyuQWbFkrn4
         yhw0d0TWtOFpl9kpCYG9iVNfnG3wARG/BkyU0mLCziovlE11po79ucAJ1JAG/XoPtV1Y
         SneBvZkJ1rgDI5IiY81eQyNnaMS8atCm1jurVkZXRqocuGQPV7EWVGj7ieVvenIptaVC
         6l2tVD5uclCh5gd8wjrGajwrdTtnpspT49HY68U11cEldEm2KYYD0nnPiMDxyDmeaHLV
         25foYOiQ2QzIipaqQZ1gb4MQb1oaCIFtESQbg/pdCSH7yxIVkiBY9OBxTSkp9hfasTm2
         W7ag==
X-Forwarded-Encrypted: i=1; AJvYcCV5gqbsqFEzNQgREyIP6E+lymjQDHldnvrfENrN/qfcKEjVNFTMIzNdcFt3quhdLhrJeEcXNrRWxCZIlmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+PBMlCJrLKYCk5zrPrALjeEJRV/MdKsogeJB8T9rFU8oS0GE
	IXwTdFHjXCA2XMCrF471aV/R98zdiAX+WVIehAjkUo4tcWkien1wC0j3Z8OGm6UupmF38LIZmWd
	rKXphdzsECuXaG48t0b5M3+wXPIqXiCdU84CxHFzf7z1yaOARy8Ag8MIYGFEXHQAjfm4=
X-Gm-Gg: ASbGncuOafrq/y4CULWaq5av5DQS+uP5GNb3pcNh4X2j5KE6b7rsavvNLliZuM4gKXS
	4Y2vRXT4pA6SWMOEZIMOuS/ndYm0l+OQE6JDXkP4hIqTwg+0c6FDBi9jpaU2Xx1HAvrwnNT7tNK
	nI5p6PRwd0Q118z8aq+NcIRUZLf1pquoRVlQ4kMTUVTk1pRBRK6AfRttcRKYCrSkLh6CVAP4V7a
	FZqxHP13udRVlBQyupFxzTlW+EH7zbhpJsjubL+uxP1lqZ2trxXxOU9B4EZCOqe6EftwV1mP9ox
	jmTwwNcFTtZln0ChlURGgZbMepEwaqicthZMLKYSk9Fdx/0pnH11TJ8/Ts5T7lh4CYD+GLMIbV7
	BSbNciTy8swBhp4gmHdqP9NHub+Vb/lKKhkMpgiXYhvf0lZL+6Gay
X-Received: by 2002:a05:622a:50:b0:4b0:863b:f4e6 with SMTP id d75a77b69052e-4b10c3d1082mr18771181cf.14.1755155084591;
        Thu, 14 Aug 2025 00:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf4GMEnU9+DKPNr9nEosmOJfrXRZRGgqiLTRtxITAX9r7U1qxrwlquD8TRJWARcRaI1vnUOw==
X-Received: by 2002:a05:622a:50:b0:4b0:863b:f4e6 with SMTP id d75a77b69052e-4b10c3d1082mr18770701cf.14.1755155084097;
        Thu, 14 Aug 2025 00:04:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cc8592678sm2433329e87.31.2025.08.14.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:04:43 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:04:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, thierry.escande@linaro.org,
        quic_vgattupa@quicinc.com, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH v3 2/4] misc: fastrpc: Fix fastrpc_map_lookup operation
Message-ID: <nmipsdulp2roagr5g2emrijonc4xkupoqm3vdelaiihy547qlk@yvg4qmg2qgwj>
References: <20250807100420.1163967-1-quic_lxu5@quicinc.com>
 <20250807100420.1163967-3-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807100420.1163967-3-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d8a8d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=4xMk_dLyLN26lIRFNMoA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: in1Z68UYzJr6kveRBfhZcg5Q8Vt1ATRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX1fkYzw76I6DR
 043jq5EcjPJsWEWDImrfmhTgLgE8TAv93fnYvFF+8vBaacNNgrUsVmae+BVwQmA9CD/uay29zhO
 7ToPtu1wdy/gt5JO1i65Z2LzeQpUJ/qNDwl8XADh34x4QReyTFQUQDRbhurhLD1L6bl1ajAIxUy
 3vkQ9QvvisH9asOup23Njv/nqhXaG0SjXpNfzTvXT6zK30ksx2CKLLEtfw41Vou22ty6p8HOAcK
 RRX6u6xRDbvEO3lACr0B6/Kr0Uv5sq/M+eJO+scLKuzxjLwdn9oE/a7vdCvqYodCaVgpM4ttYbD
 47tO8Qapqsc2PasXTxKJFvxOJzs2MyVRx72c07eQRxvRaDoVLfB/w7AFJ863D7+4XmZ4BH6df/o
 TA+/gqGR
X-Proofpoint-GUID: in1Z68UYzJr6kveRBfhZcg5Q8Vt1ATRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On Thu, Aug 07, 2025 at 03:34:18PM +0530, Ling Xu wrote:
> Fastrpc driver creates maps for user allocated fd buffers. Before
> creating a new map, the map list is checked for any already existing
> maps using map fd. Checking with just map fd is not sufficient as the
> user can pass offsetted buffer with less size when the map is created
> and then a larger size the next time which could result in memory
> issues. Check for dma_buf object also when looking up for the map.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@kernel.org
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

