Return-Path: <linux-kernel+bounces-864560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F54BFB13E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CE73AD793
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA3311C2C;
	Wed, 22 Oct 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7CsAmVN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714B30FC36
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124033; cv=none; b=Phr1Yp/x4222NiF7uqDR/Qv2kBtEB4ksbE+PE5Uiap1spzsEWuf0B49lcjTu8gLRpnWb7fUulsakZeyit4YIsOgdjypMiT7pjRSl6ZWb+N6o2ZPT2/O+cfreQLYrkghsjIcZ5wp7LfgSYFWfrHlffOg1WUXvv1iR65T9+UavIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124033; c=relaxed/simple;
	bh=U4ATiaoxVhB58bsNx8X3rRPvC7i5hP65Ww/6KwlSMVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCuk8usf6k7KLvllyfw884bKzJXfWncayZVKaN3CDzR5VJKzaL4ptFVLmmSSUpvI6S3p9I60fUXBReMNtX2TGwmfaZpSNsxQ60q4lHkpumvQ0lelQZHKmaPuNF4TrFzkugSopNSRqgdGI6oco+zmJOzKk0Bpx0ITnF4ICFZytC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B7CsAmVN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3QKPH026895
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UX1Oq/GaByCG4cqqLwGQJt8fbmbuId7BfFpYOsktJPI=; b=B7CsAmVNe3dx5tPm
	eYyBlVnazGBigaD3EYsn3RlB6lP/3E9Z/azL7stitoN8/8qgJTaPzbsEkbDcRm5z
	WFjFe07/dSPywv6gC3+netGDe3qH7JY2qTZiDxMfo52gYDSUVJWWTCL6wxTLcVpR
	TMKL9a/lbNMk83CNPrL3uBc/b4sGhsAB9s/lAUlEpZQG94yRo5ZgRB2Ki4DoXjvH
	ixpCXBXv41OUHhLv1QSjw7TweXrlPrw5oFxwWVYmjq6SveWCTJw/9m3YlpnEe94O
	H0/JHThywFuwQ8dylGEwEED+0vaCaJBsmnBL5r/mY4qAs7N1h76dJUc3YIlbIW0F
	D/rzDA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pm8be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:07:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so5444618a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124028; x=1761728828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX1Oq/GaByCG4cqqLwGQJt8fbmbuId7BfFpYOsktJPI=;
        b=mPGbIW603215iiCsO7wm4EdlX9f/NEfoPOfcr0YnznFrNznmKARlxRARroqt6WOU7B
         1zDGZFBB7uGaGpbMUJBQTb5m5UN2y+/+cK7zfnid60ZrOSPavE3vHqyNeSbZyz7QiSWU
         62deWElvOgzDli1yhJ01mxRROuFl1MHQwVU/jL+05TSC6ivFH5LlQ+GBpng8SX1ZkMPa
         8UgH2L9wariFP4Yf2BnaSl0UI2Gf68qmCh2Nq5XvzRPj0T7nuUd5lZQh6E4fIRwYOoUL
         yjlkNYPfSs1dthJbfvwtyCFEO0UUHHuePbrdgMxrln68UZT+HqpdC2aAn6AC2Ld/plHk
         yisg==
X-Forwarded-Encrypted: i=1; AJvYcCVdSOqKSFd7xpiNzYfCmZSm/KojPeoDoaCyCK1V1bgImbwqyRGQ5QK6v+XKOE6r+tm36viDYlk8Cw3AV/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAZDbC/ThKS8UJDzd1bxwpG+/h00PKNe3OLkWZ4j9bMyvuHlR
	0RQVRWgfx4AcYiB+Y0q8j3B9Rc3cLjv78VevEPbC3XMqsHYWy1/IdLsXCGXbfo4q+PROqIqBdF0
	5GCQtODTlduqNFMsG59/Incg5xKcIkw1vs+VPHErgcnj6Nty7s72Vj7OJdPytPOkoxmM=
