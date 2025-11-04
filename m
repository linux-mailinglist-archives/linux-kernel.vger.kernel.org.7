Return-Path: <linux-kernel+bounces-884240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77898C2FB80
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B53BE8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA08430F948;
	Tue,  4 Nov 2025 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRy98av+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlJy2nUd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5430F957
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242535; cv=none; b=sGGj+u6jQkhtbmS0VfW4dAOvzJDZAQKRPjCLzM95TV93lH9ZD4lu01VYCUa+Qee4APIkKub5/xNGaJjQqQIeYGVdygg5Y+I2DJjvvLaIAtAOMUYWHmHEHZkpo8RKw4Jo3yhsESO0qLxk5Shan1R78FZgls20RSSiYY+R3p4zDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242535; c=relaxed/simple;
	bh=GPfBHlhTxc0E2ivc+NZyZNkNlQB/Qp9Uzf7GzN+XDO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTmCUvaIPQnnZpKvbrPjXoyY2YPBelwyzzxkUI2KbjrefavlkGKVNEoRVbBRZYOSY/nZ1cIgfy7Vr9rgh4kVoUdjS9lu/TPweBZnkuSLoxAkkhCznQHCjaDx54tf+fyQFQDBGr1OC1EZlJMW/KQ40Ic4S0O88U0tAeUjnDYS7gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRy98av+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XlJy2nUd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43Lknd3617207
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ML0bwIBQV8yKSWMhezC+0ED+VzAtX+MqzkKsWQgpDdQ=; b=YRy98av+ZH4Ti0iR
	aXc/q1YgaP9Q/DZv0SqxGTTjdmlkZlCC1Kf5rITn8A5y+ChCQTDwMW2AfgcwtZua
	jN5poz9YFSziN9pahsVamlEaGSYIpqfi/s9/dAelzfyeigHe1k8AXpgHVMOmjE4/
	y6+wiB0SMz/SFU57A7aJj4C8slO0YEfTCYbQyOi2I5uqueuOOFAbrvvO8158TUh7
	sW82lBlu1uMomIYi1HzJzx+lwtY7EYBY4VuNmzxvEein3zTLlQacbsAIb8HnzWts
	Au8Ah7S8zrmHpN8BFyYHfJX83154jrzYOxz0i6/Q+A0a2FVDYO17Ah88sglY98/2
	MMgjcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fht44t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:48:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290ab8f5af6so52197185ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762242533; x=1762847333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML0bwIBQV8yKSWMhezC+0ED+VzAtX+MqzkKsWQgpDdQ=;
        b=XlJy2nUdhwVK1GOqs+Qwsty7RWBMgpjfLRIFiInIPC5C9CClsXuQa6HnOswheARYvu
         UrZI2CYm3Jj9ah/uYXPvbDK8dV9mj2nqSzi4T4YbEWjyNSu4IDwyuR1Y9D5/Owa0b4F3
         ExucI//e+t+cwgx15HTHKqu5H11pVFSA8MAL6ClsYGoWV7Lx5bRS+MUAORf6uAcAZO7H
         MxTop0SLo3Vj0+rupp/G0scX5BDD7xGIipPn8sVmCB+tTQpADIMZD+k7M1opD36lO3z0
         Qhtt7j4w7BedkD3dTg0sOugT2HSb4xMUbf81O58MrYtSXHbnWm+Omz1Y/rKH0TXZ92OL
         ip8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762242533; x=1762847333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ML0bwIBQV8yKSWMhezC+0ED+VzAtX+MqzkKsWQgpDdQ=;
        b=eThM0pxa4AV+7jfsP3zRudqYxTs9S380UZBrDO/mJSLv4hOmDFtblDqPv7vTk88Vby
         G3Li804gkASvYvCDGycwfozVrfuELdWqfTCRsqkz9UTD2fX8EzTmjEnhn7V4yMFm7K/b
         t9pbEGg4RlFO69Q/LrIPTSYu2b2flZwCeQBp2pq2tLzlMmRE8kPWl+1R9ns0anfB1v2/
         iggSpYv3E9mG1eFD34YuGt6rLtPL0iaESQiHzRBeNq/q76TKFWHWYOf0L9e4bv9/rKWx
         dDN8sdc3vzSxzFZz1icgu+A+hYJclQx66/qgLhhKkjvUhuYQ3riFv2G0V51vgT2IKjBY
         8C3w==
X-Forwarded-Encrypted: i=1; AJvYcCVlFIzcd2A8Mf9Cvj/T2qMQDX4PczmfcpFG8DODvVbASc0ae6n2WFdBnAfoBneNDj6fYDHHu2VulGWGpG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0KV4iTikfcG/6wQVuKyEDXIS8z+U1DPrnQP0hNWkF9QnCItt
	dmj6r6WK0//WYzWTRFLUzXVowvXa3cyy99rOsc+KSeUekTodGhBHYmy9LhuAbuF5fRdhN5aDHv0
	YYVDj/pyA2H46TB37LPjqS9h1edN97xHu+j05fRhjN+M0Jfqz7dBqjPq1hPU+/pZuKdM=
