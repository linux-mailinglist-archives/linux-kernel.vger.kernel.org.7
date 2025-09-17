Return-Path: <linux-kernel+bounces-820799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D704DB7F406
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5952B480D83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A310244662;
	Wed, 17 Sep 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocnB/XGM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75A33C766
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115462; cv=none; b=bnm50QzHoz5wqi526Dw9MWEIdV5MHz/zP/y04tdx7xjDfGOzvlbEihV8Nq0W3mgF+dJ/s+Cvut38DzJECTe1NqY0rYleKzsLTBOLzk5GaFctzq/lmtsvpjlwc0w7L6/1xW/Ob9lVwXkrUQuER7cFK2g3n12AHIBeA0WueKbteis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115462; c=relaxed/simple;
	bh=bj/BACpeROC8lw+J8b2bN0fD1ySfsfKEilZbae/Zl6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEqR7e5V5GPXpPXD//XqJv4wesnQ6CkxtNDnAmzeGB5aaWfP4LURbtNB7BdoMay0ZNs+7u2EuSMpvtHV1QrPjT+g3YvQbPH2on6W62UIggpMxuFUVEq9gHgpPze7XrZx3lyKizAnE7n8ieAZWI7y6b9ZC3PcCxQBkJirs59Ifoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocnB/XGM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XjPG014321
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8UaA1Alzuj9hbbX3YKQBafNDVZKoSiqpKwrruMOzYFw=; b=ocnB/XGMcqYtd6v4
	SHW/deuOFOng8MN75MJQ8/2RF0AVc8szwffmXa12YbPbzNIT+MnmMrhaIMy4E8NW
	wWhHCj52MPk8Nmry53zCm1d7h6RmW/opFLD6FooNBR9KZoSpJqahm3UXLH1iZB6t
	GP/1ZeJAlk6L6FOJchtp/wtdWkdx8J0w6V1coYhpzS75fEUatTiGG3HOaGPOZI7U
	QsaiNlj+FEdV40SLgNL3aahd7Do9BQ8geTYyqo9bfzU8rjyJAlhBe2DW1j0Z5grd
	kDS6ScAVytN+TForR7734VirlvncgBChsDQI4J+rWMAl2oePBA0D8tt9UMU3Qy+9
	J8tKmA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu2grm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:24:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-780e20b83b3so12313766d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115458; x=1758720258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UaA1Alzuj9hbbX3YKQBafNDVZKoSiqpKwrruMOzYFw=;
        b=KVN9YmrDtIt/r+PFYiBzPM4OHpTVwZbfw5W3Q+f5WKWPfwuFdUYj1lFHOq0IAKZmy+
         RSY6iWXvi2tobH6NNF6wzTkhRpN5qw23W7xHq3e8lYEZBSnGCSD6RlMB69dDKXNNgl1z
         H1Z7HoqP3tFL9FrdupaeI0LDJwigrMqb+mBuSXjIL221eST3fPYnRn177YeiqYM3gqp+
         V66IYQktWzaTvG07tZYhyuixz1FOo1+Xsc8yMahf4bk66d+Ui0o1SlPBryqcDYX1c9KO
         impNw28sNuQHriQa+0Ju6vbxmM0EFwXoJkKNUMySDy8y+QRpCtEEmmlwtiJ7uXe20cM5
         Bzzw==
X-Forwarded-Encrypted: i=1; AJvYcCU4A9Kdi7jXHfeKi8wIH2Y8CGudX/Erasz7HPUIZS6Cj4gme90pWStL7Q2GBXyEAdrHQZ34aSZmkgP3rxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzE5mOG67wzN8gVqoFs4VPmdb9yqc2cyjTuviZjD3xoxFwG4r6
	pU1wy2zK30Qllx/MvAY5ZWL2EPDZUmHtxMM+ScvS/Ot7jSDUEHsSzwDAetIV0gfZmkRK3IdXGUI
	evLl3tyoKlePDQ9Ba/YIzKsQ69jqiF/0kiQbBPY3g+uLkqkN/I2Zm25kSj/GRQVQYZsU=
X-Gm-Gg: ASbGncuSAAOPfYNc8grwG//Y52aNdudEPbfl61DmzBTQV/6OwiHgpWUWvJrHLNPeqzX
	jo7ApCu08cUyI0QBIr/hk0dxOmC0ezGfBYJRu5tOdcXsn89IxXFDnskbzWJMf6CNWRgoI+8d9vA
	tMe8JdJAEH3pvsH7At8xoY6wmHk41gzAEXmVMevN80WCuY+1RqkFFKpsfk0DqROGtoSluIna13T
	aMb9TT4r1CLhBA4J9ZQYcThv1IGwSCFdLXYTtL0QYF90tp+uzBZCwlRcezpiqyX23KRs9++KIdH
	+ynyb12DhR/tRBt2rvNLj1wgv1EnWCV93iMVrjEfkAhrjESnEAcLU8wgY43oL1An6fzdf0xNzX0
	zSPCKCjpk5xzibn+fnP9+CA==
X-Received: by 2002:a05:6214:1c0f:b0:776:6653:c4cc with SMTP id 6a1803df08f44-78ece74a22dmr13485056d6.3.1758115457762;
        Wed, 17 Sep 2025 06:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6mmSdxwVDKEVLfwNysJ/iADklZpu3mgw2fSh+qUBhavczlYOkfMoJa/ppr1K2MifbYqtsyQ==
X-Received: by 2002:a05:6214:1c0f:b0:776:6653:c4cc with SMTP id 6a1803df08f44-78ece74a22dmr13484606d6.3.1758115456985;
        Wed, 17 Sep 2025 06:24:16 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f0c7a5546sm9223456a12.43.2025.09.17.06.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:24:16 -0700 (PDT)
Message-ID: <3b26f3e5-1342-420e-8668-10376aecb127@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:24:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Flatten usb controller nodes
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250917123827.671966-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250917123827.671966-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyZBFecWBJ9Wg
 qQdgdPsqbfBZujM0K4IPa3VjjBvIOh3P4YaZMdLFX/TMomWugHeWMtfscmGL+YRoabKP7Wq2gEb
 9n2DdERGe8z/TYi33X7as98oX7tskfWVYzSMAVCUpWTdJ50uI22kg1e+9+vu/nYO+lIds0T1D3Z
 MqbxKlOp5Gxp91AAtNr2mPJf0p31pvIfiFCM2SEMiJKBAEUHQP+OJbl07CYMzLKi3+AgLKhWeaU
 U6/zO8O2Q1OFKtLWiNbXWN6UIP6jtTNZs4GAU08M9nzEccZrKl8gYVPw4FDrthicN99eH7I/NIW
 dBcLRSF2SpKrtEmDaYSXz/ZC712XYEXuB76DVFE7gwBkgeqac66ksU7hNfdA3QILGsd61OHtUT1
 J8+oWyss
X-Proofpoint-ORIG-GUID: xi5M2_IW0ZBKUTLowvH0mmgVyJXlMWjK
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68cab683 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=J2N_nXOhfcilw9lcM9MA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: xi5M2_IW0ZBKUTLowvH0mmgVyJXlMWjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 2:38 PM, Krishna Kurapati wrote:
> Flatten usb controller nodes and update to using latest bindings and
> flattened driver approach. Enumeration of ADB has been tested on EVK
> Platform.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

