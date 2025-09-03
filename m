Return-Path: <linux-kernel+bounces-798787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B248B422FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EB7582231
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728AD30F557;
	Wed,  3 Sep 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRlYdSsp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B3145B27
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908156; cv=none; b=rnS0tSAMyarv/kb7ooGPaslauTWmo31mMnElMVRTcg98FZ0FJ5QSCClilITa8ESTzs6clc2UDdIO5jjO+o/ujqJ8pwIk8e65sWGJbJlyvhruzt/JbqT76+ANDMZ30VJyE/Ah2x5/y0ZqLc7FKxdfmiNCe6xcNJFaPr7Ztg1eZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908156; c=relaxed/simple;
	bh=M1LtgKaIxvKtJ+9qrPZwuMH/I9dN5enhPX3YUdHFus4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lruNlIlvOK9dln23BtcR3KsQZyZlAu8+D002TqbA/M3byL88aChwfLf0wE9e2zm1ohHTZQZLxk4bViFH5yt81DsFOob+D1WpYWog/aMZovDsUVqGWwX5S/GAoNhJzhKjEew3mThM+9y7Wy8TudyeWsRs7Xi0s/noj05CgvyWa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRlYdSsp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwrSx029052
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 14:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n+WcvQ74Ce4lJ577+ml0y8UW
	yDHNSNlwkTL36vqsE/Y=; b=bRlYdSspZpKNzm2T/cwtImHx1+fmgqAOO2AOAF7o
	wGcT89iVb9A6IuUdLa5F1mdHTmBJce+mUxFFhS9rAt5Qfn62K0zs5ue7tTc+FZwE
	sdJonU1/V68ggFK2zIWWWlljsdySDjE+G3VNbG2QSLZI1k8a1APeeOkFIxrQJyOw
	49AQrBPZ3tTk9Zxh1GCpS5fRje3OE2HRs0ARc5YwRZQI7PW+wvAkajLGVPUHJkxw
	WayV7c3miaOWdpu6HtigjV2hmyAPpGz9p8dbohnquZhmWT0bFvimoZSgIjgICCrH
	mFpfaQNrU+5MqRwa5DeIqN4oMRcKO9eKK2cbI/AdXf9Hlw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw03y2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:02:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f705186bbso2767063a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908152; x=1757512952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+WcvQ74Ce4lJ577+ml0y8UWyDHNSNlwkTL36vqsE/Y=;
        b=f+jkDpsfEvGPPaXOioJQYc7WIjbrURsV9/PYxRULeq8k6I/hMkMsk2zeg5CUCdMAP7
         jYrrS/0bndE6OjZcP1YPDCuAFhPqkwE8lywGBxQS6L5SrbwXZhsNXIWjN0UXYuOG1XKa
         pQDu1CVgMA36cDlR0j1UeNDyMUv0BbvhK/3wyxa9NGgC9r03zRRjY5lkRsDLt7x1JqFa
         v9xdtyl+TGFeo/YkJHX/vQsmRlDe/1ftxlBX2AMkz/ek3crDCbQPWr9KthYXxewb+D/z
         SS10LhOiM7oYPLxtHLqbBhxr0XQJbkcmBcxNyXRinVVgeT8AugrLedlEfQMmLJLvtW4k
         1jKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoLG3QCxzR7gfA3eSyh89M6EWN17wQmwIKEPaHPC15zKc5AQ/fnW2sA9lGlelIUpJS7BKSQ5zh2fvHi38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQEm+sne0NIEbWyA6bjSaw099wasYqTx06vCPWYW0trE215+L
	jN6LO8cJyg964uURrfL7MU5Pl67kdz6wzJbOwx5VvxYOlS0e8nebKXJ36EUXopa1NbbTUkR4eBi
	S53EiYg4d1LX1rDwu9DMfkF0LdGeBYPah+NtBj0YiB6leEKV2E/L4GohHexgRbuVP52VTbpTXwP
	A=