X-Gm-Gg: ASbGnctVYPyWBhIGoDYkPhgvATt3AxUz/uZxqT8WFmcWkneaYip3spF7sDIkYmlZDvW
	jhYVNjW+YsLTfOaXemH131eMsqWzvkmIvo826OGLzptW7Opuj6pznr5C4zmTrvOQG+6p3OI7HTL
	K4b8JLiSzSN0O0YI/BsAPx5uro4KUxmaYOBQdwL+PrebmxCDhVB29DqZ2vfaJ0sCbTjFJVmzzVx
	C6WZka1CpTSAUBxHMi9loMyWzjaG4LnoL1LSE31yc8ajZ8Nobtr7hdlFbaXaxjPPh3b1tZem5N8
	qbAJVIiT+mSDllLKijmYnRzqRHMTniN4AWEgO4TCMpRs5BX4CvuODDzJ4VW5F9wHzjqvczQvC1b
	PTSgrvSkzShSOguXc+FGuu0N5XFwpU34WPjRIRRH3K4a8dmx7z9IjPG0QNyiqCB7QyA4Jsg==
X-Received: by 2002:a17:902:e890:b0:294:f310:5224 with SMTP id d9443c01a7336-2951a4d8357mr219817025ad.29.1762242532530;
        Mon, 03 Nov 2025 23:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVlq1HJiVNCk17XfjZL4ygCOoK/YhlTzaL8scnoFnoc4aalCAtrdv0g0H5F795oWl99sMb5w==
X-Received: by 2002:a17:902:e890:b0:294:f310:5224 with SMTP id d9443c01a7336-2951a4d8357mr219816585ad.29.1762242532015;
        Mon, 03 Nov 2025 23:48:52 -0800 (PST)
Received: from [10.249.21.117] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998893sm16411545ad.40.2025.11.03.23.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 23:48:51 -0800 (PST)
Message-ID: <bd1cfdac-16ea-46d7-ab97-989a2d3ff203@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 15:48:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] media: qcom: iris: Add rotation support for
 encoder
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
 <20251031-iris_encoder_enhancements-v2-3-319cd75cbb45@oss.qualcomm.com>
 <1d653876-2df0-4177-8256-00905148fb46@linaro.org>
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
In-Reply-To: <1d653876-2df0-4177-8256-00905148fb46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2MyBTYWx0ZWRfXz8lMrUv62yCG
 xEI+pd3j9oyMyvLVgEd8QOnjGolFW43saqfxfp9Mz50oQuZrIcLrDDX8yr5POlRpIJuhfHvcrKx
 wmnuEftoKM1fR7zMcNNKhg86FRKS7zMDkZKxMfWkV8YF2xx+HSOHtLrnqkPcGSESmbxjvfcm9sE
 8M2L4P/eFndBbi0vxZoATq2XnNANpcc6jWwLaJD3q3K6cjOBLsnLVxMTz30UsQVrW/S0dWvdTAm
 SxUjC9gGT9AuefRCQ3kKt2+csZGzgsktS9//kFwMR5kNaml9X2o1fdyG9T/5WOb/581nJyurHog
 UDlWncNSgNJ5UN4XIuiJZDqCuNGyVigDMTan09k3PAxFlEnc2rOBxM1sBqSVptK8APXibJ0lLTS
 aklMKOJVnwh0zwYPXF/jcbZiU539ww==
X-Proofpoint-ORIG-GUID: Q436TuYLZHI0zARaL4dcyKg0ULZsYjut
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=6909afe5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=P3cjl3EAIghPSHLTwM4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Q436TuYLZHI0zARaL4dcyKg0ULZsYjut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040063

On 10/31/2025 7:30 PM, Neil Armstrong wrote:
> 
> I found the issue with SM8650, you did not update the vppu33 variant of 
> iris_vpu_enc_line_size.
> 
> With this:
> ============================><=============================
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/ 
> drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> index be8b8588a39f..4a4fbcbfdb46 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> @@ -1082,8 +1082,8 @@ static u32 iris_vpu33_enc_line_size(struct 
> iris_inst *inst)
>   {
>          u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
>          struct v4l2_format *f = inst->fmt_dst;
> -       u32 height = f->fmt.pix_mp.height;
> -       u32 width = f->fmt.pix_mp.width;
> +       u32 height = iris_vpu_enc_get_bitstream_height(inst);
> +       u32 width = iris_vpu_enc_get_bitstream_width(inst);
>          u32 lcu_size = 16;
> 
>          if (inst->codec == V4L2_PIX_FMT_HEVC) {
> ============================><=============================
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
> 
> Neil
> 
> 
> <snip>
> 
Thank you for helping test on SM8650.
I indeed forgot to add the corresponding changes here.
This issue will be addressed in v3.

-- 
Best Regards,
Wangao


