Return-Path: <linux-kernel+bounces-721579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E1AFCB31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EA53AA773
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49626D4F7;
	Tue,  8 Jul 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3Z7WCht"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AE2264A6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979615; cv=none; b=eLpmu3keD87D5ezBvQ2iZh+qhzMBsFMsd2DwtWSmHceeHKH0qJLHAnZR3tGOaiZpffwpykxLKzFxJx+UmrixviFWvlZZvq3tZ0B8bdGdy2/KBMtSThVMZJlXkMhqwPsb3KN33NvKeoGhkw4on8A4lIKTNX6aWKHGRoygQvqPGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979615; c=relaxed/simple;
	bh=zQXHKtgpAU/Cz2/90XNDOZ/2DON5pPdweIU7vev4U2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV+RvbVy5QIbI28NYxPKD65mu31PP5Zsz3mzDjXsHowe/9ve6U+UfRIXNefbrwyvX8kkQCNCtdhrKnBQhvAPLnkGkzfSF9mfDZ1XpRWnTaRaSKJoEmWig4BDH1ndIHJnKpTnWBQ5EJWYA4KA5uSUQyXL8D9p2dJnF8aY21+169Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3Z7WCht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAS0I012557
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 13:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZ7nQ9K9etHDUg75souiQvkrDKhzX8ysd2chrySYPb8=; b=g3Z7WChtPvkD6+Kf
	UtEsgALJRRLZyvLm8daLuuvak3X0J35m6mDyYitbXbM2RgUhtvN+dRkemoHwH36A
	bb0nRYIhpLoQR/cDI7dTgtOMazU7aAihsnkPX43752zPguzLI6dCQ+CRqQS+KCoi
	xlf31LRetsLZxT/iCwp2eH83goHZB0oypNJBaxtwppOkDjMN/BhA4eSJ8iLgplyW
	dEI4O5mv74ffY/JtRgLHaD17wQMM9tZ8/0vxbNgaS6IirQ/0lM2e59U6Al/gXFb7
	1FdmJWsLl4XH8+3sFvw3uzoEzhLSyzTU/VMlOrF5oC/Ffya+uCrilqllOkL6tf/i
	cu8S9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv97n8xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:00:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d41d65f21eso29432285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751979612; x=1752584412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ7nQ9K9etHDUg75souiQvkrDKhzX8ysd2chrySYPb8=;
        b=kXE6DHyJQ9NCWqQzTrc+XOMPIciv+f4QrRSkp9HhgDdvpIoFdgZ1UM2IE241UOddk1
         vZaj9rpBWCp8jhvmwkp9w7WTqaD4tgHfuzKTTPgeNKBDKGLzD4HBSMFunVYYaRKDkn9s
         zU7hrg4IlPOp+X46hrJdlzxlPEp2h6vjbzAcnMFIUWgEB1ZPcZO0RT8VMlUVZBdLiq7m
         t6CKV+YF1mLlEVQf305u+7SLF84Q79c9K9qqo1xcH87dhmH9Wui5zoY1BKJD/kzpokHt
         3vAdxYbfDwurwsC/AjW6KAfWQs/sC6bi7u05/dVv3ikoq32HR6IpALx7l90wuhaMhDyL
         YnpA==
X-Forwarded-Encrypted: i=1; AJvYcCXaThHA6hoWiMw11G+L91rUyjOA8PeTFXyzc/+Mhl9IlMwZZ/8hFajYyp2n910L3Kc1K/FKSDGVRIPuKtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMXcoIbucjAgRUlt4v8By2FR4x/gR6+h2s9nBH53xAkcGJaSv
	/OcNIQZIKaN9oYqgSQGFUlmT7bxCG93OSaA58uj6W4nPHaxTymKNAJs4GR4RSQqGONzz4kNo6DK
	Uoyknv6nh2xdz4OcoNHSdj51w9Lx/u0Xcq5jobY5dCOSIL03AsUJiPyDcFGRpRm8ZgKY=
X-Gm-Gg: ASbGncvmVKlWLjVcPGtf5v6T3KIGFZr/nyimat1YKhwSTGuWywIp/Vs58R4LjE6bLzV
	5xRmM8/74KOpfwIb6IAsXBq4pC4IWlZdqQKOQzsUYX+z7ql4iFFCMfRZxxCFVBhuLYQkMkji1Rf
	EbcaS1TpIRSzKCMUqzEyRcHo6pA0XSVVmnRy4tU0JpyjgJ+VfCZos5uK38oRf/kdf5tPGc/gyFL
	rhepIWqQKw7hUI02Bsu1ob8Ys8XWBFt9CrfgzuIsi/ubMghZs9bkoG8KZ7iq4h5agTyIFhT0Zxv
	HJ3zOfSsVLhNxPJDK82/MeiqoLPwD7LtEPYu+ZaTWhcdvANyiAIbhd68Dl9IedZlsxhPAxmn9Ih
	oLSA=
X-Received: by 2002:a05:620a:1b85:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7d5ddb72e87mr894471285a.6.1751979611970;
        Tue, 08 Jul 2025 06:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOWeCg8LWYitPQYk8omBFmESpVhxHV/1NeuK7QjbwJP3U2bGrlO4pmbJ+4ikK1Q6UkvlaRXw==
X-Received: by 2002:a05:620a:1b85:b0:7d5:c29a:b41d with SMTP id af79cd13be357-7d5ddb72e87mr894468785a.6.1751979611416;
        Tue, 08 Jul 2025 06:00:11 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949fa6sm901129066b.68.2025.07.08.06.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:00:10 -0700 (PDT)
Message-ID: <b3074aa4-6898-446b-87d4-de8ba2346ded@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] interconnect: qcom: sc8180x: specify num_nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-2-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-2-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FrUF/3rq c=1 sm=1 tr=0 ts=686d165d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=alsCV9giXxwD5S6y2l8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOCBTYWx0ZWRfX+01kL9LymDIj
 DVLIZxzHRsxeaJ6/K4xI0pyokq6nwkik5nzki6D60wOxD1WSg5RhDxTjT8Qh/NniCbncEASlyUo
 CLPv6VQ5aedS3+YQrEil4Gy+ZQ4oDWRxRBzlgjQnSPXtNGUUkue9HCi7nSqqyNpCGLXAANIHNRr
 /W/iYY5aWEH8GAKSLzJoPNzDOFXzLxpXIiib5L/3eBUT8mCqc8k0QS2xMjMxH57+KxCa3tRAgtP
 21AdTomd+30GioX0DoJDBQV7awNBYZ/mCJZ3bXaXGH70/eH0r/7hAmOWYveDCAsdOgDmVfDVpwO
 LD5evYj7z5JwovPaWZHBbGEfaKL898A7jwfshev1ESFBACGG1BrmCwlPrg5iYl1Szs6iGEyclCE
 rUH9wslVdIL5R7yN6uIkqsRYHa+fQJI2O7dVa/DyspGXL3jbHuz5Wls4PqAB83D92fJZnJTN
X-Proofpoint-GUID: is2PCJFgV0MOi78OEZdxW13GUo3zeWFs
X-Proofpoint-ORIG-GUID: is2PCJFgV0MOi78OEZdxW13GUo3zeWFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=788 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080108

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> Specify .num_nodes for several BCMs which missed this declaration.
> 
> Fixes: 04548d4e2798 ("interconnect: qcom: sc8180x: Reformat node and bcm definitions")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

oh wow

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

