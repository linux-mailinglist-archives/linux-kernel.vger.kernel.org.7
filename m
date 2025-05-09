Return-Path: <linux-kernel+bounces-641521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8FEAB12C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96EA1C4398C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D76274643;
	Fri,  9 May 2025 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUxxbiCG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B91A2C3A
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792056; cv=none; b=IuBkYe98eiw+wFuykp6I0Z7kstvKeBwHcqsA+Ik5eGbUpt6zWh5BSDXsgZe/RaUW3/4m8wt+VQJREQgEumcUZiE0eqJviTG2kKaB0r1fI9SH1YsCqz1nLkxr9+1gKr7l4EXSV2HEKPR+oGG9DlmU/khYkuvHkycxvoEJ+dcfes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792056; c=relaxed/simple;
	bh=CTpdoO5TbmQ/J6WOyrtODpc6JRorFNNAbqWDwZwQxTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTshd8ZzoRh8Dp9UNTHoZU+duluOpb3bLTRnmRd3H944KsdX0AeVRw5EP6e9Ly5w53oM6R4tGuhJeqZwkTI+jiIV1Lva0xjzQKoKlGacBTsC37Fk9TUHPd+wI6n5liSJXM5wECCMJgErwuKkP/bJHYvQCGKIYcF/m15CjHK0IRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IUxxbiCG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549BhieP016320
	for <linux-kernel@vger.kernel.org>; Fri, 9 May 2025 12:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uhmvCJtCideJcLgLP8CeF1xAYGZD1D5hleQo38GBvLk=; b=IUxxbiCG03PZNCJV
	YaI7VA8I79XU4D5JqXf9xXZR+JZvDEk4qrIOFgr953VYWX/7GkFjO3kLn2Kbgayw
	ufbdGPXSgXMATpkvqmB2jnqxwdXTpybUpNr5y8uqhYa+h+RZsIX/1WKOhyhGQz3M
	EVvLrgtUKsPtCZv6QZeAiK32h8JLR87RpVfobQjPce8euclRhJBBBVky6jfHQ3ST
	bx0ZYp73OzleD5jporkniOYUPlqEDWJMeBs0wsMW/XjDik5Au0J+3qcBKfVCB9gv
	LDUtHbHHX/tE3kYj1pimJtNSWLuhqW6h3n6JY9ikzOTSSJMjW9vCKXwXNUyhUKB7
	3oYkNA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp8vhf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 12:00:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-478f933cb4bso779321cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 05:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746792052; x=1747396852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhmvCJtCideJcLgLP8CeF1xAYGZD1D5hleQo38GBvLk=;
        b=w3YloHy6W2NY4Y/JO+xktzbc9drtnHVm+FpXa/gQZOTWAU7pUzP3Om46rWb3VFiBzp
         zTmdGH0TT/TxXze99S6zpx8QVNjcdv5DGTlVbE2ZWUcZwingCQCf0ZWPMykG3H5HsY02
         Mz6w7CZfUmXOq2hJBSQ+LfWWiWbAm9oSVyFdiG6SUJvu9r1Q1snyEVprvO9hapgcqmQP
         0l+HAdZmMDBBbMVVWTmdm5XyYsqm2PkzjUxCViz70pn8FWMKpZ+RoOyigHMT8Rswtk6A
         wxVB0ervn1BfRePoTn2dDT9+5Hn7xGJf0efdHBylbkO3WqPEsHkt+JH11PcuH59z0JuU
         YF2w==
X-Forwarded-Encrypted: i=1; AJvYcCVgCQHDp3KN8L53VhMYQq6Yv8ltaCYKyQWOHvWZF5A5MT7kxWSrjAFbKewtDkkNpVfCRnA6r5lXJZUffQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWUXEGOscXRiauDqSrD68gqOHAidRt17Jj7kW+u6skUBrYF9x
	0MpfgcikIp2gTSmlZoPZuJyubR0Z1IGlnnvXIbQH2ecg4d3ENUdfbAqQ3qQQHBD1pWPPYEc4WOL
	cvhZSafAa0bhqDQv9S5FkkHvqKAuu/pK9kpVq1lzUMJG6FG8cKwMsHbO8nNNidc8=
X-Gm-Gg: ASbGncv1oWeAuNsJL1F8zrdXxv7M/z6W8fJmD1JkCm1Qw+8sLFxnvQ9iUQJyd5pOCOE
	ZPHxoouma02Ca09NPIbkICFC5zCoV+2XOvkiRTkxVtbgilpqef8QAJNE9JCCvr/48ase6VCmpw6
	GMGTXB4rVyUeeUbJLqN7iJmzufiTpplV90U1HyaT8iA7MOQI3u7zqjpfxMAr1zMeK6ijyoWxTys
	bT5bUM9rW0YQwMWF6UQxWq/iRh+s9ot6UujXbmFIcs9jRC1Y+HHxmGy29Xj1vqmcC5ku0qCq1Ac
	VmOb+HXYeojrQQ53Ba0EtMlJp2AHM8+d2qXvScJul3KXAtJ3rptamUa0ILxa4hBtyKw=
