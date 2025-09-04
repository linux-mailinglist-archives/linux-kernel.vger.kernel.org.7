Return-Path: <linux-kernel+bounces-801580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD0B4471B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0971C86F65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562BC28000B;
	Thu,  4 Sep 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GStfmUu1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D027FD5A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016992; cv=none; b=YGMkpQfE9V23TyTrYZ2KfgFEmW6Xf6UvLgiu71U4fy8bP0tK3fNXCFGhnYchIrbXM2UBtSsvuTwP/G4G5lbrNR/IQQ64x3AEVbxPvQJxTRUzYXG/Q+IYDRXE6+JQ1og/4BGQnj5/zfvBNPnSw/IlUhbxFoozBaUL92a2bO0tMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016992; c=relaxed/simple;
	bh=wsHd20AsJfMa6Wx3AXg6obGKYV4i2kU1t40Rvld7cXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6YuZgdIOP7i/RPLqzDfw5nUQsqvz2zYSsQx5Z2arv2rrfIf/l2DpZMq6WqlAT2VFvO/xxZVsUXNXncWq1NcdolsRYUXSxIRv3S1Y9oCnloVZ6iQVxH8g4WmjxmXXTGQpZj1s+wnEnGoJwTI/o83Xlkcyw/PizueEqAQiux+ZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GStfmUu1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584I3J4R008120
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 20:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xOnQOwS+L47eJqdD2xfoBQRC
	L3cjvg9aVuPwvzZvFpc=; b=GStfmUu1CrqwzWdKY7Agp7+Uzmd0qtGHDw4NUVYC
	MVcWrDzMS6HJONHQZEbkOc1UB5oXYafzqviDkUY7K5m+wkbOElxM/kxi/zUvBlRn
	CKQl57xbcP5wYydUNyv2JJjp+T7DtL07vAMQV4mmghTYfz/avXx2loISPf8hxJwx
	cJcu5dbQpKUP/yyFVILniN/BfFTywgX2tTwajQ6pdWL8GOcyPqti5EPyvlqgxtOt
	4nnx4XncqRZF27YeNlD4816PWjUHS8MVkYAhhCJk+KvOth6nGuGHLP0mRztd0xk+
	+RXZ4T2R8xy2eyxaniRNefn3uvYgkzSGBVPALAcurDFXDQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjrrku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:16:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3349c2c65so36717211cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757016989; x=1757621789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOnQOwS+L47eJqdD2xfoBQRCL3cjvg9aVuPwvzZvFpc=;
        b=p1kJUBpl/l7FZFMhuzgJEbv8XS9dikd4nhhyoZSOt74xVWPOXxbf0vd/O5+zkPGgGG
         u+OSQVQ61DEh34tmTFzotPr6Aweo15otLzRk9QwiOOhIEwR34vQM0+ssA5uyI2p2MX/N
         OiQQDzpy6iaEWrgAKedY9gmftqnMDUAklxfoHpdTpNNRnbWvHtSTnBStsvB1MFqBnd2b
         IoO6nAbbHRtIhD6LBSEqaCuGiWkDXz2LLqyBKIHDMBYI13OWZaPhgcDwlxAyxlUfywLM
         nf20GpEY5Q36VtpA5vPgk9uzT4lAozTvL5+qSxh/0yawHmbye3Mrza1uyIH+JrAdKUXb
         19Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXg726Drhy/aIjpYuKdc0ytA3MDRKtbBl+pG6/UWqDyR5+/AbMXIaws/GFGEFURuZJ4KmgUe+JGqZY8kQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKdhTQGKzc+feiQBwGmQPrub5HNFyCxh8auksF06Am6tyA8BX
	T/EVEtZ0ttFaSLbW26m5nP/LOCBBIWGiruRIE3Ot3iQASCh4zlI0eKKWfv1Xa6FRDJ7Cmj9jSgL
	NtW7MNARpO1KKIHDnUDmSf09ETNO+RBCfibYW4IaU4IV1I3DsUivkqQvDetgYvgkVONE=
