Return-Path: <linux-kernel+bounces-888834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF9C3C066
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77272189F52F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B19284889;
	Thu,  6 Nov 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LFpsDnqX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WzAKjhsg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D426270EAB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442634; cv=none; b=bExHjA5v1+HLPdvgHyYGo2hbdu8GAHGfWej/VTkyQn7+gkikUdUwfRc5GcVfKiSCYVZfTkk63AE452aCCwW8s4axCc3o8YgFogRTBhTkIdHxKg/ST1ug+xpvM2JUPVs8ynAbgCunTmNfBfVvOSp1+WyC7onTuZC4ulFA1ZdQ2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442634; c=relaxed/simple;
	bh=HCaYR4YVOukbLj7jhdYFa5FxgeZeqJDhW58mi5gV+F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otrGRHGS57WEf4TwNM6Wbi5Ti2bWLEiXQN8T9AzBKDVxLrMgg+c2NIL13mD9bY7AA1bjTa3ZFXLtghuTXAQ4/iSUkoosQz5ZnnFIVIXRC/cmuLGvZ6MP23uC8hKbQHeyh/paANluJRGcy55asfUa2rnrqs4sFKDGpihniB8PDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LFpsDnqX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WzAKjhsg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6CYA0P3217502
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 15:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AM2sfMtEfOa7KhDU3VgLqOS5fRlov02lYAgiXrnPdFE=; b=LFpsDnqXbN5J8HSQ
	p5kjOSYW7NDB+pDWWE86gHRIbIOit/osKG0RvSt1cF06nYypOIayGHXkO6hKf0XH
	zzbZ2iKK5vvj0g1NC87dQtIXYKN7xyd8DkE8wIHb97KvSLbBYOnHjCrwr1s6oc6T
	BudvlhVhTXK519NdZoVa3FRJ5JH8/nsn7NRRAjADGVQNX2v42Sv50atDxK0u7WuG
	e7lyl4iIi6T5213YsmUOfuqSVuAWNJU1kzKlK/hYV5RxKIChxNdLl5u4Bta80RDo
	NR6H+h5gfeRcNaKpmVYxKxY5uOBgHeajzXCefNxW24cYeQkiHvrIRVLqJbnH35QJ
	MVDcYw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8n7phr3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:23:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77f610f7325so994470b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762442632; x=1763047432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AM2sfMtEfOa7KhDU3VgLqOS5fRlov02lYAgiXrnPdFE=;
        b=WzAKjhsgwV4QJ+wjd1POxOX40IHgmBnAy5HIZutRzZKRlICHjSytmp4u7oveVkHzgn
         V75oMiRGYmhby6l+k8sUPFcacTgWIbZWBQYYhHWyJ3MuvoDcuJ1EIuq2oWylvMnnTaIj
         86DY9mYaT7FMU752ZZaLH0qZdEf+/4QwUG1GL0wyuhQ3blcE5nnS1yj124R1wRQoRGv0
         KFVMvmf+ngnn5IHXrtPrO2isS8kLUCCjaSztavY31TSe18H5yChjtYujV2rIpK7/DDXA
         Bqe2XXI/zVGwcz0CZxZNin2IoSQDoNOoDcyIk46K13iMGUubfjhtuQm3HYL6xRxLSjCG
         MVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442632; x=1763047432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM2sfMtEfOa7KhDU3VgLqOS5fRlov02lYAgiXrnPdFE=;
        b=hRqYgPnZGss+RlHDC20wc7riqiT2IobyHn/pOaaZj7plETdPOKeOiE4z3p45zDqow0
         6/I2rS6ERtU/TSrLeXvgfqNneX+f85Dkl3D1j6nMNaHeVyF22YWMRMLcBM1z6VELt8TI
         AW0WnION6k0cVx0LUe1M1n4oa9DPMYcVTWA1Bqiz1QdUI6SkQ7/HfyDerze1N49M37Qp
         hBXoSWu9IaiqfprTtUJmtxKWC4LXH+MXYoe5KphuOQhbCo4F9iOiPLSloS4waowxoGyH
         uvneoXBlA9CK/lrak61dWmVlY7gA080rP8ITaASSNM7FUZSxuiVIz4j341IcbG+B8Mi6
         +wXg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9b/zDn+T1qfJ3BN0jhF6lHgBca5Wg+f5Xj+0sMG6gjcyTCI9K33sVzDqpU39yuiU8EXxQrU75oloae4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWP2zd3ReB2NmHg9s2wAniFXK+PC5zSnSDLlN3o5Serk6Vs1Z2
	wWGYvCsd2fqN7BJcCTVyvKBry6k7b61LEhZkFrqxzqVYK+R7//niNoPvoe8Y/t6JhWHu/9LRc9R
	Z+ISfedr8yfmqiqfWCLQAOGuUDv1ZzDqGBUsdfwO2CLqOusjzCzwRrmwQJsAxQLLmuvE=
