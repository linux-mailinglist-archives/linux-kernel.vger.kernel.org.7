Return-Path: <linux-kernel+bounces-737647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FDEB0AEE2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092AE4E566D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA976236429;
	Sat, 19 Jul 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aumUsjPS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243B231C91
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752914586; cv=none; b=A4slrfLSfZXUdZBhM19HM9+bcKFVXGUx2qGb49JLXhdtiTDdlrLRYVA93uWnI1HqaudiCWkwq0Fae7TNW1gJUmCS5gttBCgJ5MrA8WJcY86lgFLPdx+rBXtsjVoSdS6WFBvBV+soU/O4gtnKFtJnwYgpkq1/+CcHqNZ+TFSCQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752914586; c=relaxed/simple;
	bh=7iN9/WrBKY25iKx+cwZ+YxYqzk4F14RrKVxydDAyfcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmRtQDMF/BFGATmP9/y+TS9Az+1MR1E4NIn6BDhf4Q25SgKgVliArQG4e1GPSg6BsIp96NxPF0Ml6s2Z9zlGJvqmoaIC0Arp4vFKxzRadY/sCXVbmhuNF/mhljq8bpr0FSUKPDfnhQZHdxtk+LPTHqrOQTkY3cmU0jwrZBTLXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aumUsjPS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4exIA004952
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+hnvC71NGCDaTEDlHwH2F+79
	X5DpGLt8T8Ke/VwrdV4=; b=aumUsjPSYsYh7JHM04fduprz9eo9a/rcbnLWUMAh
	UABO04GkBiQfvJwEk9tjuTfhFZBc3o+qt6/SrO7+Crsmah+B3r3vX4bYgphCLqBk
	BZqBZIUwuYCszGWq1l8UOhAMi2SPyyXji2okom/U2ZjBZbv85jliWQeF//r0xKp9
	/ZAMRMOWIb5j93TskW5eV0LYVaPbqxzrxore/6zgzPnYWzOch6HSVYJa3/se11bf
	dbqBLYVw9pZB4LycMoAhJDCY7q7HGIgd8i8MYh35Hg2cujtPCn9ImbzSLfdF1wNd
	mw3xOtFMFCb41izcypdp44OrmSYXiTraqLmkCruYNccDFw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmga96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:43:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5bb68b386so764730585a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752914582; x=1753519382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hnvC71NGCDaTEDlHwH2F+79X5DpGLt8T8Ke/VwrdV4=;
        b=mBgu0z7TAwGPQD7Ib9Tu0lnc4WJ0ZWE7MJWprYXD3gS+VbStTGEJtwpSCw0iQNgl3b
         vjMEAbNH2WDKPZBdctBo8awkoh0df2MgqNOxrpoXn9BIWKl9hWFVCf5A66UKLVxvUK9f
         5P8q2no0piyspRnzOfrh7tGVDdQ+VCyx3lcaKXvhqOslo2RSYZ+q/ApTgFGclZP/WW6t
         qr2zrUzk0Md98gQAiyICJPFAgq4icB45VhzemjBR3ffnXl/9LQ5ZDm1ZZMrmzmpvekrP
         rf2yOK6VHtKQX9AHeEan6BY3Z6XDP0/6KaHBRj1lCJLibhr0xM8MTmK1fyJvyj+M30w9
         vrgg==
X-Forwarded-Encrypted: i=1; AJvYcCXKpxYb2f4baFRQc/DjO48mxKJkG5AGRgkn2TQfqOCsMOZU9g/FYQp7jXVdrTlyEH52zVtWKA76llss+yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQlDI6FKUrZ2FpI28jzaUQcUN/BNrfUE138fx7RbMhTLIt0QRq
	ZZ4nXn5AuRYKt1RLOIzp0MAmz3lbOgNNCWHYWhJHGcjUA6kZ9EAryagUkx1hXp8xCmQn0o71bEs
	jyo+cP9DzbdIjG44DkcPoH9yCEX0jDaE/UGIAhDjfKSHHDVem2q40kXg1tAg1SuiovGk=
X-Gm-Gg: ASbGncstGQU2jyitC0MP5tHbl5ZicXYkftoa+NY/WxUG9kdSnvvKDcuIYPile8MXuzv
	gmHOqKCj5E/ujelE1H86XsJKEehB+0x0q04T+juR3ERIorzBJZj74ALs97+QI/4cPWuD/+zvMt8
	CrlnhEFMV6yPhEJqOieVOCv58GL0hMyjZFbsng56Xiao747cpot2K9l00im23u0ZCoTx2fJ5GKs
	I6hclW+fSs4gS2xMxV37vh7yuv60BMiPF4M5jnJXFcKKINFYQcMAzM5w9bZB+Jq4CYXL5tUW3K3
	1vNmDaGvKR/8RCg3Pg3CaJVERM3MIXqVYYxMtu61F6HOV5gFX+i6yWB3FUGvOJ9uDZ9J7wE0EuZ
	BYpJW3KbHchNkVHTrEZpaddJxFpLZx+e2dJ91H+fNZciVmhTQiHc6
X-Received: by 2002:a05:620a:1909:b0:7d4:38f:a7b3 with SMTP id af79cd13be357-7e356ae1a00mr764033285a.29.1752914582260;
        Sat, 19 Jul 2025 01:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaL23hIhZB17M6H1XzM5tH6etKFp/euLYf8xiH9hxUCYpIqAx2BG9Fx6g8LCbtyU3x+HRyKw==
