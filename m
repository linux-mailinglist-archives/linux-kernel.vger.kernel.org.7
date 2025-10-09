Return-Path: <linux-kernel+bounces-846245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9DBC75F6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2F7034FDAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668C253356;
	Thu,  9 Oct 2025 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWNcWVEV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113812517AF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983747; cv=none; b=mMTHmdBzPcc9c9s5SwTyu0A/lXGFq+p+QA1ZKH0rmh3yf+hTM/C3wG5xFrlYVsV3cdoqI/IhCAwLMRj9D4gkTjKk7bljlyTHqXYx9UoC8CuG4Cy90QDoAG/nChzIeutx1vgbW4Y/XDMGRQuidnS9WHakv0AggrfxLcZYUjZ90ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983747; c=relaxed/simple;
	bh=Eo4C5n8uEjYaAZCAKX4oEdTIX64ErZL8st6VyhbQRHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRh0Ia5yLSImeN7plOwNCJJ00tUwySbPG1oW+ANtr43M7H7k30iouGOYDZKnTfmpzqfimd3OLoRGB9xsiB9TuunKoNbvcNW2qnvRI+9yc5kS2rEJOrxT0acKJzSG5y235TkXL+6Ib6tyAhcafIayJsPYE6+AhHoINIlzow+KFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWNcWVEV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5HVc019521
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 04:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wlweRxCTHiY0YNBpwrVUh6GPJlyv1DhtLQrioAbjk3s=; b=CWNcWVEVDsQ+ClgV
	zlyDNpdTEBS3kZfrjZd6A/OgTa6sIqrnwumKMkF618GVbNK00PTAKOu04GtZb1Df
	YsWKkKCuyYV8AZfL9OoE3jgUcV+LfpHttV1DU8Dje6TQG7SeDpldfLp6vz2yp2l0
	3OsQNVwNyKYR+w1E+sFykxIzba7cWZnkyz0ZwQBBUlcsXjelSFSipa+TgWzPYdkc
	uUo32xyxeOgPvOUm0WEi7+SvHdaFjpSZCOGcjXqXQB/Xjpt7FPNdoGBRLXsxaqfq
	o6+iE/axr8kEAdaml/TLY2xsMhA4wP+fu0iRPymE7mD8fividjPbJQk09M09d+JT
	6RNQuQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9a9dp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:22:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eed7bdff0so9762585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759983744; x=1760588544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlweRxCTHiY0YNBpwrVUh6GPJlyv1DhtLQrioAbjk3s=;
        b=ebqfZagT/xGpVYYeLQ6ChAasFGWk+SH2cYDeOnziUjQBNbFY+O7+tUdT7aAXTc+IJg
         IQtApgxbvOIB1e2XoEpNxebrRNv6IXoRXFfTbLl8lIHz9MsbxghsSbrBR9qWdon3rULV
         APHvrTaDR745Gtv/rGeOVgJHOKP4CrPcblw/d0s/ifq4ii/LhQU+VnIiBh358DANoKOW
         9ONRsUmPk+Q0d4mwjU8oXQ5ApLA2GidRRbQJ681F0xBMteY0HZTd0uXkza+iwyUbFKuI
         O1su5H6S/jGDPEnYAHvCjDF1fn/5BLhNz3kCElFWTvvjE9zv1GSBoeOYbxGCWXsJI1dZ
         OooQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+fHBhEj3QoFtimNlNKTDot6yLHZIjg2/sp8fCG+pMZiMfQvrk3BbkfxLAXBUJDxQr+42QJx2M0a7Xo8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLA/mt4g2KeEZbHF4aeaX/8pWudscn6ljSLwlvkSSfWBYYX2MW
	GFkRK/pUniFszGS1cT9xuvM4W7J1EA5jl4Ougds/Hpm9EIjx5f8Val6xmBSwJgaILzARbH77t60
	F7XRTEdLmfFGSjGg2VDyxlg3Is5qAxAiHagA1ClgJJ5tmLGi5nask+JTn+Gj3qiOcz6U=
X-Gm-Gg: ASbGnct6hEt5/PFKoj3d8QSuhYyiPY53N5JRjUO3bmtjDhpCT+SR2YlW08reLSPcOXV
	3LD2YbMAkjX4cGZ7Qna7Ht3YIcWAf8hQe42MdcVSO6dSttYfOtYikXVzzgPvJA/+fW9sTQ6IiMd
	MYOab9J50y2fcb/ayL1aArTPt1+1/b6D6ypVvQEGgAtpVg9k1DrwKmbIl86yWF4+y7jxobqFar1
	X/3jf41FMXaA0odmYe6i9UEhHvdvFOh3pxpWkXMkfsR9r+E+cCN5qmP+XcQeTeG8yghT3P+2iV+
	IW3AVjxib8wp+KDBZH3ULWQctuQ3obqc9YcRdcipzm34nzWpCIZnh/dX6pUPo3xxZaWK5woh6g=
	=
X-Received: by 2002:a17:903:2405:b0:262:f975:fcba with SMTP id d9443c01a7336-29027e77f4amr67045995ad.9.1759983743589;
        Wed, 08 Oct 2025 21:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyThAq1dvMXcqDn90WzxANwfN1ADcD9benUwSZiVNbSywnIE1WHXCuErABq45wMS4n1iN74Q==
X-Received: by 2002:a17:903:2405:b0:262:f975:fcba with SMTP id d9443c01a7336-29027e77f4amr67045535ad.9.1759983742996;
        Wed, 08 Oct 2025 21:22:22 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e1ccc4sm13599145ad.42.2025.10.08.21.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 21:22:22 -0700 (PDT)
Message-ID: <5b9ccd6a-2911-49ac-beea-b37c701bdd53@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 09:52:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] clk: qcom: gcc-x1e80100: Add missing USB4
 clocks/resets
To: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>
References: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
 <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfXzImouojuemMa
 /3Jg3ohDad9cwWhoLr35DeWb3x1qQWTq5xZTvwX0AX+gDIPqRsfCm7/DXaFhUndY7sDdy3G3cGI
 rS7Nz+NWAz/VM05BdpzRLiyMOVOiflrQOudeQmS/LEjAt9pQS4Hc+gFhVLxcE6zWGRQ+B61B/l9
 5e+/8TvAC6raixcy13ThBKeoe1I33j94cOWcVyrBjNx/T4AgePmxS6iQD45CmTDH+EbaS/svLGS
 1prHFlpbD+DSW3CRtO2/MW0E26ZhSuVpIQuJ/y9nZl51BM348B/mN8h05A3Bb5DKA8q87oIZhXp
 hS51AEygxvIOQswTMK0k+NdeVb9HgmrxQU+90W3441hTMaECoeBBgaM3pcOjiFzXwzTjL3i35AA
 OyiJf1S24Vq6a+JCl7SPS/0JWrHodw==
X-Proofpoint-GUID: Rs-ffsmvNXfG-61xM_T1bcAGFAkF9oSD
X-Proofpoint-ORIG-GUID: Rs-ffsmvNXfG-61xM_T1bcAGFAkF9oSD
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e73880 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=vYJjhQUXXu9twL9fmf8A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122



On 10/3/2025 11:44 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Currently, some of the USB4 clocks/resets are described, but not all
> of the back-end muxes are present. Configuring them properly is
> necessary for proper operation of the hardware.
> 
> Add all the resets & muxes and wire up any unaccounted USB4 clock paths.
> 
> Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
> Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>

-- 
Thanks,
Taniya Das


