Return-Path: <linux-kernel+bounces-752456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30FB175C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD7F3BD3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5350228D8EB;
	Thu, 31 Jul 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HW6b4fRA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0422FF2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983820; cv=none; b=MptbBes2www8HvMAnol92JZhqkN3UAa+La5NE4+7BApBZsElm9uw/t5wv8kg+kGN9lqEn2BZCZ0oSDZhDg0NoZLKHF9jUemnwMZlXo/tpF7/lbbQzWZqS9lxJiIMjy1EeTGQz4a4QSYsfdg+fxtgmoPq1kg+q/yPV+b3Q4CYMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983820; c=relaxed/simple;
	bh=gF/Lfov/BGotqFyFDG+Y7IiqHn/X1SmvmbjPZQA1YBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdNK8ypJUmEYEoH2Q+kkfWcHCNyV6NqA8na/V9MpYiQXXEyc9XP15Ar5orI5DI0o58rjLP4pYZdFY4c6lAaxCCKkMTaxkd/bTBRjmGiVPwJjZ95vDMl67yprlsEsroqBRAP93ZVdM/jFndY58Ka72IBP4YtsrgoFbCsdITxO0q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HW6b4fRA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf9Za002538
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XgQLj33jhp7/creFx0MYZQCfK0nDYyjfst1wTym5RW4=; b=HW6b4fRAnBY7ty2S
	X4MA4g42Md+jfRahHHBZ88RIglcBUzDoEwehI/32C0VBdPJGVAc0KZh9ZCkEPOd2
	7BtgraezHj17WtQ6JkJPp887JBa+E+PQonkuOtcpHvHOrZSH7L0+NVs4yMmi8747
	+lXSGpnnu4MYDR9EL7FsqwS59X+cY69tx+vPJJzX/pzEbXo1U25Rvy6u4eX+guIz
	54IUGbd20L6ciyDmd7LaMS9hl+1AKwFuS99F7vpYExZl5RB7iyw/Fjdfa2rTQlnO
	4c2t/e4YTTYE45uRcEoXvnOadEJLVOKk80DQCAQltuVzjtJJRGwNIEJ0vCvZUvO0
	IWj6ZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbm8knp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:43:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab69fff4deso20363731cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753983814; x=1754588614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgQLj33jhp7/creFx0MYZQCfK0nDYyjfst1wTym5RW4=;
        b=h0oN3BhsayS+tAh5+BeU8s3x8Jte6Hqlgr3M/oKyWI2GBARYn3DaAu98m9e7LI9cK7
         GQ0ds2pHWmeu4iqRN1/x7LPNO0kkFijTFc/i4phDziU5BMEotiJDpKDuc7211YCh48W4
         RJlIQHLEoCy3IM2TWErpqvdPrb6/ktOq4exPZc47fkDndeCfYcqUM8ew4Wb1tBM/VAdJ
         aIA7Jzh7mdy/W/j4OWLYsUWIl9nBx6W+GROLHoQfEyslHzoi7/0IFNoaJtQOdMHUwi76
         O5AzUo295WZa1y5PQgBKcIkwnHdjzfPDYkFlLcY7rV62w/o62y4mE/pWzyRm9uUMElps
         4CnA==
X-Forwarded-Encrypted: i=1; AJvYcCW8LQvINF6wePvHN6w9kgyvZPww27AgmiFfVi2GDBfz5yyagBkjOZvpNG9k5h9e2PSxy4BM/3iOqzpBkEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EN/osJjjlVqbDCwnzWbLseLC0AO7YaLiAr5B/8iE4uRDfpYa
	BJxaEmGjY0gCSOZf2Yxc8IRu7WxYUgl+Aa0kKwWxbZ3kdmSf3L8GV2nmt2V2Gyri20WjyOfrjPu
	vBxsdOzbJ7OI7jkaFKnW7URCmq5I01q1Rs/spY2UhqLvfZ8WuAP611L6igd5QC9jEMyI=
X-Gm-Gg: ASbGnctdRi4NrO+bjliY1NRKsy2DzxcRJ2dOvQ9oqrKpjqNkJaJ8iAs09UJ13O1pP+7
	FouTfgsTIVZPevypOXvlxdG4ZdTExXtit+mYT+I3cKXoDT3Nsj6Jx/mjYPpIlqJcMNSY07OBMiL
	bVThUEOfwjI3o8mhdsyppSoJY80v0VGoAfwNvvvxVFa3/zCmuy4RrOXxwH6uo0X3pXlryTBFF26
	bm/tCV1tn8SEa3vo61/WBzjHDxQc9+VWFpWZ7e6UJg2oKtKciTj9bMFURjXFACgJgUjTfD1ig6X
	kMe4/E1iappQSN1xHyQdRa897AE53v38cpR34sorggp43yJUt0t/XOoNq/TUDbdPBT2nCZrhJF5
	0L5vRFZCoL4yuu9VDX1rTCxELvKIdAWnIk4VT2GTy5l5Xocv4tH+L
