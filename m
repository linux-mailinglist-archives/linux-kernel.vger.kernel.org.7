Return-Path: <linux-kernel+bounces-722679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D08AFDDA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2381C25F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F51C862D;
	Wed,  9 Jul 2025 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cuY2EPFY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7713208
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029248; cv=none; b=epSeD4t0/A+/3TPu4WZSAeS2aHASBqhx+tbaYb+1PRutUZLzB9I/HBQwxfHCnGtXJ4fdmVPvOfIcU8/ekP8BGp6Zo3/rbl+1q/ElSqlaRbYgkOlsjbpUjjeuFn1BOLeveWkaVAZ5pOme05I2raymNBTpLZ1Rvf5nJRrirEjMgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029248; c=relaxed/simple;
	bh=JgjFV8ttalnLWfax5cAC90o1K+OVxDfN9tj9+H+BGBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptVIbGZIFEBESzbG/AAYox1FekB+OWrwf7XSmhlkJG+//POFC+FBpsGYg1JEa59SPU+PdkQ3SmMsH5Vby5uPUSwRAdegpISefP8hooN2zG0hi5QflD4P5Kn1M6wlFvmEVazH7E5A8mYh2b9cMKTbnnfv1eyyk4st5pXLhAqoqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cuY2EPFY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568J8qS1032719
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 02:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nQ/DF0j8qjp6KjrDbYkX903lF1T/sv5VpjC/UZ0thFQ=; b=cuY2EPFYWDKn49QG
	Up3kEHogbSBHV65Ol+DbOuy3c0lvJaa42VMjpZvE1Cw2yJNN9If+AEMthrGUBHl9
	CMJYEtEXIEeAMnTEq+NN10sB0WK4BnFdYS4xu/8J45blOC/+1T75cK82+Pk+NtgF
	XXeUo2qAkD9SkisJkGWNOU0y2mdQbDDKKbWBK2m4PDwdR/E9EIt5C6Usdv0Y+b97
	htNn0stvN9n3mavg05iUQ566WxNW0wBEWPKUns9K1rEy6xa/h81d5FoJcfr4IwiA
	TNj7G4Bcfunb0A+TRalZAebr0aN32KO9F5286RkoKwwPuam7SRrduuBkvMjObDh7
	PKWAqA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrktegf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:47:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74913a4f606so4193365b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029244; x=1752634044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ/DF0j8qjp6KjrDbYkX903lF1T/sv5VpjC/UZ0thFQ=;
        b=Z99Mr4cfeO1ioQqFUSriUPBaSd+R2VVjjOC5hu0tKnQdh+KjE2NrfMqG0YgdwoqNf2
         uTf3nq/HfyUn0/JQk8bRy9+EhwORfnzlFR8VOT23fRaxPuna6C08+kiKUgrDvod8LaeL
         YHn91YxU6MKOEsE4MEaoWJuDY6FaMZ+rQdqvF0qpxGbZtOayYaC483LoUrQjf19G6jTn
         u+ShT70B+p66gCjk/BHO9HPBI8wmXNhUTmMwHcH6RNtd/NkSy8lFzbNbg2KngQekmZVz
         u/mMMsA6HLzFAcQXAkwjMKy07UPzScC/KMHv6NMvaepctB0MPLRrpS5LPsO7hUnyXlei
         CmaA==
X-Forwarded-Encrypted: i=1; AJvYcCXtg0A00r/eE9H8EAxL3UQwqAA2AA4pXBreC3ES7+RoVnanpgeT7VtuHDNakt2h1M9wZ2XDQT/aNuvr7uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUUW+9twl/h38d1maEgTISbZbfvuO/C27S2uVS6HCT6Dn4nx6
	3kZbSLCgdX0q+19htTXZwiCbUFD4/NBHql6Ltpbucs7lqwi1AsSkHF3NUxaZPOiR6KUwxEq74ZR
	OFBRpcR5YtKYUM2XInErbOlrPFp2Q8vR6T15PllF/OR6p1MiYC2KYVG3D6HNJjcVzmXOnXhRJf2
	8=
X-Gm-Gg: ASbGncsJ9we1gBHA75ahzYRykxZ0+a5KMUPkEnNXmPIjdDEB8Y5VqvCPo0/0nOZIb83
	+YX9QkYvbdm25HjRjESEDRnSlRKA3Quz+g/XIBI9idAKhlBsW1ar3wvwAzJttrd3fWtjfpeAR0K
	h7IE92GTBVcGE6tIWfpLyreJHBdfjRfXQiemT0dM9UNbHAjslgST5+R2egXMHlag5ONbZlH/xcv
	b3mSi/zR7wfM7jjvIMhtZzMzPzuXbcqxx2A++RGXIsQz041ptegqUA/3AjNJh2lMnHqTxsoCEO4
	HUWBGu1neIxFxilJ/U7n8zFBoyQN/qgY+EUynplAGUc4+JmmPHnseQ9efIdIhQ==
