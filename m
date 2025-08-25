Return-Path: <linux-kernel+bounces-784689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4A4B33FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744FD3B560C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615D194137;
	Mon, 25 Aug 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5RY+swG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9B35965
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125392; cv=none; b=b3VaUmd49QIdybvqOuTgfQs+Na1EetUB8A3iK+aWwHlaHkaZ+RbLp1LJnNHFC0VaaLO/E6eaERTdYEj+eGDHvZ1RQNG9vdfRV5WcvntEq8DyJwRtkVtvHt6cQPl7Sddi4yXWULAzsQIcakLu4ksdb3V4N72CgYWT0s7YRZi08+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125392; c=relaxed/simple;
	bh=IpsradjdOMcyuR1fVdM6EKhiQ9aldyBirJaSKiTA5ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2NRbHIOVuOju4cRw7tQ55O0OfaSCnUJhTqSo0qoDwjrgEe9TjCfz/Fl4XG8b+PEnLJ8AHt1w+M2b3Vd+EQO165gBtV9nqfFUpAuwji+f8H8KklJnT+voerESAAfXz5ZIx0qznpGo2mPwynFAX/SM7p5EV4BtbN1GepoqaKcacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5RY+swG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8DPQD028623
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FpyvsEzvwWouANgENynapW/r
	DJSy9fLuBY8tVftQegk=; b=G5RY+swGuU+chjtXZn5EhJ9OSned4ckEdMZwpJ4z
	il0nbUSXhNV6w41cx9u1XiJe6//5OEqEgCi/tqxeyzJeRsHnC6CwfiXCt1zuKuXe
	zSC3rbgZehbc18wm4AlXSMo3qXjMTTwOTF11+uRBPXhYJLxcLID7Lv1MaDJb08b+
	EhdPfbA+kJv8s3sJXLv2Jw3msFP7zFfTtlN4QG60/lBWkPKmpO3v+UYVZKg2hg1Z
	+HxlYFmSK+6uJ3ha+OsUbek7covY9qPNQ85SFFQR6s6rZQVxZ6DiT/c9JOEeGlHl
	PAiNAEk1CBz3AuCrtYrIrLTMDnh3EFWMAY/nNaM/zytVHw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615cyxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:36:29 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so4508705b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756125388; x=1756730188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpyvsEzvwWouANgENynapW/rDJSy9fLuBY8tVftQegk=;
        b=QRbDQpCGxP/tAfAOuH0oeMCHLI2KTD6adTCOpZZ/GT3SMvlfgKoNt9XBLwBFxX96KZ
         tJGt6GhNriJxXXVrX9rQFv6iBccUWkLw4sar8PDv1RGHQ9baOdH7JPxkqJPiGnDpJ52h
         P6J0AKbrvCn1FpwVtPLmzxejObDVR9sFn2zGba3HdMhsc6LXFVOSl6NWL6TBjluz/Waj
         f8eVlVFiMbNspJNLOxwkDmityIihBcC7KAeFRj6F0z7vYu/N7vyVJLBY+Bbi8bPu/dz9
         +QkFPijoyN4MEvEPqe7W3A0QOaoVPCkQZT3yofoBzVkFa94tb2ROBW6OyxXa4xjb0j99
         UVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVTe0OwxiiCb3xgrQqBm2XCRPY+q0yJHnAnl0hLJAsf1gdYmID50hDe5vj3H9bf9RO8UvojU8QgfqxO3L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQIyQUbFNi9bqpIxM/FdQTn+sNmpEQLE56r8V/gPoeTJogXZW
	c1+essP2bJt6VqszEhL79+CB8+kSQlhD8qLw/smZAB0Idsa/L71cpaj//jJym7JCwWRRz4x0KmU
	297Oin2K0O5Sg7NZ7K31N+PbhykodqCxvZ3hJyPHZed/clOV3OE+/p1pAM0WvFJWiHm4=
X-Gm-Gg: ASbGnctNIonNvxqJ6HNsq6xZre9+pJ+W7aUPHehaRsvk9YqLR0FQus6jqQg0raRSeYp
	YFfp0du5QTR/tQTFEr3wstrOnJqmfaj0aFT9p2VctoHaE+sGlNOtounnO0rtsqpQTU8Y+A0/VBe
	YeUTq8xeEY4ul1By0bQVc5YQue6BCpcpNH77PGdkNuhif7bQBE6GGUv/1CsKtKpkpA7+c1dKPk5
	3clPNTmoXPStNNMlBcUzwlTdnWOO/3mRZ1MTskjCyvvxKUuwwlKqA8Bg4Weq+HhavuU0YO6sNXf
	gXPbt8b/C6ura50L6LOQp2aK+eWecREfNwiqOlDTkqwbKatdneiUP9RgFQSDTmz5pig=
X-Received: by 2002:a05:6a21:33a2:b0:23f:3f96:ea1d with SMTP id adf61e73a8af0-24340d77b55mr18420088637.29.1756125388470;
        Mon, 25 Aug 2025 05:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpAcc7C0zPEwQwv6Q+s2reKx+GekMIC1stpaw3dY97wiJpzXZAJHSAvt83lpMcdkJmcUKsKQ==
X-Received: by 2002:a05:6a21:33a2:b0:23f:3f96:ea1d with SMTP id adf61e73a8af0-24340d77b55mr18420044637.29.1756125387834;
        Mon, 25 Aug 2025 05:36:27 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb47b9sm7429354b3a.3.2025.08.25.05.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:36:27 -0700 (PDT)