X-Received: by 2002:ac8:7dc5:0:b0:4a9:e225:fb6d with SMTP id d75a77b69052e-4aedb99e470mr112576861cf.21.1753983814117;
        Thu, 31 Jul 2025 10:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU41tcMiInT49q2UVBzc1ln2V3fBjU5vwnqygxgxHg5zY8lqlNmM/ASrKrTWFHWA7RYA25DA==
X-Received: by 2002:ac8:7dc5:0:b0:4a9:e225:fb6d with SMTP id d75a77b69052e-4aedb99e470mr112576371cf.21.1753983813558;
        Thu, 31 Jul 2025 10:43:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cae541sm317422e87.153.2025.07.31.10.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:43:32 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:43:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
Cc: mani@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ufs: ufs-qcom: Add support for DT-based gear and
 rate limiting
Message-ID: <fl4t5fpyd5o535djn3f5vbq4lqqtwx2dzcphxfdf7s6kxedcsb@yz65chgbcgd3>
References: <20250722161103.3938-1-quic_rdwivedi@quicinc.com>
 <20250722161103.3938-2-quic_rdwivedi@quicinc.com>
 <2ihbf52nryduic5vzlqdldzgx2fe4zidt4hzcugurqsuosiawq@qs66zxptpmqf>
 <f61ac7b6-5e63-49cb-b051-a749037e0c8b@quicinc.com>
 <CAO9ioeWLLW1UgJfByBAXp9-v81AqmRV9Acs5Eae9k4Gkr1U0MA@mail.gmail.com>
 <728cde88-1601-4c36-976a-3c934a64be35@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <728cde88-1601-4c36-976a-3c934a64be35@quicinc.com>
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=688bab47 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=w8oFfr48thh2NtF-ymIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDEyMyBTYWx0ZWRfX1jlLV0xNW/W2
 SKMa2dByQ0lsLl3iSuVBni63W94yA0wUJy7YMIXt3gDzb51dVlgtGzedGm2QNuKLEhEc75L68sy
 Bu5RDxBbceE9+avZ8mn3ApCpr8HaKn0/bFUepYeZzoHlNGBMFLSY2zIjgAH23KW3i+IA4C6D7GY
 3ucRKkuW/gdTotyjlmppEzIvhsBQ3AGE1hrg2x6wB/P5tioTv1U16d8tHn08o8iApwBonCL95p/
 tChhm9f89ROo7nVbqfYpZ1dSQRGk4Cf71/9dOInQKdTro802uoti7X+TBEZdv5SxohOYg5iB6BO
 KrrWuGSy2ES43gwsHNthZCi/Q2bkUQXc7sa8ex2mQjOQLwLNFCsuWZRsoPuFMfvemb1q3PSJNjQ
 /kFUTnfvH8omr7Sbj/ll1JZznQposIUeH/N4TdtkpYjfdt1JuoRjnGfrGQlWvgCb6YJOAGiY
X-Proofpoint-ORIG-GUID: GqhO0zWoVXrDKML_4DE1oDmS0hNSOMqk
X-Proofpoint-GUID: GqhO0zWoVXrDKML_4DE1oDmS0hNSOMqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310123

