Return-Path: <linux-kernel+bounces-825092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC231B8AF14
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CD1B61630
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB7C2690C0;
	Fri, 19 Sep 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7q0S1/5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF921C186
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307019; cv=none; b=L0IjCrUK1bkzPxELA1TSA8O+ZDpmxpV14U55vK/OtCn21DgBlmOhjQcmfsmgOHd+yFU2BKiE4gAQ5KGZuJmLiPylUH5JmHEgd907bHTq+ooLu4NmLjG6Byu08t6igf4dg+DP94LiY9SM81jsqiHn+hqr0hW4UCIDIRd/uvKE9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307019; c=relaxed/simple;
	bh=IaLYIZc2t4TteSa/Pl69q9ZnKun5P0ZXuMJw+fMVLMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGGkc4yNOVuMv+Cb+xr0OSoR3K3xPdKORqfz52sp6euCvR2SO8IVrYD4YJMrsioV/D5sCqyINT167IEuCgdTW8i8VQp8vi/URDbIuACt7UaVThTvH7AzEX7UTEEJf/noS9Zs87fzNZnnVweUOcLoo+5ytpgV0gZMNJQvZaOnVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T7q0S1/5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JH3Bpb027120
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vRz1jj9Fk7FMvLwwInOIipNq
	laSA7q8QqUGbRTS/cL8=; b=T7q0S1/56oKp3yty86n14aDdpqh/9Z1ndST+684P
	M2XBtNCbRl+Y5bvzIB0ml05IE2bRW/vvQyB3DpluNUjouIkOiWYFGDdEUJXm5oPm
	yWhbufNtTvxpjoOgWUOrRlSRFmvIosvpaxA0oEzFhH5Wq8XHfdHBipJ5tzHOmGow
	YxHsR0LJrAh7hqTmVoQLeK3AtjKvv2VnQThzWUSVNolN9Iiq1EKBy3fwV5T89ppF
	pymjmt/7ch301Tv4NWMQuyPLQ/f73afpyyF1I0AxtjY+x3tk/Gx8TadDISYMx7fX
	y9x2ai+Q62BIQCndoS1Vd0saC/kxj07IvK3yvyZ4coBvvQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jhg0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:36:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e303fe1cso37280771cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307011; x=1758911811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRz1jj9Fk7FMvLwwInOIipNqlaSA7q8QqUGbRTS/cL8=;
        b=TFfgI3H4uC/hczCKVNvG+Vk5zflSA2pPw9Re24WyGZyGg9QlPSND8nDUN0hZMegXMV
         QKbEE/JF3RrHiIuhUPmoZxLyiJvAWey5HRBrWMQyA0APeQTSjTLcoD11E1ssIqLmB6Cc
         A38IxsgKZa7e9xnqD8J2M21EulsWhm9mYnQ4JIxze+j0bPSaxDBgih1ad+mHGMDheqrB
         5EKtrT+TJHI+QQyoL4WmTBu6GeIIUEUXOWmKXGNNPjuFwZ4yuE21XnxhAA/fiyNOGZYw
         fHY3gowD+chlXGWAs90zIgKUceWn1lc+8IDAgDpOKn13yf+uj3bV22nHjBGt/cPlt+x5
         YYlw==
X-Forwarded-Encrypted: i=1; AJvYcCW3jbT0fDGqS/wcebixOm1MwXjUJgPBpwSdmz0iKEoEvezCDP/P+VVflHL5JoJznn5JAlbyIXCEY3UG0TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIXQ5rnSdpqJAJkLb0uyxT+Gtsd2Wdf8NOV9P8MqNTUkHokEZ
	7cOEBv/9DIgFDq9TEOmDk24+6SJtRLHcgYjiYnWR5lUibtWcG3Agjw00gvFzfUQCZKxOFb5dzud
	FcWKT4l09A8TSeeEcg0XAadRs96Ib+ff3WsYd+oeG0Znbdm7iUF/t+IBgn0kILuTVvxu/RLi8+1
	s=
