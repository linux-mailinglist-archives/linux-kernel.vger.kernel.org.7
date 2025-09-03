Return-Path: <linux-kernel+bounces-798338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D439B41C88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D321BA6568
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56A2F3C30;
	Wed,  3 Sep 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfhIxdYS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071802F39AF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897314; cv=none; b=sxFit+7fUY/lcJpPSxD9mKbgxaH957L+p1hqOfsNFhErwBELZrTHsFeCOk2Mrx/jN2AXT35jXo7q7uC+sJplWQYEsLVg+4c0Tl/K5aKt/J0UrGZapalWKD7UWWU2uQ6e8OVO9DHli3p19InrwJ55Ya78fB5iB3XUzf7hFaLYZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897314; c=relaxed/simple;
	bh=7+79JLZEdYdW7EsjOhd3wHHBOMun7TICIG2s/RhNN5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6kQhYE/yF3w4ZDsA714WETROqdBWPCJW29sQ24OsqAzcHUb+6KFR9ej5eSF07Ul3R5E9aaWq65QhsaoMzb1+ebQC3HNb/FLZ2EOUwad/t5NzrHtbsdYVgF0J0wbxc/eIaaWg02D8a0A2XX7PJigS/M5AJZCtTcl3rfFaa3Mwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfhIxdYS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AM6Rr023418
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qLaUOnzcULpuGK96TIq7/Q8T
	lONrYTUZzrvCBlNYoKY=; b=gfhIxdYSD9hWSM17gi+nZEvE52tAge7mklgZUiSY
	RLVdZzhQsHPS09GiP+kqkYxKLgAeirHepKwknoqHGs5nje3t9V4akj8L3kjmLHHB
	7023mAAhkSjr3xJltUO9uF2//Jaluaco1C4GIgcqWWgR/vJHWYvKC8ueBBqHhEDT
	GTjUhGFhKbTUVn/Xfkqp0y3m6x7bgCpnpDWPvGE1ox7Q68dHuu3iWKNr8nwp2uyY
	xKWPHR+6MMOOtqQrFlchmtcUuaUnhguJ3XfORaVQWFi6iDmlm4nivcLEYoFgk4Ql
	ZDASV69+YBO/fTtnqKaJ1h+CbAhW8MJ+GDgzDoWWE+u8Nw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbhyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:01:51 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7455da61e81so1099733a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756897311; x=1757502111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLaUOnzcULpuGK96TIq7/Q8TlONrYTUZzrvCBlNYoKY=;
        b=TA0B0GbZVtrT5hoQD8JYPRGQHO09qMNUh8CSW7+WC5AewNP1QwdyvBe16EsEtFINQt
         IhFciEvU7W1QtDNlthpFrC5LLmq5v6wT2aBkn2Wc+vR1SMP42MYvWrNfLdJC8dQM6lbz
         JGIrP5dOkSe0HY0Xk5eumneB6afc7HCGT8AnM+lX1IExdX/7vjY/c3GI1IeObFD2y1zr
         t9IqmoXKEF0dnzj8pkhYZITEG8eQZLs4Ext+2NOUJVWk5veecQ3qZY8rf7bn7c6X5b5m
         pODt7jZRnH9xX7npxJUcPAk0ajwS8v2TAjCOaqzWkFm9juALcsZo1MkeRB0bydDF3Lxa
         qHZg==
X-Forwarded-Encrypted: i=1; AJvYcCXzyH2t5wBuuQsa6JDlVbWbg99lg6bpB0+ZBePNbZMew7tH0KckhZjv4tS0s9suEigbvETSkgiuEWcTc4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvW1kpdfal2sk2n49B9Frv/fllV6XHzXrkFUSsBwTw9BeVIfB
	fK0kitpb2BNu0T4UpkxmjVwL6wq8cacj0xYggkDbjlS7pApwXPIQJC4dRtpwdPaqoUJPqFtJjeY
	bVw6Uu6gMKywEoy//YZkmYFW4LNemeERWgElKEMbyL8qNhmWvLnVuoe/k8kU14uinYpM=
