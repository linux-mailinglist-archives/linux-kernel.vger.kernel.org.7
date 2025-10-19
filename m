Return-Path: <linux-kernel+bounces-859787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3FBEE92E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13F3F4EAB0D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B52EC0AD;
	Sun, 19 Oct 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cl3aOc6S"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E578570808
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889646; cv=none; b=RhTNa6dcdH3aXk17sETQnugfNY7pCOKgGwFn2KnmufZ/e8AJjnISmR9ceP2ZFvAGtDz0fjZ/jwftMyd7zdJeCcuq4065/SvHw4ucGnay1VlGpwXUC6AocKHHZKXB2Ise45RS3Qi5e+4thPwH+ZPxLiKbkKoGW4GXwZBuhJ6gPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889646; c=relaxed/simple;
	bh=Kf85A626unFOvqMadxHZ9Cr1Bq/4e78kA3D9mxQntak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buaFWowNPxNftiXQabF9tL8AhBma+X8Q9svwL8W1G1Ml0FjXWlleZaCgdL1gaQrsAGinBLqz4RFK+WGGx0poxJhXUl+07KC+ldnejzkFrrCavL6a7UqcpanwTfuEdZQ+5ZeSBaJI7JCW9bHcp5BrXo0aAPcn5/FQA8mx7EETGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cl3aOc6S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JDqw41015803
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I0aOhuHfsf8NnOCKsGXsoFF5
	VUAwjGMlD/AzJt3MbXQ=; b=cl3aOc6Sy5pydot+kRNSrbkrFxMsjMCn4XrvpzKh
	bpf3Ug8jW7hWdR7wKP+GUa051yguULly1KjOX9wHKqyCwoz9CG1hr/L42bSmyCTK
	ruWSzOAAgiB+K4z9GHh/aPHnnHLggkFh+LTf9Fb4x9ZN+GoNMKgEOp+GXiRvlv8L
	f68H8OCb6ywMtZrm1rE2fNGaX9HouCgG7OplN0st47ppI4spbBykC/v96Flia6RX
	9zf0fGflY7wsSNr7FnJZeoE/WS5Yv7fhQ2AxJTW3mUdG9faUdxhGlMdyO/XF986q
	eX/uGS50zfMH7kY2EeldZ685pW7BEWSKkqw93gmrJ63NLA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k2ge5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:00:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c6f88fda2so77315546d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760889643; x=1761494443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0aOhuHfsf8NnOCKsGXsoFF5VUAwjGMlD/AzJt3MbXQ=;
        b=VkqSECG5swgL4EdiDSq75fnfc29xlFLj0Wf1cOUjNDFRKDA/rGV/rJq57gBv+3kKvs
         33mVrpQHVhyOg3Yd9gSoLDuqKAw1+cn/JuWGBy0lx8/BSQgSCTSTEJ3jqHkepu41+f/I
         1hUJzW2yDcjJ2lt5arfs9j7AjBByyeO+mPal6hWtQHOcMATm045mC0Bh/6pJBEVb5dES
         9QBXU0YuWAxFvUGHd1DrAUjbPyIj2FmgYTdsBiV2eYGbYmnJh7dWUz1KRRCQdYL5h92e
         JFJWFzVxdlJA9uN1afPH8gwfXFp9WQPWxQ4kc8R3dtVMtCX55zOKXUe5EOJgMuztrDb7
         gFtA==
X-Forwarded-Encrypted: i=1; AJvYcCVM+kCLwr7TaNDlyhao+F7vhsiR0V7N57VPXiFh/C6stLHGp/k9kOmUFBsCdQ5+I3AyJQPYvQdey4xZhHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhfAdhpM5ZqgL1H5JLfIXymHzJ5v1DkOc8t1ttwriBc8AyJaw
	7ReXcHikIrJD2eK/Qp7XKXPThERuYsxuBOscJPqcshlDAHwY2GG9+/kCBWY7D8tBO/JoZ4CzNIH
	WE7lIzX68a3iy+VrsIZbpydrKMc8iTAp2Fe6+aqlr87nZjcTbNoT0UJZNG7qz/gRtPbM=
X-Gm-Gg: ASbGncs0jBUkodJWTZQJn7e2vtlUpqGKs5+moNtdoWNd+jYntTYt+znwWMc58Qr2Nqi
	bvD53/O1sRfVP8x8c00n9MVcwg+QHbtXD51HCqVrI/avGbXBtEmxG7XtQJeIIZIIEKyqeQ0+jMO
	Zc6XBJOtYdLj+cy7+Q/1LjWK5hLE0XoKsJMpYb3YNGeZ/iFaudiumm4Lh1xeANNKvlL1w4uSmRZ
	nxewKgzugKHkGDwHBpbJFl4oD/Gpo3SGmBtBpvxHmFfrrikZ8AoDljks95OqVXIj15pXJ/AHD2N
	LRDfkSTFtJtQHDC1/QjBlt8+QL8Vmb/1qNCqRvGgorFvl62O47UILlp1gts5Y+RaPFeYm/Ph0Vu
	T4JqmU2jFTp/lyCmpPceqaxtvoPpP0HMJAxyw1yvH1AHTG+E5agry9y5N2ayDHpk8oOtNiGVwDo
	ifuIXLuWEpB+E=
X-Received: by 2002:a05:622a:587:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4e89c56ff04mr156963521cf.36.1760889642820;
        Sun, 19 Oct 2025 09:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxIuS6L7f7xl2z7A/qtPnCnl8+CWdxgG0dYfEbSDh9YuNhHQTedtbsmxKzGddTEFlE02CDlQ==
X-Received: by 2002:a05:622a:587:b0:4e8:916f:9716 with SMTP id d75a77b69052e-4e89c56ff04mr156962901cf.36.1760889642395;
        Sun, 19 Oct 2025 09:00:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9508d89sm15105791fa.37.2025.10.19.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 09:00:41 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:00:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Restrict
 resets per each device
Message-ID: <i36io3dee54fngsiwavyzzxsqgfoxezwm26gi22jf5nzcmeyxc@kkd7s2oh7jpl>
References: <20251017045919.34599-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017045919.34599-2-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: ciPF4twOxUUnYriyGdILPxAv8RyLS2vu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX6YXHkwpOnwjP
 jdvm8WGTFnHNXp1L5w2N0eVKWYrUo/bHb5vXBe1W0ABM1H1noR8UdyU3mxZUHguXU8h+cC16dvq
 7/FwMsgwtnI7B1rnT965au2xog+T6yAh7f9vtL0v1LYnZdaFiTDW4xiI9fZjzG9WReBwPkMKBin
 9oY7NwUYqozrqQvVEwtma/xwp0ziiw4GvIahu8SPZIB5c3ZdcQKuzFAIOXcL6bv+H7i0mu+WpCe
 uvy6rBVHAFhDwDm36ioFifSlP3HQhrz4f9YMRNPgTgV8nn0RYBKzDw7jsahQJ/0doa36DGFyOvL
 TUeazTQY1ZsPKziVdQ7hXlZv8xSypQKaxAIaVlGu1or9GZ8sDupXX56sfSOu9NqPYRkpjVpdmPY
 aWquh//nx5a6XwFzshS+RtOY7XM3eQ==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f50b2c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hUDxmADzl2bKAqMNfzUA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ciPF4twOxUUnYriyGdILPxAv8RyLS2vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On Fri, Oct 17, 2025 at 06:59:20AM +0200, Krzysztof Kozlowski wrote:
> Bindings should be complete, thus complete the constraints for the
> resets by adding missing compatibles for devices with two resets and
> "else:" clause narrowing them for all other devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

