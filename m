Return-Path: <linux-kernel+bounces-897344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442DC52AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2B50224D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F726E706;
	Wed, 12 Nov 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZ0FyE35";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gcdMsmsR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8813959D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956051; cv=none; b=tAlnfn1ilExcv5Xqn8ElqlEwEWYj8llnSsvhj+MCD4uSM7GMXG451do0Bv4KCmEcuAFTGmAGu04/z9fnvw+lqSgJVPYtnZwXvsCQaRnDIfwr2Dxhepb1jTJBAfIuVfFfFHxDPNpUiuMeA2QV8XFRqZvgBfgybQgNWXFI07BHuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956051; c=relaxed/simple;
	bh=yUVoXexaOub7BTb7gu637I7PFwYE/ysxkVEIn3Z/fRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3pWMnH1LKInVhRY7/KBL/ZDL1vpkE9L8nJtn/Ic6NzLs7reUN9aK3SVdj/ufKPTXx8/fxw2sDXGJDt2eJIFid2aNii6ygj193Y1CUtNkWEctIgKgehoffnjc2pcX3aA7852q0cFCPg4sDsg0FnMcYvAigTaKFKMRO3VqFOh63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZ0FyE35; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gcdMsmsR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9fTOJ721947
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=pFBpxvCThnvTjNirIlaCiwpE5flozd6oDfK2MM6c4Bc=; b=YZ
	0FyE35DJvhsctetv+GZA8d1/C4lvdQEfA3egCJ3nsIXAUrl3WEDcaAMK+tCUm4OA
	W1F+D/489qT7pQqR3I6pWkn4gh19aYk2pU+kxaxo6DbAnnCQHz3/CuqVZXCzVn+F
	a7zHSSYvd+gNv2I7a6UY6wG3QYrsMC4Noogdaa/yku6pFWVMVIYo3atzE9I3agug
	LcsMu2d/+E7xQ/etXeTThjfgRMtIFMoDmHSngwc/h4GlAv9txoZA+ywdtkMXPri5
	4AbQgCCfu4sZ1b34/Eu2pniR8jzlwIMuxn/Im0+QRsSfJZ9nrvlLEvIcsOE2t7CD
	1oKaWhHhbMdbZv/MSWrQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqu1rscn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:00:49 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45066f4a4ecso1271004b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762956048; x=1763560848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pFBpxvCThnvTjNirIlaCiwpE5flozd6oDfK2MM6c4Bc=;
        b=gcdMsmsReib51q/TWxJMGRquUb5WKEQ5KUa4C4vxzzyw2v+IX4eFZcYio755IGTV5B
         1F3QBrMf9nHcaIXtCvkOoIZL0Q4VBh2Mqgp+L8JW+DTq/KS/B73gkAwhq3Tpx6M/Up55
         BwpO4qxkDNm4XQ7W5hieXg/eQ/VwlmRRxuSqQccjZQyltG4bIuA/52DDR7dtlkUdCsv+
         O3N3OhtLtG5xFn7LxT0Yar+zwIJobKNF7QXNdsq8QvSOq8xYjbFawcp7E7ntBZ63j8G+
         6qV+xuaaZqBypP71hTivMceCUR4N0D1CrkvXQAKzsdtSj3clnf50Ky/nU6RveJrD5dGA
         P+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956048; x=1763560848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFBpxvCThnvTjNirIlaCiwpE5flozd6oDfK2MM6c4Bc=;
        b=tXiUZ8oEX+Ah5z6TttBd663Jo8aXb++dgve4RM6aZdgGfId9VC0Q/kAHJz6G+zEpaq
         V5PXIBkxPjWmH+sdYsEadgpMYYwLjhxq6mmV6muqXsz/FmWqBO7KQsxka+N/9ov2z7Dd
         Qj0VLdGTrtmkcOROsfBBAATa6/Z3kdR/3xrnpG/UZ/5Miay7dK29IpGcwAjnuIbsPP3p
         CLTY0bhSVeFVuWODOcg+j0aBApR1FMShPG+My/4o4PJOW72n63w6ilZZh/KC2+Xua/s5
         oD31GtCxxSDVZWMc8z1BFIlkA+OMB2VMjyU0fWx8DGNxetDeqHSos8Co4+KORN3ZSq0z
         9PaA==
X-Forwarded-Encrypted: i=1; AJvYcCXyMr8rAiTOSd317oLQ6+2BPIx2cinNeMAEbLmY2bexOBmx9y7b2oDakxqAyz+69CEBpx3r3qBtIooqOXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNXaCFPAKYj4nFb6JQbkHmoWU6varYKqBfT9XkMEcR2c537tP
	xsXtMW8ntPkEuGfYnK/VfPt5e3YUVMRRgZsH+M6D4vCJ7N/yASmYfJ6WyTqixkhg7Mxu59xPusE
	kgDvGQsSKlmPIWkBHyH0zBjPaS/lqowNawe3YQ/lYFz1GTlQaWiTDVXiTOv7C97k+USyEHDzMoh
	hCEkne+QPTKr3o6w6mWvC1ve4UZ9e1W9EYZ0opI0ncoA==