X-Gm-Gg: ASbGncvCScPKV3ww7TIAti5t1spEnS3nu00EUPFPCf8mrAy0Tum2GRkEC2lw4v54tcc
	9+NsnnGRRT0pHAp56neNImFHeaqpMDCNNc9eEVcffCYgM4L0haKtPFtoHSpo0josVQdNXWvXQyi
	3o19AEM16dlwW1YZbYnEHTjsmWQDukYidEadhq9J5QQWtK0tEkf+FdpjFmzEdf/J+Pm4kwHhJ75
	J3F0jxDSEce07rsw3kSUk9XR4sFuCcqJRy/8n+3Jj75buuEeb1XL0RXcQPnxCw1JdW1I64F66NO
	eQKcYt13wCc5ffWFHq8TpyRLrjjFpcdAwNEYgLKM7zVlg2vrmzRQ++vEGNFCkIOo9aiwLqinGQ5
	i5gmzpPpKc491gl8VriBK4x4h9ZNaNSFKLK976pneA5Q2y8iDizk0
X-Received: by 2002:a17:902:d512:b0:248:f653:538f with SMTP id d9443c01a7336-24944a12af8mr216023185ad.27.1756908150881;
        Wed, 03 Sep 2025 07:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIBrzUehFEhNOQDQfk8OUpugY6wgISvKlXoqbQ3W4x5v+1NPoa7mta8UknLJu8FmxdZvq0rg==
X-Received: by 2002:a17:902:d512:b0:248:f653:538f with SMTP id d9443c01a7336-24944a12af8mr216020855ad.27.1756908148649;
        Wed, 03 Sep 2025 07:02:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5e53dsm548761e87.7.2025.09.03.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:02:27 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:02:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 00/11] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
Message-ID: <2g3iwc2en6wh2ucrsth5ontzdwqr7tr6oplxjnfdjsy3lwyyfe@l76frwiadgru>
References: <20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com>
 <660c2594-9a93-450e-9a2e-17ef6b4c696d@linaro.org>
 <20250820112242.usd4sdd3avxdlcas@hu-mojha-hyd.qualcomm.com>
 <f5582304-8f55-4c3b-b752-9cefa1e4df96@oss.qualcomm.com>
 <b5a0ad0d-ceba-40d3-a111-0831c4538cea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a0ad0d-ceba-40d3-a111-0831c4538cea@linaro.org>
X-Proofpoint-GUID: n095r2mvzaYrB71mI_NEE99MU7HqKlXy
X-Proofpoint-ORIG-GUID: n095r2mvzaYrB71mI_NEE99MU7HqKlXy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXz3iy3ggjMnIl
 wp5mvljpjNiKcxL29GJDZxAKsmF6JMQClbx1VVAptZs/N7SOzqaraZQiyRObDrIo3kPjqSBgX3e
 CdlfYQ2OuuQNq5N1bhtrSPlL+nucSU2fM9pDxpCtBDFw5xxf0WDEsmQS4meYLpo75c2jA8gIoJ1
 EJ6Xw8PUtlcYRmpiR5krb5b4RyoQDRg8mClv0tH7AcpPxkgyyjWFVOqhYGpZmCz+EMFoHPomyAS
 rs2bqz8+8e+5a/b5F61w1qAdxc6mOWCZsD7Oohub5gXl8lyk0kJeANILnbTn5kj5MM0srl+DnRd
 yBShnwOjFi3KqcE37jvex/pM3vcluC1acDiOqJU2c32/JhmwC/iJKTHEtppPvndBipkoDgTR6lT
 Nr7igI4P
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b84a7a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=14clLndLnRljEXVP7n8A:9
 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Wed, Sep 03, 2025 at 02:31:55PM +0100, Bryan O'Donoghue wrote:
> On 03/09/2025 12:56, Konrad Dybcio wrote:
> > > Can you try with this next-20250814 tag ?
> > You sent it on the 19th, so it's in your best interest to run a quick
> > 
> > git rebase --onto linux-next/master $(git describe --abbrev=0)
> > 
> > and giving the series a prompt re-test before sending, because there might have
> > been incompatible changes, whether ones that would prevent applying, or break
> > things functionally
> 
> I can't even find that tag next-20250814 closets thing is

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20250814

> 
> | * \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \   00062ea01d35e - Merge tag
> 'drm-xe-fixes-2025-08-14' of https://gitlab.freedesktop.org/drm/xe/kernel
> into drm-fixes (3 weeks ago)
> 
> but patch #9 in this series stubbornly won't apply to any SHA I've tried.
> 
> meh
> 
> ---
> bod

-- 
With best wishes
Dmitry

