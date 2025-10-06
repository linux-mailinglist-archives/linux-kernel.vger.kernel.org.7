Return-Path: <linux-kernel+bounces-843041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13114BBE483
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B973348553
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DDD2D47E9;
	Mon,  6 Oct 2025 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqPRy82Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AA2D46BC
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759780; cv=none; b=VWU7G0Xvjk/aAuXFQelDf+uVtKoHjUhfAQ+a245cWZYGqwTKgLkpVF2co5kdZsRRYYq4deeIbcgKiMX8IEjDp5aL1+TDN5Hs4lWvBZ4c6ANCRc2rSxS4F4aCPD5wcOc7ziou1VHiDEsBHlYSwUR+fIXMAZBKO231uytmsUoa2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759780; c=relaxed/simple;
	bh=+Ac5cJDdDTJOQVETiuUSs4LHivS3FpAmbvBAbBep0jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX1o0ThSyrnHnYH1fSOFFmcmiX8kNkybeggkP6M7TXIGRKeGoPvFQWWuH0h6u4x0wjROWf57PBac6NXoVDEVsg/Xp+CuW1iEta5oJ7e98Xz4Ys2Zd35TgfsDKISc9toHWkDo9aHD5kJXx4QBuUuqT/DIZh9w7FJlT3jCIYJgKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqPRy82Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595LqTh4018496
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GB29UCMLBPXo5eLdPjvIY/VLAFer3OBUfViSSQUTz/4=; b=HqPRy82QW9dvo6V9
	ZeLHR1a+pjiex41d81XSc+lXdIouV9OoeMLKggKrxaxBJsYRhMVD4EhnyluvKqa1
	e1mWUjSS2ixA7Al4vx5kR5g4UHaftia6Fqrrxcwx5EE/WwIe4Q/xtWQfJyoXyndl
	rpXhpa51BoKonI/WtZR8D39pVuFBU7QbGm0JJ7YnswydRT5vmi7PqMP45wc7SdHH
	tjyEWVcL60jVbqhe4mwkuiSPjSw6ppPrwhA/eglD5bk/EVAxQ9tqW6D52/SlC4B8
	PRtqHL4hJbuQnUXgYVuGsUgeZcQjywlM8TO4h652Zo7QBfEDtmxQ+qyeGksA6qut
	FOTPaw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhkvh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:09:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-286a252bfbfso99059785ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759777; x=1760364577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GB29UCMLBPXo5eLdPjvIY/VLAFer3OBUfViSSQUTz/4=;
        b=PG4S374E4w+xyvkrqIfpodV75UwqnU3edRD1Ua0TWi3dcVfnCyQ3BMaJsDezvJs7Pp
         OcTQjTEVnvkdZqROWRoY3GUyXj0ltU9WRyAIls+nGfBe0YzR2BBTTfxRKA4vv32bo9ka
         UlFqejIhZ6oUP09IAwSZm2c5yAr6Xg5se9VaVl8aRKb2cmdNe94PPhUSu9VqGt/gOtL3
         9VAu49XztQ1e85QeIihzRDjc3NpzfRPn+NCEAQzTIWdu9NP4t+Y0YtNpVN4i4QQTGri5
         icrp3zjwiZvbaEwCGuAX3kzRnSaj43iEI7Bv5oj4dDcQI9xfTvUN2nkh7Lag0HRn/Eot
         H/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWo5Rp2RYfA9HcsTdryVJKy8TP+DardOz8Idp+wi6BQpyQ7wHeB1lryqcb0ELUakr3DRSRcmr+NLCeACfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1uk9b/tfctmO+mGy+GxMCml4PD6RO/4/+Fj4WJYQdNYXavdj
	o0FGcCt/DdKD8Kl+ptvXWjTm1uN7gGw6AUDiphMvZurFYVw0IMK9X48skfsCXHNbeKMzT8wnd/l
	plG0H6V0+KDKaRu8WmfrQ+8L/vyk2h9X8AerDTaim5go12TgkTpuSy33DMMyFqjm8xD0=
X-Gm-Gg: ASbGncs8YzxcSkwq4Y1vaAX74rPhj9wxB22Flbq4Z7Iunr8cZwu9dsv0lKyKhCdJRA3
	MaDZ2fJw7f8NmVL4Gw3q7HtXDzpRc0XblyT+ssSlpMbZpzOC7K7Y5tqqM2bnH4BKPL1xJ8WG0OP
	6kFHxAoNlGkdn0iVph3Ldcra4j4fsWS+0cevipcbwZe5Q6xMfwicVJSCMv21MFI9nxn03Si0iHq
	IpAryf6s8UIgDt4fs+f17f+y1NdtVrtY0UjbIM48N0uUyjzLjwl4K82tavsQ45TgCUwCmCSWQO1
	m329VD0VAWZ+dbsD42+/hcbOjbWBtiMju4c7903FvnJdoD7S/ZagIVncrXPwvXemCtG4x1kHQeo
	WxBw=
