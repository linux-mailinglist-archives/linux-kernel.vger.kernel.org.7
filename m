Return-Path: <linux-kernel+bounces-803383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33360B45E70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CE6169B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69982306B35;
	Fri,  5 Sep 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AI+2bHfF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226E306B31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090552; cv=none; b=jnTZFwot/+Uje1JnYc/mDNfHrDXCTIju64h0zqM/HCUvdigydeFb9aKYS4S6Z8dZl51eeFOL2294q/M5bhq5XumksMiYv4xoyg93Cr+KZmwN/80MJVjWOWlMRZTm6wnz7b87yU2n9nOTjq6GEworPP/bIWVwulPZgHC7vBJY7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090552; c=relaxed/simple;
	bh=DUFnGFR+b0RlkETnIw6FBxZGRdV4PzHTSFPqvHJy19M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFwhaK+TQnZREAvcT7lC3sumC+JZsz36+LqLKnXEcoaYJhrbRn7aXIDYMtjwzdhaonsvTMV4KybB3zibzK+j9JD+VQVP+vGloAkRJ89YG0z2DL46xpexHb0J8vFAEceWoxjr8HWhkYwoNHWMKC+CPNEbNxWfLDdTRcZI+EjwtA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AI+2bHfF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585FBjgl013631
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jROajlmlcBln6vhnpv4vvF5t
	CEtoLH+4Zh8dpioFagU=; b=AI+2bHfFH59iPt5l4s5H4K0lpIczuLf5F2mAfs+a
	K8iWJc2K9PcOkimdSuYSYPoVRDMAb5P2cgHHXsJVEI+g/BMGRmgIA0WftaCuj/cc
	ljimHivoESGk3rRQvLz+mZc+yoUNY2/pbgg97JudjNvRFRBRrJ1hkoiO+rFU4+d9
	8ZNtqCSQbiTn0Fk7Y1jox7SyE6Ln8CpqfV3msYkdyjI8u0bpqvsPA1QYVWb+DeBI
	LjKwPDmIf/qLiB6JuoC2YDmg0vZswqS8vAZKF0qdj3EKfQeLqZ9pWtjC3IVzwHyp
	8C/YUBTfVtjg++P5aCY8ZLTBOen2wcvYWD46GBoARsJC9g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyft43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:42:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so42979461cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090549; x=1757695349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jROajlmlcBln6vhnpv4vvF5tCEtoLH+4Zh8dpioFagU=;
        b=QJ3iNDJcF+4YIEv4YU1LJDlHsPJDUOhLF6WivoZN1tdIVNZcvpVkM/is7KSOsZ/nuR
         ojCa3aCu+1pSPDgy0SklR8L9cbIQy+59foOKBSfrE6JmJjTsPqDc+/3APQreeOATcpkV
         BNzkXFWVrP5Ae+oYhv7N1zz1K0MzcERnKfa/S5q5/e3B4Zl3uSYv5E99kyu03eWwsxzT
         4G0mmhX+T7QLWrjAXJECMegpgaM+eqpIZ6FQvysGR2VfV45sRdOZLrlkoX/702q8ZRtf
         xWZteNzRmN+1cDnC13ZCiGlbDUlbO1Fo11VFOAGLWT40AkEb5FqnkrlFHN3IOUMbKPpD
         t0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUCdVM1rkEP27IgLiWvUt9afVZIMr4Fkr9gD5v3gqyat4zop0y/F6lPKe+sfd54VArMrumrbGokP+FYSSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG4grd1+HoZktnOkYIZyiPYJQaQIHgWdomrYQef9VBP8Io0/MG
	ndiX99CQrKCrBhPrPS+oX3npsnx9qG19bHfSiMHIF/Uwr2TMrB+nTMIJmq/tOzQsr68DnFByGe6
	iR730xzmu6l/5CA6SHzjvzWIgyW6sVXUrMVlZW3ys7zdLbrFgKJvgtyi6ds59XU7K2iM=
X-Gm-Gg: ASbGncslK2Ew/7hn2GS0MUrqBVX9QpvjGFtPg2/oDlZXGlixxhpQ77cNhduBR7ulqmg
	neUzDmi1Ex7HCJ3ADvExD0Eu+79qr9DTlWfY3LdA/cWHiOgUGzEw5iyT56oV6eDD2YIDz9l4CG0
	ux41gqeTj7HObtM612vyE7mRy5LUBEniommxKrHnlYFrFeocFRSnhI5MIWZN0oGdNfNWDyJwrwo
	KrZ26BCKz96wiC2cWbzYHT0LIn3T9IgYefi73yNJonO2QAOg+0+57KgBZhl/j4ZR3+uSpjWwRPs
	iliuAfK5xsFHwFwZuj5Ja/SvgYjMaOYXoC3SaNoz66p6g2GTbkEoqvclYFrrUb5yNkWjzwCSPN2
	7ZpK9mVCang+7p0+FDjhKZ8zU92nspOPD8TjRjB2aOdIe0UCG4LQh
X-Received: by 2002:a05:622a:5a88:b0:4b5:e8ae:2c4f with SMTP id d75a77b69052e-4b5e8ae4c42mr57976041cf.51.1757090549047;
        Fri, 05 Sep 2025 09:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPiRLE19NZ0JHt5HAhIWc5mt20Vu2UIiF998qL/Cy3guuAy/WYnY5wUX4hI6ZNygHmSZ0kCg==
X-Received: by 2002:a05:622a:5a88:b0:4b5:e8ae:2c4f with SMTP id d75a77b69052e-4b5e8ae4c42mr57975671cf.51.1757090548543;
        Fri, 05 Sep 2025 09:42:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfcd18sm1858430e87.108.2025.09.05.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:42:27 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:42:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 03/12] soundwire: bus: add sdw_slave_get_current_bank
 helper
Message-ID: <2yvgofbauwqzdysb3r5jfijedpg2qdfb4znfkj5veuyanff22d@tro4rzcfytk6>
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-4-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905154430.12268-4-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68bb12f5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pQdESfS3DBkDoFfcH0sA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7jtwsf7KfyzKC_WY71Ecp9-xKW6GXnir
X-Proofpoint-ORIG-GUID: 7jtwsf7KfyzKC_WY71Ecp9-xKW6GXnir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXyhWqAmgVcgzE
 MJ4frX/kka6NDgNtIztZ85rEwMscYtZH+VKZkp+4mBzpOEwD747MUziVGsS6vx+Brd/IwV+gBM2
 UwTcUS3HPF+MECkLAicC/4cejjNlS7AZv59ZIT8Jxxv86f4RddWO8KShAZlA+Omq4Ziywnpp/fm
 WP1OuloTKkFh+F7b59y3xfHOHWLIt9SJJiVLqg8ih729gKlCxfPhhMb5FaYbGcs8+7xoLc7eSs7
 p4f1gTygkszfy7mBu8g9JHY2XmDculqjvPscs3aBhj7cpuBPXpZrqkCFUEmBtLkArwnBUcqwe0r
 VV7zv7VlpSjyN6ypHztE1VUJjqtGCDQ1BVQWkPMyD9rqpx8z+ZdKWnH4JNnG6MXvnFJJvgwVGQl
 e1U0cQXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Fri, Sep 05, 2025 at 04:44:21PM +0100, Srinivas Kandagatla wrote:
> There has been 2 instances of this helper in codec drivers,
> it does not make sense to keep duplicating this part of code.
> 
> Lets add a helper sdw_get_current_bank() for codec drivers to use it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soundwire/bus.c       | 12 ++++++++++++
>  include/linux/soundwire/sdw.h |  8 ++++++++
>  2 files changed, 20 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

