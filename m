Return-Path: <linux-kernel+bounces-809735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE28B5115A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 641A74E1144
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33130F801;
	Wed, 10 Sep 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcUQ7a3A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188628B501
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493195; cv=none; b=FW9tuxXl079Zs6S6zChgFaZclpLULxp2E127YHiz7WEpeXX5GHUztKJLrExAfbjAdRsVUfdkc0GOboiBHseV2BqsflTyOUHNx2AUn5XgDkWRMbqQgvmZu3eXnM+JifcWZi4aymxrC/IJEmyA/Tu0oM6S6M1J2RTZPIR5esj8CgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493195; c=relaxed/simple;
	bh=DlbYRyEexjj8zwCKt3P7KTXIhWfFrI732ELpZqO1BK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+UzCep+5kFko+kezwux5nYSlV9E/kKoFeJL9ansDVoia4ivdBs0cYlv08kpUM4dFjL4x2IVXzwvTjU/ORTTbPR/yHJGrT9tYtcljd5Udike4kWgBmFbZdm5EXm/EwrD4ziHqeIv0tV6bHxFUjHj9koGu1aHbddBgFlSpImns+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WcUQ7a3A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7cj4i002880
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DxMGn1L6bdanOBGg3S871xsvM7GU6DH0il/8SlYbifI=; b=WcUQ7a3AjLuXIVmF
	nWTcbBOsbzu8QxUIZgY7ZRDVQZqUjQyXrwwdm99BXQCx2nxjagdIMoSy0mAw46sU
	fzZoWx+lPCXprO39Aa7DY2zwvtHz16aVvq0lOzKpWHeMfQDJ1EZ+1tZCt2IykxPV
	64D+bbuea25tz2wKyTMAEm1kWSbDP7WT6vrzwoFWH6/XfqTLFvXGIkL+Uh1+weMh
	8ughICVKVY+Ff5BMBYOAGhhVQmziNeGsHuisltrDj/85lz852yq9e8yqFvclOoIr
	zevksYVUHy3T1vbDXxDfmvMaXNpBYcqIIR5e4DKnTEooA0U9Q/J0MelCOGzb5elf
	2f6n1w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8ab2w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:33:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b3ca5e94d3so11167481cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493190; x=1758097990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxMGn1L6bdanOBGg3S871xsvM7GU6DH0il/8SlYbifI=;
        b=WRiD0XJqm6d7IrJp5EhSe1+s1UV6yMSRB2pV0KsG/9Ic7Ez1K6kkFL02DwfgAVUaFx
         ugkO3QexbjjSSdpKAJFhROclmBXfq3NiCGjnKX3xsttJDxRKBQFPV+xffwRc+vWBOXIO
         s0y6VOQCQb4tl2EoxFOB1dLmO2hhHXBzNBPASrlUj/oTiOFpwxtfSPuXL9KopxYPwPgy
         J2YQaLGmvIyBZR/Am6RMCJLljaw8Hq30zSs0lTTcePDLB1UNYCX2BJOqKOyuLJed9f3t
         2CHWpP9qoGPOsbrPQ4xp5RHNqhgJi6nEIE72duDQe7LFDTz8BppG+wbX1QRtx9yKJZk+
         1yqw==
X-Forwarded-Encrypted: i=1; AJvYcCV2DSs9aMfWW3TtvmNAVxXb6J3/c2os/Q3a8Rllakmt4cuM2gX3ivCpeMO7BkgP00OHl2LWxXkW1iOLym8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLonZzPTJ4JfkG6e3Zp61+stW1JkM6sjqOHxmwL2hrwK2HvJTp
	j+d5oWN7KIcXOEk/pO9BU70UfGQRjRsnWavcDzlipJis4HCe7qEOZXQFzCk6ZP81H0P1IsabhOq
	QNy31uPGu56zntQS0zIPZl8N1PJy6ZZNsHaTuzXyB6IpPKefJxRL3cnuT5d1VRAjWajo=
