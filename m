Return-Path: <linux-kernel+bounces-877388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCAFC1E00D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C61718857D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E127256C89;
	Thu, 30 Oct 2025 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UNhLPD3i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ykna3OBK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EC22576E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786901; cv=none; b=WYpCqN27EEjCNmCubZruzLQkUDjKZ3Qn1NqcnJ4+JLiDXXBa4KcqvHGTY/GzHKpBLNHmB7eiuATAxB1VtuCSPwbtntJfko3+bwXA7WChH9FDR11inCOxQLvGTVBRJrxGsj9tTojZdtJe6xP+SG+sQSuV6TRJqgsmH5Ji538DOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786901; c=relaxed/simple;
	bh=JcdsJObsCPxTej1TgcKSkDEbSvqlt1gBALjn2o4FudM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGx7p4uPYPi3FLsZj14F2yJXOm8CawShg1lFKOCI2snygMtKT8F91rrZEt4oM8mpKzX7m5emTSK5Apvb+b6cwqhYrDgoz5dnNjxRMbl5SIURljxWs9rH/brd6pEtUP8GkvHjKTJgUmseAL9vOQIBqDvPWDERv6Xa1NyGzjAFLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UNhLPD3i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ykna3OBK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TIrcdB1324771
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uplEjRjXn6n3hOHodOMA23ldjJzjv7AtZodGTNnhxNU=; b=UNhLPD3ifF4rVwn0
	U14gbgxpacljiEatqxFgv7arZ1DtzgLkh+a772vfZu4Do0s/WPan7dRUGMxSNIWn
	kFahZe39OKUl+e4t6CUcctsUdzjEAWcmK+vUjR/wSvCCFPFMAWOr25/UtwSu1aDI
	Ty/eCetrIlJ1wsF+NRhkJekDfb6Cv114Y8Akrqa7mKAvsHKIsV/rhDYBH8d+0cnt
	n9sTvpyejez7NVUkmYgitTPYWGmC3nvB3A/aemlTfHulZhfyZxILkLKHsvBrmQC8
	/kroevwpUQMeisdshqJ97Akby2ITYjQWOuouHrEzRO5gZpRYqOCQF5hRIHRneTfU
	jCkLug==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3rkus0e0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:14:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-781253de15aso1134008b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761786898; x=1762391698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uplEjRjXn6n3hOHodOMA23ldjJzjv7AtZodGTNnhxNU=;
        b=Ykna3OBKtRI8fP5DNtJdHCVMNnfOyngWPVGRsPF9mQasS4OJJcM7/Q+VuCKiAT5mtL
         7RF3Pm7So3CUKgrdLLKGt4rh38UXuvXvwiBhvp3mJ0iS2DvE5z6AjsQqQ15Fe1xsR2qA
         9rTOvTJDYRDxxbPF6pFDsR+lR6NHcYye1kQiG6MqveEjM7gIVE+g7zF23YEsX5drSi/B
         XowQaRMcl+UVqsyJU23+ecFR6ApJqg6u2diMTH5M9QsqnTOkn81pU7jRJ+kalxf5N/Ae
         xewLA3WZAl7yQd/BbKQg9uEGcmrTJ4+a6l2ELPnTbIGjiO+aBmfk/YIUksbNmTm4J0d9
         Fmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786898; x=1762391698;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uplEjRjXn6n3hOHodOMA23ldjJzjv7AtZodGTNnhxNU=;
        b=DHiADgJovmg479GaTPzDY3G6lOZ/8KEnnTbyhI7CZpPiV7lHeJZ7nfRo3S66HxvYWu
         NoJjlOiDSnk8ZgD/WnA332a6mlo6IGDf6Z3RdmOobXVP2tpRxJo1hKxrL+wMnDOxOzv3
         uOy5g20C/xRK9UyUDA/mkOn7oS9wIcwKAuO9QZ+Qaqbpud8oc6b+j7h75NRRQE47eaZm
         Zz+Le2s6SjHue3ADqrDaWtOxeuCrHnSNyFK1bvjaZ3V9T65oxACRkh7BdClcLMSH/Gxd
         UGwJZv1hLbVUFnEJHMSq5CMUR1M2nnYhaaIvuVCVmGuGd/mPZEQ+z30BaoswZi0wbDax
         IN1w==
X-Forwarded-Encrypted: i=1; AJvYcCVWFgegvPCzYQQ29In3EZrj8S420umSwyydgiSre68b7paXP2BPS8LVvSQbEeclRiPnhFpwF1t/NXi+poU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7+B9Kq2x7turDN+JivIKb7cB+oJvzhUDQW0vHarZV6jkzzQK
	H9gHhksOqzTZw0Dlb8pGGF1AEYBv8gM9HoYnzDU7bRFQmxg1V0AfdLcs+H0CflumWxaTsdJlX/q
	kNCBgiAF6sSBZn5hY0TDgZjPQ1X4ZyIJOCvgAFVVITxbhm/AflsnJlrjt/GW5XEZffxs=
