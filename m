Return-Path: <linux-kernel+bounces-816302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CEB57203
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0310189F48C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809C2EA74C;
	Mon, 15 Sep 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYcBq/rp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222A2E2DFE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922608; cv=none; b=TkVnJiKxwmZXsNlfFc0LqwoPWH3FLLbP/lRoilBDheNQN0gBaHfWMGMLvaLAJn+SXEOvH+Y2mW+Jh5EXmcIfqHfnDHMrWlvhRy9gHl5Lpa3dUDU7l2nncVcL3S6eS0mCKPfimK24tVSkmeN2rdTX+gh/81N2579n4iyCjMeahHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922608; c=relaxed/simple;
	bh=imIwfrWHj9CQmVA/0RQBUojS0AI0wdZSgd77TEu3Ta8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAZEf97PBfLkV2ZF5ae7ffc2mXoslOI7GxVh/fpxUqWyGl4iYWPzxLFJSVn8dSK7WdN6gQEjWImBGEAc53Y/XEjjvd5VRL+qeOv0lPPBhJsj29IZC+mXxgMwAGt7wdjOGqosUp1iI/FJ9x8y5TxOFN2JLuHg6tHofPK+vJqQ4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYcBq/rp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7I1Nr004787
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aFvQk9L7Sc2ogFTfxkGGaTbBywW0snMelbktXcT6biA=; b=AYcBq/rpbD2QYOl2
	Vheqdu7hdaICz4pS+OWcBxCqTLqbcGJB1VWwddADXBRZxUOiPVtTjq6X77fqdSkD
	4N041k8wIxUbo+/t3c2BDk+rkrrg0qvuSbinBlUzw6WYQH6/aXRXGvQD3dxEW2PR
	WcNS9GKOfm9C4BujrPfpdD7nRVafEXHKMC7caQn6gWsbe/e7vn8ADGf4O06KhLNH
	saSmA/s4ZS0i0h22wBkBk71nwtREAn2qGPA6E7a+G+1J5oxNFH/XqQddckHnPX3I
	0WPCA5pG1dPU2mGKrf/yf1HA3snef0KrWqRIm9YBLRD2Ql473Gph+Jo7l9+d1giY
	KXxrgQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495072kxek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:50:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-82aa446f7f2so7242785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757922605; x=1758527405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFvQk9L7Sc2ogFTfxkGGaTbBywW0snMelbktXcT6biA=;
        b=FtIg5bFM5n1EjeP0GUOWgAdDkYrojcILXJHqBzvNtHiyVGYxz9UdGo/MpLEOgMgpBs
         YpfMCQ+Zvd4WYP2Pd0X2Wq5FFiastZD/2cDbF0eKMXVT+HEivQ+4aV3GJ19LOGWyf92e
         a140+mTH1c2EXV79tD2+8Fc1+natqTN2rnUtfRa7vGE1Sj0kZKXYO36pDwjULKCnrvX6
         BmZ3x7KIKovfBlB8SgFFPDTFVmBomKhjj04FJRv+lMbgc63nbkUP6PK/ZNmyyd6MqdAK
         +Gdb7RpNV49QeKVYbegMhK0UiVUGf6V31scheJaZ6NL4uYBfiuVqUtFt8ffo4Wne/Fr/
         n3pw==
X-Gm-Message-State: AOJu0YzMGGMQ+uZbb+6Vm6XA9aKi4dovrk6RFRvoXmTnTcV0QFNkYUi0
	/uCEZB/kcjE4Fx4Pt4i8G2VDAuVeFHvpjPREC2WUrPtUwo+TM1NLEm/ET24rXoXbQ6nKwYVhpWV
	jpOGebGYYH/3rdOkSbg9ZTsjsMewqJ15KbGx7yAYn8zZmpm8qjGlnEEr4Dul0veiBw9Q=
