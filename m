Return-Path: <linux-kernel+bounces-820856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D4B7F78D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28353A29D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B379132898B;
	Wed, 17 Sep 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T1F1gnen"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87697328962
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116340; cv=none; b=JwQPIzrn4q/wtEAEh8SZOV4W+i0SdmDKmRBi8TuacKdSXkt4F3T2XRXrZSAl5/lQ2xUeVwL69GS2N6ic905YGX8liFmP69h4DsD72mEtn/auQb2XY4pLBnHMxE6kdk67Zt2I99i+rtbzmlNUP04mqKBvPWAtjb9iHHH/gBELg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116340; c=relaxed/simple;
	bh=wmnaUoeLg54xR4kD8RVtS7d/+a4+fnfXhWXtZ54xcWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8SfURZD8Gj1omI92b3VbS81NN7F40skwc+BCuX++7aTY/Yu0hFWhe72G9XHpGSfVebDDUndhM+oM3jBqEc1MzWZYvkE5ns2IFf4xMqPQ46dpx0UrWIusD/VFOtXgwpwjyIvGt1URZh2azbf0oHjrRRo/6lic0zDRRa2cjZDs5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T1F1gnen; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XYVg018237
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4FR8amwe27Ylu/pUP+vY72tN0Ut6/tbsNkz8y6d1L3c=; b=T1F1gnen/pG2HG6Z
	EKF3zowmzP0ugVBn1c2uzcxqi8lff66lKgjVIFJK62pTeSOPXR90ohiYIl6/Hnxj
	yQHrtzv24MnltrHmmpmYy/pSB8+DHtYbrVKAVMVlT9zt092i5DERdRZmsqSsoqVZ
	XhgsB/ro8WrCGujQ9XtCl4pkzky+GWJ5MBclBZpxGRo8QBEH3mN4I4ovwfR/vKk6
	jWYdXgt42FziZhR+GsBq+mNaaaLa78R/MlIa0ZIt671PwvBdHccuWCn5+nD2cxj1
	Ohjegv5Cro7+P7obqgaa2vuCHfwaJPZwrUZXUibOcz3aIbBXYx7PsGaITJ4ooCyF
	T2qpbA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwagvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b7a8229679so3727911cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116336; x=1758721136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FR8amwe27Ylu/pUP+vY72tN0Ut6/tbsNkz8y6d1L3c=;
        b=itdUhs0nke0sFCSRkWfiuoyc21UBgEmqmjOnr1DO12JULRmOISRJp2ZbdxKi2m4+eM
         P5vHRMQ9bOqGiGBsj6BejfpvUH0KZ42A0t7txZmw/ttdEbD6+bohF2kjwWpLtGQ/Ng5k
         APgcV/FSSqMPH9yDbl9twIIzHeN9Sk67ghwot8TZii+AkY4SCHC5LRkEUo3YsJ6kpQL+
         XhfvPqA1bMzdzAqnVq6PNbL5jcFxKYb+LCfIHPUZIUSqy5sLVhxevAZ/zap7tUPMBLHX
         nTH0KAfhYtUIA7T6Q6J05mpnJUXRtblg5bn3kB0A41nDHA2O8S1Y1v2C8UetWbCxgvvT
         5aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvcVrG79qXHDHX8RzoteTaNC8W2ioFaPRxuwbQEINNiQG0YNx2dgqxdRvvM2a2n8wVn4Q4QoEMETL3cJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlQkkbvs/RM5SjlN7UsS9ayT6SiiNALp0gSbBRXSdaFO8M+wF
	CkdkZXTALvJJ0Xwue40AbjVzntQSruTT01CmLIGfyVNcb5qTe7PY9w3XSefS8LeS3EaTHH33Bks
	hPjJzEn4ElUXAMgGT71DuqJdyC27AHM/5BtYIGKcQHPTK/Qu6Gq8ELYWwSHLp39kdQQQ=
X-Gm-Gg: ASbGnculjtB25OgbR3ndSoptiQQ1EhmUaHbqHo3jKbGfB3z0UBGqMnS/JwAg+rbNKKr
	DYwphF3fWwxS+NquWmV6JU5UeGjxEF6gYF9e3iMILJN1O9OUbmwDB/VaCscGdJmhTST+y73MJPR
	vaThXj5AoJbjkTBReaZRa2QmhM/zfvYv0LiCEPqeFIJSXF+nNO8ipxkRX8YF6mffWKuDzWgl8bX
	B1ERiYVTYPwsXs7LCWDHR+LcbqVKosTysePC1kzNsZKph5cz7FOzhhrGWyIx54rrw7B18QxYXVx
	CYjWIBgFOBJDH7aMyLAO9uRHtbCqYNgvn0n5GV2j0y7eSIjbLtO5byGq1z90P+vC3+PuYWVuG9C
	3qiIVf0ctwdgICCo+NVhO7A==
X-Received: by 2002:a05:622a:34e:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4ba6a201826mr17337391cf.9.1758116336284;
        Wed, 17 Sep 2025 06:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmQ7zvxYEQCcz1LV/ubwUUWJATtIDKSxIlQFAS7llfXEprD3GrYMvTESV9fbgINseDhj8YWw==
X-Received: by 2002:a05:622a:34e:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4ba6a201826mr17337101cf.9.1758116335644;
        Wed, 17 Sep 2025 06:38:55 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3128506sm1379313066b.28.2025.09.17.06.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:38:54 -0700 (PDT)
Message-ID: <324327b3-7773-4abe-9628-c191685ea646@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] arm64: dts: qcom: sdm845-lg-common: Sort nodes
 and properties
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-1-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-1-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cab9f1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=Gbw9aFdXAAAA:8
 a=EUspDBNiAAAA:8 a=JkoFm2tBDPzt1COVDkcA:9 a=QEXdDO2ut3YA:10 a=5XHQ0vS7sDUA:10
 a=IQdlk4_VRkkA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/i9/e7KxBy6w
 uLbLp1ZDpvjhVfL0FF+t+WdwmWtbX3hqajyyXVXOHeC6r4rKzPinftri1ufMFarUjh2KzFMbnaw
 UJMuhS07G4jQ5RlVfQ5ThZEuTX3ww0GyKI7IuInlhbUHXeVqI+hdmscDVHDxElE8n6OwhFFmKzq
 h0E3qiLvGj8nYe2kngOaqPW9/s9FuS+XTByFgQUg04pXGPT+KBd4ORLQUCJBpio4Ht3fX1Hgtau
 KBOqH8zbpYdlTHxGUNtL3Z65lYUDTA3KUpd8L2itZE2YB816vw/rdGqlvVRJ/JqNDIuZdS+i0+W
 L2+pUoTKU1oPiBJIjMoHIh3i0WqvAhiU67me5jyeX3KN6vEA8Fb+lYzYlMojgaV1feCwts45c3H
 gvNc19jy
X-Proofpoint-GUID: -7IMNYFgHnQfTstFhOmzIHZWfziaPjUO
X-Proofpoint-ORIG-GUID: -7IMNYFgHnQfTstFhOmzIHZWfziaPjUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> in accordance with:
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

