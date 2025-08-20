Return-Path: <linux-kernel+bounces-776917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74D8B2D2F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7CE5870BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8FC250BEC;
	Wed, 20 Aug 2025 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MppeNeDm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D723E32B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664077; cv=none; b=nUsJ0hnbDJleDLQUMqgrvPkbZzZLGCTMcdN6Y7Bf6p2SSzZNSrSvu0t/76OJ2IxonBuP/BifGIFEOF9W+4zHgCAndNInBN5ZT+9d5qLHKUQEtCloGYb7/iu8qj9KN4wDSV2BNFhSGtz/jd140Sd1G+WeZk7F/91vAjAe+7S84a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664077; c=relaxed/simple;
	bh=IGnA1FXv1f8tKEdqJvkn6S/E7oLAVWuQedEUjt4GafM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaCe8j3nsacMva1sP9fcjVgBOOQAiHN6y6/k7dKLSpgO8xlyMMcpL/AkeAevEBmjDYQgi8/HAD9+gie0i1wxEvOusUA+aKJJPbnin5VhGYfBwnU7m1bNEIWZWV2N/ImH4sp6uuwzwDs8EM9x+bah3I2hOSempo10XwKg7GTbnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MppeNeDm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1pDUn011480
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hAK0xru7GDJ8nMhMtlK0GPrXNKZ4lF18AzZoweZOXc8=; b=MppeNeDmQW3zgxHH
	znkuQMlORXHaKNmWH7c1g3NaJ6BGvfqpa01qdsXLiwpBXrigzdaSXd0jvQCTp9iT
	+PWJ7KW2/EFMU8UKKMLC+WrsRyBxar+0PTcdbfnIlNPPSnAVUuCToKanZSh6e1lF
	pujYr99B6NDid+CSRpAuvM+8zvh7c2QPaRm1OjRUsmrNfY+DaXA5NQndbt9Rz6VU
	QM7ZqrEwMOkAQ731Ix75CNABdpzWFM8va1/Lv2rxltSgstvmGWIQwg+oBlEbUh4N
	pLaHfQg65QS8bOnt1w0y71+3GwG+CEp/Mdhfp5xOvEMKrC2gRIUOvGf9zwc3epol
	9GgYiw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52bgc6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:27:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e890901so11502490b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664073; x=1756268873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAK0xru7GDJ8nMhMtlK0GPrXNKZ4lF18AzZoweZOXc8=;
        b=HgpAxtchkQIZ2h4X/K/VhX8hl657Z2PZPHyNXgNDa0XumO3Yz26ZlkF+PQePo0AcRO
         yl0dIqgFKLDSxSBWzL/f6gHllHYDuOhqyvnSi8ImDkfu4SKp/3J6LI5auJ20mS2k0OUZ
         BuSTKE6DmWSPZ27zjtyDnAbAqMgHuqqHxN1fUl0scCxX/h9VIeTPE5gvLPaPUcYtGwtm
         5qwDtcEzrCbCQ8X+wIWMP9YZeBKtQnP5L/mTIOWkoJh1cZGa6XSgOEswuc+cJdAncG67
         9kxcEomoKTRr8xh1ehdNUCx0qJCCmYSQhV2Tq7fXaupZ2gwiYogoJQVa4o0HUdkCePA8
         6Y8w==
X-Forwarded-Encrypted: i=1; AJvYcCUoPnwB/fdS99Il4YRKgSb3DkUYLytZe1MHjyhWwhKRIdAMAu9QthTr8/Vj7pW72bnWsIzSKDwfoy9emnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3IUSLS0NPa6Ml4cR3khVqlyJ8vapShBD0LFecFYHYhZKv6R0h
	kKcvFGDzb5mIfYILtbNZVQnQX2tLk0kIItomG8F0L7RbvcKRGWigdR1Vm3fEr2X+ZpK43Fc/oih
	f/29TtiFLBOHOAAsfYiblHRrzQilWiCD1xtD/cPXe2ArmUvnPb6NoGj2QDrrMDcQQsWZSLnAB7+
	s=
X-Gm-Gg: ASbGnctqfU09h2OlsEMNhrQJrdJLbsQwMC047jWHTlNJe8MRmDQMSvEbBplI9Q5MMtl
	yCvjFvAIek3f+WIGQtmMveX84ASDpqiFqzzAN6PlP2QnHPFFoSpHXW7EzuVGlq7A591Ga+kZ6CJ
	5B2J66451F5zL63qZPrzvbdigVmvJonNgSQD4prSXTMS3qI/aOAV+7CUXzneEURgCXQ7R/fGz7A
	VH9Vh+hIff1kEeZMea26qKe8P0wPD5Rq5cqJJ8hK/BHpuwz7cdNGFZvhYuO5aOiHGBsGuHpDIv1
	ueX/uE9tM6g2g+k2olUuxGnPzib3Bbx8052B+Q/+faq5CGIPGK/qTOu9Zzm3YJdO7fUuoDNeGA=
	=
