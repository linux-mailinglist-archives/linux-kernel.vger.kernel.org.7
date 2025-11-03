Return-Path: <linux-kernel+bounces-882229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993EDC29EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463FD3AC2AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B42877C3;
	Mon,  3 Nov 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ae4dgChw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4Vp7T9j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C734D3B5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139660; cv=none; b=l79FV0z17P27y27a/+BIQIkN9Ugloixl1IUy2WutQZl5I0deT/xE5hR+UZfife22A/2fOAYC5BM6lReFbBGnc1+VX7h2y6+VngOsS2AuuPcJvkdVhdF7vxXTMz4Kzqm60o5+8KgRKxcPFlmRY3ad+q4g3p61owvY2jnVOW23+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139660; c=relaxed/simple;
	bh=QSHEnqmFKvho/lEKyHzgFR2hs4DL+DjIGG9CxTxpsEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLvTS77CF/s/7DiA1x7LZNu5rJBGmMGJplRlZzCAI9dH5Vvzn0bvxfY4OvCRFI4c/l/Lcp/rThQ4YdRwrj78yFOMDQRO7rWl84KO3atRWDCjqQGvFsi/dnuuIB1d9i9yT7BidE7m8ebEIPjv4nN4ZYnPPI2eY30nJELcpOhBIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ae4dgChw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4Vp7T9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2KDWGM1108817
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 03:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FcCvOyYpj5kIxZcWJPVz3ndDcWqWgYyyK6gtYhwd2B4=; b=Ae4dgChw2X6r1elT
	jMJK9GAiS2n+kcmD9/HMohZDjKahoCyoYkd0RHKBnbIlg8bTGIXxQOc2ZwqZ/VZi
	eX+24OH/xvAX3x9RUnqcVEVElNPfN4B/O53zW0hbQAh5ewLlygCJlm67pwljiF29
	Ry4s0gggPiXOOM8VsoPg9WVFY/mNYIadqhwl9/qoAIDRGN1zEHOe3hPKbTWA+rXw
	88gwXqqLFuxCx+lQx3acCGhe/72LfOOGtZhDteXkbWqxi+IKSCXkdTO+9bH8MH5d
	uYbLf6y4BbXEvpiB3i8d5T3rPVZMseAO79bxk/z1c/i4F4F2ZaUD1n/vUACD6sVE
	FzI5SQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ak8k4fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:14:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956510d04cso13872285ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762139656; x=1762744456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcCvOyYpj5kIxZcWJPVz3ndDcWqWgYyyK6gtYhwd2B4=;
        b=Q4Vp7T9jpwEGxWe9NQaVClnkzTwFDKvnl+4WpO/3UsGiHVaHvNIaQRRkUqqmfrgqnS
         7jC6rmPwe+YSyLo/oGh1HdoQ9UVh7d6qIWXww+Eqyc+JF07xheZroE8tTvJZwBTdh00i
         aZfg2wl5rGrM1fGLRIURkRA2M1rSJpRNmriNnrgwQdujuxVxsuutjkvzSpUb6e5rDTsT
         Bi270++avZf9SxqnqgaLCCIEv0GUHxGBcJISEJ+n71gbKN/Bb0Rej3ZKLqAnaGey4jq5
         l71/CItXrzmAYlUkiEdDqjyvt67vg1WUkRiM7QqLZNV9byl+wPNQUDvjDC+dOdnGqCN2
         KTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139656; x=1762744456;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcCvOyYpj5kIxZcWJPVz3ndDcWqWgYyyK6gtYhwd2B4=;
        b=OJqPwriFUex27IORGiUyUhwsHCttf/HTFDhQ+8x/UZi4mZYLc61VRH6KPwfa9jFYQ2
         6MfgW/nIEj5bsRauz8dWjoiBNU0v7RvUfZMVbwqGrAbeT/OpbYN6ILfjf/kJivyZJyhM
         VhCNFshyA2K8d59JXIZTer0vvrcHAuv8XSdaT5AuRRMrlelHFIjTD3CtLIGVOXJ7iL7j
         oKcsWhCUKHCuw1WVFd/DWs8mShOjBetK9df5TL/iYn/C5M9jbMNbdWHamjKQIZtRcXgt
         4nlBgpniLeCaCoFI77ldQ5SXHKiZ7nJm50qFV/tQmHFWsIoDQ8d7UrrWnQksQ4FVZ0jY
         ME8Q==
X-Gm-Message-State: AOJu0YyWBK2+X6aVaoT2U3jkeOFf+5eKrWUqKna3DpcmOQbuBIMSgM2E
	ZnPY34ZXhVfuBHJaR1JfiEziyqg0iG/7TTfuOT6EWWZi9yp+fgeF00IoBYF8oZQq9W3emqmWK/v
	no0uEq5sWcOfMax630o8pb2buVHIjmHiGA6rRcO9EJp6t8zbhly3mnaV6r/97Y5Dx8nM=
