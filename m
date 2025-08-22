Return-Path: <linux-kernel+bounces-781573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF5B31437
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E685B188D27D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8211E302740;
	Fri, 22 Aug 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvjNoG+q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D32EF653
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855634; cv=none; b=Em9cEc3lLljH8QCaxSFPv1XNU9tjjJ2sNPeUHHT7GQJC7mfLzKiEJt5w+MNQ1OVmSURf+EkaY4EgmZ2+iqwEQjgcZ6jFktMSzzllL2SZ17fekf8+lj2otFN+pOnDgxfpqJleGNlLRYWal+z7Udmc1H26pFMtC8fcnHDP3ENBhtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855634; c=relaxed/simple;
	bh=jmzwF7hgpK+QeNYSHRElJIUrPbgwq9GsIHmndptgODM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QswnB4MgQvz8I2D4a/x1QKCWLa/AnZzBWfqRls6qehQV/X+WP2LgufjG9Ib4F4nKgj2QP2mNN3+k+RyrhVLC+WjbJdFUC81u7gE51RipbWBry1TYTrmYtQNOvA6Sqg2RVl1uwRRNUIfhDZK6S0imhC0Ds1fNIJtBXDdLHTe7/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvjNoG+q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UlIV029672
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oTdfVcHoKyH8WICZlBEizZHt
	xUjGef7BEKTRRFMZNHU=; b=YvjNoG+qJZnkXcCMccxiMYV92i/bW2UvDcwbxlEx
	CV+neUtgBnJeGViAnSZM3NBQAFxIEYLNBrzIZRoMGSYoRu77FN9sWVdm7qkJhbTo
	4KjSwDFVRssRsbw41F2grklp6e2HXOEV6AiNwepobJTfJ517ZlHRJSzY/PAzdP04
	TN/0oP8LSfFHD36NtUf1eL/NsID4M1NFGoXof5a7XrODQ1yB2fCTNjca5GGZW47v
	ZX/cdHFt/WDeh++OF/N/T1l51TcblEMcbt8ST441fMMoX4/nm2bet40a+xeT9xzI
	wuqoS2Ii4aYvgsH5U3gtLLmKJOaxsalDY0G0NkjuuNNKKQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52crqye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:40:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109a92dddso57029621cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855631; x=1756460431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTdfVcHoKyH8WICZlBEizZHtxUjGef7BEKTRRFMZNHU=;
        b=HtkWtZiqvulyXE6XJPkIRCw68SyrIseWajv4e4EQ7EqQnN90dQd8TqEUR+hEcsq5oP
         7n6vjid8m6QIuSxpsGnbzp70fKsDNbCgUbKaz90JjY0+YIkoKMFq5wTt+E+/1Nkn5bk+
         ckMJcVgUD5bRVnLnqgNo09uOrsybPX/LOJc7tLvIEPWMxu4cLw7fCJbeRfllCIDUqdHV
         UIzByTr9b7tiCpuMYeDz6FJmkbSA5T+NZrq49HIbikqh6qfUTjABY0G0FLmz9Dunp9tC
         I1ZJxJGJa9jLBh1xoGlvcCosp2LhQlf+S5HCvoFu8uHhfX3qHVOUwSs4xo9uj3jNMneG
         luPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRlkx0EWCp9YeOgQ8TIcsfISr4UkXcrBKXIg83sOCVOQyGOariJrL+j7BjIx2Sa1gu6DW+Cw7bLqytLkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QAtmSCxNqJosbiTX9BZjV3UWYmxuWMDUkvbI17y6ZDvnrYCw
	yW1BVZpChpD/DUdT99etQ4pv26lNM+BDHP3CuePDUuY+bGTvj9bpM3pCgK4s2Jr75S9Tirg0Ubh
	EvLwx4Z+5U7Uw2hPiSM3bCXfmM7Tf3OUnka9ygn1NxSVEOsNaU4oVvnaMa21WlMymIS4=
