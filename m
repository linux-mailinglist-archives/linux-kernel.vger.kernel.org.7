Return-Path: <linux-kernel+bounces-864209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8CBFA2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F023C1885C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B119F13F;
	Wed, 22 Oct 2025 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZdmsBnw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833B190477
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113633; cv=none; b=YVkPHdM/mjRbAK8QgE0AY+eOrptZNxJuimbpK5/hBKZchqtPuEvstpAzMMBF+iSwi+RWxKaS6AC5SdjUUDK+SskjRMXwshkw7iQyJBCf8FWARFunFPwNgEdup+D3XJf8BDwNvjeLlcokqWgkpQq1PhJis6Mt7eMgPoGxEszPvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113633; c=relaxed/simple;
	bh=VhNKSj4t+F6d/uuShD/79vS04mSB3RUROA0m34pJMEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjttVfnKnKhynL9Jtnow/V9HiZuOzmsi+dtzL89P7MG7Eyc2bEoKtJMsUhoBakuyhYkFKUxuZDszU96gqKU3ExaY8MpwuUGgbPvRQnZEEyaGPNr4zKv9zlkfo0/5DDBzGm/mfL9BaBN5eey9y9OAac+u7Peu62biQbZ3+DaonPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZdmsBnw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2tBMZ026903
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vlgEXZyeNEItFgbT779OPuew4dhY16Fij+w5r7ccMMk=; b=CZdmsBnwCEt7Njd3
	TnmjDhq5Hh1G1U51AfL5jI1AKjFnx1rUf/0li+xRnr45ExmU2ZnrIzwLuW+ww3Bn
	VPh36Ix1gatnt6sACN5aYK+F2QjfGbCRfJUIjtOx+DbDmvF1w2AhGfmDdWQgfI+n
	Wb6M7wWNUGKsbbM7nDlNh5bSuN+KVzhctWmN5xsBIiSWdd3sJzglsTu4rgxiNcsQ
	lWNjZmEt2Fq8UEi6orUGFaNOp7hvw81Ou49JWA8FJRCgHhHu9A3fmri+zTaFuQ2U
	p3o/DgzfEJoNUOeg1w32h4u2ABRKwDjtqgIBg91txs/v53c5RqqXc0ixdvzNMFGx
	t57YYg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pkp9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:13:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6cd4d3a441so623147a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113629; x=1761718429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlgEXZyeNEItFgbT779OPuew4dhY16Fij+w5r7ccMMk=;
        b=kwnXJ844/2Z1gCNpoI8zz15q1dJJhusJ535gDrdrocFEXrNXUAn1/qCk2NZuh3bTHU
         B2ZAKvaJ4jGNZzXcvCJ+GQBXtOWu6MkoBVDz5Rnkn2kQQ4v2KUeF34Mm6EU5TVF+eesu
         EUN/bis2PKOHkHnC5evWvlQBhsZ1ZKx1Cj1EEa367vGbvFvpmVnNNRC1oUo9JY1XIFZ6
         7h9+jaFuN3mEHjlMzuM/RT6+tmzy/l93wjSwRJXtZVZ9gx1DTv/jq9ldwZI52rTrixQa
         PKKJBZDC3498S6kHBIpBocpO8TbCUZUEkC9XCP5hGNfP7PNgl9unXsfuYi2Cl6GIg8UF
         YYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWeQIwAj6Qv0XmYTDsT10PJ3UxMgIcJTeHOP1qY/QDIaEOG4dSaUeGQuVzaQqh3a0rHeDokS2FGJ0i9GLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbPi5JA4AmKN5LrK++Yx/cjGc5wd2b47kHCLx2/zbv81BdySa
	k2hee8yuyXQu2Viqfj8i3L3k+0nmxkEhcPGJThEb6fWpoQLeP16e8/BlqmipRugU1WS6DkGT18P
	L38Rf61CCl8ZXBgnfwdYu3hJeFYodJdEtBt019yOgyU7nzz2IHFsGr3QLJ8l3JrPeP1cfaYUxoI
	8=
