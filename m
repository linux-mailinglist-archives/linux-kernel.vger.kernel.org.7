Return-Path: <linux-kernel+bounces-862979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A57CBF6B75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D045450449C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD04336EE0;
	Tue, 21 Oct 2025 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ggWKD7xb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84C23EA85
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052618; cv=none; b=LmaaHQun/eZfKwqA+x2bECQHKELj5mXCHPnKjjvf2GhKWEzKqYhAGSiB/mmshUsAwHt7lQqYF1iO62XH+RS/gF35VH9vKeTi9q2p9d+xhSKTckRrn1s1bWYVn4wytYFl47qc1ZRfu+dgs8PD/b1hjaH4BMaubdNvzTtTBeNfQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052618; c=relaxed/simple;
	bh=K16OiEvHLEE5P9JWPOOzxQz3iSFrMjRDBmvPteaRCZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MRorylBxCS3UITqBgl0CnT8WFYjPOiEQ27XHt5ntXsfWglIx7+2N8ip1/xXlRWBeczt9gUCrtMH8ruRiTQjWvMq6V1VbTrjM0BjGTUK+dme8VZPIGHbCH31W0jmWnjg7H/tmlOR/LN8Qoh3roAn36jpHykNnIN3NI2yjDMrgRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ggWKD7xb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8NU8g020896
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CWUXrVsIv5uz3Q9scHKagVEzhFaWQ8+fZVxGbgRHCdA=; b=ggWKD7xbnPIT46My
	o2uh0x8OE83IMoaVqSvP3ckUEpyuIpSsQ0N0hvFngTGHqT3fwPFTmeljg0l7qUui
	AoqH8cVwR3QpFnM4GxexA/KS3MZ0MYYloptBsPJ8WWZcRzKxRXLmvYHeYSzQqTj3
	Rf7VKgPpD6weY//7CQlkSbj5qolBIrNoWwIoOgnXfQMQEnFaDlf+DOzUvVuVNn8s
	qlBSoyJyKWE6rNYybZNVmHrEfSIchn0m+r1RO+kq99wlQ84N0X3CE39wEsdK+HCH
	gzPzK+jpqP5npbmaOS0jVt8ChW7Z9Su5uBDYCysNVxqR+Mt1DrdmTTxFapU3IU9p
	uj0rBg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469gpx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:16:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-890cb81b3dfso210537485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052614; x=1761657414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWUXrVsIv5uz3Q9scHKagVEzhFaWQ8+fZVxGbgRHCdA=;
        b=cuEuB1KExEa6FAH5NFG1VjBN7ExAo2xRQnDVmzAmRJqadGbnduKt59FhsJj9wbLdBD
         JwObuRY8luWt7ZopTFPXGB/Xa6hB4GECli600kmZ2ebKeBDhzt6zYjUAhARTXDN17tUB
         mkSjj54Uph1lsjF6NFK/MkL4lUbclrQO6F/19FCd/QiDILO6ZMjX+jBuwJwTMs/VzWoT
         ht6UZ6lrkOTMLxfAwMuIOPI4M8yTbfdma5X0UQ/MesqTjMlkwZd7oNODXKj72sve9lUg
         YRjfL+NUdHb0tlkAV0O4ivAel1xde77MBDAqxSdtQm3ZBwQbp5H2IswhUEoKJnA383sf
         a2jw==
X-Forwarded-Encrypted: i=1; AJvYcCW9E+lyFC7fS6FtHFrmo1a0SMwR73W5wKYGOnVRWBpOo2GhaG+9ryyRaiUt610UU89bz0bmWZK3aprace4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetWIjm2LufyLG6oiHXtZlSjGOjUusBgS850UaCqlUymSv1+ky
	rjxCrQqnYHcqq0M64xEh7/+qBrQFyRWMli+gy3EWvC4TaZC/4mRWVbdihaTNbuCo5ufTN+e4J6J
	h9uVETVTMov5r7cb7l2wZ6+/QmAFdKBMZpzR+jhS69m6W8umx/EsNkSLa5tdfYMwmt6Y=
