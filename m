Return-Path: <linux-kernel+bounces-819886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DF8B7C3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BE54609AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51682F6590;
	Wed, 17 Sep 2025 02:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcO+71mJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB312F549C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076060; cv=none; b=fgeo4dQebbBrRUUQyFJyOoUFq+HUbzeapxHrG+xPD7MP6PZob5U352KlidtDXW+kND+R6gjbN2S5U4VhGsXGXGF5cY3CNDa+6tJ4BocEpY4bj1XI697nhodNImlPDN9qbUVpkqDmNICBekNqCdoJMoXNuEi2pa4yVTXEnoUuYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076060; c=relaxed/simple;
	bh=ZVOSah7WyUCxAwtViCyBrw8IIhcxsA5kP+tsBwbzwsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqZ+UwoAMOw1X+AiwRXwyz3nCu9h2rfZzMNIE6eRYUzUssK3dcp6ih/R0k68a+BD/Sqgw5duPxd4KGW2S4kOpNvC43YJIUEy/vPWYrP+Oz89SWuzeebnOLP0EjH/8kC4vVn9ofeN6J7J2v/2fFdWrbEBqQsOJuCDZfXP8ecsL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcO+71mJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLaQwP027066
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VYlZBe92chnYNBC11wB4N82uu0aHrj9AIx2n54JzLec=; b=gcO+71mJL/8mZHVd
	KTpDaJ5GD9zE9ZDehnMwHk6rKIja2rQLRRZgWlKeONk75jtlavNcmw90j2HVhWO8
	8T+amM+VcWaGq8w9al1BypNRVR69vzy+Qn/xclMVMEvv9iXk2mscUkrrR/RLj66N
	ceztjk2EYqB0VrSlUOMiZ+lg17bsIFEIL1V3kJtgtA1kOut9FtPFqLbHwrO80YtF
	nzj8RUbROoDNrEPMJPV+Ct14KC9Gd5BzFw1jlJyptcEwmuPwCwgj1jVDSBoEjmqi
	uAOmauBBVSfhuvAJql51f6bLwfL37i5S7YkJZgv/THUzbOU8F5SQOy8xp4BOGXRD
	X84gvw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxgkct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:27:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7760b6b7235so4636643b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758076055; x=1758680855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYlZBe92chnYNBC11wB4N82uu0aHrj9AIx2n54JzLec=;
        b=gvKjHyz1waT/FtepNh1KtEVT9wcxW7/opV6A6aa4ywWZ5Y04p7M98e8LhJn8wltFbm
         g7ZxrNeNsz/UKVs/3C/78aOa8YE7CK4b7EzfZuAOkt5af5Jo4fLW6bZbCaMq25ctyEAo
         R2tQteVsJrBfWxKioXKdg7QecfE73MtbuBN2lskSihxXP6O9o2b9/VwwfuVpQx5j0FE1
         BhRiUFwP7rJ54HBM0AFGKJxPE7hslC49fMNGtRuQR3VA5d8xD9tHHQUEn+azJHe0q9o7
         ZhdKPJ805Q8hjDuK+6LtTbsLLsT9DsgiN2r46rmIEefTDSsg94UXsELSEILRcWFUTT1w
         JrpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoneFBUlgiho1BlpIqRftJI+eOVDQ82p+Q0vMN7kY9MWIPlc84fRrQl+2jqxiiqB4kUGRgZoZkDckxfhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkCnp6D8/awRiMqP+zzjX2dfHK4XvjGPKF7vYa8irFdqqkELt
	ZyJwTRzQXTDt/SODBA/I4ySepMYn62jnZhMchjn2f1tT0bKz2xK2h1D1Pws1/82afbdY6UcbrZ9
	m3oXixAwATysOY1aZ6cjwQ/c7ceMZ3EQC9yFqzp61VqO8Yav9/MKJm46ijPj/TZ62lYWsmn3ykH
	k=