X-Gm-Gg: ASbGnctDaZO4Wy5VP4enzsGA3n9kJifLoGIZsR9Wn/WkhSdS3LMP6WsbQ13RltsWI1Q
	RQlwlj8xX+WAFYvYqv0+O0OUGZWmB94nRUUQvTQlY4tHrl47DGEHVjx7dr/ScFyx4ReM7wxoSJv
	2BPZ7ku3LxpS4C95YdlKC91P5I1G+C7xShc0SiaNPH71NYSkHWdWnNsX4OxB2/f0sEBdsAvznXP
	EYGsTio/pC5GVmdvcy5KGeeKC/oqFUzirUWBB9ijZrqVktvI/YNWsonlIqnVHBLuNzGIqbFpsZ7
	8Cdo+rncyp7KQ4D4LJnDftZ/eUZWTNqukiZY6viwBRCFKvfT5WD5hdhyr3IoLV/N9vBTvW8Lg37
	Sid+hY7HVNEfjU3TWUCThX36DH71Z+O8ZtS5FKgsePWRFpDwptwKl
X-Received: by 2002:a05:6830:6d2e:b0:744:f112:e537 with SMTP id 46e09a7af769-74569ec96f4mr9524794a34.30.1756897310753;
        Wed, 03 Sep 2025 04:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdiePyT62civ6LFTn3goLcy8YW+L9JeKgsjo9tX5PgEGNj1cvGwn1XZZFaj5wacomXsnH2IA==
X-Received: by 2002:a05:6830:6d2e:b0:744:f112:e537 with SMTP id 46e09a7af769-74569ec96f4mr9524761a34.30.1756897310292;
        Wed, 03 Sep 2025 04:01:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad52b4dsm434598e87.152.2025.09.03.04.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:01:49 -0700 (PDT)
Date: Wed, 3 Sep 2025 14:01:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rajendra.nayak@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
Message-ID: <d35s5ldfswavajxkj7cg3erd75s2pcyv725iblyfya4mk4ds4g@hekhirg4fz65>
References: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
 <20250813065533.3959018-2-pankaj.patil@oss.qualcomm.com>
 <bdfb09a2-0053-4a07-85d6-5e15b8bc126a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfb09a2-0053-4a07-85d6-5e15b8bc126a@kernel.org>
X-Proofpoint-GUID: n8FsoGI-vQ7dwSQhB6au6eYUqIoITem2
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b8201f cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=FCd5T-TvBLVYlDZUGUwA:9
 a=CjuIK1q_8ugA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: n8FsoGI-vQ7dwSQhB6au6eYUqIoITem2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX6SfD2hL5uaMc
 4iZMlIjKwA5dYMLlbwZKrqvXETqAEDzwNBF4+WiAXzX5+pG+zu8em9EBL4Y/7/sYx6ERaC7DPBY
 eLDGZ3mNw/YZ4cG3TSX/rV+5z7dMtOkRNbruyqc1zvOvG3GcpWZFeQIRni6IpOPbbnqA3H/Y/z6
 tsKfp8Aptfhih2YgZh8qeMSYIf+ACkBaPAIe7iD6Limfz6n12MuYFpmqL8yBvKVSLeOnYI0qzcN
 J9G2Qz/zPI6nKHbJL/cZTbJfiwIoLlFhf4Vao1gViAVVdgPsWLW+dpUif41FhCudHcWcptqlGM4
 yLAw/9aRkKnhAyH9JJV/jOQlRjDCijU++LzLHwusV9QIw0pA0XFyPqnhymyzmLFzf0NhFGBLdcj
 8FNmExgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Wed, Sep 03, 2025 at 12:08:27PM +0200, Krzysztof Kozlowski wrote:
> On 13/08/2025 08:55, Pankaj Patil wrote:
> > Add DeviceTree binding for Glymur SoC TLMM block
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> > 
> > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > ---
> > Changes in v5:
> > Rebased on top of v6.17-rc1
> 
> 
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,glymur-tlmm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  gpio-reserved-ranges:
> > +    minItems: 1
> > +    maxItems: 119
> 
> 124, I guess
> 
> 
> > +
> > +  gpio-line-names:
> > +    maxItems: 250
> > +
> > +patternProperties:
> > +  "-state$":
> > +    oneOf:
> > +      - $ref: "#/$defs/qcom-glymur-tlmm-state"
> > +      - patternProperties:
> > +          "-pins$":
> > +            $ref: "#/$defs/qcom-glymur-tlmm-state"
> > +        additionalProperties: false
> > +
> > +$defs:
> > +  qcom-glymur-tlmm-state:
> > +    type: object
> > +    description:
> > +      Pinctrl node's client devices use subnodes for desired pin configuration.
> > +      Client device subnodes use below standard properties.
> > +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      pins:
> > +        description:
> > +          List of gpio pins affected by the properties specified in this
> > +          subnode.
> > +        items:
> > +          oneOf:
> > +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9])$"

If it's up to 124, then this pattern is incorrect.

> > +            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
> > +        minItems: 1
> > +        maxItems: 36
> > +

-- 
With best wishes
Dmitry