X-Gm-Gg: ASbGncvG0/s8IoSIxEnZ2Wtv/Rr/77HASVYG6GNTki9H3iqi2O7N0B/eV+kkOM7psxt
	bWVPnjTM3FEAlut4/5PKXfZ0bd+UJ4ju9fAbORMrEVjsnXiAulQTDHMx7vXcd9yUTVRe5SireUf
	jq3shlMPAW4qQRLRtenVSa3I/mwkAfz1jWjripGiA7DUpw/C9DCIeL+6b9B243xwChPHT0Z+Kdn
	SXqf+LT/IYRKn6vcirPp4BWClWEYjEX+9vo61JIBLIaXZDmmKT2xMsgR1U0mOy7sjAUjKzU/Ejs
	UgDDrdEDSLPVMdnT73gUxOnfotQp/HluOZZsLRYNNetyis0BNBDCdcEcg+Wr8yhI9VxKed10Ocs
	7PnX8USGAiGbS6edzvPnEHrtKL/ARPqorr0Fgarx1nx++J2TQnNgn
X-Received: by 2002:a05:622a:11c9:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4b2aaa7d88dmr21808871cf.36.1755855630875;
        Fri, 22 Aug 2025 02:40:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsVhv7L8dU3Sq9QVmMF8OX+HjQZsePw3qXFbwxDvx5fPbibAtj7OF1KcsW/5psLmLDmYVKTg==
X-Received: by 2002:a05:622a:11c9:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4b2aaa7d88dmr21808571cf.36.1755855630011;
        Fri, 22 Aug 2025 02:40:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a63da08sm35381751fa.67.2025.08.22.02.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:40:27 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:40:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Srinivas Kandagatla <srini@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Christopher Obbard <christopher.obbard@linaro.org>,
        Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v2 00/10] arm64: dts: qcom: x1: Add missing pinctrl for
 eDP HPD
Message-ID: <xos3ayzhunyl24wu3nd2vqutvsx5dnffqrrp2xnouw2w43nmsw@mbfmcq75qgpn>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
X-Proofpoint-GUID: ckXNWLpaaMv-xW7haz3kz64k2mgV--ti
X-Proofpoint-ORIG-GUID: ckXNWLpaaMv-xW7haz3kz64k2mgV--ti
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a83b10 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Cg9rbgvQzwxKNQwbMMcA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXzyMMvijNcHkZ
 GACWj7yr2OsMxB5IvL6GrNZJjip3qwjMkUL/Cs8FjsIaMvdqJAJ6C8NMF/blRV9/JRqnzmq2+qh
 aCRRuvnvuow78nplgCWVN+4v9lsiVmkSD0tDqKrersEiVgw1uwm2nTK3XrE1M2Yr+zJCQi4m2ox
 Qx7+zWkvAB+zdTIYBNnrAOtINA16UjO7Jf9lp3J/QaURpGdCVS8F0hVYXDrLWdrrrFa9f97rXPA
 reD+pnALh8jIWbuVhbS/ATz8ks18I0u908t7tzdaI5pN6Nav7EAzBNpu4t40kcdpFOwoJthGUbL
 6BSptyPmVaYEQAbroON3bggiTkYWaieOqXyq/BNvoGqXqXyyMRC4vWbHgSpprft2IfCK58ZOZOK
 uEtTSka2iGPj97afGyyguZJNOkae8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On Fri, Aug 22, 2025 at 11:28:51AM +0200, Stephan Gerhold wrote:
> At the moment, we indirectly rely on the boot firmware to set up the
> pinctrl for the eDP HPD line coming from the internal display. If the boot
> firmware does not configure the display (e.g. because a different display
> is selected for output in the UEFI settings), then the display fails to
> come up and there are several errors in the kernel log:
> 
>  [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
>  [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
>  [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
>  ...
> 
> Fix this by adding the missing pinctrl for gpio119 for all the boards
> supported upstream, using a &edp0_hpd_default template in x1e80100.dtsi.
> 
> I ran into this issue on the X1E CRD while testing some things and had this
> fix in my local tree for a while. Chris made a similar patch for the T14s
> [1], this series fixes up all of the boards upstream.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20250731-wip-obbardc-qcom-t14s-oled-panel-v6-1-4782074104d1@linaro.org/
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Changes in v2:
> - Define &edp0_hpd_default template in the SoC dtsi and only reference it
>   individually for each board, since it is exactly the same for all the
>   boards upstream anyway (Dmitry)
> - The resulting DTBs are functionally still the same, so pick up tags from
>   previous version.
> - Link to v1: https://lore.kernel.org/r/20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org
> 

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

