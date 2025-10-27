Return-Path: <linux-kernel+bounces-871816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8CC0E702
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807434244DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433B3081D7;
	Mon, 27 Oct 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgWOyT3I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42C3043D4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575059; cv=none; b=JeH76WZZ6AEkVuCns7KmJr4kWrjqpGxdv2Z+cu6nHS7I9tM+sh+Y1vZE85/zVKBI6RQ6uUS7n8wDBJzk9oHFE9yAsXwhxzV4X8nHwNkb8+DYoEQSE5wGjgRVJ2kaaqWF4rmee8UHcBaytfunarMZFZv9p9aNkqPYyRVhm/SaHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575059; c=relaxed/simple;
	bh=E6e2JqYmubVVoTDNvWKRmNqekD7fmAvqw30dUrKfXwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTjt6OP1lOXAFAdPHLmyxTjQXlu5pgkn16SqXCoHRDwICj7x2Wni2E/Zvx7NrboI3TcCE+xFwZOOuqcP4TRTlbE+Lzdc1iD1Y1R1nOVjes/Nxz6DynPXyCdvCK7CxDem+5WlTzb2m8jrERFDB3X/vsZevr15+6CNEA7fMUt9/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgWOyT3I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RAAAqE1502840
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z22q11bJjODxBoHmYKUh4Hk9
	cf6IJGKHIianKI9ipUY=; b=IgWOyT3IN8iuBQVuTPSWo9K6Tf208zO9kvOf4adB
	UToFUTwzGTlrjU5UB526DTG2nFzeOSCjkiGNtZnNj4e6LJ4rZ5mSNC6QztUtFaEf
	Edmo4Z1QU11fLYwU+se2aRcon45fGDI511m3erRxjdLW/qpahw+tgJsxfVQ1Blvu
	BIMwYIi2wS8ahyoObhGc/6NRVnRZtQhALrXDOL7VNHae6mEEN1yFdWpumWSGV/2y
	cO4oy1zkIKB3h5+G8utP0k+USpd0WeOuEjjKveWGMkxwR2Vhr2GBuyklVOmw6VFm
	k0VuXFDwnNnfjinAuWzmERHiCsfm6ahMmVz0rkBoJFTd6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a20pnst1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:24:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eb9bcc1105so85046841cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575056; x=1762179856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z22q11bJjODxBoHmYKUh4Hk9cf6IJGKHIianKI9ipUY=;
        b=Ofc2FRzNV8aJS1grtPVbp2YwrRLC0E7YmzHP0SLbeKgW9u8Z5yNTk+bRWvIwKCO5j5
         lwqb9hSRcvR9XEUYSuajPHi2TvmPfF/FZG5uf8Rqdnsnz2L1x2jXyO0wraqWI+FqbtMj
         GGf6WUBxO0N7PIJsu0o3G+DbU+yE6gZ2/EJQ8TgrINeumtb8KgRodCrdP7y/txtZZHj4
         wgUZBSLjDaLtK/tG6sQQ4dl1wyqxFzoiKdmgtvM8y15BL6voCKxkoUptjT/SGcSMKfk7
         Ddn6YJne1a0Mo0LchAFYcw9CovCB2MVMcqUb2tydt2dvDlg2tcz3P2aLz2LvhQZjjCo7
         EXvA==
X-Forwarded-Encrypted: i=1; AJvYcCVReXW4F3B02bOdcbzqu9s+5bTUyCJpoZ5SqQJ8CvI8ZT/5/iziAn2FTjxqZYuG9Lz9/FWdalDrRjGlSQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NR7EmG1rB6uuGubUBrTYnZpXLdVrnKrxUhtzJbWdCzUQejET
	ezxd2uTSuita85UwHFSb1UFMV6NjvnwHIkSsh/wrtEsGgaQOp9bbTUtFJsXNEVcIjC/JjjBZJpV
	H5ENtJTRD69X1fPpyyxJ+oEuTUSK5G5wq0CLLWRv8luV54ywSy/f/NugXTq9QujdDRTw=
