Return-Path: <linux-kernel+bounces-635876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43379AAC316
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CDA468279
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98AD27C172;
	Tue,  6 May 2025 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W8p8CWkd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886127B51F
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532409; cv=none; b=hxm3BAQ7nhl+yKaiylkSLCF+L+z457BYwAib/afbZ0mjvrrB4xyP9l3dJldw+dC1kttA3J3fopiCECE4XkvY4Aa0Bq/IdrVtfDGcqW/632YNePftSEFCItlxaPt5GAQFv0C1yI8OlO30KWY6fAoC/J14JnVzCRp+ssCJHnQz8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532409; c=relaxed/simple;
	bh=cJ8z+e/cz/4JpyhS9gbI2W0uxCVuruKRkRejJqlbgbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZu633kepeUy5QSGaa/NC6ufGGw8PQ/jPp4dgLpLLghJ3YU0vJqWZEbk0P/HeodimHhjY3IohtOHyHZugWc7UOlgV7D1rj8YmYOHf0K5oBANVb1DyS7lmnYMeFS64zIZMTkyorCg0xC0FWNb3mdwCPmD9V3xztA7DNawbF4rjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W8p8CWkd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5467taBp017779
	for <linux-kernel@vger.kernel.org>; Tue, 6 May 2025 11:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=e2/mPm2rqjVa2UWZk3lLu/r9
	DrwqHykiPCnvgPRDP9Q=; b=W8p8CWkdl/U+Jl7zrxWRaneUa1lmPnoS8SdufiqB
	FssFDDUwKJkhUqZY6lLPezliomZilDA+PnRq9K0UP0W2m8BGqi1qZnJTWXkRImKN
	o5YRwnKMRBe7Pbb1yVc1KdPFe+/8FrI0sR6WduZV70EwstczDd80CF8Y9HOCVslL
	XYD3DHM7TtVWCLNH7aX+HIphJ5xECs4Xje06wcczOwDChkS7I76EkQYGSiETkWoq
	BqXgIzLLUW1irjjpQo2k2fmh0rA8dw2g9t+gGN3jhCRdgH0lCV+mQU4sv4IMG8Nc
	JoCj0GAus7uorHVDy9M1fbHFqb0VTReBu2BcDGgllvN8KA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46e0xswyr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 11:53:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-476a44cec4cso98058521cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 04:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746532405; x=1747137205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2/mPm2rqjVa2UWZk3lLu/r9DrwqHykiPCnvgPRDP9Q=;
        b=XjO75eSIXieUUOVGOFIMGUtcfXt+khrlQeyOKosfeTQ7eTxdLurU2IPmn/BycFTll8
         uMzk8tf2E8dCmNJhc9NNmiAqRCw9uuZwDi3a8/2OklnIKKk+h0gHx+yGFA+gNRgNwBIc
         KOlRJgQ77cQE3uEUngIfbUtZMdQZyoyU1HiZR9t3un4p4Yerka7TYO8dq8aoNSDr2GB2
         VS/jg8qnjPFwcyze/N43WCPR0zCrB5PSYSGuwVeK27H31h2zcWe8zbUiDVY2dW79+1Vq
         aE065RuthwYouBk4g28VTX9wsKzHZcAxCGhAL6+R+eKiJVXnZTK+scQx50tJEe1YcEhu
         sEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrHdnRUctxRMmOQueRv0o8otEQoQEVwLKBpJuxMXvXfHJekmdrq9Se/EDYryTNICXkBsJ78HUqWplJvK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Jo/qkoXExLpoSMthL0jA5ZdUKvjITy+Hmu8FCrmMFkQsSO5F
	30/BcSYNNyvcwgQdR81lkXuaOimygrggfPhhy362ZJcuX6LJBctyA3xedRbbCG5mdbVs3V9eOR6
	cH7n/9j4EktPNCxGDmCzYN0QDYowjm4z75ggGFQeQvZC0/P0Y6uGNaYJgr07FP/c=