X-Received: by 2002:a05:622a:30d:b0:475:6af:9fc4 with SMTP id d75a77b69052e-494527b6a6amr17803931cf.12.1746792052269;
        Fri, 09 May 2025 05:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA8qG9PHS4hQuDEdHbS+SHA5v9z70KPJj7sce2vVbNBZDeYH7Q99+EdTOoVi9pAiRgZujDlw==
X-Received: by 2002:a05:622a:30d:b0:475:6af:9fc4 with SMTP id d75a77b69052e-494527b6a6amr17803571cf.12.1746792051608;
        Fri, 09 May 2025 05:00:51 -0700 (PDT)
Received: from [192.168.65.105] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe5133sm1277192a12.11.2025.05.09.05.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 05:00:51 -0700 (PDT)
Message-ID: <4a72ea06-22a8-4f8c-92ad-b5b3afa25b70@oss.qualcomm.com>
Date: Fri, 9 May 2025 14:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/11] scsi: ufs: qcom : Introduce phy_power_on/off
 wrapper function
To: Nitin Rawat <quic_nitirawa@quicinc.com>, vkoul@kernel.org,
        kishon@kernel.org, manivannan.sadhasivam@linaro.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        bvanassche@acm.org, andersson@kernel.org, neil.armstrong@linaro.org
Cc: quic_rdwivedi@quicinc.com, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20250503162440.2954-1-quic_nitirawa@quicinc.com>
 <20250503162440.2954-11-quic_nitirawa@quicinc.com>
 <58d913b8-0715-41b0-883a-423f29cb5a8c@oss.qualcomm.com>
 <be69cd1e-c04c-4976-9be1-390631316d3f@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <be69cd1e-c04c-4976-9be1-390631316d3f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LUWaqHg6eMat12gRRGNYTtePYlBY8-Gx
X-Proofpoint-ORIG-GUID: LUWaqHg6eMat12gRRGNYTtePYlBY8-Gx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExNSBTYWx0ZWRfXw/6MDupfA/jJ
 hWIK2MprP8bRI3I9rmOUF4Bq1R0cNynhIY657miK75JqSOAPh5YUeqSdcVBSo6+9YoSj7MkIaDP
 hySQs90b0NmR2DyoB8TVXRscEvpCUoWIexibsVsTjYyYh2Z/ywladq6d2GLfdHwpORmYYYyDMiE
 SO5BLyC7xVUnIRf+2DRp00QmXQa7n8+19In4HWks8CtBmPSNqodvmRs8JzA/nKYCPEwq/1DoRPa
 5HQUikKS+x8QGBockXHDInPALBWHOn5cYPoPhgaFNHYfEGPbp1BbAcSs4PBdWecQBzlQEqqPsh6
 tRYnWgFf8Ojo2OcZ2PXLBvyR5QqMHaKMxALeA+xPSn99cFKOq+9Jx+z4qAjPBPh6sjZXP4e4dxE
 ddAkwcyL1J86rdRmZdqNwzqz9YGEMZhV8s59okuJddIhX51MUeDxy2DFQSR1BWSDcIRr4XJG
X-Authority-Analysis: v=2.4 cv=e/4GSbp/ c=1 sm=1 tr=0 ts=681dee75 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=ZEsPLPZzlgAfrG_QwPwA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=842 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090115

On 5/9/25 1:49 PM, Nitin Rawat wrote:
> 
> 
> On 5/9/2025 5:07 PM, Konrad Dybcio wrote:
>> On 5/3/25 6:24 PM, Nitin Rawat wrote:
>>> Introduce ufs_qcom_phy_power_on and ufs_qcom_phy_power_off wrapper
>>> functions with mutex protection to ensure safe usage of is_phy_pwr_on
>>> and prevent possible race conditions.
>>>
>>> Co-developed-by: Can Guo <quic_cang@quicinc.com>
>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>> ---
>>
>> The PHY framework does the same thing internally already, this seems
>> unnecessary
> 
> Hi Konrad,
> 
> Thanks for the review. There are scenarios where ufshcd_link_startup() can call ufshcd_vops_link_startup_notify() multiple times during retries. This leads to the PHY reference count increasing continuously, preventing proper re-initialization of the PHY.

I'm assuming you're talking about the scenario where it jumps into
ufs_qcom_power_up_sequence() - you have a label in there called
`out_disable_phy` - add a phy_power_off() after phy_calibrate if
things fail and you should be good to go if I'm reading things right.

Please include something resembling a call stack in the commit message,
as currently everyone reviewing this has to make guesses about why this
needs to be done


> Recently, this issue was addressed with patch 7bac65687510 ("scsi: ufs:
> qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()"). However, I still want to maintain a reference count (ref_cnt) to safeguard against similar conditions in the code. Additionally, this approach helps avoid unnecessary phy_power_on and phy_power_off calls. Please let me know your thoughts.

These unnecessary calls only amount to a couple of jumps and compares,
just like your wrappers, as the framework keeps track of the enable
count as well

Konrad