X-Gm-Gg: ASbGnct4WV+MPix2CTZebujCZdZJ6A7YkFDlKMbnoxu/+bgc+l5sH184bg4oBtYiees
	k5DhgCVEc6z50GBxtxwL9exFUl1umZwk1kBKvFk9KRN0I733ATd5B5FUWQJir2CY/ODUAB69lk9
	DzjyweA2dHWWfdib7GXBnVHo2dt4t2a1EBGq1MEJZjNRc+Slqbi6uEJRkFF2c/u1qdidyMIIwSC
	7kuwP0fWjdl1otHYpOPIEFIeMsbnTkrFDatn2jh/IGqzlA+SDqxyUllCkMiW5UY9B6JOaWk+Myr
	34SF/+gohxoaUoTDatIaow2O7pMJrv8ioLdQ1zwpepRzaSMIjM6pewgy75nnAhny4dhccJSSDHB
	SgL8UuKhqsv22N51RJ7VE0EO2PJppwQHBe1fgALfM2Fp7nKfbQDn4K2t2VylNjXqxJd46
X-Received: by 2002:a17:90b:3ec6:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-33bcf8f924emr29437652a91.26.1761124027940;
        Wed, 22 Oct 2025 02:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYnE7/JebDCjKfWg4uloOPxh1RmrBCn+nnraZDMpeo8BYYdxfdxmAhCwzmMViUUHj4rDoFCw==
X-Received: by 2002:a17:90b:3ec6:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-33bcf8f924emr29437609a91.26.1761124027467;
        Wed, 22 Oct 2025 02:07:07 -0700 (PDT)
Received: from [10.133.33.84] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dd9d6sm1941797a91.7.2025.10.22.02.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:07:07 -0700 (PDT)
Message-ID: <7901b3f0-72ff-401b-8ed7-86b8bfb083cc@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 17:07:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dt-bindings: firmware: qcom,scm: Document SCM on
 Kaanapali SOC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@linaro.org>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-3-3cd3f390f3e2@oss.qualcomm.com>
 <jqunb52dy2kyygpolf5ct72j3uktln47qppuhfczazowykatt5@3bg2c6umqw52>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <jqunb52dy2kyygpolf5ct72j3uktln47qppuhfczazowykatt5@3bg2c6umqw52>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX6mejSzpLH6Vb
 +wQSZfguqDsrGFUKSb31K7aUhlwylRzIivZ/UxL9iMr1KzR9EV/Tto0NL5gt7Mkla3OW4XRxcpK
 SU2dKChBLbjMzfaxHaIt6T6eDeu6Swatp9JRGSuc/9CE+fR53wRhgvIFWg69fHT1gJ93gA0wbu3
 PeLUUWp7cIedN+XX/9WPhHCt385IE5zeAf+DOUBiblPeKaGynwkt160/MEH74H5lJqBzyTRor2x
 FH4FqAvKyYze6NK62wkrEv7UyeVwENxWzLpJeO8feVx55MaVqTvUqRysu2j1ChXqwrnkrP4gBML
 k43dMRCe2BuR1H61Pd25Y3ffZGQ9tb1N6usDZKdLmYYzlL7dWnmhFQ/IDrL6p9yXpdDxuueIDSu
 I3RSxvNOPKCWtCVkh/4mDa326Rmf9w==
X-Proofpoint-GUID: MKu09f5XFGg9ura7LRUU4FI_NdLTLBhF
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f89ebd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=sM6Lb9GqGZImNCjOUggA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MKu09f5XFGg9ura7LRUU4FI_NdLTLBhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000



On 10/22/2025 4:50 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 22, 2025 at 12:28:43AM -0700, Jingyi Wang wrote:
>> Document scm compatible for the Qualcomm Kaanapali SoC.
> 
> SCM, not scm
> 
Will fix

Thanks,
Jingyi

>>
>> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 


