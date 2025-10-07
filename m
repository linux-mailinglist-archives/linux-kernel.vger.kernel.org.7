Return-Path: <linux-kernel+bounces-843671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A737BBBFF64
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B761891833
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325F3175D53;
	Tue,  7 Oct 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlXMoU66"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A035972
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800485; cv=none; b=eTrh66GsqJvzcIfzUjpvkRbEFo0ZCLqXoiGmAo5D/KbroqRobEIXgNKcuHUORBvKdvQIgyoi9vyV/ipnsCwgjuAYitL6sxGeK+3xYNiF74Xn9uqoyLFk3es0r+Qt60NOHna8XGc3kbR9YxyJT9l2ooLulRfAlpWGyh1n6IRefSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800485; c=relaxed/simple;
	bh=4ualLk1DeZlEWqfWckWpbEx0sirQm5t7gARFYSVy84k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ4HnuLAX2y0qyOS/QCwuqEkf251Hy4jiMLTK2XbIu26GhlTqgMAVy8VNT2TqRuBlLRZB2r+xGqlup5+bKW6VavC8KFqy7DyTj36z+WUpXP6eV4JSDvPB+KA4zJPo1MFTfp9Jk5ttvVuTUStMiVSn8VM3f4whFima64139rlfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OlXMoU66; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FIboI000498
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 01:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=i2Wck2j+6o7Lb4Qgkj6MN4x7
	UQxZYVDXXZmfJzy/gQY=; b=OlXMoU66GWfO5eZBg1onhe0qcCdzcoLKfwG/Wa30
	qhrX88P/JBS8XLvDm+nxwYn2lASkLj1Tk4rrACWYWjEn/KDK2sB/6zARQkaPAjCn
	PhDKzJMOx6zLbxza4CcHM6cBjkRI0H0uPIGJmNpOHZWAekbmSsOsgr74nVthpaDF
	M/docPEEpBj+nClSsHQk9SQH4EGumkMvh9mjaTTwvu0OUCThv+yWCVPvttkqzi9p
	jI0lBiKwsgCZUYGruyxeDmLgiqVtR+vjWSCcqGpi6PoDm/Z5oqp85g/ZrE/1QMFi
	3GLLZkSuu+p2t8h3jw9jDGYTJeIfWDZyfpjYpvjmxCF8Hw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhnfe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:28:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4bf1e8c996eso115767021cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800482; x=1760405282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2Wck2j+6o7Lb4Qgkj6MN4x7UQxZYVDXXZmfJzy/gQY=;
        b=UssRSCwn85w7nNJMNACAjBNrfZKGjI9yWGH3HCLBVXYm+uKcisTkBLjXE8kUC/Z+ZA
         8FCxej6UurYznLvKN2A6Dxr/i9HziwTzF70kTgYVri6+z8FswCDsnuiJY0TFZuY+Qm6W
         +HLiNL/p/+/xD+WnP1CRYY2LD2QW5dDGkaKK5nCz660oLq8ApNQadCVOgdo3wQRpWcT6
         L0pfgZvQ0tnyZO2Csuvn2Zd+KpDJTn8mNiHW02HwKYyTHJhv9rFDNydvPwrxmWkZYJXD
         lnZvd3DAOO/Q8ml3KBFNCvZeWTj/5Qj3ua7wYHWyAMDcUrMh+wWPtyhrlFpk0go7Tca5
         DEBw==
X-Forwarded-Encrypted: i=1; AJvYcCVj0wl4CjrTJiA799Hz9+jArISblOyazlbPaHXQov6PN16ZtONy+zd2QKg2Z3qpviofp97yAVNazbXouAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IWrl5bwPD0ug/4r3Z6n1uDIDlKiOVAX6iaH3XnLF+CVzF1D1
	3bg1+nBg1u8PZyuB1Zlbje8Rubl8fc97xVjCqaOIM+3kSBFQm+Qs/002eUl0ZLSnRVnD6Okuo7J
	J5vJR3thWnpTKa48iIzrH7xxw24SqomcOK36ZOqO14BGSYNNAEpZkbXEyMIUJX/kEbm4=
