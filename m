Return-Path: <linux-kernel+bounces-730385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B69B043F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6459E188E975
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CA262FE3;
	Mon, 14 Jul 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNhQqIjo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8311FF1BF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506730; cv=none; b=olK3zCqpApDSTdGJYggNIds3GOQOmjsPguZRjNXxGhFE2moAJAWntnYl8dw9aAfeiI4fOzjTZEs//Grg8m1NJp7DrMajxG+58lrDAiqtahNJq8jS6htOdYDAg8tAP4tV9Md7SCwyFlskVoJrEsYGx7AXYKDoJorNPgJdsMF7KbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506730; c=relaxed/simple;
	bh=LX0PbzwtV+UgCJR/jUcWjRadb/XE4XitWxSuw/c1Bzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eae55B/c3FjGbdXF1wnvZc/phIbuguIrupPSye7GJ+aIJ+Wv5zWjZtO/hz2fCeHTmbM915+XVm2I7gWjvhYt6lKgyTmLcJm6KNWaEOxis0CcK69NwU3ZAZ/TkSZaocDlY2PeESxdomwnLf9Arq8D6Xh8D59z8EkbIKnar+GDnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kNhQqIjo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9siHX010728
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6LV0K5UJorWZ+7uM8Thq68wdIY0Xdv/k6eWXam/eClc=; b=kNhQqIjoc5cCmRQ7
	wdc6TlBQ7yruYBIu3W+dQihuwiFn+tK6s4LmFT0vP4gI2Q1PQWK9xiVEVvN1HFnf
	JBou7nxc43Fg3nl8pLI1ta7dTzm5nRspNy0P3KOlsD1nu9CpxIT+ZbWgKyCyYrMs
	fPRJlB5TOlY7F7uwC+4hoo4zT7ToA9BETKyikjMRlHoXc8DltnFt2lQmQ/m/zJbe
	DaZcNUVamVB+VoSCsr3Q4LdyQX3tXnbEyNIfej5VPAnSfd6ektwxfHwOxL+NOUKn
	92seAj5xxzqlrbIVpkhLpwbKfiJYbUTWnZCAwbuu5ZPZyBRq09Ktx4T8Pa8P6aTo
	kfZmEw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a3mu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:25:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d44a260e45so807723285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506727; x=1753111527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LV0K5UJorWZ+7uM8Thq68wdIY0Xdv/k6eWXam/eClc=;
        b=efgr/sMmEpCnroWIptQr1jTdONN/QsyB8HYAput31RaAtFBtC1pvqQe+pUgPObuAOD
         u+H3dOr3Cxef1BC/0R6hi6vCqxMGqIcKePbKbseLSfH/DqtpApxEnjWAEJfg/4GEjKKi
         2/rHv9XyFulc5BKCvCMLsKo/9+kyZommg1X2oPwKHaeq/VUcH8fRvtxuqbT8bSx2UrL+
         IHWrbb5SL92jkGtnZ7l6PSLgz7F2/L6oWBkCDf/X+oW8awr9zmk3ETFXRJi1OaP1mDbr
         QJh0yhedGwerG445KyCGqQtX2JSaPfVxNd56nPQIDpI8xb/7TtkeZ3vteCULLCsqOmnC
         MHTg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Z0my4b8AGcYLZvvFY0gDZZGFHmopfhhNYTfNmsLzyGEN+QQSx2suip9dtPOGaP/9XPYwv/8bwtNX1tA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2EXa8+mVg0LFqBnSh3y/VG4zv+50weNyjJ3X2u7iJEIs9qGA
	iB+t/r4QsQJ7j3VEoX5CaJYN2sl2xVN591JI1qz6kgbSJPMkfQPG4MV9xdsM1YMS8BkJji6J4Cf
	XIIKYqF7NkoEezY4Y0bajTs8QdUIW0BbJMWyIANEh7vEwcRbxoGzS8s0frNirrb1hMG8=
