Return-Path: <linux-kernel+bounces-844180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49ABC13CE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0443B188FF05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A172DA746;
	Tue,  7 Oct 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5opgIXz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29002D94B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837103; cv=none; b=EHwbp9AmCKRfMjry4iMuHs77i4fmVDq4PUfOw1gXHB51ydxuAWx6PdnLVMdpCOe8KNeyhMEZo+FD9ZCiMMgydhYDpj8q9RZV/fLRRAUShxDJDemoHnelnObx3LXIJD7i6PtMO7vu5XQFDDRIS8jexY+Mu6N+/vFQ2C4ygcRusJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837103; c=relaxed/simple;
	bh=ZXrGelmvQas8vmmTp/wX0exf21knoe1W83mDfua+9fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1mKYWBAcstEM+e6+iXq4Axg4VL2md3+NknGQkMUU8CT8gobZSInaJmupmQZYV8zJGCcSGCrpiZeOtP5l7gF/Eu0bkAjuFXuYaAIh/bFd6UEqc8ti8expfDgbBjlcFgG/mMB23dKpCGMLwYHdtNLSnc0J9CjC0ZeWgNfiFjeekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5opgIXz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5973h0Y5023921
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 11:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCYeVPjY1mm3YEzAO8t9rcepeUOr5QIFPQ94aq1HS8A=; b=f5opgIXzjj32H8O2
	GznYGxX7b9hB7zfT+3AMVvQ1pink7gbD5s75hTBwmdY9fop0FyRPss6FpvsX4iJm
	ieMfCKXwwsvaDQA9ibIcq8G5h8CTF19JfPuapbTFQ64why/7SgMqsKtptku/ncxX
	E7sBbKsKIakPF9RF+X39F1iP4nX6/nBoh+/vHrc2E7NPj8VgIHCLxVq0pxkM8KyV
	htbGGg/KTmp1jmr3nNxDNWzzlFtt9fBaljuYtbq4RIH5ragoacVHNu5Mp8yZnHyE
	HBCnyBDTTwinimNRtcOHSbdCebsOHem4dHqb0qqgadoVPdTe2UVClST0ORpwcLeE
	bLFK2w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mg6aaryc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:38:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso2990400a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837100; x=1760441900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCYeVPjY1mm3YEzAO8t9rcepeUOr5QIFPQ94aq1HS8A=;
        b=DAYZekU7AadJein7MLeHI8VBfpjlbF16zlj1qFEUb3IUjqdqvp0rbwrnvUskb5/8sa
         FB/bNqgAh3fs9Dn4yFIFjQ9/CCsTVCNucqMbHmlJj/DuKUOBoHFfvc9fzggStVWL1oON
         45cda4UWqxjQIfRNJ/LHSJSPtbGyp7mQE626xRkRXN21VMVsyIRjoMDWPVtkvaXABERo
         hirkili4ZlQJzrD5Q+Yz27X7cOdSa016xE+2Nov3oA2uJWb24G0E/0xL9K1yjHixzIvz
         2GlXLVze56sZfUnPAHG4KkAL2P91Q1G8sLEVV/TEkpd4h8l81iYKLSEaeYl5YTfxjkQM
         +wKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3fB7UYAEYVViSEVMtTMSBBB4mktuRbAexAPejGppNiFzju4lCGKpYimk9yuQ2T3uPO463p9DMaJIw1yY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XqBAeO/W7dQ/Tyg9tTXhdwHGL0fZ97yHBbLMabpKx2ZAqKeN
	SGbeGwK47rzyaTQAY3ixBgPuPtpbm69UQnwnKPNK3QSRw/cczZm3XxuueK/f50g+9cFq0XJRnDp
	clEOP/J9d3Xjjohk66Lf951oLdUG8b71QX1WVBwTMvUCCNW0854Mjrldp+Bsf6821XzI=
X-Gm-Gg: ASbGncv0bgDeum8wFwL3xsTqWDAg7blx8gDH59Un/QnXKnVVFfjSE6e2DzQa/FSlWlQ
	BdbdY3W5hcOpP17h7tWY98lQlX+cEtHpHK3n/4KeqEaosO72yh3FL9KL3Cjq7+4QDj7EjsW8qJZ
	dNrdF2GH6it8SgUt3VHWz4YTlatKx6YeaZcUYr/NA/y7mJNAM1sDIP058Y5Lah01RGeUUXX1ID0
	YDaFAgt38++S0r9uw8mzhPTecNNtukocBL6OkAISBIrnyymqDeBtNAZWslASWBXxRYiLf3eMoMg
	sC0DKoYAnDzcxXZjjsgJN1ISqh+9q7X12Ai+90hA9Z+DBIHSsvJX1jEK0EpEbmA6k+KMjpaybPV
	E3A==
X-Received: by 2002:a05:6a20:12d6:b0:2c6:cdcc:5dc0 with SMTP id adf61e73a8af0-32b61e6d11emr21191682637.16.1759837099730;
        Tue, 07 Oct 2025 04:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjww+c/j8M44jX9PgI+h6Etypkqn272KmpewHvoFomBsMZzaaIb9jb1O3bbZyUinW/tDhShQ==
X-Received: by 2002:a05:6a20:12d6:b0:2c6:cdcc:5dc0 with SMTP id adf61e73a8af0-32b61e6d11emr21191635637.16.1759837099017;
        Tue, 07 Oct 2025 04:38:19 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad926fsm14634202a12.5.2025.10.07.04.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:38:18 -0700 (PDT)
Message-ID: <aff68f3b-298a-2cb0-c312-808d7efce6f3@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 17:08:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: iris: Fix ffmpeg corrupted frame error
Content-Language: en-US
To: Vishnu Reddy <quic_bvisredd@quicinc.com>, vikash.garodia@oss.qualcomm.com,
        abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org,
        hverkuil@kernel.org, stefan.schmidt@linaro.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QtdTHFyd c=1 sm=1 tr=0 ts=68e4fbac cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=kcjkJnMakA67_LZCmskA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: cEXXwI-s0e28y1PjFQai6T0d5aFfwzNc
X-Proofpoint-GUID: cEXXwI-s0e28y1PjFQai6T0d5aFfwzNc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMSBTYWx0ZWRfX+KD+xOzKth6S
 CV3byqsvQ2XZ5vMGw38j2i8UwnbgVl9xLcFgbY7cMbv9bDiu38YjXYOAmoVHdeTIQJaeYr6ETCp
 5InUiIefJf6r1bHr/8/DqCQKZTuMJBQcUT88GyBfFrMIaGFTrZsAULr6msnge8JABxqqfnkrmuG
 HygX03WmvdKVrwiTtjdvMrUIUrfM9Ej5pQ2kXs5RGkn+I1APVwJD/twC5EPiEpTmlvpgcgH+yDf
 qjxfSPgDDCKjrMh12cfU1fwCncIf9A0DQFIOZCC0RtnZIYOdWJDkgWbhqniGR4fqvvUukJl08Jp
 iZhJeSmQEqoLKAamP5vKdNlGckXccejoiOSaJDXD8jjDnbvTzOoLCftKT2OKvAsBvW0wD2x21NA
 /8+Gp5HfzyXgJI30PHqYXPjl6jq+Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060121



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

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