X-Received: by 2002:a05:620a:1909:b0:7d4:38f:a7b3 with SMTP id af79cd13be357-7e356ae1a00mr764029885a.29.1752914581761;
        Sat, 19 Jul 2025 01:43:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d911c9sm623429e87.147.2025.07.19.01.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 01:43:00 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:42:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: Fixup x1e80100 to add DP MST support
Message-ID: <fmehneccbfrtvr332o3z5qo4wduha4i32c3lf5vixcbskeioll@7ax7pupvdcnt>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
 <20250717-dp_mst_bindings-v3-1-72ce08285703@oss.qualcomm.com>
 <unwinuwoft6sfczcjlqq5kijss3ttggfbobs6ydw5c2lkmndc6@7c23jntiprob>
 <1b385a59-5461-4c28-855e-d2379c2a8173@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b385a59-5461-4c28-855e-d2379c2a8173@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: fZlUaG7BDzqHsbIxjW-Oha1kToGj5JSg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA4NiBTYWx0ZWRfX8LXxygS1EIgh
 haY8ZVoj4QUqTnTcJ5beQs9WcKw7KjcirwNeCPtXp+QOcy4L/Uyo0cpQ1/pWIVc6M19rJQxPSza
 2jMIGcRmESIDfoqpylkxoa7qBOpsTtjG8xgVJjZbr69/9nBdvMLIZguAbd+rtdVKTvoXp9hT6oA
 P2IqYRltYRZyKcBW3up+aQNBN3cTZHnUMrkeHcvAk/cybyrf6OMUu2R68DmrvD6KwJYQZnqoZag
 JnG+PWAU+0Aesg8oJ0jDN3tPKZPWfd28V5KdZtO0ETx8CAC2pMEdmT8ZGaTyYfm4RO3ScbzyggW
 2TdUW7DA98pUh8AMyUcbuqvX2lfjB7lTv36oeoJAqCuuVj5SX/9rpVh5tcsNX+75VE7Okc8mRBt
 k616i/LTq+paWjR1rl4XPpNq1w/09tkH4FZDsZSOmMaktt1v1LtsNDDjuPb6dibuEg/5OPKH
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687b5a97 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=cjBuAn5bJLGjDEKm4m4A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fZlUaG7BDzqHsbIxjW-Oha1kToGj5JSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190086

On Fri, Jul 18, 2025 at 05:16:56PM -0700, Jessica Zhang wrote:
> 
> 
> On 7/18/2025 2:13 AM, Dmitry Baryshkov wrote:
> > On Thu, Jul 17, 2025 at 04:28:43PM -0700, Jessica Zhang wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > 
> > Please fix the patch subject.
> 
> Hi Dmitry,
> 
> Ack.
> 
> > 
> > > 
> > > Add x1e80100 to the dp-controller bindings, fix the
> > > displayport-controller reg bindings, and drop
> > > assigned-clock-parents/assigned-clocks
> > 
> > Why?
> 
> IIRC issues with the x1e80100 dp-controller bindings (i.e. the reg bindings)
> weren't being picked up by dtschema because the x1e80100-dp compatible
> string wasn't in dp-controller.yaml.
> 
> I can add this to the commit msg after moving the
> assigned-clocks/clock-parents change to patch 3.

Just explain, _why_ you are performing the change, not what is being
done (this can be understood from the patch itself).

> 
> > 
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
> > > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > > ---
> > >   .../devicetree/bindings/display/msm/dp-controller.yaml    |  2 ++
> > >   .../bindings/display/msm/qcom,x1e80100-mdss.yaml          | 15 +++++----------
> > 
> > Split into two commits.
> 
> Would it be better if I kept the compatible/reg bindings fix in this commit
> then squashed the assigned-clocks/clock-parents change with patch 3?

That depends. If these chunks are required to fix warnings / errors
after adding compat string, then keep them in this patch. If not, split
them to other patches.

> 
> Thanks,
> 
> Jessica Zhang
> 
> > 
> > >   2 files changed, 7 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > index 9923b065323b..4676aa8db2f4 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> > > @@ -29,6 +29,8 @@ properties:
> > >             - qcom,sdm845-dp
> > >             - qcom,sm8350-dp
> > >             - qcom,sm8650-dp
> > > +          - qcom,x1e80100-dp
> > > +
> > >         - items:
> > >             - enum:
> > >                 - qcom,sar2130p-dp
> > > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
> > > index 3b01a0e47333..0e699de684c8 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
> > > @@ -170,11 +170,11 @@ examples:
> > >           displayport-controller@ae90000 {
> > >               compatible = "qcom,x1e80100-dp";
> > > -            reg = <0 0xae90000 0 0x200>,
> > > -                  <0 0xae90200 0 0x200>,
> > > -                  <0 0xae90400 0 0x600>,
> > > -                  <0 0xae91000 0 0x400>,
> > > -                  <0 0xae91400 0 0x400>;
> > > +            reg = <0xae90000 0x200>,
> > > +                  <0xae90200 0x200>,
> > > +                  <0xae90400 0x600>,
> > > +                  <0xae91000 0x400>,
> > > +                  <0xae91400 0x400>;
> > >               interrupt-parent = <&mdss>;
> > >               interrupts = <12>;
> > > @@ -189,11 +189,6 @@ examples:
> > >                       "ctrl_link_iface",
> > >                       "stream_pixel";
> > > -            assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
> > > -                  <&dispcc_mdss_dptx0_pixel0_clk_src>;
> > > -            assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> > > -                  <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> > > -
> > >               operating-points-v2 = <&mdss_dp0_opp_table>;
> > >               power-domains = <&rpmhpd RPMHPD_MMCX>;
> > > 
> > > -- 
> > > 2.50.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

