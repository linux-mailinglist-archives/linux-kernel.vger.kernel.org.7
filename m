Return-Path: <linux-kernel+bounces-822776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4CB84A60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D70A6263C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98030217E;
	Thu, 18 Sep 2025 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rtn7nfEp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29C302761
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199618; cv=none; b=cvTS0eK4i5VvDzT49o+NcQ7ufbGk+/IEvPqWX17h85DX/ID2rhCyhjq0wriWDgaxPsEThXupZQJlv1KbhZvYJF36NM1m+K64yXa0ZVqQyLdMsOcMNQctrrfWNa9UQjGXjjPA/m1INHCD90MO/YzbJCC5BQ4FldbRF0Pg4pq1LzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199618; c=relaxed/simple;
	bh=QcDU0S/gGtyrDJoonhlOJQKmYDHiNPBGxqw1d4DtiHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmIq9wxev/SMlv5SxsDvzbxxTEYS+xoPSamZp2rlkQVBmEwItF/WEoOmhm3DzMOwLLuWFMhXP1diY0X1fGfbh+pjq0K7J7araXvXTK7hbt/IOSG2OscOgQCxNoMGsYFrQOU/IbGgH0U/xDcMYO5bzNTVTNeGCYi+vf6ftKQH2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rtn7nfEp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBETRq018300
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQi6E6p9KLnZzlas4XjllmXc+yprtBYyqANSQeumeng=; b=Rtn7nfEpcgK1qY2v
	cgDmu2IVJTGkcyD6haMQgdNdKYiZ4OiXURc2a5BOfNAm67kRCYHsUgZ67lRIDFUP
	YvWmDhfFE5yBPLWzh3FtHByfwVKGHkP63RVaCOv0K7qwsj1l+6SibBWe5o1aw54f
	fqyOzLeuF5BtTopwtXMJRNlTsCSLtVKxFVx1IfOAF7NQn9Mz3V8safHrvI/LbQwb
	0+DsfzBRFP2/MUVapsfLzn51C/K0dl1E/g/0dEbDJVgMxHTkwiGwIT0+75TOwSDD
	rrFRDkwTQIcYIA5NUelBVuFBvG/vIZxuBCl0b+Togc/NJ91K/YNWD1DGJ1iB9oZo
	CSgCHA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwebac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:46:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b600d0a59bso4531721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199615; x=1758804415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQi6E6p9KLnZzlas4XjllmXc+yprtBYyqANSQeumeng=;
        b=Ay1SmCQsTSK0691hMGHWgxhxc0nxMepgpDZ1dt+emtvIlYQilkD3SHzS7Hdz3Ovrga
         MGjpvaV3rR0WiPGZi/C+ql/a1aYW/YDDMEpb5ZcjuHvNaXCVr/mG5JwWvcmgT/mD1Vgf
         Bq6Vg4aizv9apUxnVFVy6zK25wrr602MU7n9xV8uF4e25bgt2+pai5EH8kPRw/PigNvj
         qzXroJhhq4jsopbM6Maj3Y6714JpHy4YQOAn9+i02L+x7MoevUm9pYPy/JtFb/Zy+3/M
         K4mqylPu3DewaL2+57tiYpd0ntm4Zb+lAv0/6xryLcnVSbrXrVxxwZ+LB2lu9WZlGzaf
         6OHg==
X-Forwarded-Encrypted: i=1; AJvYcCXXPrxp2VTcR5CyisUSGHI5sgXhhKTWDbOzHx1ErwsGzDg4OBS1JxtBSbrkZ/RGP88xrhvQU/vcDEGObYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9qF8GWXruLiXk4SKgjon/Pg2Msmt76HITJ4oM2VufEh8Wry0
	/fKRuzMwISSKVEh0NTk2+DCk4d1W7AM4f6uglaeWI8OIs+WdUBKkAxsHF9PybsFT/0w74D1+DMJ
	rm01jlhe1cNlXRJiBGIWYCExavxlUZlLW/X2KfqD/Oqra0CzFx5tuxxt9SdyYBsklipw=
X-Gm-Gg: ASbGnctr+KkuXuRzg84GkcSgIlQx91g0pWIM8QAMC1N+QxA/UZQwCEioZKxm1ElP4UQ
	nDHcKgbtOJ9lkj2Hc438jpRFj/6PMZBggvHxG0/1mvsimS9XClk7+z1ko38mXdlLlATwniSoja6
	7iWUTB9xpqiy32hIE89C9ANk6/vYQv0JSETmyCgvtShoz1wFu6Ygl2w87poLlLzu7Iu34aS/EtY
	lj4mw3PRwJSkP7MVdTJctf0NJSgsUfSWaJmEGCfXJyCTlNVxTL41tTCB5OcWiWwW44idTE5UPio
	BOH0/TqcLk6JhmzZihvb4srmPqtiOMgxgXxFYSCP9GMxfnb0cf8TwqKXgONAy8tzHNbzU3rbELk
	xM0HBAVwL9cDycMjKP0mJgQ==
X-Received: by 2002:a05:622a:1a22:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4ba671e4f25mr47443981cf.3.1758199615420;
        Thu, 18 Sep 2025 05:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgBR0C+dAzCLmJ+hmxln+f5FlQgcycTu/DhEnyDBQ0nAkbRMwAhB+7lqoqPXh2Ubt8pkL/kQ==
X-Received: by 2002:a05:622a:1a22:b0:4b4:9655:9343 with SMTP id d75a77b69052e-4ba671e4f25mr47443731cf.3.1758199614793;
        Thu, 18 Sep 2025 05:46:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa981284fsm1033537a12.14.2025.09.18.05.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:46:54 -0700 (PDT)
Message-ID: <3c42a3b0-b8b3-4c37-963a-e9cec2d3d025@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] arm64: dts: qcom: ipq5424: Remove eMMC support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-9-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-9-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cbff40 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=be57XhxKj-X5Z9eHZJAA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+xIJW8GPmONI
 TwYGsIoQE8fvf+lipfIFszY1WxcRfdCK2ndp2wfwieNbdw92wtd+9Wph7oo59eJ1PHJzxOOMPsS
 ed+81d4aY/FeuzQphNFZo6sZRxE17wRw9XfStei+fyXDqK73qNxLlhz7QtRTQsIqgy0QRQgF0yd
 +G4hUAOurlch9U+7XtFtCLKei5LIxZt7wlA5KZSyu/gKwVAlGIM8w2MN/AeqOrshMxa1fr/X524
 UPXGjkPGwLOn+5jmeCMGJmLEvAsRLgxpqdouNxpHQZfD5Ip9mphhdNNgz4VzSwDIY4gP8aC+08W
 S2ohJgRm8Ce3OUTV0ROrlY9brRs05Be+WCsq8LrhKQlMQWXjdWIqIlySForGBhrPjVUL8LAQMdy
 wA6qwnpU
X-Proofpoint-GUID: BW_4Gh3wzB4TR1RciKCGtDzN5pfCSYOM
X-Proofpoint-ORIG-GUID: BW_4Gh3wzB4TR1RciKCGtDzN5pfCSYOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Remove eMMC support from the IPQ5424 RDP466 board configuration to
> resolve GPIO pin conflicts with SPI NAND interface.
> 
> The IPQ5424 RDP466 board is designed with NOR + NAND as the default boot
> mode configuration. The eMMC controller and SPI NAND controller share
> the same GPIO pins, creating a hardware conflict:
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

The subject should contain the board name, i.e.:

arm64: dts: qcom: ipq5424-rdp466: xxx

same for patch 9

Konrad

