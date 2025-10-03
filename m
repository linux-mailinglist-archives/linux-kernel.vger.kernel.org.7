Return-Path: <linux-kernel+bounces-841571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4EBB7AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07BD74EE6D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4A92D8DB1;
	Fri,  3 Oct 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvOK6SXT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02F2D8785
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511647; cv=none; b=JfU7OpXuPSkjsOPzKR6kzW6grdGVgPAte9IG3peNc6jTfonb61Qw6IvDsuyarCQ9KzNpESpz8YcGFZbdbH4pgRhQTngvVtgrT6HSQITgepH3AaEG2WXeuT5TmSVsC4HQKyfuuC9lg2a5l66qu47MTrin7aEzepwLytjzt+Une0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511647; c=relaxed/simple;
	bh=sRXN7wdWBdzUwr0/A2cwW5ynUeLKYkEY8qUaCZEgH7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKg7ZnTWZp/4yXsAkB2XDQnf15Jyg28Aq0xaStGGqOtnw7S3GuzuvIV2Qmui7F5KZfYi8WJOh0avwTlRoXjG2aQj4RSCSmoqWGiRKNGBs7XY1embSvpC1P3Eanxqi87dxW25k46LolbmkdfHRIlkmpvnt2vRVf2msAbdGLhP5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvOK6SXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5936cdSm007888
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 17:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=w3Aan5Y538FKID4Zme+09bSf
	ZawmXE/Z3TfUDYtZLco=; b=ZvOK6SXTiGxwJA5O8q0E6YRJIQWlP/SIL7BBvjvx
	ktJ3KWhxKbewT+wO0IoEqojsHme6LMc2jgqRZCbELPmup8XesK55EiHXsc1iuEIj
	XW+VJmQmJDAh6gfKl59aZdzCskN2mO7HNn/wldfFrra8aGIlUeZsm5XMStqPys/a
	P3j5amWXD+4UVoEIOKvicZg7z5DsYwvvJEvVNARi67nU2r14J76iSzzJPtNCinFz
	aVwngPwlsmxo/WZ67lxylz8ukhf1/xJh2ICZGa6KuvdLY/AWU1nd9478I5+je0/+
	zpmaqfeLCcNSA6hsnAvogx7861uaJmBGbtJpDjozB4mg1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh4nhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 17:14:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de5fe839aeso63463121cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511644; x=1760116444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3Aan5Y538FKID4Zme+09bSfZawmXE/Z3TfUDYtZLco=;
        b=UITOPNonHorCJDV62pzE462UZl9N69A5bMawB+71qK1rU0AeAW66LRm9j+VIzCNZgn
         4R2gNTK1AWfvLwKhQhh8iNxnfqncpUHym2zZ9cnQZ+0cobp2J+O1UKh00PYe+vOYJB9/
         cbrlDmKMhnjZ77kzjDa8ifudWb7Zl/yAuBzTq9BsdLgSRM9UXLXFRzRcHDQGBUuSOnxn
         W0Zxxe16/G+fCGTiAW5m8VUn/yvhp9w0KacDqrA990sq34pK2wb3S+x9ag0zvvt8NfLX
         f8Jj6nRrzorofrP6jJ8FCjPoulQoNf0iw2KhmQAAvFDxIqFkH93Hz5BIpRk2Dhh6hUEZ
         ofSA==
X-Forwarded-Encrypted: i=1; AJvYcCVf4k0tcw8qQQwXoTpeftGAcCQDw6d4nmasZTu9Uj8HXmJWM2zLLo/eXgbn7VR3adEZtDsYK2xqGS4RQjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrkLzVHBS0VUKGPIu7Mi4bJ9vhjIe7lgwaFcGToZhoRDs+Y3v
	GPEEoEYqDyX7F6xibPSOLCFKWyr3UhmKg70T5XMn076l7Rt/78EF2iR5YFalB7wMZ/jT6GZ4in8
	mSkVNEDGzdiyO6lHozSpSxNs99vwIOnfE3abKq/t+/IomcwQESQvE8EPxLZHWSSwiNsg=
X-Gm-Gg: ASbGncvy3fyOvNvQioxrWXN4ms6BAtqmPjrhu6fBAoIBydMi8HJvAW7WZhiTbjulbZI
	TGml/AY3P+3tOo1jhOiNolDt6lqwlWZdX9m5ObL0Ms/GXCEeatN5DKMaVunrz8H7LF9VGEx5eIp
	MuyG1vrNHnIwt5Wm4HPBF9u5sz7VclJR5b5wUzqWTB5rwKzPLa/KXg8rfz71JfLoPDyP8Drg7I0
	5hF2R9vZg8c3zVbG8Gz0KKYa5e7exMuYOAlqZ2LG+pQAUfauznA5vHFltq9Zjcqccfi0/RkFMKD
	GXHZtjbnDBuDQHsLZ0QdezQpiQgxXH05YzINq2s+bOstfRjJBwL1Zu+KWfCKk0litpS9m92MvdW
	vKxo2V0K6LPpe5BB75VJx2unfahZYyhTPhrbRx0qvTuEsce7odkC4HiS64w==