X-Received: by 2002:a05:6a00:3e11:b0:748:3385:a4a with SMTP id d2e1a72fcca58-76e8dd5c0f8mr1714834b3a.23.1755664073237;
        Tue, 19 Aug 2025 21:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcUojZeMUSbe1pEWZytu3vdN7AWQXRbXfhsjIC+2+iyfPG1ah4/TK6T5StHV+fx+cuygIhdQ==
X-Received: by 2002:a05:6a00:3e11:b0:748:3385:a4a with SMTP id d2e1a72fcca58-76e8dd5c0f8mr1714803b3a.23.1755664072690;
        Tue, 19 Aug 2025 21:27:52 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d13ac60sm4006778b3a.48.2025.08.19.21.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 21:27:52 -0700 (PDT)
Message-ID: <54d71bb6-27bb-494f-8f63-710e0e4148e7@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 09:57:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] OPP: Add support to find OPP for a set of keys
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
 <20250819-opp_pcie-v3-1-f8bd7e05ce41@oss.qualcomm.com>
 <20250819081859.kz7c27d6c77oy2gv@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250819081859.kz7c27d6c77oy2gv@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXy9BsERiHtWOh
 iJwxpd4JyuYDpiKKZSVVC5boha8ogoDc2M+JW7v3U35Vtgtdz82E0SoNGpI6+gTDe1wEi8sRB29
 hQ1G3rhVqh4YRMqh8I18Mt7g4Rk/rJedxvOYbb9SbtZ52EIsFOc6s24VU46XkLPswBWmiYj+hHJ
 IbzO6QL9AV/nGW3ly0BRSE2MbmPrsZwn0/p3PpjuIl1JNZdlxt3U84a5xZGSAXxLfsqf3F8ZVPk
 8jxFcw/Rx8bkJTyki7xypJj9pU9jOH+ASML+ytqDzFU8fiHLrwcakUX04MMVRtuctEasCee+YcL
 K+XMCyygoLjF3NNM6y3k3qVkUvsxIS/TcipPviIuVSXj6xNV8AIq/voeexbLUtNGG3qAOOHcZYq
 gETrGMkSb7IveyiYgrKGUB0n26bHag==
