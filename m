Return-Path: <linux-kernel+bounces-742133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7EBB0EDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35737188B70D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668A283130;
	Wed, 23 Jul 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvWMXOBr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EAA28000C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260930; cv=none; b=QUOI821NndZaa/irF/sVp64xJziUN7twYLvGvbdcuXahGfOWiltUFvHswrxKHYwWjtgLRG0wcOUS49Q5kJ1B0pLzNcmH84X8/atQ2mP2uEBt+LTZylVfRm4TBBqjmded/27AZE85St47n6oZrF7b+eBT1UXM8cCP4BOML2V06pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260930; c=relaxed/simple;
	bh=J6LLkUZtxkhT0lF2A4tYYQe7AdJvj9M8D+fzDPn2MUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqc86hdVi9yIqyjBlaRty8UuC6NK5iqyd2xZNIAxn0UqbnOgOV70wh26QkDJE0QQ8xOWCCCPsqM0QVTP+8OPf0DOB4++sfRp8oWllnzG9XsDwOo4Qo4+SUlgfBQV4hOTVrlm9at8rqUyn4r4UQBCiOuPA0ccFWZjpQSVE9fGYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvWMXOBr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMO8wd013723
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2/MKy99x4tsVjpzMWhXhf/+0
	XGUClqX2jBqY1KxJfYc=; b=YvWMXOBrULWXQldxeFHZpwXye1T0I51eS9uifweF
	oeyVAzfF9qVXP9zw50I90MEAs+zr3M/tTeRrtNrv8DXa4p2as6O8D4RTGRIlbMRE
	Jwx0GTmn5yNQQFIVMZ9cnly/rrWKRwiKrdtfECTm/wa8qpDNLkkgHod0CukG30Ge
	olCsoxwyJFoKA3Nokt49zilQ/0eWfW/g7D1yHve4fXhi0ThWBViig1HLWyqyM0ZP
	ByPTXAtindCiCtgxGcQ4FIIpei2W5harCuktfPzj1OxBTvT8uEPk/hwPnoMYAJ+u
	1jwY5j0wRBTPq4Av7rQbsAzxZbmusLkZubPC7UijSNpa2A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048vatnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:55:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so6002418a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260927; x=1753865727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/MKy99x4tsVjpzMWhXhf/+0XGUClqX2jBqY1KxJfYc=;
        b=vZgMIOcEdvyoodT4yCtaPT67ddqYo23eB8X8/JkEzNZJrv8ibuTbe4v4OSP3dHIPne
         8zBAiD0+ufRcgT3pL6JXTamCXW4yWgnM8YKeEJWqh8ULOIHV+GgMjIVBDmfYCE1+7Hyj
         KMHMpUweMoi8lqmgZ8FBw6vQBwuXpUE3VZr/W9cu3VMzApMvKkKpnbk6y2CdW3OaMdpZ
         07DVXHj8n43LGzXRqJ1AE6mDrrjM+7NA5l5FpTMItLZ7Q29t25I8xJsTgtGV4DsNxB2h
         hCbZSXrJVwdqJUY33t3FMZ1j8uhaichGcqizdlMVp9qNEVbrHNe5/LU7Pc2kOhFVzG5i
         7nwg==
X-Forwarded-Encrypted: i=1; AJvYcCWuvswksUR2i0XstnB0i+seZHL5piwnwDDS8hTEPQoSLtjGR9VO0YUHiHjE3VyG40gNGbsTIbd6fbdg2cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOW3XbHuQDK5JHuZAkwvGzASP+02yBgHYVV/t7cK7MH1xWlss
	fYAXZfoiTDy+4AW54Ps+Tnp48JAfUCUmtf/P0Lo3TW2whOprMrvuXrSiQ//oV5XEBed6NqM6fVJ
	2EIXD9QRwXuIRYlCpKqS8AlnqF1CVyqIO/qUTvHLFsi1GOqC/WbsLa6Er0aQmsmXg3UY=