X-Gm-Gg: ASbGncvwWnIRU/Hy8DOsmhglnlpMJpCUKGLm3Vt1vjROpBP2UB9CprD+HgAx0HYDEqr
	yaItzu9wgsn37ZJokSUhzzX1uerq/zVAIuZSnMTo1wAyMLYKVLTPkRK//+viwbCGEGTk9atPMnm
	BRz1g7DQJ84Fjz3wrNtj8hlDsbmX7yAUXJnkKJQGQiEg7leqo9iSC527Olmzuf2J6wPd2CM5yaI
	NKfmCe3bPotvZ3wBTiXhRI8v7LSmIRcNcCrIjZSu9v2Rx/zdUuTVdh/WH9c9N4B4XU6XkODfieA
	3o0Q3B3EE0mspSgkk2pKiu6N7/YfpImt+K7I+4/OJ5VVOcMk1NNeAGYoMXkowYzr6+LDavt26+l
	CxILn6Z/oTHLoi6uUVm+Gosh6ZMb8OP720w==
X-Received: by 2002:a05:6a20:7294:b0:344:97a7:8c5c with SMTP id adf61e73a8af0-34f868ec5acmr9474788637.48.1762442631924;
        Thu, 06 Nov 2025 07:23:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF97e0GXoOncAGOrjI2ScllFLDrtpqS3SjsIAfKcVzSGuS3VIsb+Ftj9YpLE5DE7gJppyEwPQ==
X-Received: by 2002:a05:6a20:7294:b0:344:97a7:8c5c with SMTP id adf61e73a8af0-34f868ec5acmr9474750637.48.1762442631390;
        Thu, 06 Nov 2025 07:23:51 -0800 (PST)
Received: from [192.168.1.3] ([182.65.157.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b698asm6878934a91.21.2025.11.06.07.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 07:23:51 -0800 (PST)
Message-ID: <65a910ff-61ae-41a8-b5aa-9a7a119fb13d@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 20:53:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251102164819.2798754-1-krishna.kurapati@oss.qualcomm.com>
 <20251102164819.2798754-3-krishna.kurapati@oss.qualcomm.com>
 <aQxyfjYosVd_kPKC@kuha.fi.intel.com> <aQx1WVif-vgN0_T-@kuha.fi.intel.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <aQx1WVif-vgN0_T-@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lGvPxjkfmB88GTlhtihwVIfrkmDFhFYM
X-Proofpoint-GUID: lGvPxjkfmB88GTlhtihwVIfrkmDFhFYM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEyMiBTYWx0ZWRfX9RsXHZt1ROEH
 BrD9iRY3kB8lAEOljf+fH1f1AsWge7r8yzhCWehTDv8PVks5tVJJ1XGJQP22WHdhs6b34p1Vkrl
 IIGKX+EYi6bC4gRahh7tFXP6Vlf/tGKe6Lk9Prp5lqqoPCIsDe7sGdL7BBpWXP+6L9PGv4YBeTn
 rCpZziISfzU/to91Lha3Ndcv8ajJNiiTeymapTSQYLoYUWE1f0e1bE3vBLP3W6wc6WAq1hSDz+p
 hZnUM3mWLVEDvXXweIBglpF/Jjw8ZHxCc1uihph/Uk0smu5/l+f9yhtpTM/Jsdhj2jvgH24GeUW
 VmskfKeudJIknt0ohmAbs/+JuvdPsp+vA/DtvxpUtixiSskKRzHKhTnjExEUiNX5pd5b+tbyhP0
 Sq9yivi7ZDAJSFuwZzhqjy8W1PoWaQ==
X-Authority-Analysis: v=2.4 cv=ErnfbCcA c=1 sm=1 tr=0 ts=690cbd88 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fO48qRZoIuIFQjWVjTpNpw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RlX0HteZJ6yL10uBmSMA:9 a=QEXdDO2ut3YA:10
 a=QYH75iMubAgA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060122



On 11/6/2025 3:46 PM, Heikki Krogerus wrote:
>>          struct regulator *vbus;
>>
>>          vbus = devm_of_regulator_get_optional(...
>>          if (IS_ERR(vbus) && vbus != ERR_PTR(-ENODEV))
>>                  return PTR_ERR(vbus);
>>
>>          hd3ss3220->vbus = vbus;
> 
> Sorry, that has to be:
> 
>          hd3ss3220->vbus = vbus == ERR_PTR(-ENODEV) ? NULL : vbus;
> 
> 

Thanks for the review Heikki.
Will update the suggestions in next revision.

Regards,
Krishna,