X-Gm-Gg: ASbGnctDODO5VsZLyJ9SAdMcNgRnqw/rV3CDrrkekfZrHna3iM6pcoHyH5V/9zGJsSZ
	TwnIYk+lihRH1IOAFHTQ7HfTVGR8ZvgXjqOOGTf4Y4f6AehKDbu8J0h6XzuJdzUS4AX90I4S6ss
	BAC6MR087dlD+ACpsMLfbStl/KMP5eONruOqjipfSXHLad0TIPJntO+2WrTYg8anKqz/Sb+Cgy9
	/Veb7CS1qHD+7o62gUdqsAVuu/XwlD7ej88zL+oCuQIh115GybvUS9sey5WKEA428a5N7NgbDPV
	XQn+6JKstHxq33IW3yATbuW9z94joXKM9bHFKJ8vMbS5yRrM8sRmb071iH3h4RiRKe3tcIkrn/B
	lI/5qdyCkexvX+D2uDS4EKIAErFqLzEw5Hg==
X-Received: by 2002:a05:6a00:228c:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-77bf75c1492mr538628b3a.13.1758076055092;
        Tue, 16 Sep 2025 19:27:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa3nKVRZ5lcOuXaoBxQLObp2Qb9gc/ezSveqX2YOxEc/wcuth8hVIukLM4KDYuJgtiHtLYwA==
X-Received: by 2002:a05:6a00:228c:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-77bf75c1492mr538603b3a.13.1758076054636;
        Tue, 16 Sep 2025 19:27:34 -0700 (PDT)
Received: from [10.133.33.240] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761853866bsm14036121b3a.95.2025.09.16.19.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 19:27:34 -0700 (PDT)
Message-ID: <a60a1d0e-0cdd-4e79-99cd-5dc543242a87@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 10:27:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
 <f3s2srlmvuj7wmh4rndffmbfrzylbuq4rsu7pqqrnqa5fgsmch@t5f4dgmqtgys>
 <c5e3ac07-e91e-4c9f-9256-497991b75200@oss.qualcomm.com>
 <aiplezjbovtaghgblua5xj3rag5kjwzt6sjrnygzbez5dtaxm3@vn6kwmskc4e2>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <aiplezjbovtaghgblua5xj3rag5kjwzt6sjrnygzbez5dtaxm3@vn6kwmskc4e2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8OnFtpfBzSit
 ckpR9yQQfe4YhSA24UbeJhAB9P76lkckQ5gC3wO41TndS8F2ipYJ1VCwDHxLwgTr38f1u9/+qGj
 2JsidvnsKi1l/Djmv+AajNe3AVZK76j1fMZFSF/e8WIIB7cF4Ovy8NnWxZU11iwSpdP2hZj8/gB
 IjZuIehoOyP9BN0CGsQ+IxXle6c2jNXIbmqqy7DuikUBkHqlGZMcsGF9XPsarJYrpeB6oxKYKxg
 YqIHxozv09QwqFh8k/4/by5B68A7nptF35ZQ8aFhWX1wRknzAmjrK/KFKFsWppa9Pz/nLBlgOsv
 nUUZw6rqSRzmqNxyXU0JH/4f25OGNM7XpplK7sR5ypB2A4pRJK9gHVCv0xaW1d3kOJqCbHhY9nO
 mnHXZGif
X-Authority-Analysis: v=2.4 cv=MMFgmNZl c=1 sm=1 tr=0 ts=68ca1c98 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=lQXKqyNTGrdWrY9AsKwA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MrGqTnDP-OjnAQESzK_WhJUzn1ltCbuN
X-Proofpoint-GUID: MrGqTnDP-OjnAQESzK_WhJUzn1ltCbuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On 9/16/2025 6:16 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 16, 2025 at 10:40:03AM +0800, Fenglin Wu wrote:
>> On 9/15/2025 6:19 PM, Dmitry Baryshkov wrote:
>>> On Mon, Sep 15, 2025 at 04:49:57PM +0800, Fenglin Wu via B4 Relay wrote:
>>>> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>>
>>>> Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
>>>> for SM8550 and update match data for X1E80100 specifically so that they
>>>> could be handled differently in supporting charge control functionality.
>>> Why?
>> Is the question about why this was submitted as a separate patch, or about
>> the need for the change itself? The reason for the change is explained in
>> the commit text.
> It's not, and that was my question. Why do you need to handle them
> differently?
>
> Please always start your commit message with the description of the
> issue that you are facing.
>
The simple answer is, the charge control functionality is only supported 
in battery management firmware starting from SM8550 and X1E80100.

I will add this statement in the commit text.

>> As for submitting it separately, that was done to address
>> Bryan's comments to split out the compats changes. Anyway, I will address
>> the further comments from Stephen to make the change bisectable.
>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
>>>> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
>>>> ---
>>>>    drivers/power/supply/qcom_battmgr.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>