X-Gm-Gg: ASbGncvHydBgR2y+WC7R4cjZSlrncFEfIkllCPA2GX8KV+fFWofBsOJP8IOSWkAYsVa
	QIhPjF4f0jA96n8tv/NeTRsDndg0oP7QvmLA1PSu023o/zGbZnDOG/9TjiJA8sqAeq4lMkaqfV+
	TULACHHGl67y109NCpPmssZDcb9pE5jiFsaMt9jvnn8sqCnZyD1hfqB52K+XF40jgg621CmGRw1
	rTi5QuGJfHqZN9EfvZCFAaSjCPYZ1g2sjXHson20bpVCVrEGGc9PCauZXEX2WY2vS4SR52ovO3l
	cctRbPL7fc1zJIaCMXrjnc97i/La0T9X5ZyVHf2MR137NLj8+l8qmBu3DGZ7i4g98zZd+P5/gpx
	o1X84rFW4THL7PS9bSpN72WzCotkxi1MXRghO9bxSp4BaPXJSzB1hsjm2
X-Received: by 2002:ac8:7c4e:0:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4ea117a5b7fmr22868471cf.9.1761052614236;
        Tue, 21 Oct 2025 06:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhrRrLX+L9pClZQtFbNEWvlViDkRlkGNmA7lfMRkaxTXZ1qhcdLBO3MOkS1AHdWDH6zOIELQ==
X-Received: by 2002:ac8:7c4e:0:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4ea117a5b7fmr22868241cf.9.1761052613569;
        Tue, 21 Oct 2025 06:16:53 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7e984f2sm1057089266b.13.2025.10.21.06.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:16:53 -0700 (PDT)
Message-ID: <16844fe5-9090-4504-be72-f3591b64e0d5@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 15:16:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcom: ice: Prevent client probe failures on unsupported
 ICE
To: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>, quic_neersoni@quicinc.com,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251021040337.787980-1-quic_dmukhopa@quicinc.com>
 <89150929-873f-4d09-9cec-727f92572d17@oss.qualcomm.com>
 <413d84ad-0858-4e96-94e5-c0a2ed68e6a2@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <413d84ad-0858-4e96-94e5-c0a2ed68e6a2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tm5Nr5Rp_ibHruj8w12Fvt0rWF42Tmwr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfXwD14du1T1ezK
 OLTQFoZu5FhJswT17AuMg7tKYCDLLLa/5V+mT0dPoMT5KEKREoDTKzSa96vniO2uP/TYT8J/gwW
 KTlaaq8Ugr6G6WHopSvRRXViR2L699ZI8QnM3Zjz+0locaoLr+GQEKC4Bobe8JVgVI6QYglRAb/
 IkSLSZEoVYogDoFTr+14DLffrD6g176H2MRaFEcKxzPjsK8iR0ikp6leTGTd2IVriVMMpa5V8sc
 hoyPmxJF4QE0xt28jLVPyvmc+B1jRQLNuPUhQusgjJfgyfe9oLBlD+TeSgmctkNCKVJmiuaD5aB
 M2p8JwW9/4iXM/CgOE+MqtEU6Hr/dOfx7iCdcTfYLEHEX9CWbZVZqnBv0fqj0z3yGGwClv+Vt5Z
 5G70FAXGRMU4w/BBxUF4VdrxbU9IxQ==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f787c8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=AeV98SofgcCFkdjVCqEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: tm5Nr5Rp_ibHruj8w12Fvt0rWF42Tmwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On 10/21/25 2:34 PM, Debraj Mukhopadhyay wrote:
> Hi Konrad,
> 
> Thanks for your comment. Please find my response inline below.

https://lore.kernel.org/linux-arm-msm/2023042722-humble-unthread-9597@gregkh/
> On 10/21/2025 2:57 PM, Konrad Dybcio wrote:
>> On 10/21/25 6:03 AM, Debraj Mukhopadhyay wrote:
>>> Storage clients (ex. UFS and MMC) invoke of_qcom_ice_get() to obtain the
>>> handle from ICE (Inline Crypto Engine) driver. Currently if ICE is
>>> unsupported, the return code from probe could prevent the client
>>> initialization which is a bug. To fix this a new flag
>>> qcom_ice_create_error is introduced which caches the error encountered
>>> during ICE probe.
>> Probe currently only happens if the ICE node is present in the DT and
>> referred to from the storage controller. What does this patch solve?
>>
>> Konrad
> 
> Even if the DT node is present it is possible that The SCM support for ICE is unavailable in the underlying TZ framework. With the existing logic, qcom_scm_ice_available() would have failed in such cases, returning NULL to storage clients where the clients like storage may keep retrying which potentially can cause boot up issues. This patch corrects that behavior by explicitly returning -EOPNOTSUPP to the clients. I will update the commit message accordingly.

Wouldn't that mean that we have a broken TZ?

And wouldn't this be better solved by simply moving the SCM checks
to of_qcom_ice_get()?

Konrad