X-Gm-Gg: ASbGnctf8tGpcd81soziEhbxB5W3JgQOniY3+z6ygcPmCT3jfA4zQycnQ4NS48H8VU7
	addMIv7lZlj+uKJxY/Q9J4tsnRvpLsaTT4APZD4K/mafFjZxW5jths7iiZQPWNdld88UtrJkawR
	XpYNUTWzMvwAAq7Sqkrwwcl4EW9Gh5UZ0VuoimrijkKnpwKM/3p6dBvPFDUfj9aO2jMYE8h9L3W
	lq+bjKEf8430KG52ZjYypfoWjEtdED/Pp38QR6wJ45fcNEPJMudHNkc8XXVsdDDtUWkQiRv3ooF
	lSMeEbtoqHgMUgWmzKy9o3IIOn/YEkeVAExleP342aBMpZVx3wzOGqYno4K8yrgVqHYnVvp7jMm
	ZLKNIuGSy5VODhyOcCyIj1HFCGrn9xDFFFMT6EZBdrA9xaZHePk4E
X-Received: by 2002:ad4:5f06:0:b0:729:d2cc:9443 with SMTP id 6a1803df08f44-729d2cc947cmr38070706d6.39.1757016988773;
        Thu, 04 Sep 2025 13:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ZBkThlXqQk+QXlZrohvU7MoDDoi4EYRmpkHcRkJ3x4qqQmgMU68HV5l9Kryo0ZsRp4157A==
X-Received: by 2002:ad4:5f06:0:b0:729:d2cc:9443 with SMTP id 6a1803df08f44-729d2cc947cmr38070086d6.39.1757016988093;
        Thu, 04 Sep 2025 13:16:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4e2e3sm1393356e87.147.2025.09.04.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 13:16:27 -0700 (PDT)
Date: Thu, 4 Sep 2025 23:16:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Message-ID: <zedyu77se67b3s4zmuqcx2zslaasemllmtr6ua3k2p53cdspcc@ikpf7np6ugfy>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
 <qya226icirpzue4k2nh6rwcdoalipdtvrxw6esdz4wdyzwhcur@c2bmdwnekmlv>
 <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLnqZktduc/aT05R@hu-wasimn-hyd.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9f39d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=q5DPIbX8LfODaG0eNlsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -lCBpkSgl7OvkOt5-aM4CqPUn0aLK9uD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX0m4KscPCAmWx
 w0QdQxS8wGEVVNthFdg4nJyF2uidx3DiYAM51Fx+Cm7ieqJbEZVjBaJmz3SgAnVEchL51SqVOyM
 5zmfYje2ROgRVm1zm5Xf960DplY8vN84B711TihkVcPpa+jJ1bsqGcMT8YJJ/9tRXmSVF0CCPfn
 FFUETDVUzCG0QuGUMIC24wNmvSyFJwz68DHQ4PTtJkFjBWkvYGryTI0muuH0yjxYSawqEPTsxyn
 Ps+8zyYiMEDA5GYn52KqL39VzUQrBeQnOBozgLbQBQH/JFScvCnBsVUCj0XxxPerfqEMzrRzVrE
 sfbO/oUvPZwStfRFm/OqLdLEWQi529Wz/jWBqZLcBYdxK5eZVdnDwz4vudr3ct5w32n4InM/ZP3
 chcfRQRS
X-Proofpoint-ORIG-GUID: -lCBpkSgl7OvkOt5-aM4CqPUn0aLK9uD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On Fri, Sep 05, 2025 at 01:07:10AM +0530, Wasim Nazir wrote:
> On Thu, Sep 04, 2025 at 07:43:27PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Sep 04, 2025 at 10:09:01PM +0530, Wasim Nazir wrote:
> > > Add the compatible for 256Kb EEPROM from Giantec.
> > 
> > Why? Don't describe the change, describe the reason for the change.
> > 
> 
> Let me know if this properly describe the reason:
> 
> ---
> dt-bindings: eeprom: at24: Add compatible for Giantec GT24C256C
> 
> The gt24c256c is another 24c256 compatible EEPROM, and does not
> follow the generic name matching, so add a separate compatible for it.
> This ensures accurate device-tree representation and enables proper
> kernel support for systems using this part.

LGTM

> ---
> 
> > > 
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > >  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > index 0ac68646c077..50af7ccf6e21 100644
> > > --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > > @@ -143,6 +143,7 @@ properties:
> > >            - const: atmel,24c128
> > >        - items:
> > >            - enum:
> > > +              - giantec,gt24c256c
> > >                - puya,p24c256c
> > >            - const: atmel,24c256
> > >        - items:
> > > 
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> Regards,
> Wasim

-- 
With best wishes
Dmitry

