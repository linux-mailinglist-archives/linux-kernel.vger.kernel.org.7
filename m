Return-Path: <linux-kernel+bounces-866032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0BBFEB02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDF32505440
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66641EA84;
	Thu, 23 Oct 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="japWMUgj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75DBA3D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177970; cv=none; b=bD/xD6xnb56/5Z4oZyivfiioZ7RZ+zlEumgTL3g8EYBW1A9GcnUPy43VFk1UORPYY6r6IOMoYYPONmsj5nBptUU6DAYIhySDa5vdKI8nhkG4DL4vGSxsHKcTnu4yVG79HRC2KpkS2rIGBaCzAEwcEVa3Xmkc7zXTMlpYlt6KXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177970; c=relaxed/simple;
	bh=VwFu2pqCUART756V66FC3WXoUKMk9AaNAqLUtmNd/0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlKEaWzLCNFD47nHJ7gbMDMBKb78/vfVWeqeHCQ6xXBGPrn4sWsiHROzbkAIG03aDVgnn6tu3gQh0aVGt7u8u89orHw3V7uX298mW1rGTaBe/5rlimozsvMV9cYj+S1SaAZvIpbRFv3zmaPDJy2AQRiyG9/ihUJLkqLjWy9ik4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=japWMUgj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIenmL016177
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YwXZ5EJgF3RkMDIp30Ap678K
	ahXPe1cvGbyvyzD4Fnw=; b=japWMUgjE8nQcrGptptNoSttn8Ogbpv1yYLNr4ha
	Q39CrCxGNupnXejONRySS/6ELfIh0m6xBTCToB40El5q1c5iRuERXMy/g2dTNY+V
	2TaiinEnw37yx5DblQNyRgJelyaz743ojzkHd2g7L36bf0dphAouC8fucGznFH1K
	8W0rrbMDcM2rGXIiLHLi7KUgtwIWA6+aJvKPKG0nvtHgb/3mkSbUguoBRu2SagDi
	Uvj/zHHpjRC/fkSjxOKR1VQPVj9DnPDlAzqmSiidy8dvIYx8zAZjzzz4zpn4rA4C
	MszCi3mtVT9tsbQAXoY4FZE6EH6hKRR6/xPSyHr5NmMmmg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsc1un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:06:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8adba545aso6018401cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177965; x=1761782765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwXZ5EJgF3RkMDIp30Ap678KahXPe1cvGbyvyzD4Fnw=;
        b=T2SG1H8ARZGLgkhqLuvu2L1uKJxBegoQOUOUTW4LMBLqsRFOk+UxYxDeFMZh4iEP3E
         7Y1W5hxqG5soLR9fZ3LDMbpkV4bu7lXURqRJQ3dab7cLDIOMR1/X9xsnQu4/Nmj8zBRC
         6/dvnRUcpM2ptqHW2/8lnNClL5dUdHUT4ofv31MS7mcct3tZtqQvGbHqiyEv+DJgBp8F
         E1kq/hmaZXbJqlHOhkLHk5FnZOb0LPHs0RqTvEK2onp7j0jj9KD66reuy3dO+lbmMqDf
         px26wd+cnauMk0MhNYII98DuQf7SiegF1XaJ4ubT7AEGSJBvfwNqJupVAz41aQZQth1D
         hh3A==
X-Forwarded-Encrypted: i=1; AJvYcCXfmtcUpe7GlOu+rxXZSaEhRYHOUj6zSl9AdTkNPqQtvG8pOjha0fX72aPHrLMSB6Ga+pQiFNE0h/6NB8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPTopOnF9OV4xjfaOpsiRcQUhHzYm7j6SEqgWaQALMm770PA9A
	/JB3kqVAW8ql7ovtmH0bhdnVbB8wuvzReB//cUheh33n0aYnfXhZfiz0/EjpQRVEGugr7NGiCMz
	B08nbZwfspz4SwSehdM5N57w3Jrd/Jpx2iYlTDNjlonBJLg8XaT8dbMQtb3xW5QHeKmQ=
X-Gm-Gg: ASbGncsYooxBbJfY0tiSAIzlv64KWdmzy4LqdBPRmQPh+ZT5IDcXFAcM2fuIVLWTfLr
	2FlkLusKIvleVWa3ABnbYsbqAURQsDQUJDJ5e7kucrkWWaGtJ7BAWwWSHjA9NlmVLpVTm56rqdO
	miNLv/TAec/KDiPpmNnftjptjR0Tdlok+vmyHkHIIWGVIWXZR57rEYSuGX4PHusdNOIdPQPDeSF
	5ue+f/w+rBdfPSLPlRqPAJoskO9xQtYlBQgLpP1LIsP7aTvvF60pYH6XQKotQu2f8j56ChNqXE3
	Ua2Kt19G2xzpDPda3P9wWqvN570qdEkN2OpEG7mbm3HWnNG2lL4cvu7n9e0vHnYjFrfo8a537VA
	ATf/wB9C4WE7PTvQWUjJ8G+IaDqV0AFJZaN+KZwXeQB07rOnPYfx54q977cgTF85C9KFJPT7vwO
	BDpat0Eg4kT5w+
X-Received: by 2002:a05:622a:138e:b0:4e8:a9f6:355 with SMTP id d75a77b69052e-4e8a9f605c3mr220955051cf.72.1761177964894;
        Wed, 22 Oct 2025 17:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDNjOTVSPDTOLMhvrhjQF/rHxfIIgpodkg14JMuex89C+8dkQsRhvtmM3bkDBHfMKN9H52zw==