Date: Mon, 25 Aug 2025 18:06:20 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: qcom,sm8550-iris: Do not reference
 legacy venus properties
Message-ID: <20250825123620.wxf6x6ep6jm3oykm@hu-mojha-hyd.qualcomm.com>
References: <20250823155349.22344-2-krzysztof.kozlowski@linaro.org>
 <20250825113734.iekrgyvctamhb5y7@hu-mojha-hyd.qualcomm.com>
 <a3325bf1-2a3f-416a-ba2a-4fb1e9f85e61@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3325bf1-2a3f-416a-ba2a-4fb1e9f85e61@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX/qrRHsAHUBo2
 RH/KPNYtoFCEJDG1ASvvnt4EVLOtYxNh3O/ffQW/KfmgzgmyK+dRC+se+SYOVjk4AT1ID39FrP6
 EIxcR35bWWTwuiWCYPxqcXm2THHlWQ5E/CAyijOMWkWXAdd27wrEb3sKL3Rk5bbC2ght1orF+wE
 Dhg0Oxyb1TcbwDV5q72TtO/ZZPqPrPzAOz0e5skZdDcCS4IIg/PRT/JSyldT9RK8sPRohG1xK+L
 67lZf7aYQfmnaaVlsp7cqwfJg7rz5LgVVbBAIcml9IQab6h+tfSvfpBv2FNIU7uiiMoQefXM8Nx
 u3hFxnOml6PC761un/ISKXnJffraGUSmlYfqMn7eUvDr+yMfZaXP8qsj4I7bU5CFN49xn01TeMd
 WgHgk7CQ
X-Proofpoint-GUID: -eiHbcHXaCHmAPDj1tYMkzDGrDXTYdlA
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ac58cd cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=u8hhPA04-lIrY9isCZcA:9 a=CjuIK1q_8ugA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -eiHbcHXaCHmAPDj1tYMkzDGrDXTYdlA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

On Mon, Aug 25, 2025 at 02:02:56PM +0200, Krzysztof Kozlowski wrote:
> On 25/08/2025 13:37, Mukesh Ojha wrote:
> > On Sat, Aug 23, 2025 at 05:53:50PM +0200, Krzysztof Kozlowski wrote:
> >> The Qualcomm SoC Iris video codec is an evolution of previous Venus and
> >> it comes with its own Iris Linux drivers.  These new drivers were
> >> accepted under condition they actually improve state of afairs, instead
> >> of duplicating old, legacy solutions.
> >>
> >> Unfortunately binding still references common parts of Venus without
> >> actual need and benefit.  For example Iris does not use fake
> >> "video-firmware" device node (fake because there is no actual device
> >> underlying it and it was added only to work around some Linux issues
> >> with IOMMU mappings).
> >>
> >> Stop referencing venus-common schema in the new Qualcomm Iris bindings
> >> and move all necessary properties, except unused "video-firmware" (no
> >> driver usage, no DTS).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../devicetree/bindings/media/qcom,sm8550-iris.yaml | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> >> index c79bf2101812..320227f437a1 100644
> >> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> >> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> >> @@ -26,6 +26,9 @@ properties:
> >>            - qcom,sm8550-iris
> >>            - qcom,sm8650-iris
> >>  
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >>    power-domains:
> >>      maxItems: 4
> >>  
> >> @@ -45,6 +48,12 @@ properties:
> >>        - const: core
> >>        - const: vcodec0_core
> >>  
> >> +  firmware-name:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >>    interconnects:
> >>      maxItems: 2
> >>  
> >> @@ -69,6 +78,9 @@ properties:
> >>  
> >>    dma-coherent: true
> >>  
> >> +  memory-region:
> >> +    maxItems: 1
> >> +
> >>    operating-points-v2: true
> >>  
> >>    opp-table:
> >> @@ -85,7 +97,6 @@ required:
> >>    - dma-coherent
> >>  
> >>  allOf:
> >> -  - $ref: qcom,venus-common.yaml#
> >>    - if:
> > 
> > Saw your reply on 
> > https://lore.kernel.org/lkml/59951c47-1015-4598-a885-25f8f1a27c64@kernel.org/
> > 
> > Just trying to understand ABI here, how all of a sudden we remove a binding
> > for a hardware just because it did not get noticed until yet that as it is
> > not a real device and we always say device tree binding should not depend on
> > drivers but the device but we are saying Iris does not use fake "video-firmware"
> > device node for removal. I am a bit confused.
> 
> About what? What is unclear in standard DT ABI rules?
> 
i.e., If a driver is not using a particular binding at any time, its binding
can be removed.

> > 
> > Whether removing will not break any ABI as initial binding enables the IRIS
> > related code to use video-firmware, now we are removing it.
> > I believe, removing binding always break ABI ? or is it depend on driver
> > code not using it ?
> 
> There is no single user of this, out of tree (I briefly checked) and
> in-tree, so there is no ABI impact. I am changing the documentation of
> the ABI, but there is no actual ABI break because impact is 0.

Something is unclear, that is why you are willing to change.

> 
> I am really sorry but it seems you ask about basics of DT, so please
> first get into docs and other existing discussions.

You are right, I'm learning and not an expert.

> 
> Best regards,
> Krzysztof

-- 
-Mukesh Ojha