X-Received: by 2002:a05:622a:1247:b0:4e0:3cdb:d1dc with SMTP id d75a77b69052e-4e576ab90e1mr48287091cf.43.1759511643798;
        Fri, 03 Oct 2025 10:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkV77r7PT0L/lrRELV9noKeQLSHDewsA/eylq6OZ4OFiGR32HGy/BEXU6rkm2xWDWluN3TxQ==
X-Received: by 2002:a05:622a:1247:b0:4e0:3cdb:d1dc with SMTP id d75a77b69052e-4e576ab90e1mr48286431cf.43.1759511643127;
        Fri, 03 Oct 2025 10:14:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124414sm1996946e87.26.2025.10.03.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:14:02 -0700 (PDT)
Date: Fri, 3 Oct 2025 20:13:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
Message-ID: <gfbvgsen75w5h7afyo454pvdfslkeprqyuycuok6syinbza7vx@crapzdo33re7>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-7-b14cf9e9a928@postmarketos.org>
 <f58493a9-6def-4610-9c3e-d6a877dc23d3@oss.qualcomm.com>
 <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
 <7661d9d9-eca3-4708-8162-960df0d7f6c7@oss.qualcomm.com>
 <ad721948b83a54eaa34f367e12564fe6acc222a1@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad721948b83a54eaa34f367e12564fe6acc222a1@postmarketos.org>
X-Proofpoint-GUID: 4Q0QpDvmAGqYciyFWEQuR7Y6k8nZPMOc
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68e0045c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=QgkLZLD_Px6AUkAJ0r8A:9 a=lqcHg5cX4UMA:10
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX1TpqJjTKTjHv
 ydlFmVCRkrZK4faqJpvME9RSbHumDb/RmP13GG9fJd+lYd9rp/P8VaGsL76DQjCBEpLsjIpr4BJ
 /fqs6ct9+sjElZq6nMIaeKwKGF4QYQzDSKwsk4trW42Vye07YTEnQ4HiHa74XJL+jayq9AKniO6
 4i8w6plKbLHs28Wrh4NgtcY9xI6cjR+fxYDuRJ07Sak+SOfdAfWt6EHsCSVj4l1CPQ47qcU0d0N
 spmbD2Yfu8k7NGLS1twPkJEVaYIrFstedJzTwH2torPHn1wAvaoxkfr4/Ccnr4F2I0VHEz/ILFP
 RGt7bY9WbsuFjyDJh7m0ogI77YuRC9EwRA6XqwQp35D5lbkwwPLf8sdN/z5ZZjVYTvETRdiDFvP
 tn+xsFPn4ChQenby9fUaABZloVkrbw==
X-Proofpoint-ORIG-GUID: 4Q0QpDvmAGqYciyFWEQuR7Y6k8nZPMOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

On Thu, Oct 02, 2025 at 07:26:16PM +0000, Paul Sajna wrote:
> October 2, 2025 at 9:37 AM, "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com mailto:konrad.dybcio@oss.qualcomm.com?to=%22Konrad%20Dybcio%22%20%3Ckonrad.dybcio%40oss.qualcomm.com%3E > wrote:
> 
> 
> > 
> > On 10/2/25 6:51 AM, Paul Sajna wrote:
> > 
> > > 
> > > October 1, 2025 at 9:14 AM, "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com mailto:konrad.dybcio@oss.qualcomm.com?to=%22Konrad%20Dybcio%22%20%3Ckonrad.dybcio%40oss.qualcomm.com%3E > wrote
> > >  
> > >  
> > > 
> > > > 
> > > > As the dt-checker points out, there is no such property
> > > > 
> > > >  If your wi-fi works regardless of that, you probably don't need
> > > >  to set the one you intended to
> > > > 
> > > >  Konrad
> > > > 
> > >  
> > >  Perhaps this only exists in the postmarketos tree, but it definitely exists, and doesn't work without it. I'll remove it for upstreaming for now but hopefully someone sorts that out. upstream.
> > > 
> > So you didn't test the tree you sent? :/
> > 
> > fwiw
> > 
> > drivers/net/wireless/ath/ath10k/snoc.c:
> >  qcom,snoc-host-cap-8bit-quirk
> > 
> > Konrad
> >
> 
> I think I'll probably just drop this until a bunch of other stuff is upstreamed. mdss is totally broken on mainline, wi-fi doesn't work, fuel gauge is missing, etc. etc.

Please make sure that the parts you are sending upstream are actually
working on the upstream tree. Otherwise somebody might try running
upstream without extra patches and be surprised about it not working.

The patchseres in question was submitted in 2020 and got rejected. Since
that time we have added support for machine-specific firmware-N.bin, so
Kalle's suggestion can now be implemented easily.

Regarding the MDSS. Is it being solved by adding reset to the MDSS node?
Or are there any other issues?

> 
> I tried the 8-bit quirk and it didn't help.

-- 
With best wishes
Dmitry

