Return-Path: <linux-kernel+bounces-725149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE9AFFB60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6728E4A741A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FA28B4FA;
	Thu, 10 Jul 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ONcp63FR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6828B4E0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134048; cv=none; b=FdJL2NbWuaS2M0YYs5ZEuMngygxseF//G4xxW77vAa16hVZSlwhQjSwKcRf0P68VMcyIxVi53VzT92gvbcCYIlaa5SxDVTQBlNlZoDwwSoA97QGc+lZBOx82T2cGhypwfN3909JXWa1DugY5s6b3vGcQCVZs+8neroGnoZKLVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134048; c=relaxed/simple;
	bh=LVmN9IMoThPPm55GG/XAdGDdx+9vMomvj/ki3t6YKq0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqSgiXeW3GZD4kqnlxmpx5u3bxFD4SXFR+AKqUzQpegcwakOYr8pRvyyGe6cF67DmAAU/fPnop//4Dt/LfGz2HW2yRpAi5HjZpyDBOhvH9Qljb3iKw49O5hK+B8HAqOxgZl4CMwCjZjaZvG72NP8PpE+WBecFdL6sknXFnBPyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ONcp63FR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A1Qgks014434
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IZ4wqeM3mPOhLP715cEB5oc3
	w1TFelaRzZl7u+0pw2E=; b=ONcp63FRcLZayaishEpguP+E580hCyTZWbAygcYS
	efLIfoU2fFIzEUPhTXskUVrj1MahY4puDOw7uFh/ys2oVWZtDYakUH3BJMtdWybG
	sdgY8l5aJPcch9UoYyML/Rkr8VRG3797uwWAB9PHqO0yiH43KI9iHJ5SwgIczXaU
	ahly86g+neDbAYYxwsXO7ZnvomBljrwjcQrj/RzGVYnkY4VPQ+/+cboZ3SvPh7ZC
	vHLIpYTui3COhoC6zZFV+QhFiZ2pNuMbQ0lWHU7PG3nkObdVxKb84Mr0nBzc89Cz
	ABsSkFzr+zcj7rxJ3J9go5YdrDCCnDfqe3FpU8LfThUEXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b14xps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:54:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3e90c3a81so62171885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752134045; x=1752738845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ4wqeM3mPOhLP715cEB5oc3w1TFelaRzZl7u+0pw2E=;
        b=qc+pNbE7+5qcPU2xS7DZK3nxgFZbIbmz354/3NQNQLeNYopsWLNZbFM8MWdTtrAzco
         kdKABQecI2ZPL9nBC8+TuPVBAPiMcp43p5cKRhEy7qSBnevaQm3vMJ3lHa2MHgtWTl4k
         NigWTQkAOndYg4BoXn7Th571ng/Bi8pHLao5j5v9llMv3HNm1NHpMN4Yf4fP96V2NYoQ
         ecyqoLZCVCnG0+qxkX/DRx1OS0yp3m1AKDOY+gC7iTAqB3V1IjCulBXkW8BSTywEditV
         haCz15msneQl4Akia7RrZeMND8LU9RtH6JsPrFkFVvR2YgTf16VxwMZiETGS6yItgNJC
         X+BA==
X-Forwarded-Encrypted: i=1; AJvYcCUBKeMygG0v3F0BTXMamQlBcoxkm9aG9Yo2Ekp6lAV9K2AeDpGKc7WLs0hqfjz/hDQv0L+YC/Ozx97dOM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1ROEc9sebsfQ0sMKOzxIUjQTOxwP8eMYH2pxQuxU5tIJT2rR
	NLtEREmKAhEct18j66WHjKaf7EmmfgHUJ2JCxvHi4UHNgVEm1fPXj1/BXXGRI3bTgGNHKldrAY6
	3NDS+5jJrDfFksmkWSVK7qpfeQN1quugpOcDmMLE2loWML75NGOQ1/zcGnD7HrlVTRBY=