On Thu, Jul 31, 2025 at 09:58:47PM +0530, Ram Kumar Dwivedi wrote:
> 
> 
> On 24-Jul-25 2:11 PM, Dmitry Baryshkov wrote:
> > On Thu, 24 Jul 2025 at 10:35, Ram Kumar Dwivedi
> > <quic_rdwivedi@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 23-Jul-25 12:24 AM, Dmitry Baryshkov wrote:
> >>> On Tue, Jul 22, 2025 at 09:41:01PM +0530, Ram Kumar Dwivedi wrote:
> >>>> Add optional device tree properties to limit Tx/Rx gear and rate during UFS
> >>>> initialization. Parse these properties in ufs_qcom_init() and apply them to
> >>>> host->host_params to enforce platform-specific constraints.
> >>>>
> >>>> Use this mechanism to cap the maximum gear or rate on platforms with
> >>>> hardware limitations, such as those required by some automotive customers
> >>>> using SA8155. Preserve the default behavior if the properties are not
> >>>> specified in the device tree.
> >>>>
> >>>> Signed-off-by: Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
> >>>> ---
> >>>>  drivers/ufs/host/ufs-qcom.c | 28 ++++++++++++++++++++++------
> >>>>  1 file changed, 22 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> >>>> index 4bbe4de1679b..5e7fd3257aca 100644
> >>>> --- a/drivers/ufs/host/ufs-qcom.c
> >>>> +++ b/drivers/ufs/host/ufs-qcom.c
> >>>> @@ -494,12 +494,8 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
> >>>>       * If the HS-G5 PHY gear is used, update host_params->hs_rate to Rate-A,
> >>>>       * so that the subsequent power mode change shall stick to Rate-A.
> >>>>       */
> >>>> -    if (host->hw_ver.major == 0x5) {
> >>>> -            if (host->phy_gear == UFS_HS_G5)
> >>>> -                    host_params->hs_rate = PA_HS_MODE_A;
> >>>> -            else
> >>>> -                    host_params->hs_rate = PA_HS_MODE_B;
> >>>> -    }
> >>>> +    if (host->hw_ver.major == 0x5 && host->phy_gear == UFS_HS_G5)
> >>>> +            host_params->hs_rate = PA_HS_MODE_A;
> >>>
> >>> Why? This doesn't seem related.
> >>
> >> Hi Dmitry,
> >>
> >> I have refactored the patch to put this part in a separate patch in latest patchset.
> >>
> >> Thanks,
> >> Ram.
> >>
> >>>
> >>>>
> >>>>      mode = host_params->hs_rate == PA_HS_MODE_B ? PHY_MODE_UFS_HS_B : PHY_MODE_UFS_HS_A;
> >>>>
> >>>> @@ -1096,6 +1092,25 @@ static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
> >>>>      }
> >>>>  }
> >>>>
> >>>> +static void ufs_qcom_parse_limits(struct ufs_qcom_host *host)
> >>>> +{
> >>>> +    struct ufs_host_params *host_params = &host->host_params;
> >>>> +    struct device_node *np = host->hba->dev->of_node;
> >>>> +    u32 hs_gear, hs_rate = 0;
> >>>> +
> >>>> +    if (!np)
> >>>> +            return;
> >>>> +
> >>>> +    if (!of_property_read_u32(np, "limit-hs-gear", &hs_gear)) {
> >>>
> >>> These are generic properties, so they need to be handled in a generic
> >>> code path.
> >>
> >> Hi Dmitry,
> >>
> >>
> >> Below is the probe path for the UFS-QCOM platform driver:
> >>
> >> ufs_qcom_probe
> >>   └─ ufshcd_platform_init
> >>        └─ ufshcd_init
> >>             └─ ufs_qcom_init
> >>                  └─ ufs_qcom_set_host_params
> >>                       └─ ufshcd_init_host_params (initialized with default values)
> >>                            └─ ufs_qcom_get_hs_gear (overrides gear based on controller capability)
> >>                                 └─ ufs_qcom_set_phy_gear (further overrides based on controller limitations)
> >>
> >>
> >> The reason I added the logic in ufs-qcom.c is that even if it's placed in ufshcd-platform.c, the values get overridden in ufs-qcom.c.
> >> If you prefer, I can move the parsing logic API to ufshcd-platform.c but still it needs to be called from ufs-qcom.c.
> > 
> > I was thinking about ufshcd_init() or similar function.
> Hi Dmitry,
> 
> It appears we can't move the logic to ufshcd.c because the PHY is initialized in ufs-qcom.c, and the gear must be set during that initialization.
> 
> Limiting the gear and lane in ufshcd.c won’t be effective, as qcom_init sets the PHY to the maximum supported gear by default. As a result, the PHY would still initialize with the max gear, defeating the purpose of the limits.
> 
> To ensure the PHY is initialized with the intended gear, the limits needs to be applied directly in ufs_qcom.c

The limits are to be applied in ufs_qcom.c, but they can (and should) be
parsed in the generic code.

> 
> Please let me know if you have any concerns.
> 
> Thanks,
> Ram.
> 
> 
> > 
> >>
> >> Thanks,
> >> Ram.
> >>
> >>
> >>>
> >>> Also, the patch with bindings should preceed driver and DT changes.
> >>
> >> Hi Dmitry,
> >>
> >> I have reordered the patch series to place the DT binding change as the first patch in latest patchset.
> >>
> >> Thanks,
> >> Ram.
> >>
> >>
> >>>
> >>>> +            host_params->hs_tx_gear = hs_gear;
> >>>> +            host_params->hs_rx_gear = hs_gear;
> >>>> +            host->phy_gear = hs_gear;
> >>>> +    }
> >>>> +
> >>>> +    if (!of_property_read_u32(np, "limit-rate", &hs_rate))
> >>>> +            host_params->hs_rate = hs_rate;
> >>>> +}
> >>>> +
> >>>>  static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> >>>>  {
> >>>>      struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> >>>> @@ -1337,6 +1352,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >>>>      ufs_qcom_advertise_quirks(hba);
> >>>>      ufs_qcom_set_host_params(hba);
> >>>>      ufs_qcom_set_phy_gear(host);
> >>>> +    ufs_qcom_parse_limits(host);
> >>>>
> >>>>      err = ufs_qcom_ice_init(host);
> >>>>      if (err)
> >>>> --
> >>>> 2.50.1
> >>>>
> >>>
> >>
> > 
> > 
> 

-- 
With best wishes
Dmitry