X-Gm-Gg: ASbGncuTPtKTUyjf79vgPtW1R5FY0n0F+1FweMqpF2b/n/YPk8ogtqgEa7Y0KUPHuPE
	lKLz+gsWcEwAx4gm2Mn9maJSSieORWseWkVJX+BDXvW5LQzoEGDEmwBkSn6ekD4aor+77RwukDv
	8eRzbhY5fgN6WIBocvpzDUJu3YKB2Z0XitkyhGRf8iPZOgkrKL7e9BIPkO6SKJijdF0iwMjs3+y
	0LqUXb7eGc0w1cOZex60g+u7B56WESvInAd1jQ1vbts2Gr+zGxZ2VHhm75GAi7btbgR1813N5Xb
	uABFOgYvaFwedQEiBohzcxQOpBoW3nbX516iX1WLxwZqVBOZ+tvOjhS15sJ/wE7WtJIzxe4HvOX
	UO0KOOjZ7/sJOlCfegN9OrNcdHQECOaRM5HUF271j+ouMaRdUtx0s
X-Received: by 2002:a05:622a:8e:b0:4b6:22c0:28b2 with SMTP id d75a77b69052e-4c06fc17cd2mr44749391cf.35.1758307011141;
        Fri, 19 Sep 2025 11:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7BZxgFDyOXsNj9/jIpPAudBj4ew/yuL0jMxO3583dHiffWIBP3ZgD++Hgh8WNcx79iLjzSQ==
X-Received: by 2002:a05:622a:8e:b0:4b6:22c0:28b2 with SMTP id d75a77b69052e-4c06fc17cd2mr44749081cf.35.1758307010702;
        Fri, 19 Sep 2025 11:36:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361aa4809fasm13689321fa.68.2025.09.19.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:36:50 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:36:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pinctrl: qcom: glymur: Fix the gpio and egpio pin
 functions
Message-ID: <whhmtqfa62q2cstagywz2hesk6t3h3o7hxlcn47gjmodjttm35@lobzyyzv2sxv>
References: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org>
 <20250919-pinctrl-qcom-glymur-fixes-v1-2-426ea410aa94@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-pinctrl-qcom-glymur-fixes-v1-2-426ea410aa94@linaro.org>
X-Proofpoint-ORIG-GUID: 8XH9w3FhhGmKZkWHk4DuCaAyZooKoDFD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX3XdEdaUEMPct
 zKa+U5JT0OS2u+ZODYg7lKFUoy0ft9hJxN8uPbJro9X/8Y3+imjYn3ybS4kVQQCzRqQieNjbRGN
 kzxtT9PgdfaFPuBSlW7RwygX0zznP8IQqT171sAJaHUgweDQ9HhJBXyZKFRMPWM5mWgirHExxMH
 W5jrsBf5kwYZIpflsjopcy7a0POaaaYQuqSQ+MRlXIseYBkV+sPRz1+59d1KOVBxK0VYkEtm5xj
 Kb/iXdSwtNoqXDxtsDl1m8yQCPmpMyCdl0NFWUsKJUZns4kvKC0SWop0vV7AopZiBmsCu4o6wZX
 6KcbNDU7mhNKX0QsCMg19ep4sQMY/GzDHOC4aAMuwj5PMbN7Y3eS0WSX5qhzO7ZYZ+kxjkLMXU+
 djkDprZg
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cda2c4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CQ4xJWP5GyeMjeXyLdoA:9
 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8XH9w3FhhGmKZkWHk4DuCaAyZooKoDFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On Fri, Sep 19, 2025 at 03:17:12PM +0300, Abel Vesa wrote:
> Mark the gpio/egpio as GPIO specific pin functions, othewise
> the pin muxing generic framework will complain about the gpio
> being already requested by a different owner.
> 
> Fixes: 87ebcd8baebf ("pinctrl: qcom: Add glymur pinctrl driver")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-glymur.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