X-Received: by 2002:a05:6a00:c84:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ea6652bb4mr1477304b3a.13.1752029244439;
        Tue, 08 Jul 2025 19:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4f2L3r+oNT/avXH/4ZfezYoJMBm/VekozQ6XrcYIynsKjsadJJ4UbsxMUYMB1n2pUGbU6Zw==
X-Received: by 2002:a05:6a00:c84:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-74ea6652bb4mr1477281b3a.13.1752029243986;
        Tue, 08 Jul 2025 19:47:23 -0700 (PDT)
Received: from [192.168.29.88] ([49.37.212.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4f1asm12802173b3a.161.2025.07.08.19.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 19:47:23 -0700 (PDT)
Message-ID: <114409da-5d1e-40ed-aa8e-3bcb769ac0a1@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 08:17:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-fix_scan_ap_flag_requirement_during_mlo-v3-1-dca408b10ba4@oss.qualcomm.com>
 <f5148f63e6f96fd18558dbb7f49d090aec931745.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <f5148f63e6f96fd18558dbb7f49d090aec931745.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yaHdvESL5CzSqCJmBtSowesEvKb32tzJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyNCBTYWx0ZWRfX4Ee5YmSX2LE5
 b+9IUQX17BDyxNwgpN4Onk4vuap5unCcCHsIDpdFM5luSgW4QCN3tZBsml6ZVX4YY0DBMPLy/Go
 iFdKlQvSdb8WjPJJJOyXBaNLgdUa+WQsdkbcX8h/cGjmusUxogfG5bgEKxAQUYI3GUm2+fHoZxA
 VqDlW1vl7eeqfTJz8IzQ4ta2MhfO1isEZTRD/Gm+5N370TKjzof77DPlZYZpOxZgZAG7jaYQ9ka
 NxmneSCxLOUzI2Wj2Ve+yrkEImsYhv0R9uKZeRIRds9bY5cxtAigt/3DVN8xUvyARZL+qMC+gyb
 hEsf8ttzvfbGHwyVNn/CdeZqqA5l5r5bdwLOTYym68q4jx3/lhorY5B92002q3ehZmzOfFTDioW
 +GHRlBmUY+oup3YHFsvqVo1uvnu99pX9+4mFVTphpxmTbSweFngtlRWx9LCYADTQq1IKeGf8
X-Proofpoint-GUID: yaHdvESL5CzSqCJmBtSowesEvKb32tzJ
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686dd83d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=mPedDPIPg4NzqpvR87qMnA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=4ctZDmFpGKd6Wb6K1JoA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090024

On 7/8/2025 4:16 PM, Johannes Berg wrote:
> On Wed, 2025-06-25 at 18:31 +0530, Aditya Kumar Singh wrote:
>>
>> -		if (ieee80211_num_beaconing_links(sdata) &&
>> -		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
>> -		     !(req->flags & NL80211_SCAN_FLAG_AP)))
>> -			return -EOPNOTSUPP;
>> +		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
>> +		     link_id++) {
>> +			link = sdata_dereference(sdata->link[link_id], sdata);
>> +			if (!link)
>> +				continue;
> 
> for_each_link_data()

Sure. When I was writing this, this macro was not present hence did not 
use it. Now that it is there, I will use it. Thanks for pointing it out.

> 
>> +
>> +			/* if the link is not beaconing, ignore it */
>> +			if (!sdata_dereference(link->u.ap.beacon, sdata))
>> +				continue;
>> +
>> +			/* If we are here then at least one of the link is
>> +			 * beaconing and since radio level information is
>> +			 * not present or single underlying radio is present,
>> +			 * no point in checking further and hence return if
>> +			 * flag requirements are not met.
>> +			 */
>> +			if (wiphy->n_radio < 2) {
>> +				if (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
>> +				    !(req->flags & NL80211_SCAN_FLAG_AP))
>> +					return -EOPNOTSUPP;
>> +
>> +				continue;
>> +			}
> 
> Is that _really_ worth special-casing in the scan control path? It's not
> like this is a performance question here.
> 
> Maybe ieee80211_is_radio_idx_in_scan_req() shouldn't WARN_ON() then or
> something, so we can reuse it. Or maybe (better?) just reorder the
> checks there, if the chan_radio_idx==-1 and radio_idx==-1 would return
> first, and WARN only if we found a scan channel that isn't covered by a
> radio?

sure reordering seems much better. Thanks for the suggestion, will change.

> 
> And <2 seems really strange anyway, ==1 should basically never happen,
> it's equivalent to ==0, as in no list of radios?

That is correct. If underlying wiphy does not advertise, it would be 0. 
And if it advertises, ideally it should be 2 or more (otherwise why 
advertising?) But, there is no check for 1. So a radio can choose to 
advertise but keep n_radios as 1. And having n_radio 1 is also same as 
not advertising it. Hence to ensure these kicks in only when we know 
n_radios is greater than 1, < 2 is checked. Same way other two places 
also it is used.


-- 
Aditya

