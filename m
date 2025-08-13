Return-Path: <linux-kernel+bounces-766441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3571B24668
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24C07BCDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6228C02D;
	Wed, 13 Aug 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9CaoIbL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5D7E105
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079256; cv=none; b=jcwJPy0UYOkzboTD3UKuh0C4UBpVuqc2p8aU3xLB5ojW2xTzMLiTT0VnaYMre3r+MBpbrUPs/xZmIOJK/4rE2uYoeSDcogys6JoZzR8J9ouf0zkENsI6DksahI+TwqYfn3aGLvaHvc8X4eYRfO8G5lS9a5enhLhZjSSjDght2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079256; c=relaxed/simple;
	bh=cBywqYQ571JjXH/CFVXtPZFVBnz+yE4lfUMvOMd0qMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAL4pm1j07ovOAQbqY3OoJOygimZQ/n3FOaNHb4FA43C1XOIHHB9v718kgSbfUVvwcurdVarsaexKwiYMAF5sd0WcvZJUt7jo/qmaBGpYdnufRKI6NQ9urZNACHMp8gKTyKC71Uason/h192PdAHvRIdn9Du9buoKHPMEhmUFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9CaoIbL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D9ewU7022115
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wiBWcdk24yow8RF3k9D1Z3F3r9BgHRGCWV7I+lbiN7E=; b=N9CaoIbLvjII5iGW
	91H0wJPvVuZVgOQHfDedopcJWkBiXmu0ICOQy8BWlNAMtuIFn76O9zsijrMcXWaR
	nGy1Lc3PT43fWeQIRxtPT/wUiLltdupUp3wNKpr4D6+EAXiXh4Y8inhd+D0CROS+
	QvyvLgiKqlvKBtRTXqbV1cO5t0dB9S9+v8yPwFXbTTPA6MgYB2fzMCuUCJvhmITS
	jVdz6J9Z8oSnKORIzJeeMhKraWxKcjqxlBdua9wfi2YinhduTNdaOnw1ZsZxFm7E
	EXQIckRprZ49SAJVNw7MUW0hmGfMqL2vtakcjWUxi7WJVzJI3YEFLDrBS1JssXgF
	zzOp1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rr1yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:00:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06ad8dadeso16288231cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079251; x=1755684051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiBWcdk24yow8RF3k9D1Z3F3r9BgHRGCWV7I+lbiN7E=;
        b=M/7ChQRFFyDcmFOtvoq+NP3kqi3JQlOOISRL/pdlXnnNsVogxTA7Vu1Z84yi61Vc0e
         ZUNX++OmT+AgHtSd1HE72iQSmdoGp7oa6AQvjoJJoHeNo9yMzXaoeXtQ7eb/rvauODTb
         edEx+VI1u7s2XjQTHRXU9DhCsZdpypfLzsX21gTxiSqsgMKIqvEXV2lrcd2nAeVt0daI
         zvv+094K/TlsFrrWQhww9M0DOqYdhB5Wu1Jc1BFmFuKUu5Txtq0nKKbzClUNjHxRKceh
         AO23DgqWe88xpESG8I+LxCtLzsbRk8eJsA+RzN7MEvJGfVSDsi3AI0qBQMIwOKhw3s1Q
         2Qfg==
X-Forwarded-Encrypted: i=1; AJvYcCWuymE5U66YmFIgUzLrvVwPHvEuWjMmE7RwVRcjW+TdK/lQgrODJQk7VC1F35N5VTjFdulQY+At4fk5vmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VvN+sDo3bVEtC1HhQYfDVddkfjR5W+/S2n6X9rLvFN7yLeFl
	dyf3G9pDA1wUjf1M475VQH7SWZ1NnWYtoKvCTM7HjcXloDR3y8g5W/7aJ3n9VTG4gzd1vrEiF1p
	2FOMjqKvG0WkBdiLrc3bIt7973yxftGuvWGCTnxObY77B51uToYc8vKbkWsqjtbL7KDE=
X-Gm-Gg: ASbGncty1x3RuGN1lfeQBeUjHkjuKRlpCt9NeIXNb25w+h0K+uu7xDXF6nUrx9Qf8mA
	39oIUHp6KgcOtG3O4Mh7vguiIUiyxZWT7mqrvsBtQUdb+psJTwko5d/o566I/5Z5vKp/Bvz6C/d
	SeZl5HrAUX27l7d9s7znnh3XVXOSKxOaJnhiffqOstYfvXsXEaZHND4plAljvI9AmTUFPgn/AgR
	waa4YeHLykL91QMYbA6umvFmJ43NpixF2ybSBqVFVvhpc4U7DHvxM/IzZfQuesmFalc4gtleQKl
	toiu+RMyO2bWtZBFjMmxXN9rhMR++wxBXgvnQT/BanQGuecwu7GpaeWHN3tmnXC02cmcBzmSP8Y
	5e6ojhnGeFK700R60IQ==
X-Received: by 2002:ac8:7f06:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b0fc6c46d3mr13966841cf.4.1755079251117;
        Wed, 13 Aug 2025 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmTrD4ySjMqSbwhalzXJcsozDXyEzKvaYMIjrNiNP0RSpO0suJx9JL31ZtBXBXWoPTlWVUaw==
X-Received: by 2002:ac8:7f06:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b0fc6c46d3mr13966501cf.4.1755079250541;
        Wed, 13 Aug 2025 03:00:50 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm2366142566b.41.2025.08.13.03.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:00:50 -0700 (PDT)
Message-ID: <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:00:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfXyco6F6cz7/UP
 DlNkbPZWj9hGchCW9rdcC0wpYUl6Ak1bAcXlZZZRr2uxKOheLZVM1ckmzH/vyZA5QC27c92Xk/U
 fNooxXZ+eiiVUNMdSfzMh2YSShlKWJ9H9q5rhoZ2eVhqcnioSdGIGr8gQcClp5xXaUORYM1J5Ez
 GQ0Mf50hfZRfpX7EWxHtj81QBua6JPYCAbG482kJEtNFuxuzM6WFY7KReGUEV3bjEKPNIC09Xb7
 vHg+oCFQHMDgVizhveKAlVMwaIO5aIa3q4MY5SoyMnXp3cEn/ucQkT66aRnowtasGIYjtuatHWM
 IQQ/7gwCsSIzCJ7EVAhOft+eGSX3SvkHU3vn5+6hgPittvOGnpGKEK6kuoJE7jcZ7lGJ581W/am
 nqU4uNyF
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689c6254 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=WNCivIMphfMWkbBb3CYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: o9skYh91u36xqWtkpOydZvFpEddGJjhq
X-Proofpoint-GUID: o9skYh91u36xqWtkpOydZvFpEddGJjhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Enable userspace to allocate shared memory with QTEE. Since
> QTEE handles shared memory as object, a wrapper is implemented
> to represent tee_shm as an object. The shared memory identifier,
> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

[...]

> +/* Mapping information format as expected by QTEE. */
> +struct qcomtee_mapping_info {
> +	u64 paddr;
> +	u64 len;
> +	u32 perms;
> +} __packed;

Please use types with explicit endianness, e.g. __le32. I'm assuming
TZ will always be little-endian, regardless of the host OS

Konrad