X-Gm-Gg: ASbGncutX5/enewu4b/wVu1STUhiSphmF5J84MrmhJrEY8DRQeLbffbHWa4AmrJNjXe
	fwJjxyBkMCvKoaDalPHdPfIAKPhsnNqrYKTwmXc7sP6yPvRbpYedm45qdi94fhR0U0UbhajRt0d
	ko6g5uBiOL9IF/QHvrvbdBRAykRgbitwMgrh3+IwHiOocVYDoONXzwRGPNSGaa/4M4zN+3JWhJm
	ALkYTC/sQiPgO5gGvUh3FyvUOO2QVdMaXTDHNfAlLnhq38s51taC1AnirEKfEH3Ygg5RXFtp+w1
	CJQBvaIBC7CnwfmSDajHsTkLdla19Bc/sup89Xz6Mm3hWR4vevHb0zFsvqmWbTSGV+rr6fndSoR
	alPcv0O9L76gfKGTqFi+A2ujRh8Lg8CpH0A04xrbfSkJXLbSDUNyxwJVB57tdxgdET3IlkmIitk
	lykrL0k/fUTMNZ
X-Received: by 2002:ac8:5ac2:0:b0:4b4:906b:d05d with SMTP id d75a77b69052e-4eb92c5efbfmr144865441cf.29.1761575055902;
        Mon, 27 Oct 2025 07:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHedx+dtjFeyY8ERWvJ3HADlgp6xnamk0D1DPH/Gu8IaWETgNF+9zta9rUpjvduSYCDstnPbQ==
X-Received: by 2002:ac8:5ac2:0:b0:4b4:906b:d05d with SMTP id d75a77b69052e-4eb92c5efbfmr144864781cf.29.1761575055300;
        Mon, 27 Oct 2025 07:24:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0e0246sm20252481fa.49.2025.10.27.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:24:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:24:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] drm/panel: Add Samsung S6E3FC2X01 DDIC with
 AMS641RW panel
Message-ID: <62nvrszyslvmjwhsw2hrtqjny47o6eoz7wrixbgga5gpwjcorl@bhme3j25ywvs>
References: <20251023-s6e3fc2x01-v5-0-8f8852e67417@ixit.cz>
 <20251023-s6e3fc2x01-v5-2-8f8852e67417@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-s6e3fc2x01-v5-2-8f8852e67417@ixit.cz>
X-Proofpoint-GUID: yiBBM-Vjao8Fy7iUZ3DEy2xgSY1jam0B
X-Proofpoint-ORIG-GUID: yiBBM-Vjao8Fy7iUZ3DEy2xgSY1jam0B
X-Authority-Analysis: v=2.4 cv=A+xh/qWG c=1 sm=1 tr=0 ts=68ff8090 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=WFa1dZBpAAAA:8 a=bBqXziUQAAAA:8
 a=EUspDBNiAAAA:8 a=5iTMaUzIoB_AQxUztnYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=MZguhEFr_PtxzKXayD1K:22 a=BjKv_IHbNJvPKzgot4uq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzNCBTYWx0ZWRfX3CEB9RVifPYF
 T7V35F3Bh+z8IXihzgYCQy4jx9ZTcW+rSSbM6zB1AyBiVYQS5JhE9HoAQMsnBdwQk5pvR8Crl+a
 yom4so8W4AYKlTltnTqOXBXUUmHQ6Wg3sgBw0qF2V81FoM55oBqv9DbGJg9yw6yaP+H/JIqpK75
 TxvyQC19d13uCRpImfxL8ByUxLyQJMk6cBPU4+c+ylfy414RFFlZsy2siS/evLfOW6dIu0qc9O+
 qi7LFfdJX+xihMMdAOHA3Nd8nheXiFtXUjHxEkDwJ2zzOB8AFTGFwCQwiLJC/8ih9Zlun9kjUOj
 /OBV8vINNqp0ftMF5tPuw7ZPguaqd5K3t/NswVkjKI3+93cP3B4z2CLBtVNUbfvkXasbLBk6NNo
 RBDb2m3xlXUwnUtwh08hGZDhXNkKfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270134

On Thu, Oct 23, 2025 at 10:24:26PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Add panel driver used in the OnePlus 6T.
> 
> No datasheet, based mostly on EDK2 init sequence and the downstream driver.
> 
> Note: This driver doesn't use previously mentioned "samsung,s6e3fc2x01"
> by OnePlus 6T device-tree.
> The reason is because DDIC itself without knowing the panel type used
> with it will not give the driver enough information about the panel used,
> as the panel cannot be autodetected.
> While would be more practical to support the original compatible,
> I would like to avoid it, to prevent confusing devs upstreaming DDICs.
> 
> Based on work of:
>   Casey Connolly <casey@connolly.tech>
>   Joel Selvaraj <foss@joelselvaraj.com>
>   Nia Espera <a5b6@riseup.net>
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  MAINTAINERS                                      |   1 +
>  drivers/gpu/drm/panel/Kconfig                    |  13 +
>  drivers/gpu/drm/panel/Makefile                   |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c | 385 +++++++++++++++++++++++
>  4 files changed, 400 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

