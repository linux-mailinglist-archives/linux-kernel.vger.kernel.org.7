Return-Path: <linux-kernel+bounces-776342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41990B2CC31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E9C16EADF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E1F30F7F7;
	Tue, 19 Aug 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VU94OYN4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040E30EF89
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628656; cv=none; b=Y1KMfLp8YPkPyUxxvdTR+11KvmZSED9DfrhmloN5/+OVGzKt68bwEjm48QWfp71obGBsYR0vRu25RQvmb+JV+fYykIqdkleRvSs39zOvV+4B91bHa4LX2uoPUTdEGprayTap9La5HI8ead9JVSeQ6O7XS54gNP4b8E7TgN4FLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628656; c=relaxed/simple;
	bh=Pdv81BMM7kCuOjJPFUlIlZjlYr4uZ4fxBzQBmQqdYu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNw7T0rmRAOxAn/V6/0goasr2CivOYmqf2A8ggw6xseLBw6bMEg/lh6KVzykXVwobC/FAwKuhZAc3yyK1yHA0vBF5kiWvQalKB/ngkLihhPc2fYDgmfDAhxHsuoDVOMTuxz2VHwNz9nixdQNadwk1GIABtP/SrBDvyEDiXhGKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VU94OYN4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JGw5br021768
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xZfnogI6WpgDksp0nKQ6I3VT
	GYZpsfSvZDFAnG6Y1vY=; b=VU94OYN4R5VTLyKVzN/Z2tkdy2y+PIBj0IxmdMr5
	viHYDaNguJO7c5O4ZsfgLAbiRI1ZbhR3H8I0vy/n+MA/1BW2L7mKH/rmLwznNCDU
	z/OYVSp4hrg8OjfcWHBbaj/5CkTOI4ydutfKbcVY5TSr/NlaDyz+sZUeH0m3b1TT
	e6J0rbOCoEenNYdrZzP2C4r6pdjEoGnACBZloRPKtLHCZLvqwieZoQXmludqF6d5
	nfH3kqp2uw723vSH0pKR4EqmwPl+OD04GMUq1p5lqeL0ZFq0nsAbGCXKiTIKlLdJ
	Rv4CHBqdjP9rvA7CeRQr9gXKuAnfpS6FrvpchRjwjck4SA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cmc81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:37:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c7e901so165118711cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628653; x=1756233453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZfnogI6WpgDksp0nKQ6I3VTGYZpsfSvZDFAnG6Y1vY=;
        b=ov8REDqf+S+1Q0ZElXt1Lz1yC69vPJu3S+x0jRjezFxLKJgou+xuL55/RvqSd+nRFk
         vlAG6OBgXVQCPZWGpet/ZzsIDG3jcUoS7LnQLpeIyrZoO9VBA4KDgXg71w9KpQF99XQh
         8y8Gky0sfuSTEstj8JLnodOjlv9TmbYwuCdwb6g2peJPOyVa3VQmabAttHDIec09SvGW
         WoByoQOakTlcVD0ADkRlrodTaoZMZYGNzlPZP4sK7q8oXbdN0ruIA3fNYZmiLBsXlOya
         PJzLGknMg1Jo+EwPVkUdXBCh4GIHMo9OY8gYxx5hhqX5Jv61E5imFBXG0gcUjGmPCGIQ
         Tmzw==
X-Forwarded-Encrypted: i=1; AJvYcCWJGfzcgl4CJTkadowNlLldRCsrqx7I+wbKRr6l3MTFwm4jM4W1+f3pX9jR3FcfQBs0Jy2BYPcOSRTWXOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlw3cG7pOYRN2o2ZU+gwcr826rIRn88Pti49N7r1E8aGLx93t
	2zDQIO5yXstSl6XnFc2reCaNd+vipH9nEDVOPWbuGuEMhADlYpUEw4YLqJXeUYvBEa2trDGB5oR
	NULOAegVX+R/SGgjtV4TkypUxcfBbmHLZzIoSkmULlbH7uGPi1Vig0CaZC8n8+5p6o7I=