X-Gm-Gg: ASbGnctJHxaAqUOn6b8t8/BixvJxnATwu4nEnUxINUB8dQX1/bgG0E5kDKqNYdeJKmm
	GXpgZDMF/Hgaleh/S1EufXjdzJBB8JwHFTQzvjPT61MnIiL84Cw2bOcTVpIqdftKGoGJ6FZy4/o
	1xQmBNOPoZZvX2eFFKKb4aTRGmyefbVmnZQlsR757N/hZYHdPsMO13tmfywfaEwzE3tIrYGMDaF
	B1OOzl3DP4p69HYwcj9oGG3gcoKmJT3w91+z3KCk5Ol8sUdBCVpg1Uwy7L8Rl9m4sP3yqatpXiV
	09UsZk81hkTxhIe+9Xp7/RdlImlnawEIo1D+0jKAgFhAY5+QXZzaNxlWHjuo5n+a3qpwchGdZAD
	HaFpOfIFFcTB3wRP9iRCvtvts2A+nNs+AyVi1dtdeQdolND+pBrQQ3p4QrSl4Wj50MdGiTtY=
X-Received: by 2002:a17:903:2f87:b0:295:615d:f1d2 with SMTP id d9443c01a7336-295615dfc5amr74639555ad.48.1762139656404;
        Sun, 02 Nov 2025 19:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4++0FISgdbKE49ZuiNLI8Dj0TWTNPlqyMmFrX5Wook5O8KJn7oUSf3QxBDSlk3adCE2YEcA==
X-Received: by 2002:a17:903:2f87:b0:295:615d:f1d2 with SMTP id d9443c01a7336-295615dfc5amr74639215ad.48.1762139655842;
        Sun, 02 Nov 2025 19:14:15 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269a8ddcsm99033685ad.91.2025.11.02.19.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 19:14:15 -0800 (PST)
Message-ID: <5d0e6d7b-d127-46be-8985-9be33a490aa0@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 11:14:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
 <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
 <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VjEBSVLDF3vzY7MOukpulyGJzAWA12rc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAyNyBTYWx0ZWRfX9LeJJKpoYNKB
 gMaEpXz6qbgs6Ny/M4LfhTL0vExyr2HyTCFRKZSFlrcxjnrDT1uYV0aUrEnDPFNnExAbmKYnSAu
 jJGrTnk1lyMiz3J7qRXi2G/4L3pgC5hyXy84PlpumIX2Kd7R1yj3Fm3PExQowJ4XcdN/EmCYiPx
 sSa6OP94V/mfjdUWK6bM8hAaRs+MZN74ziKOI+JNVteiQffum2DjuyQFSxn8gzcZ3ddOKYdA88m
 yjBIQ4zPovRY88kjIZddlJQ6wDgCIv+xwQlyPZ7bAPRwNDbl9PXbgHh0/eqHZnBcaPWzemDN4Wa
 +bR+G+Mu8lpkoIFKoRYiVCtoEy8e4lJaCv4k9zb5g6eYlPrBf+pApwe5nJ3CftMlbGdYmCtbBG/
 vxsnu2zuHFJfAx5AwuO9X6ibsjRFEQ==
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=69081e09 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=FMcQbdABRIzOJQOt2JwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: VjEBSVLDF3vzY7MOukpulyGJzAWA12rc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030027



On 11/2/2025 5:21 PM, Yu Zhang(Yuriy) wrote:
> 
> 
> On 10/31/2025 10:43 AM, Baochen Qiang wrote:
>>
>>
>> On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
>>
>>> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>>>               ar = ab->pdevs[i].ar;
>>>               cfr = &ar->cfr;
>>>   +            ath11k_cfr_debug_unregister(ar);
>>>               ath11k_cfr_ring_free(ar);
>>>                 spin_lock_bh(&cfr->lut_lock);
>>> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>>>           }
>>>             cfr->lut_num = num_lut_entries;
>>> +
>>> +        ath11k_cfr_debug_register(ar);
>>>       }
>>>         return 0;
>>
>> miss _debug_unregister() in the error handling?
>>
>>
> The documention for debugfs_create_file() tells us:
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> So IMO any failure to create the file should be ignored.

Maybe I was not clear ...

I was not meaning the error check on ath11k_cfr_debug_register() or debugfs_create_file(),
but was meaning that in the err handling below it, _debug_unregistered needs to be added:

		cfr->lut_num = num_lut_entries;
+
+               ath11k_cfr_debug_register(ar);
	}

	return 0;

err:
	for (i = i - 1; i >= 0; i--) {
		ar = ab->pdevs[i].ar;
		cfr = &ar->cfr;

+		ath11k_cfr_debug_unregister()
		ath11k_cfr_ring_free(ar);

		spin_lock_bh(&cfr->lut_lock);
		kfree(cfr->lut);
		cfr->lut = NULL;
		spin_unlock_bh(&cfr->lut_lock);
	}
	return ret;
}

> 
> 