X-Gm-Gg: ASbGnctAP2bZgZp6GDd6TurBcn0rcQm4cfB4Zmg/2gAJXKin2fG0jM+1VllcIk63fAU
	91r9P/8hX8ANjjjpxgUHR4iDA/ogyuPnt4dIaCmjwY5udZS46eXi/vr6Aox6GV8c4gAaFpzAxeV
	pAlbBLSNSGBIzCN3A1YUQTjBZ9WW8d9AHILxKQHUfgCZTW/eO6XNoxVZrT35dxm9aocud5NaloA
	NxQUJnUAyIBfpzM0oUimQhZw7dyYSa5kkGtW6Y+WhEGebYJyJXW6wSE91A2TzwbO4Yeqehbv9XE
	KsLaeWVMZJI6cTAbO5DCOeuNC4fEuJxDdUrD+CxmiF5aZ43cJ3pozX6iGc7lKghcj+yZfUrj3ok
	FztM2o+wSaam4otInRB5SOA==
X-Received: by 2002:ac8:7c44:0:b0:4b5:6f48:e555 with SMTP id d75a77b69052e-4b77cfd4f60mr94842161cf.5.1757922604562;
        Mon, 15 Sep 2025 00:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAflOJ54Lq3cHAk5vIwFH55/fPyxggfOmOlLP0TjHN6i+XfS8IJFnTqbJiNsxJwWBvExHJhg==
X-Received: by 2002:ac8:7c44:0:b0:4b5:6f48:e555 with SMTP id d75a77b69052e-4b77cfd4f60mr94842051cf.5.1757922603937;
        Mon, 15 Sep 2025 00:50:03 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3347b90sm878500866b.109.2025.09.15.00.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:50:03 -0700 (PDT)
Message-ID: <c9c0ceeb-d9ee-49b9-a8c9-f4a4d13ccd96@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sdm845-starqltechn: remove
 (address|size)-cells
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250912-starqltechn-correct_max77705_nodes-v3-0-4ce9f694ecd9@gmail.com>
 <20250912-starqltechn-correct_max77705_nodes-v3-2-4ce9f694ecd9@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250912-starqltechn-correct_max77705_nodes-v3-2-4ce9f694ecd9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfXzc+0Vf0RPMqy
 iBfc4OSe7+myn1AO7WRqUDrJxmZqLY7IjFpBCGNWx8zAy3h/dIN2D4g30cOA212RNT0hE5GoV9z
 3rqeW3yhngcM7CjUu6tTYKJeCsy5tGh3l7EbKSqka3c3Hj/R1qIXyfy5+nLrIruwVzxqBD6GZzu
 8JfjWjxAX+t7BEY/DUsKAVYrmkmN5lWPpbcmojibBpd7c98eHOle/cbZu6NGQmq5t18vNFknI8j
 TlNQ8qXLcj456oQFjK4laGCozP+fT6ZMhhxCzO8UisJvOd0o/ad8kWi5TXPAQygI1ySjPMinuTe
 99+KZwnTbDCjwt4s/AIZ9qhhJiCMsXLGD55HVg7+oL+IlMMWjm0Se7N8wDNSqQPgBq/ckGpnQvC
 ECZ3ql2p
X-Proofpoint-GUID: jEc4ka7T2PSGf9JT3zqC3yJFSYL0KyrS
X-Authority-Analysis: v=2.4 cv=WcsMa1hX c=1 sm=1 tr=0 ts=68c7c52d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=xr6KYs1_5vtqEaBoEi4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: jEc4ka7T2PSGf9JT3zqC3yJFSYL0KyrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130025

On 9/12/25 6:47 PM, Dzmitry Sankouski wrote:
> Drop the unused address/size-cells properties to silence the DT
> checker warning:
> 
> pmic@66 (maxim,max77705): '#address-cells', '#size-cells' do not
> match any of the regexes: '^pinctrl-[0-9]+$'
> 
> Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