X-Received: by 2002:a05:622a:138e:b0:4e8:a9f6:355 with SMTP id d75a77b69052e-4e8a9f605c3mr220954581cf.72.1761177964404;
        Wed, 22 Oct 2025 17:06:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4adecb3sm237171e87.12.2025.10.22.17.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:06:02 -0700 (PDT)
Date: Thu, 23 Oct 2025 03:06:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
Message-ID: <mwin3lfvpcwxxhsub2whcpibuayk36f4ljrodvithfygqad5w4@cg4h6peh4v4a>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
 <g2iviaqetgxf5ycz2otzkpmmc4goo7xuyjmttuu254bfzqqvkf@4vybjh4eghpm>
 <4eebcb7d-1eca-4914-915a-d42232233f9f@oss.qualcomm.com>
 <dwfvko3hszsoh4ihnz3qdpsugmocbkrbhosijdw5q3bxh64kuo@o74as2li74px>
 <lz4sbvzfiij3qsa4d7jeblmi2vfubc4ltf435sh6tcs53l6fbq@7f3tfm7yiyjc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lz4sbvzfiij3qsa4d7jeblmi2vfubc4ltf435sh6tcs53l6fbq@7f3tfm7yiyjc>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX0qPB6yK04d/E
 YSGqcoe8sVQO/+Eo39ROGsrKM5vFVqG89qQgX5Kxce1D5ReoS50+pa2PvsKZhC+20brfxNj9E+q
 kcaxz+rRnqsbZaaehnd+FCQerHqT80VxVbDwpNtHUJ/rVyV1cSxfJTD7MI5Ia72kkiXYFmIXhO8
 OIBZPxptV034mHJKD+wseWnsLLfB3dDcjkkyQci97DZJ88E0WO5Cb+FFR+zVM067lz1M9nqUF9k
 rVtQpuDGwaae2od8dekNL0Ny3vXaeZcZZfVbztMzljD5YXRVpSgL/5rseKbgiVPEQjWNycJlxAD
 Zl+zkLGpxfBv8w+QLcb+YW70uncGsK+7ApbzjvSnkO2oiLmpPgDnBywRaL/T+PNTXNyo6ojZGbt
 pCVFTGgN7TqmLDXgA+JrY4EnngPcGA==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68f9716e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=Cw9dS9RSUmV-52qKxfUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: RroXrT481FJlkCkzeTxpUCnYE1K510os
X-Proofpoint-ORIG-GUID: RroXrT481FJlkCkzeTxpUCnYE1K510os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On Wed, Oct 22, 2025 at 05:42:58PM -0500, Bjorn Andersson wrote:
> On Wed, Oct 22, 2025 at 12:34:58PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Oct 22, 2025 at 05:05:30PM +0800, Jingyi Wang wrote:
> > > 
> > > 
> > > On 10/22/2025 4:49 PM, Dmitry Baryshkov wrote:
> > > > On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
> > > >> Document qcom,kaanapali-imem compatible.
> > > >>
> > > >> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
> > > >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > > >> ---
> > > >>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
> > > >>  1 file changed, 1 insertion(+)
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> > > >> index 6a627c57ae2f..1e29a8ff287f 100644
> > > >> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> > > >> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> > > >> @@ -19,6 +19,7 @@ properties:
> > > >>        - enum:
> > > >>            - qcom,apq8064-imem
> > > >>            - qcom,ipq5424-imem
> > > >> +          - qcom,kaanapali-imem
> > > > 
> > > > Can you use mmio-sram instead?
> > > > 
> > > 
> > > Here is the node: 
> > > 
> > > 		sram@14680000 {
> > > 			compatible = "qcom,kaanapali-imem", "syscon", "simple-mfd";
> > > 			reg = <0x0 0x14680000 0x0 0x1000>;
> > > 			ranges = <0 0 0x14680000 0x1000>;
> > > 
> > > 			#address-cells = <1>;
> > > 			#size-cells = <1>;
> > > 
> > > 			pil-reloc@94c {
> > > 				compatible = "qcom,pil-reloc-info";
> > > 				reg = <0x94c 0xc8>;
> > > 			};
> > > 		};
> > > 
> > > other qualcomm are also using imem, could you please give more details on why
> > > we should use mmio-sram here?
> > 
> > https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/
> > 
> 
> I considered exactly this when I wrote the binding back then...
> 
> But the binding defines mmio-sram as "Simple IO memory regions to be
> managed by the genalloc API." and the Linux sram driver follows that and
> registers a gen_pool across the sram memory region.
> 
> I believe IMEM is SRAM (it's at least not registers), but its memory
> layout is fixed, so it's not a pool in any form.
> 
> 
> What Krzysztof says makes sense, but rather than just throwing a yak at
> Jingyi, it would be nice if you provided some guidance on how you would
> like to see this turn out.

I tested, pretty same approach seems to work:

	sram@14680000 {
		compatible = "mmio-sram";
		reg = <0x0 0x14680000 0x0 0x1000>;
		ranges = <0 0 0x14680000 0x1000>;

		#address-cells = <1>;
		#size-cells = <1>;

		pil-reloc-sram@94c {
			compatible = "qcom,pil-reloc-info";
			reg = <0x94c 0xc8>;
		};
	};


-- 
With best wishes
Dmitry