X-Gm-Gg: ASbGncsvzycqlm989fmjRjtI425JXioC1aHC10k96jQ7YUU8R8ZbG7v/WMRHVcz0UiA
	T1tNL4puSPk+WInk6EvwogddFAU/JgsR3XQbiHnc3fhHiehJYHci5Zu73ZFy3irISpp/ZkLGYqW
	Q2NlcyPt55rNZ7tNiL+grRIxqDS6hZgbpZb2js94ffneNeOtXmUjtjdy1Ptif0VSwDEyvWY1Ypq
	Qv1u8ujB1WurGbLJ88G0aQAjNUsANiC3Wp5qfLmKlzV+i1OHBl7+PFe6oV6E1gYZplGdyXEO/EQ
	+RMGMW4Pj8YMjNvUWCncmNk5Jq3EMnhygb9FSw+9Tdi0osuKY/kMofjotSjoy0QfizlXUFGQ7wU
	=
X-Received: by 2002:a05:622a:7a87:b0:491:20d6:75ff with SMTP id d75a77b69052e-49120d6761amr30624901cf.31.1746532405076;
        Tue, 06 May 2025 04:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXOcFjlZPXrhnZADw3wS6Inb1dGDnsA/hWap6iVGRk+I76OYADv+/Pc/bqYfbWLm93Pti8hg==
X-Received: by 2002:a05:622a:7a87:b0:491:20d6:75ff with SMTP id d75a77b69052e-49120d6761amr30624541cf.31.1746532404657;
        Tue, 06 May 2025 04:53:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f6a7bsm2020949e87.222.2025.05.06.04.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:53:23 -0700 (PDT)
Date: Tue, 6 May 2025 14:53:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, manivannan.sadhasivam@linaro.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        bvanassche@acm.org, andersson@kernel.org, neil.armstrong@linaro.org,
        konrad.dybcio@oss.qualcomm.com, quic_rdwivedi@quicinc.com,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH V4 06/11] phy: qcom-qmp-ufs: Rename qmp_ufs_power_off
Message-ID: <qhblitwmuhnb7axrflsqh7pmshmhrehh2hina23k6zqq7mhafv@xtsl376cyooy>
References: <20250503162440.2954-1-quic_nitirawa@quicinc.com>
 <20250503162440.2954-7-quic_nitirawa@quicinc.com>
 <prbe2guxzsea6aqonf32m44zp6oa3vzdf5ieazcontv4fmx3d3@2r4tu5nr2k4x>
 <2191c270-f4fc-47e4-8bb7-ba6329332ef3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2191c270-f4fc-47e4-8bb7-ba6329332ef3@quicinc.com>
X-Proofpoint-GUID: uB7sYl0yy_sW7fYS6VRyuK5_BfdJ2gqU
X-Proofpoint-ORIG-GUID: uB7sYl0yy_sW7fYS6VRyuK5_BfdJ2gqU
X-Authority-Analysis: v=2.4 cv=bdprUPPB c=1 sm=1 tr=0 ts=6819f835 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=JfrnYn6hAAAA:8 a=COk6AnOGAAAA:8 a=mhj7_-Pg-QKlZrooJR8A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDExNCBTYWx0ZWRfX25FTC/ViMSGa
 tXt+tfwKREtWRSLoVYJvnSsGuyo/VSs/vtQ0Cz39crus54wKi54DkyN0qg7l0+HmKjTCMRhd5Ds
 fpcn1PvtObpqphrx3Ft4/v56PN3iDwBs7QTL3n3ehWv0EM4U98mbEOQp4QnWyqWGFg5LpZruRJa
 x1wsW/FBt4GroB9z+uULcEmOqWc4PpDRf3RLtF+666faNav9y8f0QNqY3VGuuO+otA0ZxQG92g2
 6QDnIqBw0jov1UgSwhz2YTK6xF8UPf9ZIoSUq0/bLKodTUeWHRPPEsrlWe+sAtYr/V5X/3ZkmQg
 jvumh2HINCTqv5SGGNltU5r32Rh7Sc2Bij9gNthJIFqkJeOSHzn2KIJkGnsayHUjdqj2EaZCCVN
 2mIW1uo54U+unqqymC8XDr6+cD0E8PHgba6XRF9bW8IO3S+jJbjDU9MR4Cavv4Hn/vZejUJ/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060114