X-Gm-Gg: ASbGncvFP34c6LpTS90c2iAeHc7iHcI05jhuygs1yRmz0ELKce7b1HP4XwOZz8hEms8
	c+4cd8HCPh3QkyF8SKGHmIOwM+yTR2dCos7i1vjLDoeVzHEARC+g/XvSu1eptxNMML/pebcaZSo
	az2USzMwYDO/S8wwqFEEhJCbJ1VZyNRErgccPOEqFLKNdyQ6TUMaPIZF0Ui5tvFzxiey9VbaneG
	jdvwYW5UXeDRO98vG2I9Nbww5Rtn7cok9wFCk6SmRAAkoS1UCRrdtUPWgzDQro5E9UhFlXx/eQh
	sJ5TdJRSbLJuVNcg9SPMu7TxMiNks7N7mGuFhgwc7c0uR4tveznv6X4TFR5stNvrUWLc7NVWBDI
	tltHO2HjpPFPB6UrN8jqXiEtZevjP6nnmDtwqXFnoEtjZWgome/Ur
X-Received: by 2002:a05:620a:ac18:b0:7dc:b8aa:d093 with SMTP id af79cd13be357-7dcb8aad0d6mr2168475885a.20.1752506726640;
        Mon, 14 Jul 2025 08:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwZ25/ylUQ3528GkME7MJF3ljBMaRtFCayAvIoA9pqD+T/SbwujgEb5PAw4osLJdBxZhSxNw==
X-Received: by 2002:a05:620a:ac18:b0:7dc:b8aa:d093 with SMTP id af79cd13be357-7dcb8aad0d6mr2168470885a.20.1752506726150;
        Mon, 14 Jul 2025 08:25:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b87bcasm1975359e87.250.2025.07.14.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:25:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andy Yan <andyshrk@163.com>
Cc: mripard@kernel.org, neil.armstrong@linaro.org,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        jani.nikula@intel.com, lyude@redhat.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, simona@ffwll.ch, victor.liu@nxp.com,
        rfoss@kernel.org, chunkuang.hu@kernel.org,
        cristian.ciocaltea@collabora.com, Laurent.pinchart@ideasonboard.com,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Pass down connector to drm bridge detect hook
Date: Mon, 14 Jul 2025 18:25:24 +0300
Message-Id: <175250667117.3567548.8371527247937906463.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703125027.311109-1-andyshrk@163.com>
References: <20250703125027.311109-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vy0Zx4Vdbb0zvTEwuM1T_YmEKNf40DrT
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=68752168 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=0YRiGFPyvPvEouyWwLEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: vy0Zx4Vdbb0zvTEwuM1T_YmEKNf40DrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5MiBTYWx0ZWRfXz8Dl6ei5fzMC
 Ds4uePjyQf0hv+0w3Wu/eZC3gHmyxvhuo98MYPJ2OJsNAVGbUj47717uymoUbPy8ymgv1pCHrHn
 92KLKS+LZ6ozvKwZR5NlbWKpObQqstqUq3ral4P1aExUb9LPyWcUmYcVLOmZh6E5Jzj7k4nUf/p
 GUhNjec2p3y95lSBtaRQLeTbeL6PMrQZ+Hm2aq1uFkaDdYq87IpXSVYsVsZrVJERc0jaA6Z9E2x
 aK9gyvGlhOMoi92NOhs4of8/so4fNU6B2Glj1xfIrKiaDec+QANNsvDVPL3EpQ7Qrx1cUUHE776
 VH3cCGJeb1kRwfzTlDz69bm5EGklQBierx/QQe0eIsOIXWZFAxuwTI+Xf85/fVpFT+QLtmL0Yiy
 bvx1q8wxaTipNyE0j4t/d2/IomUNKLaMGPszh1e6fb/1kM2LZpFZh0emVgKRlA4HMfbsj2j1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140092

On Thu, 03 Jul 2025 20:49:51 +0800, Andy Yan wrote:
> In some application scenarios, we hope to get the corresponding
> connector when the bridge's detect hook is invoked.
> 
> For example, we may want to call drm_dp_read_sink_count_cap(which needs
> a drm_connector) at the dp deteck hook, intel_dp and nouveau_dp do this
> at it's connector's detetc_ctx/detect hook.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/bridge: Make dp/hdmi_audio_* callback keep the same paramter order with get_modes
      commit: 02bb63d1a59341032b8e7e4021e18d044bdb1786
[2/2] drm/bridge: Pass down connector to drm bridge detect hook
      commit: 5d156a9c3d5ea3dbec192121259dee2c2f938fa1

I fixed the building of cdn-dp driver while applying.

Best regards,
-- 
With best wishes
Dmitry