X-Gm-Gg: ASbGnctmFuSW42was4/fOkTGh1j7tOOq/Hc8pv0PfvwximA87tOoU5wZeYjd8fMLDqn
	9+cR69/wYXVGJEizdEYqxLIFUGuQ43I2lrl/ko9RzEMbHARtvzrUE0JstRP+hZOgTKk4I1WKECK
	wGSGSaOJtTZ593O6rywVQgAsRqNIr/bJ+fVYteJ/BZoQFWt1c3jspFiIAfJmIA+MF2G7ZskAfC7
	E1EsXQgUtHUvJT4od/SK23DLpycRSbNbz1WaQRsc6G2wd0wweNBXU1DvqRprcejUdKmScCzjePJ
	/Y3MuWYZhNEfRdy6Odoka7zRRBbYS6H8qrcfWCftHHgx+N1+UL8b50L9fe8zzUqirA5PPrzPC68
	4hSccqphq5z1GkcubpTErXg==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr105966481cf.0.1757493190249;
        Wed, 10 Sep 2025 01:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELYkAW9euO7xNhHIImT1VuFKchy/KUizYQutBzWVi31b4Qahaje2/jd+ln7b6AU9wCDck/8Q==
X-Received: by 2002:ac8:5f14:0:b0:4b4:9175:fd48 with SMTP id d75a77b69052e-4b5f830417amr105966301cf.0.1757493189549;
        Wed, 10 Sep 2025 01:33:09 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334e86fsm127048166b.56.2025.09.10.01.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:33:09 -0700 (PDT)
Message-ID: <f20b174b-bfe3-448b-8da5-963693de8f2c@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 10:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: qcom: sm8250: Add egpio support
To: Sean Parker <sean.parker@viasat.com>, andersson@kernel.org,
        linus.walleij@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250904170613.68855-1-sean.parker@viasat.com>
 <20250909205248.16169-1-sean.parker@viasat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909205248.16169-1-sean.parker@viasat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c137c7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=B2zXoFvHAAAA:8
 a=EUspDBNiAAAA:8 a=yEquWHxyAAAA:8 a=HbEANjnKo7ABX2ZL8B8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=VYVPV9JAioCtC5HZRjjr:22 a=_j3XSMEICZ-j_p4bQif0:22
X-Proofpoint-GUID: 5a5DZTGPikmpzrFbYfPuHn7cRMoeobye
X-Proofpoint-ORIG-GUID: 5a5DZTGPikmpzrFbYfPuHn7cRMoeobye
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX4fQ26s70PaIw
 OVPOxifA6fmIZQwi14suIXTelszpqoxRXfR9cjghnc07WbPo/NlpcdBPCYdDRFVGEYaJ8o2KsPm
 9RZW29bZ6raZUUJjwfdwq9gWu0dUUZkdNU5bhdapWK/JC4zC+asw5vWW+UNE/UvZVnDfN3SC5ka
 poU3PZDDblIR0022m1+zJ13TUvQaudOEhjNkCaKcWA8os1e9ItL3xucwjKybrieO2ginzadZYhw
 C+9JiqzHBbfUwsKwwWrFXPCLAT1o7pdLoFVCX/DAbDWGo6pXsYD9jrQKHNicpxEkpO0P5hIU+3X
 BveSa+eeQsWGOtdHOQMHyqTcutbWSfGAJrkMN1x/AiMUWS+e2A0VcwJ11K6hWBaW+tYW0iRuXiq
 fLdlz2Lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On 9/9/25 10:52 PM, Sean Parker wrote:
> This mirrors the egpio support added to sc7280/sm8450/etc. This change
> is necessary for GPIOs 146 - 179 (34 GPIOs) to be used as normal GPIOs.
> 
> Signed-off-by: Sean Parker <sean.parker@viasat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

For further/larger contributions, please include a short changelog
under the "---" line (which won't get into the git log), describing
what changed and apply any xxx-by: Foo Bar <a@b.com> tags you receive.

The b4 tool makes it much easier:

https://b4.docs.kernel.org/en/latest/

Konrad