X-Gm-Gg: ASbGnctFamOwWtdbUhiaW954IaXLZyz2/shEfag3U2YGBg/CM80GmjGzNp5tfHiXEqy
	JwnpGwBuS0DQhuEs4EUCpIYHRwCRhX/emmdVI/cja9C0DjDaJXoMnCTN2fyNjKKHASdKxCFvwIG
	qqmE1Qjp3qPtCtpPQHeTmi7VKGIdqLMZFXUbJk6Tg/moDkh999AbVBgNB5wriFtgdBFWLLkrf90
	IUPhy0eVhjEyiveXyiM+LX0aEIztnHTBP9UqNdVmMLTUZcI6Jgez7m63BS+MJDUamMKGXhYIe25
	sAKIbtBRQXgmbWYirBewZmfLxf/eRuYgUpUh831RweOoYNjeh5bMSJi8EoK+FtPi33zmUT/FUx2
	/JtHJBsNW3frLpgSO1rlXsf08sUoZTx/OLx9KXuRvHJQBlEt8a9/jLaothZ0uSJZB3oCVa2Y=
X-Received: by 2002:a05:6a00:4f8b:b0:7a4:f552:b507 with SMTP id d2e1a72fcca58-7a62c6948aemr1423131b3a.25.1761786897946;
        Wed, 29 Oct 2025 18:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxg/gaMbHhmdQxq/ivXimd6Kc2sCy+uCcSh3cAwCWaFK2lzCgf5JPs9bcpzB5W6omR/iGAbQ==
X-Received: by 2002:a05:6a00:4f8b:b0:7a4:f552:b507 with SMTP id d2e1a72fcca58-7a62c6948aemr1423099b3a.25.1761786897435;
        Wed, 29 Oct 2025 18:14:57 -0700 (PDT)
Received: from [192.168.1.118] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409e456sm16519817b3a.71.2025.10.29.18.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 18:14:57 -0700 (PDT)
Message-ID: <83c8504d-3159-4a87-a1ea-0fef46bf6762@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 18:14:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the ath-next tree with the ath tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Ath10k List <ath10k@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251030113037.1932c6d2@canb.auug.org.au>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030113037.1932c6d2@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2UFstf8XQGKaloNK45dgPhsXxc3nRDwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAwNyBTYWx0ZWRfXyojKWOm8VxYX
 yf5qvCetJqhHUZZBx2/0BPqZYbKRT83lYpe37FnWsG6bbtXQQmOdtTdhgjgPLA80XeUig59/f2/
 JRpQmXBn46+G6RKH5KfMCUryZPkSA3fLubnu4nRNcwQHnBATOV2Tfi0TeAzf6EshXnzzlT3Ei6o
 yZP9oSsx7RayfSxmuXDFmLhBxr9088S4TYZO8XuF8RQB7hvB9sm8Zi0Sbk16k5B7YqS0rPYhs9b
 ofZ7/MMRQTPXGPbNuhL/Lr9l+7A4L14ErPgIsw9HRt3B9Yql/jDor7iyEM8qyi40D6WUbjQdO08
 PIp79tnE0elRcLqbejXsupCpwF8VOC8GOj9oBFxkp2EGLI/hrqC5XjQ0y/fSiAPBTToTvKpfv+E
 P1pARpLQl01B7msZDWG1jn3vKN3NiA==
X-Proofpoint-GUID: 2UFstf8XQGKaloNK45dgPhsXxc3nRDwr
X-Authority-Analysis: v=2.4 cv=adZsXBot c=1 sm=1 tr=0 ts=6902bc13 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=3sE9uRzZUefYBai0eU4A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300007

On 10/29/2025 5:30 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the ath-next tree got a conflict in:
> 
>   drivers/net/wireless/ath/ath12k/mac.c
> 
> between commit:
> 
>   9222582ec524 ("Revert "wifi: ath12k: Fix missing station power save configuration"")
> 
> from the ath tree and commit:
> 
>   6917e268c433 ("wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon")
> 
> from the ath-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thanks, Stephen

That resolution matches the text I've prepared for my upcoming pull request:

Note to maintainers:

There is a trivial conflict between two patches:

In ath/ath-current:
9222582ec524 ("Revert "wifi: ath12k: Fix missing station power save configuration"")

In ath/ath-next:
6917e268c433 ("wifi: ath12k: Defer vdev bring-up until CSA finalize to avoid stale beacon")

The resolution is to take both hunks, ordering them in reverse xmas tree style.