X-Authority-Analysis: v=2.4 cv=cr3CU14i c=1 sm=1 tr=0 ts=68a54eca cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=6WgZcX-rmC49gpfAgPcA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: k5m4tZp_ZzRUmf8GsPi-hGm9gijKpzww
X-Proofpoint-ORIG-GUID: k5m4tZp_ZzRUmf8GsPi-hGm9gijKpzww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/19/2025 1:48 PM, Viresh Kumar wrote:
> On 19-08-25, 11:04, Krishna Chaitanya Chundru wrote:
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..ce359a3d444b0b7099cdd2421ab1019963d05d9f 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -461,6 +461,15 @@ int dev_pm_opp_get_opp_count(struct device *dev)
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
>>   
>>   /* Helpers to read keys */
>> +static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)
> 
> Move this to the end of the list, after _read_bw() i.e.
> 
ack
>> +{
>> +	key->bandwidth = opp->bandwidth ? opp->bandwidth[index].peak : 0;
>> +	key->freq = opp->rates[index];
>> +	key->level = opp->level;
>> +
>> +	return true;
>> +}
>> +
>>   static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
>>   {
>>   	return opp->rates[index];
>> @@ -488,6 +497,23 @@ static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>>   	return false;
>>   }
>>   
>> +static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>> +				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
>> +{
> 
> And this after _compare_floor().
> 
ack
>> +	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
> 
> Why are we still checking this ? You removed this from freq check but
> not level and bandwidth ?
> 
ok I will change for level and bw also similar to freq.
>> +			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
>> +	bool bw_match = (opp_key.bandwidth == 0 ||
>> +			 key.bandwidth == 0 || opp_key.bandwidth == key.bandwidth);
>> +	bool freq_match = (key.freq == 0 || opp_key.freq == key.freq);
>> +
>> +	if (freq_match && level_match && bw_match) {
>> +		*opp = temp_opp;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static bool _compare_ceil(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>>   			  unsigned long opp_key, unsigned long key)
>>   {
>> @@ -541,6 +567,40 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>>   	return opp;
>>   }
>>   
>> +static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
>> +		struct dev_pm_opp_key *key, int index, bool available,
>> +		unsigned long (*read)(struct dev_pm_opp *opp, int index,
>> +				      struct dev_pm_opp_key *key),
>> +		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>> +				struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
>> +		bool (*assert)(struct opp_table *opp_table, unsigned int index))
>> +{
>> +	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>> +	struct dev_pm_opp_key temp_key;
>> +
>> +	/* Assert that the requirement is met */
>> +	if (assert && !assert(opp_table, index))
> 
> Just drop the `assert` check, it isn't optional. Make the same change
> in _opp_table_find_key() too in a separate patch if you can.
> 
ack
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	guard(mutex)(&opp_table->lock);
>> +
>> +	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>> +		if (temp_opp->available == available) {
>> +			read(temp_opp, index, &temp_key);
>> +			if (compare(&opp, temp_opp, temp_key, *key))
> 
> Update *key and do dev_pm_opp_get() here itself. And same in
> _opp_table_find_key().
> 
ack
>> +				break;
>> +		}
>> +	}
>> +
>> +	/* Increment the reference count of OPP */
>> +	if (!IS_ERR(opp)) {
>> +		*key = temp_key;
>> +		dev_pm_opp_get(opp);
>> +	}
>> +
>> +	return opp;
>> +}
>> +
>>   static struct dev_pm_opp *
>>   _find_key(struct device *dev, unsigned long *key, int index, bool available,
>>   	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
>> @@ -632,6 +692,46 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
>>   
>> +/**
>> + * dev_pm_opp_find_key_exact() - Search for an exact OPP key
>> + * @dev:                Device for which the OPP is being searched
>> + * @key:                OPP key to match
>> + * @available:          true/false - match for available OPP
>> + *
>> + * Return: Searches for an exact match the OPP key in the OPP table and returns
> 
> The `Return` section should only talk about the returned values. The
> above line for example should be present as a standalone line before
> the `Return` section.
> 
ack
>> + * pointer to the  matching opp if found, else returns ERR_PTR  in case of error
>> + * and should  be handled using IS_ERR. Error return values can be:
>> + * EINVAL:      for bad pointer
>> + * ERANGE:      no match found for search
>> + * ENODEV:      if device not found in list of registered devices
>> + *
>> + * Note: available is a modifier for the search. if available=true, then the
>> + * match is for exact matching key and is available in the stored OPP
>> + * table. if false, the match is for exact key which is not available.
>> + *
>> + * This provides a mechanism to enable an opp which is not available currently
>> + * or the opposite as well.
>> + *
>> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
>> + * use.
> 
> There are various minor issues in the text here, like double spaces,
> not starting with a capital letter after a full stop, etc. Also put
> arguments in `` block, like `available`.
> 
ack
>> + */
>> +struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
>> +					     struct dev_pm_opp_key key,
>> +					     bool available)
>> +{
>> +	struct opp_table *opp_table __free(put_opp_table) = _find_opp_table(dev);
>> +
>> +	if (IS_ERR(opp_table)) {
>> +		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
>> +			PTR_ERR(opp_table));
>> +		return ERR_CAST(opp_table);
>> +	}
>> +
>> +	return _opp_table_find_opp_key(opp_table, &key, 0, available, _read_opp_key,
>> +				       _compare_opp_key_exact, assert_single_clk);
> 
> Since the only user doesn't use `index` for now, I wonder if that
> should be added at all in all these functions.
> 
ok I will remove it.
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_key_exact);
>> +
>>   /**
>>    * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
>>    *					 clock corresponding to the index
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index cf477beae4bbede88223566df5f43d85adc5a816..53e02098129d215970d0854b1f8ffaf4499f2bd4 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -98,6 +98,18 @@ struct dev_pm_opp_data {
>>   	unsigned long u_volt;
>>   };
>>   
>> +/**
>> + * struct dev_pm_opp_key - Key used to identify OPP entries
>> + * @freq:       Frequency in Hz
>> + * @level:      Performance level associated with the OPP entry
>> + * @bandwidth:  Bandwidth associated with the OPP entry
> 
> Also mention the NOP value of all these keys, i.e. what the user must
> fill them with if that key is not supposed to be matched.
> 
ack
>> + */
>> +struct dev_pm_opp_key {
>> +	unsigned long freq;
>> +	unsigned int level;
>> +	u32 bandwidth;
> 
> Maybe use `bw` here like in other APIs.
> 
ack.

- Krishna Chaitanya.
>> +};
>> +
>>   #if defined(CONFIG_PM_OPP)
>>   
>>   struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
>> @@ -131,6 +143,10 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>>   					      unsigned long freq,
>>   					      bool available);
>>   
>> +struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
>> +					     struct dev_pm_opp_key key,
>> +					     bool available);
>> +
>>   struct dev_pm_opp *
>>   dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
>>   				   u32 index, bool available);
>> @@ -289,6 +305,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>>   	return ERR_PTR(-EOPNOTSUPP);
>>   }
>>   
>> +static inline struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
>> +							   struct dev_pm_opp_key key,
>> +							   bool available)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>>   static inline struct dev_pm_opp *
>>   dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
>>   				   u32 index, bool available)
>>
>> -- 
>> 2.34.1
> 

