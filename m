Return-Path: <linux-kernel+bounces-773524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C6B2A137
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482785E730B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341EE30FF29;
	Mon, 18 Aug 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CRbbCsbo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9783101CF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519051; cv=none; b=aYJxEpsWQENTnNFXLRxvL0f162BQQu+gizPey9JqflywnzjJjxLhAjSRBit8wheLrFuE02rtkzX9GvwLZEkZQ6BoQPjyK45/bvf3U8rml3KrL1klbZaRUDiW6QMwgLZZWey+fCA65y1BaKKscdMbRQCDiqykfycFSuwMtnADjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519051; c=relaxed/simple;
	bh=ntj8WCLKC48E3RqrJqdwUp6JvG6kd4zyY6tqV2E6kIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbZlS/Cne/OVOqRPl3/eYty2sdf+9iYWSusHLfMHAVWbNNVLjpKh7pU74EFw98t/gfeHwQsdXFgxXD6rCEuWthZWAMMvoKzW0VhIexUui7P7pEes6PZ/cXBql0MFYjqB/7NQNAjftGEpSB18TT0FjXx86aLRdal2EBSxqLp5eRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CRbbCsbo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8Umaf026299
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hkCumoRo2vdkK1vJUdNAG8+5dWwDOOe6LmYrb1+L328=; b=CRbbCsboCmEeSV5G
	He/9QKkQkSmpqBbjylTHOsOuzhgOf2ZhdMWXnzJfyK0gPTKGdEiKKsTzy0fg7u19
	EByc/RZlQ4mD+wRAmk7W90I5z3hSLiS/Pi0/aB54nJLnE0jtuzkfP54FVMJQKB0L
	cU7oU/ydbX9pbuGUsGNDh9ExK4dqWRDWUTanvWQLQHKzDU297sSq/kyGCldhQBda
	UwOSozM4LuL+lz6hT55a5NYtIwLq9wGCYv5z3XaEUDeqIaGBCt64A1NclTy4zx/U
	a+QHWW069SO57XSNorziTvrd9Lx3aY/TcT/hB4CsV+fl3aPJji/sZXS/coxL0K1r
	P8bdQA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfvk69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:10:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458027f67so96856665ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519048; x=1756123848;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkCumoRo2vdkK1vJUdNAG8+5dWwDOOe6LmYrb1+L328=;
        b=urvEIlhFT5nCCFizKC+nhqDvEUvXPrblkz2prVUbbB/giIT/xDW11Wh5Y1kEzUC5KS
         MGe2JHODqyexY2PbiUc3U4ukGsnmv5mYcIqJfBvHg4F4pwlqPcM97x1EweV+1JaDMSQT
         R/ndYOhOdWuzUOcxuMrHHjTa6k+XKdyFAFmYJxb9GUSp12jcfZdyAH2r2Wu4s5+5WH8B
         6CjpkYYR43xnD7gRKn/wZfBr00o+ShcF4Y8UGxaMrvOJ0H7PlG8YWiKn+lUMCcZOjY9P
         qsen4HNh6lRaIVosBs8zBJOdmuGV/qn6mWQREP547zAZROfZm8w9UARkSmyj1bfs6HL6
         /LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc1aVG8IOSKZRCIn0jc/39zOE4U72bwmSNq8JR8P7i8qLrUc2pA9kLOdWSliVdCWlB3+ozkanN1mVrV0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBLdq1Rf39QV+CvVWrW/xHW//fhU+EUNEjbsa8pZhtkZvF4JD
	GtkpTY60OleLIdXg9RBTpTF/uj47avS1HHXwc5ImrMONJ064CEhHFBjpescPmbS2NuI7mTTg6kA
	JyD/TMYOm3Cuwe79QPM+h01iN7lzQk1VJu+8SfpOlkBr3jAL2v4juJkE6hCBAf9VdoHo=
X-Gm-Gg: ASbGncsNgHaPk2aJRnxjTVRpEpcE1B1E0nHFRoLbPUPVGBarQg+60pXEuAsFkNCrjB2
	1Hne9irRLYdmuy9Em85z7shPhQLkP2GiAWUOF67SY4e1aPEOezFuHXOu6ZAqgzYBLwHwT+zEZrL
	YPPyU1znyUXWfAgJKIQLxVfLk41XA2+bkHyv1AbhUaU1acP4eOd5viHzFsq2jq73Rb+zdFnLGie
	eJg0G5o5QBqi/ycwOEQfSfjJA2nD9aGHW5fZIkPOtL+7WSrwT/cmgTSrOih+gT9yGGXXktjL1l2
	An4/UWuV6scjkkwsd2XKRDGzCyA4h27jTH3W1B6S8pOF9IsCOA7ioAfrPS//Fm3y