X-Gm-Gg: ASbGncs+zN3yQOI6ozgSa8qeRl12wH0NLzYPG14lAKpJRyO40fI5Zedq8ZHeExw4l40
	glXMn0OWW3hwyBbtvM8JN87DneSmd4JXTUoNfps7PqUGlvrcvmwVCE/uY6FUGNEQElHK5msxvnw
	9CNoSAK38L70kp3Rrd+U9RnrxnJCRN3tnep4/naqj3eyKGV8X0nKJPt1MUfs1qGPtA3Mec/PSg+
	fvMnDWZ3iZeUJ7YavFFyOxBwsJMcwsd6Mg1GVo1NWRBVtcUajHYQGlw8JMenUxZvI+NtAk01ckL
	gz4usuzDk+DtZloiEK7wrRY9IlBXvsbx73EngqrVxUX7VSuPgyNgKwEy5UADfhd7i8K9NhxitMr
	5wJQ2A34tUvcW4rSOGuQ=
X-Received: by 2002:a17:90b:1e10:b0:312:da0d:3d85 with SMTP id 98e67ed59e1d1-31e506df8efmr3704017a91.6.1753260927304;
        Wed, 23 Jul 2025 01:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7aSTD2BEN2GPGipaFx5snYQw8DKNBiJv81IMCn4FkQGBP3nLk9dZg+gV939ivxjAN8wpgQw==
X-Received: by 2002:a17:90b:1e10:b0:312:da0d:3d85 with SMTP id 98e67ed59e1d1-31e506df8efmr3703988a91.6.1753260926904;
        Wed, 23 Jul 2025 01:55:26 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8d550sm8456955a12.24.2025.07.23.01.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:55:26 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:55:20 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tingweiz@quicinc.com, quic_yuanjiey@quicinc.com,
        kernel@oss.qualcomm.com
Subject: Re: [PATCH] arm64: dts: qcom: qcs615-ride: remove redundant gpio
 header file
Message-ID: <aICjeK+gC1yxPb9I@yuanjiey.ap.qualcomm.com>
References: <20250723084351.4627-1-yuanjie.yang@oss.qualcomm.com>
 <e0c9e620-a331-43c8-9c62-f9769744a484@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c9e620-a331-43c8-9c62-f9769744a484@kernel.org>
X-Proofpoint-GUID: _6wqysETRRCyX9RZfVbL1Kyalh6wJlKm
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=6880a380 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=HDA7t77kZpctsFZEpKoA:9
 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA3NCBTYWx0ZWRfX+3W66Xg7atFI
 i0whc5dQsrSw+U8pDQZfuEjB7VS3wXF/2YcdmugVtd3iVfzC8/NuroXqwNuOXXKPb9sHjZdqpjE
 jjC8649FGYlUXHQaJxyo/JxtOTS8jzDo9c1Xxjz07j96gJVVpj2u99/SoEEJlJEEGsIgXae++9V
 etogzW4WMwodTOrM/3TdToyNNMlhHxOKzVPFC+rTAOsbG84zS6pufP5UCUp9f/hkVju6rp2cZs4
 4e/o88VnRxUqA4T607TWkurPL3tjSIHKJZjQydPUxPRVTdmUVdvO9c6XnLXmmdg1WLw6+8vXFBv
 6saR9+oynLJKiVYkr/tAxTo6RZSpUe9vD0ogGYc4QzEAWDWBna/24uXt8TWDkm7oL+J5lf0M+ek
 1wawXuC7Ji130NLJFCnl10/EUWSvqG1rZvBHRdBBKRuT9FJE62igo6L894IqWIsZxw32HFzi
X-Proofpoint-ORIG-GUID: _6wqysETRRCyX9RZfVbL1Kyalh6wJlKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=985
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230074

On Wed, Jul 23, 2025 at 10:49:10AM +0200, Krzysztof Kozlowski wrote:
> On 23/07/2025 10:43, yuanjie yang wrote:
> > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > 
> > Remove redundant gpio header file in QCS615 RIDE DTS.
> 
> I do not see it redundant at all. Just look at the file - it is used.
qcs615-ride.dts: file

line:
7:#include <dt-bindings/gpio/gpio.h>
8:#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
9:#include <dt-bindings/gpio/gpio.h>

I see line 7 and line 9 include the same <dt-bindings/gpio/gpio.h>,
I think we can remove one header file. 

> Otherwise provide arguments WHY you claim this is redundant.
> 
> Best regards,
> Krzysztof

Thanks,
Yuanjie



