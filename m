Return-Path: <linux-kernel+bounces-754139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12CB18E8D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D516A1F8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2823506A;
	Sat,  2 Aug 2025 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YYUdagnT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD73235047
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754139032; cv=none; b=Uz7tTLw+vii6p0KtGXQw9+2XX7t2U4WQfED/sLMj+N0gOrEn9oW9pd7LPSUHeWUecwvqqXrcuXQgjo4mdH9vKXIyoOaGbyoYNyvZuzZeruaI5TTiR6LvIu98yDZ2oaYJe+4R/j3qN3wK1PUB4UNgznbY/YhXLC50zRr8LP81i1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754139032; c=relaxed/simple;
	bh=27DW76JEz5gbRUe8ewnERSHHW+rWv0dJXc0E0M4vWJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggj97Y7J8fw3N5nawfj7SgrCEN6K4kPEM7NvV/xQYYSb15UKbNV6zrf93BPl60PDr18oNhfEsoPB9ZYdDGA16CRTAn+ldindeWHw6RNTenz64LR/ihr/LcPIpSC6vlE2dBN8nxdbOyw5eNc4ECV3KP+0Sv+VC1tLksneaWDhMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YYUdagnT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 572B0D7m020397
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 12:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Vs1D1U7thDc7U5UX3yQ1lCQG
	vG3bv8jTH/mIRvodFyc=; b=YYUdagnTtSda1VNyzVg2uZ9vxG1/YwTt2HGJ9WWF
	SAAjGtW1Ldy+BIr39pw4prPq7G+hQ1mTz7xEmIsLp+5Hg7zioQkGu2KatGz+Xmr5
	55icuIetmguJmmRNYWuLI0LJH6B0XWAEm5+079y5FwEnko8qcyHtL35LSsRApPBT
	ZI3YsG5yDUCfpiV9Ehei1bq8iU5oaU828J+Jss+4wn8V0Lpta2ZTGDHrA2uXxng5
	F6haPGZNrkO7BHaHs9FIlJgUm83EC9v/Wnr39N64e5hi83tWyNLF3vOUAI3W/bJk
	bgTfGVHPtlG5FWwkuAbxdEwTTGMxitm0ruFclhiWrvlqtA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4898cjh0jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:50:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab55eb74bbso37471641cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 05:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754139027; x=1754743827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs1D1U7thDc7U5UX3yQ1lCQGvG3bv8jTH/mIRvodFyc=;
        b=uX4eqALcLcyG4uO2uuUI6mRgT7AYusGkV/Q1BncO0lZKmoUTbnfKGASmaMKqDV32NZ
         nChWgLbmLOtVbl1iX/AOnJjjOx8uMVT17wp98dZQ00PPcHZ4kmAkSY9Eyk2IVVKU3JyP
         oS+vZgZIe2IWHny9ZwBWvztKM9MsKkXoz1qdrfamkfMAeaduwflvIu5s6Fcw1FGGETpF
         1bRF+AqePV2kxOfLfwTdE21CCbjzvSNDeGQ+wj39Lz3U9bsP8tmXvW7+taKzHirWC2wb
         ltREQp5rCLAg8uwBybf8hN8zXfzOfoPHlKtlAEde+9BPnvyJZWpg8/a1BpUwBsfLxbTj
         aMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJGN176bO5/c37G2Iii0IQ3eIHWqRwUDxu3m3iesRc5PBjSVGRFs8Png5vj6DeqjcoKXW/8A6YW5KlxBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztlLi1CYvMEEcinRjWlIIGYD+NJT9V/oOnr9oMNmYESBp6xZG
	WpHBn9IZUqEIdApk9aKFzK/UN2zPcGjzpru5Fl7XBzentFAtQiPhkIuKAeqapyi7OHDtZUFvcMv
	Q0Ab7804ILk/vwiCYR/aBbS/otEcV2T8y1evfhUDGtuHkfYhbHEdWknNLprdfcd4sCFGy4rp6OB
	A=
X-Gm-Gg: ASbGncsthhPVkXNqcgpmT0Dj4E/UYEU5XD820Tx9rQoWtcPjuELVj42uS0nxRQXA+7G
	1IcZtI7dpffWlUmIwx1SdCSVaOK5gzrpZojyJs8VRIt0zMP3/TVpIrlYXU6nN0cP4ARa9ajExuB
	NfW8YEGFObK3SYMqWLXf0eOA6Kr1gHnlL1be7f400AQVOuwv+jaFb/dilcu0x9NLr2G5nfgLkAq
	UQs9aLbzE9d9nqlcgGXxTL5YVi+MMRB2tam5Zw1P2ZiLH27OI2JID3x53Ia+ZosccpobldFkFr7
	IByYAHgS+MS4V0rtLg2+z1hMd1zDzL19N+gfH5uXX0EY7CG1xPRb1AGb0rOazTyJusU6fdp9KfZ
	baASIDasBIBvRqi2awT9M+qs7lpDnUjSGIJg1nk80+3+MSSCubQzp
X-Received: by 2002:a05:622a:1a19:b0:4ae:cc2b:77cd with SMTP id d75a77b69052e-4af10ce9bdcmr38028891cf.59.1754139027230;
        Sat, 02 Aug 2025 05:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdQnn8wZtb8CWV4VbyrqAlylwn3DtqWMLsdIcs1457Yr2H1nMf0zL00sZjrwZSSf85tjhLEQ==
X-Received: by 2002:a05:622a:1a19:b0:4ae:cc2b:77cd with SMTP id d75a77b69052e-4af10ce9bdcmr38028541cf.59.1754139026796;
        Sat, 02 Aug 2025 05:50:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388d8151sm9019371fa.41.2025.08.02.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 05:50:25 -0700 (PDT)
Date: Sat, 2 Aug 2025 15:50:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: himax-hx8279: Remove unneeded semicolon
Message-ID: <y3s6uyv23kn45shp72mazhtdfc3uygawaxgsrpu5e4u4zgt5z5@vdr5w35inye3>
References: <20250729054214.2264377-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729054214.2264377-1-nichen@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=MNBgmNZl c=1 sm=1 tr=0 ts=688e0995 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=WdE5XIPRt-e4Io1gumIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: I2cnvZUbVG51W3Q6j7uCgOzMOX_lWfx6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDEwNSBTYWx0ZWRfXwDbFKVb2bnhE
 iIEOdMrw8OeNVqT5o3bWe+s4kF5GNU7smcc17IGKsas9lOABOxvHgPbBJDukU/ELLRTgjxXjqMk
 Plhj8zN9bGSZDBqqI3iXGAVxC4XyXu7xlW/ib3cas6pzu7ZgXnh9uLw/qfdKoymDiW1Yzn+pCY4
 ZGa384JwE4aC//0I9m5H68Knos19T8fDVP10Qvoaa90FOJ8XczoJBw0+WhznOfOEnm9rAxh0uWJ
 EehKa8ZbjoqyjZbsFqyxkfKALqn4BqnuGLE06kh77jg18SOqLlZeiX2qkzf22/3GBwwuJzYTLcO
 pZ3P042N174hmv+jQhCshSCabuNtOF+DMdoSJXNPospmOUhMGLGNrIPKzTpVKzXlCV7zJfjbu4O
 CZ4AQ2ilIt0doLA7BjLyaJ/z2nhAApvyPcm1NpLmwco7Rp017prPIbPIIOcvz1xPid8u5BsV
X-Proofpoint-GUID: I2cnvZUbVG51W3Q6j7uCgOzMOX_lWfx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=796 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020105

On Tue, Jul 29, 2025 at 01:42:14PM +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx8279.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