X-Gm-Gg: ASbGncsXLedzLB0JpHg1Qt0c1VFGTDsxvNlKEo+O+P0HrgrG5dKQwAWRKj6xxqa08fu
	DCO2gGaKR5Er9ssWtikO/9U7YCIyFO0xTw0zTOn6obQxDn949KPrnWXhbGskWf0RxZ17etM/Enb
	g+DszfL8p84gX5PnXJNrqWFEjN95U4TGV6ARe3WcyxgVmwlKxXLzLWFsJJ/6Qcm5zGTvAaYUKCl
	z4wbNlG/5mpLL0=
X-Received: by 2002:a05:6808:1b12:b0:450:507:c77d with SMTP id 5614622812f47-450744c0bd4mr1438120b6e.2.1762956048306;
        Wed, 12 Nov 2025 06:00:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH96c1EnT3cd13kxATKATzWmWR3BVJ09jffO+pUV8+0w4fuulnyNcRl+pIMD8xQH7UGqOY2SEAhMOOnfhadkY=
X-Received: by 2002:a05:6808:1b12:b0:450:507:c77d with SMTP id
 5614622812f47-450744c0bd4mr1438095b6e.2.1762956047813; Wed, 12 Nov 2025
 06:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020113708.7403-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251020113708.7403-1-hehuiwen@kylinos.cn>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 06:00:37 -0800
X-Gm-Features: AWmQ_bmSomh-Lqktfo9-_yIT0yuHH5MOogLEutWFwCLiDDcs5TN9J_P3zC898No
Message-ID: <CACSVV02vOhbW9U-9ZAT3QAh8ZKqr1vyO0sQY7CDRAGrwM997NA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix NULL pointer dereference in crashstate_get_vm_logs()
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: dxAC3B66NPXh4u1CDOS4T8ZjECcV3mUp
X-Authority-Analysis: v=2.4 cv=Hpl72kTS c=1 sm=1 tr=0 ts=69149311 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=G_YO64yXUFrr-ST3v2gA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: dxAC3B66NPXh4u1CDOS4T8ZjECcV3mUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExMyBTYWx0ZWRfXxJMlR+qia4+b
 Li4PavDfKFKJX7Gcy0T5I90gxsOL/m05HuK5vVikxtbBfNqOoyQJMgZwQvyx2boDosfA/f1CKWn
 Cbu762bVfKqhpZvwp251nfnqvhCGVrZYI8ZPAyiRwf6Uz+LAokseJSb8OdFXhQO5hoUsmhbIJHg
 V4l6kjjbzmL+oOQo33M42IRDfyqAmY0nR7Or5JPu6ZE5iE6Vq0DFWrmwBmqsNexjJk+PhiRBDGR
 NKZhmCiRX3eRgvjZvH8CreaBXwcWFpE0PhoPkK4kPTFu3FBLPGGTMUw8DZqrf33+QwvDwY23+fW
 ERPMMoJc/j4cV0KtDxKiKE5ndYiGgv0wxI5fOYnsppm8hS3EFhF34VlDr4NFCnSOik8kyxBhbXT
 QWsYIDdM4Ep/oVmWHTjXtwoCWri/Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120113

On Mon, Oct 20, 2025 at 4:37=E2=80=AFAM Huiwen He <hehuiwen@kylinos.cn> wro=
te:
>
> crashstate_get_vm_logs() did not check the result of kmalloc_array()
> before using state->vm_logs. In low memory situations, kmalloc_array()
> may fail and return NULL, leading to a kernel crash when the array
> is accessed in the subsequent loop.
>
> Fix this by checking the return value of kmalloc_array(). If allocation
> fails, set state->nr_vm_logs to 0, and exit the function safely.
>
> Fixes: 9edc52967cc7 ("drm/msm: Add VM logging for VM_BIND updates")
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index 17759abc46d7..51df6ff945d2 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -348,6 +348,12 @@ static void crashstate_get_vm_logs(struct msm_gpu_st=
ate *state, struct msm_gem_v
>
>         state->vm_logs =3D kmalloc_array(
>                 state->nr_vm_logs, sizeof(vm->log[0]), GFP_KERNEL);
> +       if (!state->vm_logs) {
> +               state->nr_vm_logs =3D 0;
> +               mutex_unlock(&vm->mmu_lock);
> +               return;

You could simplify this by just setting state->nr_vm_logs to zero and
dropping the other two lines

BR,
-R

> +       }
> +
>         for (int i =3D 0; i < state->nr_vm_logs; i++) {
>                 int idx =3D (i + first) & vm_log_mask;
>
> --
> 2.43.0
>