X-Gm-Gg: ASbGncu2YEKjGbdSHA1VJYW9w1jnX0L0/CC98YU5sfJepeksXdvz3tfM8eUogAlY6C2
	cvtMnfbOYJrPoqHdyuPYG9/2blG7I2uveyaxw3030LlTGt7+7UduG9hjKX2vE/uFAUpARcb1Bsw
	lUyteS8cXOUtLGlqqw7niaUZQc3S8v4KFXgyaxNqaDjf+3TOOU3BNOZ7H5o+/fhimGPPWQ0eKf+
	+ZtgkUFf25CHg4BpZseQTA4jjXcu+1yhH+d7uMmzLEO8cVSS5g0tGgKf5Rx6+cLa32FYYSvHTwY
	A1gbOoQjr2pk2QYWiYy6C/oUcdsm+c7rJIuhLZQNecxDbIH8WBKNER1bY70gSlapaLPMs6gZnqH
	Au+lwkNqF8nyhJoefiXqM1PsmPqqr3YITI0CWHoojl5pY0wDQ8cXH
X-Received: by 2002:a05:6214:21c4:b0:705:1647:6dfa with SMTP id 6a1803df08f44-70d76fb9f38mr578826d6.17.1755628653070;
        Tue, 19 Aug 2025 11:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9g5WDnru9g6elHH2WCUnlGhO39LL/afayuPo32Knp3mmA5gZjAJ4tQtVgbmRYy/mExMGg3w==
X-Received: by 2002:a05:6214:21c4:b0:705:1647:6dfa with SMTP id 6a1803df08f44-70d76fb9f38mr578546d6.17.1755628652601;
        Tue, 19 Aug 2025 11:37:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a64d34asm22517461fa.73.2025.08.19.11.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:37:31 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:37:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 2/3] remoteproc: qcom_q6v5: Avoid handling handover twice
Message-ID: <t5j22g5mqunygoj2qcggle5opzi53lofwjd2xen6pfwmd3dwa2@gipoxf3u377e>
References: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
 <20250819-rproc-qcom-q6v5-fixes-v1-2-de92198f23c7@linaro.org>
 <r4kjhua4aakkgni2y4feigk5vvaz73ncetdvegic74lhuadosg@s2yzjlgb65lu>
 <aKSSqXV5FOW27VJo@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKSSqXV5FOW27VJo@linaro.org>
X-Proofpoint-ORIG-GUID: cGP0YtvXCwsZarFfqF-aLC-7MuwYekJO
X-Proofpoint-GUID: cGP0YtvXCwsZarFfqF-aLC-7MuwYekJO
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a4c46e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=RDiawQoRPOseaMlkMMUA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfXyygLlt/WHE2a
 Hk8q93ojKrvojsRYid66wZO2O9MElYUKk84p3moAoaoaq3PkOTSl++0zOsjzEvfGg/2R6BE8un9
 36gMWEalrUC08HL07kUzph+0qkaBBkczIr5Qj/F3pPYAa3e99gDgtoDTQcx49/TgQcyAK5r6oM6
 0vKLpvSl8bjFjM0vsv8slRREazAHj1QeV9/+xTfwVQjo8k8ShftjnlkYLqMD1h1Lkx9xWnJl1tf
 TI0/NTpwXhk57VevV+eLKer2wEnD98z9TA8kKlGmkHiXxz7GLQv8FOUDyI4xEp4VEErtDc31Juj
 vivVwA4H4F66KQkkjYsOIqSJZPwJp+bg3zAKlrYy2qUy9PZxsCucfkwUCrjeG4vcgbpT67CPpd2
 D6b6RwBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

On Tue, Aug 19, 2025 at 05:05:13PM +0200, Stephan Gerhold wrote:
> On Tue, Aug 19, 2025 at 02:41:55PM +0300, Dmitry Baryshkov wrote:
> > On Tue, Aug 19, 2025 at 01:08:03PM +0200, Stephan Gerhold wrote:
> > > A remoteproc could theoretically signal handover twice. This is unexpected
> > 
> > theoretically or practically?
> > 
> 
> You could easily trigger handover again from a custom remoteproc
> firmware by setting the handover state to 0 and then back to 1. However,
> if you find a firmware version doing this, you might want to have a
> serious conversation with the firmware developer. It makes no sense to
> do that. :-)
> 
> In other words, on technical level it is practical. From a conceptual
> point of view it is just theoretical.
> 
> In any case, if it happens, we shouldn't mess up reference counters in
> my opinion (or risk dereferencing invalid pointers etc).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