X-Gm-Gg: ASbGncuPhzjitQYcDBpja3tk0/fDr8q0lxhXY/aIx2QBRuAtzfOz6cWDASFAsNtMtJb
	jFLn0MSnO+iBV2NoLi3/iIivICHMcOuErwIDpqKD3RcHvXSHSlxhmWTtefbwJVNnkPLs9wjctBW
	eM+dcc1LyTw2Gvh2abEN5DXOvoOFWGlT2FOinj3oIaHZpvlxjh8UbtdJLYVPNiZCX+mCvgHxBu0
	DwYJwaOcKrjWR1fxafx0tJNZaSbBRqZAS4LyXdYQuC63uRKTT8Ihb99NgxBZvPFzwXb0IiHlk9U
	CV3SfIuWo/3UnFMGU9VmQUx0zg13Vhty85H9MiPu7m9xH/qYjhbPNyA=
X-Received: by 2002:a05:620a:1a04:b0:7d4:57c8:af59 with SMTP id af79cd13be357-7dcccbb4d3bmr259298685a.50.1752134044859;
        Thu, 10 Jul 2025 00:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGug3lj6BT/YLHkKCvadb4meP/9pexcx5rHM0GbCxH95CB5isoXEHwrq8yUV95hMPU8pZzHqQ==
X-Received: by 2002:a05:620a:1a04:b0:7d4:57c8:af59 with SMTP id af79cd13be357-7dcccbb4d3bmr259295885a.50.1752134044386;
        Thu, 10 Jul 2025 00:54:04 -0700 (PDT)
Received: from trex (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5037fa0sm49646845e9.7.2025.07.10.00.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:54:03 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 10 Jul 2025 09:54:02 +0200
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: bryan.odonoghue@linaro.org, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, krzk+dt@kernel.org, konradybcio@kernel.org,
        mchehab@kernel.org, robh@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, amit.kucheria@oss.qualcomm.com,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] media: venus: Add QCM2290 support with AR50_LITE
 core
Message-ID: <aG9xmiDzSQ720SQW@trex>
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686f719e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=N7Dblu849QoN8slZYEwA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA2NiBTYWx0ZWRfX445R7eRB8Ov4
 afcbPKiVKo7TzGtmfmT/fOFb5LasMwsZDdwdkANLw7g/tcbfBSM3pISmlg1vmDX1RfLeeX66z6r
 0KzapdJ8jDnO3yOXGa0/wAb/TwI3aeX9oBqxzIO0+rHGGhkST2v4teM9QK12gRgB9BvWp7yBh3E
 nQux56pkl7X9HKEIzM42oCFBCPFT9J2kuMMc4iDPpIJRptrjitLdNEWnZy3129cxJJW6DyNO79x
 Xbhv7TiokeSxBknVQHVdc5nDR2bzYyfFL+dTpfT1VASFrpMLveC6t1FTfcmUUhUhx9RjeiA0XzE
 XbubN1xb9ncH5Qdbwg9IS6BUJtTQjbyeOeFcSy1NyT+nqKJpVl0nD3oaXFwLOswehYbuovQBPqS
 9oqnn4Wo5PwZaRAx8Fb0DmxVRQOveMf3HYSz6VFAIWgdNYjj9Zjn52CGcafl2o/w84YIaXCx
X-Proofpoint-GUID: TTSRUDQKyBtm27Zat_E6w6dxuxTJjRBz
X-Proofpoint-ORIG-GUID: TTSRUDQKyBtm27Zat_E6w6dxuxTJjRBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=740 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100066

On 08/07/25 20:05:23, Jorge Ramirez-Ortiz wrote:
> Changes since v5:
>   Two additional new patches added to the set to support video encoding.
> 
> - patch 1/7: Add qcm2290 dt schema
>   - added reviewed by: Bryan O'Donoghue
>   - added reviewed by: Krzysztof Kozlowski
> - patch 2/7: Conditionally register video nodes
>   - new functionality required to support AR50_LITE

This patch needs fixing: when one of the nodes is not present and a
system error occur, we hit a null pointer dereferrence in
venus_sys_error_handler.

will respin a v7 in the next few days