X-Gm-Gg: ASbGncupcifg6gYu1DxOwurT8njVCwE5Tfk3ImmuijZAchiqa6Bqaa3L4v7yl9niTtA
	Bwidef2zQBYbULqGoUHkhlAXQo/8Ip8/vzhO5Rx6ht4fcSh/gf8XAVUqk68LJ+fdOUrgpZB7OZS
	808KkNvC6ILHwFm8bTMulwzV4YU+vxpx0dK6g6th3/CKtakjSJilrBLlz84F5m5IWFFmPwzWUSb
	iPoVcRU0AgrIGONgh9cVrJC0W/L/nZhWUGyOYvLJgUKXTR0GJwlpqf2dOIJ+DAf3Xe/+ikHxWL7
	kbadtchShhI0SNeLFOk1srMUkIl3CmhzSuKf2KjgZ+9HWoXC9oiuiExJhrBXXEM7YKrl+t0it5Z
	ZS81jF1cQGcMRFEKrXrrJimcMgiKJJGQA3JjJKWYQNFtWsNVg09YSMvYCFg==
X-Received: by 2002:a05:622a:5c17:b0:4e5:6d3e:d769 with SMTP id d75a77b69052e-4e576a4668emr191842881cf.7.1759800481769;
        Mon, 06 Oct 2025 18:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxfeNp2wWx3PYGTBtbjUe4nY/+LVjFKId/qxcvUtH9OJG+jhOdfQBv8YVwQTtsYrG6Pr+XnA==
X-Received: by 2002:a05:622a:5c17:b0:4e5:6d3e:d769 with SMTP id d75a77b69052e-4e576a4668emr191842691cf.7.1759800481346;
        Mon, 06 Oct 2025 18:28:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01135a82sm5548587e87.39.2025.10.06.18.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:28:00 -0700 (PDT)
Date: Tue, 7 Oct 2025 04:27:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingzhou Zhu <newwheatzjz@zohomail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
Message-ID: <uehcbtdwrvkkluy3lszffukozmumbxbltbmdzagwd3ecmlp6an@lzeffmk6fx3o>
References: <20251006121456.26509-1-newwheatzjz@zohomail.com>
 <20251006121456.26509-3-newwheatzjz@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006121456.26509-3-newwheatzjz@zohomail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX3heR6uE/1/bG
 T8mXRJIdOdCBWGAjghyqLTHBu7LXIq6/cBoIkXmhZrWC3vijvhN+hNorQWZCDVEc7taJrTI7tMN
 KMx8x/44hJDKENrRsfTZTjlDXO6I2qVGXVSCWfyWUDvwp1JG8FqtQyFtUvUeAfzNlnq1FtFlQuK
 mn13TjEbDkmi3TqWdLAxJBv0SFYnOggt6OGyHvOe29EXOIZtcco35s61o3voncOKfW9Z1Yi+w2L
 H9DvGXvxYHYGHf8fA6g6yd8DfaJqvrzjX/0rtMi79NHBj8BcOXqzK+mlLcnQg83hGm88hfcq0qJ
 d7R3tkNxa22wlfPpQ+CftSfp54CFnh4pmHeKnB+er5Q8tJ49I8xJEO5/GDiinnwqjQf1Rux6UVy
 nb9reXv4rmS+6DkKon3THdCowO7fLw==
X-Proofpoint-GUID: riUBQbLsOJ0cSS8Wnjyht_5BZxg9daDK
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e46ca3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=l4nIPSqNMi1mnKGloYcA:9 a=CjuIK1q_8ugA:10
 a=zgiPjhLxNE0A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: riUBQbLsOJ0cSS8Wnjyht_5BZxg9daDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036

On Mon, Oct 06, 2025 at 08:14:55PM +0800, Jingzhou Zhu wrote:
> Add device tree for Huawei MateBook E 2019, which is a 2-in-1 tablet based
> on Qualcomm's sdm850 platform.
> 
> Supported features:
>  - ADSP, CDSP and SLPI
>  - Volume Key
>  - Power Key
>  - Tablet Mode Switching
>  - Display
>  - Touchscreen
>  - Stylus
>  - WiFi [1]
>  - Bluetooth [2]
>  - GPU
>  - USB
>  - Keyboard
>  - Touchpad
>  - UFS
>  - SD Card
>  - Audio (right internal mic and headphone mic not working)
>  - Mobile Network
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