On Sun, May 04, 2025 at 09:22:06PM +0530, Nitin Rawat wrote:
> 
> 
> On 5/4/2025 9:07 PM, Dmitry Baryshkov wrote:
> > On Sat, May 03, 2025 at 09:54:35PM +0530, Nitin Rawat wrote:
> > > Rename qmp_ufs_disable to qmp_ufs_power_off to better represent its
> > > functionality. Additionally, move the qmp_ufs_exit() call inside
> > > qmp_ufs_power_off to preserve the functionality of .power_off.
> > > 
> > > There is no functional change.
> > > 
> > > Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> > > ---
> > >   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 30 +++++++++----------------
> > >   1 file changed, 11 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > index 94095393148c..c501223fc5f9 100644
> > > --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> > > @@ -1835,6 +1835,15 @@ static int qmp_ufs_phy_calibrate(struct phy *phy)
> > >   	return 0;
> > >   }
> > > 
> > > +static int qmp_ufs_exit(struct phy *phy)
> > > +{
> > > +	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> > > +
> > > +	qmp_ufs_com_exit(qmp);
> > 
> > Just inline it, unless you have any other plans.
> 
> Hi Dmitry,
> 
> I have inlined qcom_ufs_com_exit in patch #7 of the same series. I separated
> it into a different patch to keep each patch simpler.

You have inlined qmp_ufs_com_exit() contents. Here I've asked you to
inline qmp_ufs_exit(), keeping qmp_ufs_com_exit() as is.

> 
> Could you please review patch #7 and share your thoughts.
> 
> [PATCH V4 07/11] phy: qcom-qmp-ufs: Remove qmp_ufs_exit() and Inline
> qmp_ufs_com_exit().
> 
> 
> Regards,
> Nitin
> 
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int qmp_ufs_power_off(struct phy *phy)
> > >   {
> > >   	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> > > @@ -1851,28 +1860,11 @@ static int qmp_ufs_power_off(struct phy *phy)
> > >   	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> > >   			SW_PWRDN);
> > > 
> > > -	return 0;
> > > -}
> > > -
> > > -static int qmp_ufs_exit(struct phy *phy)
> > > -{
> > > -	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> > > -
> > > -	qmp_ufs_com_exit(qmp);
> > > +	qmp_ufs_exit(phy);
> > > 
> > >   	return 0;
> > >   }
> > > 
> > > -static int qmp_ufs_disable(struct phy *phy)
> > > -{
> > > -	int ret;
> > > -
> > > -	ret = qmp_ufs_power_off(phy);
> > > -	if (ret)
> > > -		return ret;
> > > -	return qmp_ufs_exit(phy);
> > > -}
> > > -
> > >   static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > >   {
> > >   	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> > > @@ -1921,7 +1913,7 @@ static int qmp_ufs_phy_init(struct phy *phy)
> > >   static const struct phy_ops qcom_qmp_ufs_phy_ops = {
> > >   	.init		= qmp_ufs_phy_init,
> > >   	.power_on	= qmp_ufs_power_on,
> > > -	.power_off	= qmp_ufs_disable,
> > > +	.power_off	= qmp_ufs_power_off,
> > >   	.calibrate	= qmp_ufs_phy_calibrate,
> > >   	.set_mode	= qmp_ufs_set_mode,
> > >   	.owner		= THIS_MODULE,
> > > --
> > > 2.48.1
> > > 
> > 
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