X-Gm-Gg: ASbGncvENTryrT5kRgBSxRnzD5GiPKv0iNOlKS1jzzM4+IRkVvlfX1oUti8O1dD8NTU
	UK3V64WlLU6DgTymiKLXDjGy8zAMY57fELQ2i19/6H0AtLwhPeeGkZl39uxTRo0JftK3M87V2qx
	YkH/YDTGi1Sfn64PGdhpMCAeJRgD6hK/wfCH/IiEUit2HBlXW80OFSiNyssv4mfmsTMf5Dy+0e+
	L77XhoA8tBPfy37remmz0zVnWYSukKntGr9G7NpP44kQFLBU/dW/9lEhj1G6szDxfQwx8YnU+wq
	HFBLxY0siIxuIM+6ht6j1DaCJ5kKWiWVXRP1J2MjSq4X+P1KOKe1lWUsW6515q0VCbG0/7kZdaJ
	BbU7lmdTuYJSsQZjvRa98VbID4w==
X-Received: by 2002:a05:6a21:6d9c:b0:339:bdbe:df98 with SMTP id adf61e73a8af0-33aa81c4325mr3171400637.28.1761113629176;
        Tue, 21 Oct 2025 23:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERRf18K93LdeI9VMbcV853FrexiDN9WUsC1cNVcTdHy8qoRDogCxdEmNHDa3eZ7mE+TvbK1A==
X-Received: by 2002:a05:6a21:6d9c:b0:339:bdbe:df98 with SMTP id adf61e73a8af0-33aa81c4325mr3171378637.28.1761113628696;
        Tue, 21 Oct 2025 23:13:48 -0700 (PDT)
Received: from [192.168.29.179] ([49.43.201.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f24e9sm13402940b3a.44.2025.10.21.23.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 23:13:48 -0700 (PDT)
Message-ID: <2aeb793f-041a-49e5-8f76-28452721b743@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 11:43:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <3kngkegljl73a3kmzcprwhkwpjml7rfgiy3hypv3hyvyxe7yg2@ccyzzva2bifj>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <3kngkegljl73a3kmzcprwhkwpjml7rfgiy3hypv3hyvyxe7yg2@ccyzzva2bifj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfXwqmY49qsSMUv
 rknETS6YutZ6w0NL0AQNoMSHd4HVMRJahHB32jVX7lHM9xP5QKbPNOjg57JhZ7PbIPu5z/qWwIl
 cymZVIUACvWWv0MRq3NUy/rZ8fRfO3ktIktDsAjJTzmX3in/VFKdJMIic4F+n55o7OE0lm4+Rab
 jvt1N+XDhsB4JfcjHXObEMeQiA/FHhzJgLnoTg45jaWCU8Vwq3rL986HbrxiXvqIezI4wdmTvfZ
 3J2qJ4VDcD7ueTAqiGlPDGU3Y8Q5j7ILOcJowF9QuDp9R16lEEEzxpVK4HtrhzZzw7cGHDxgVJF
 8Apgvg9IGYwMy1jIBHVZ52ahNCdX6OwsKyljnRE0442njFALoLraPqbHxmesc+VXAJ0SSMIbqR+
 I7+CEotFLyGPknmsX1rzSYPbEFOPdw==
X-Proofpoint-GUID: y8BcAoEE0kHEvTTfK0zFa8Ayk39cL6yU
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f8761e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=dwtHxs9cUlWiih9SwVP/Sw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VzD7RiLjpxdenJvD6jAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: y8BcAoEE0kHEvTTfK0zFa8Ayk39cL6yU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/22/2025 3:58 AM, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>
>> All rpmh_*() APIs so far have supported placing votes for various
>> resource settings but the H/W also have option to read resource
>> settings.
> 
> Is it supported since SDM845?

Yes, H/W supports reads since SDM845.> 
>>
>> This change adds a new rpmh_read() API to allow clients
> 
> See Documentation/process/submitting-patches.rst, "This patch ..."

I will address in next revision.

> 
>> to read back resource setting from H/W. This will be useful for
>> clients like regulators, which currently don't have a way to know
>> the settings applied during bootloader stage.
>>
>> Link: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com
> 
> This is useless, please drop.

I will address in next revision.

Thanks,
Maulik

> 
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> ---
>>  drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++--
>>  drivers/soc/qcom/rpmh.c     | 47 +++++++++++++++++++++++++++++++++++++++++----
>>  include/soc/qcom/rpmh.h     |  5 +++++
>>  include/soc/qcom/tcs.h      |  2 ++
>>  4 files changed, 61 insertions(+), 6 deletions(-)
>>
> 