X-Received: by 2002:a17:902:d4c6:b0:244:5cde:d384 with SMTP id d9443c01a7336-2446d85f7demr181641495ad.31.1755519048381;
        Mon, 18 Aug 2025 05:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZONzJWFtT1XNEyRK6xcm4gebbokS24vhl3Ky3z4naJfpk4imCqD/UHpgAJi8OHvE0+TLUjg==
X-Received: by 2002:a17:902:d4c6:b0:244:5cde:d384 with SMTP id d9443c01a7336-2446d85f7demr181641135ad.31.1755519047954;
        Mon, 18 Aug 2025 05:10:47 -0700 (PDT)
Received: from [192.168.1.4] ([106.222.229.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446c2f441asm79279165ad.0.2025.08.18.05.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:10:47 -0700 (PDT)
Message-ID: <272d2a39-19ce-4ac5-b3c6-3e3d6d9985c5@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 17:40:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm: skip re-emitting IBs for unusable VMs
To: Antonino Maniscalco <antomani103@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250813-unusable_fix_b4-v1-1-3218d166b8a8@gmail.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250813-unusable_fix_b4-v1-1-3218d166b8a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S9PMBSqlfzAmAgeSzWZNWO-_lAenk4qE
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a31849 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9Q8gPALlkHEzzDxkdHlyxw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=b798ue3nI8IKDaXQGNYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX4AxtMXko4rc3
 gWezlydP+2Jm6skFTr8FPBKNCyEXvYc1fLh/zCNN6ro+Om2MaIMVx7KNC7slmGTFD85rhr3e2pS
 0ULBSr5us40YJTco1ph5xTeUSjVDj2JraSYjnHVsfwhc1lyvAK8j4pqw56xARkc/E4Rfadg4r+b
 /jPphTw4mInSp2fgiaPaSfJJ6odXzn1KqRkYVm94JIYNg+iVDi8fucAl+O5xGYF/hjCELE4Aam6
 QNqI+qiBamVO2APkmUaJp01x5ZAeTs8LJ8ML6TPUUxFPjqWOSYUOOTw6YgH5AjtvyteuKoVb7T3
 k4BsdzoU9hH5QDH+r7rIlgfYzdXwrDmtDwX7RQ/8tipYaIEIJaQHaDXgKVr2y1+MwSOFUluSvus
 4ppbzT0l
X-Proofpoint-ORIG-GUID: S9PMBSqlfzAmAgeSzWZNWO-_lAenk4qE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039

On 8/13/2025 6:34 PM, Antonino Maniscalco wrote:
> When a VM is marked as an usuable we disallow new submissions from it,
> however submissions that where already scheduled on the ring would still
> be re-sent.
> 
> Since this can lead to further hangs, avoid emitting the actual IBs.
> 
> Fixes: 6a4d287a1ae6 ("drm/msm: Mark VM as unusable on GPU hangs")
> Signed-off-by: Antonino Maniscalco <antomani103@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index c317b25a8162edba0d594f61427eac4440871b73..e6cd85c810bd2314c8bba53644a622464713b7f2 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -553,8 +553,15 @@ static void recover_worker(struct kthread_work *work)
>  			unsigned long flags;
>  
>  			spin_lock_irqsave(&ring->submit_lock, flags);
> -			list_for_each_entry(submit, &ring->submits, node)
> +			list_for_each_entry(submit, &ring->submits, node) {
> +				/*
> +				 * If the submit uses an unusable vm make sure
> +				 * we don't actually run it
> +				 */
> +				if (to_msm_vm(submit->vm)->unusable)
> +					submit->nr_cmds = 0;

Just curious, why not just retire this submit here?

-Akhil

>  				gpu->funcs->submit(gpu, submit);
> +			}
>  			spin_unlock_irqrestore(&ring->submit_lock, flags);
>  		}
>  	}
> 
> ---
> base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
> change-id: 20250813-unusable_fix_b4-10bde6f3b756
> 
> Best regards,