X-Received: by 2002:a17:902:ef09:b0:278:9051:8e9c with SMTP id d9443c01a7336-28e9a65bbe4mr151249405ad.42.1759759776696;
        Mon, 06 Oct 2025 07:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxq1GEAbYHAQEO8/Ijrp/7z7LdukF6tnpYf0+ClvsrQbBiRXSi+LJNN1E6SVrt66M4621L7w==
X-Received: by 2002:a17:902:ef09:b0:278:9051:8e9c with SMTP id d9443c01a7336-28e9a65bbe4mr151249005ad.42.1759759776277;
        Mon, 06 Oct 2025 07:09:36 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.253.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8796sm134519245ad.77.2025.10.06.07.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:09:35 -0700 (PDT)
Message-ID: <fd9860aa-23c9-b223-2139-a2da93191410@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 19:39:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] media: iris: Fix ffmpeg corrupted frame error
Content-Language: en-US
To: Vishnu Reddy <quic_bvisredd@quicinc.com>,
        dikshita.agarwal@oss.qualcomm.com, abhinav.kumar@linux.dev,
        bod@kernel.org, mchehab@kernel.org, hverkuil@kernel.org,
        stefan.schmidt@linaro.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfXw8pQabYJ7Gjx
 apKElxSqIHfvvY43p/EVr/kS7bM2LcBhHiRYiPOB3IV7bvvJjLiHjMHkKlP5xwIqlo5f5sph+de
 ApNhfCl0QJfWEHeMtuJWhbSVrY/sTo51RqtH6jCG2XrXZMYOltvscUFcLQRyxYL/c4FdbrzVU75
 JkDQO6LI2e0s0EunHA8z8+S7TZ84lvlC7jL6qURXgximeIaCVujJeJr8DPok52FKaxWBlXm56ST
 zOg1Ln3I1Dck+wJFaXoA7GSSjulU2Ul/GBwk/hRFknC6BT8oFtkjaJrKSegyxtG2NqwF+xUrRpr
 nmovhknyFiyDScGpeg6M5DCdv7QqBLYDOdK0U/egIADUquuxGzGwnZph+m0bYDwnrv7fxr764WL
 AQwZ6EU1HkkzbAzDJZdM7CB4hUfGlQ==
X-Proofpoint-GUID: d7sRtbSNwoy1eGk-JxqdD53Gktv4n0E8
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e3cda1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=kO0dpjAoeuYzon0q5oXcQQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=kcjkJnMakA67_LZCmskA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: d7sRtbSNwoy1eGk-JxqdD53Gktv4n0E8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036


On 10/6/2025 2:48 PM, Vishnu Reddy wrote:
> When the ffmpeg decoder is running, the driver receives the
> V4L2_BUF_FLAG_KEYFRAME flag in the input buffer. The driver then forwards
> this flag information to the firmware. The firmware, in turn, copies the
> input buffer flags directly into the output buffer flags. Upon receiving
> the output buffer from the firmware, the driver observes that the buffer
> contains the HFI_BUFFERFLAG_DATACORRUPT flag. The root cause is that both
> V4L2_BUF_FLAG_KEYFRAME and HFI_BUFFERFLAG_DATACORRUPT are the same value.
> As a result, the driver incorrectly interprets the output frame as
> corrupted, even though the frame is actually valid. This misinterpretation
> causes the driver to report an error and skip good frames, leading to
> missing frames in the final video output and triggering ffmpeg's "corrupt
> decoded frame" error.
> 
> To resolve this issue, the input buffer flags should not be sent to the
> firmware during decoding, since the firmware does not require this
> information.
> 
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> ---
>  drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> index e1788c266bb1..4de03f31eaf3 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> @@ -282,7 +282,7 @@ static int iris_hfi_gen1_queue_input_buffer(struct iris_inst *inst, struct iris_
>  		com_ip_pkt.shdr.session_id = inst->session_id;
>  		com_ip_pkt.time_stamp_hi = upper_32_bits(buf->timestamp);
>  		com_ip_pkt.time_stamp_lo = lower_32_bits(buf->timestamp);
> -		com_ip_pkt.flags = buf->flags;
> +		com_ip_pkt.flags = 0;
>  		com_ip_pkt.mark_target = 0;
>  		com_ip_pkt.mark_data = 0;
>  		com_ip_pkt.offset = buf->data_offset;

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

