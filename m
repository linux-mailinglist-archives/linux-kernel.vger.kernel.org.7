Return-Path: <linux-kernel+bounces-739896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E3B0CCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071336C2980
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951A24DD0E;
	Mon, 21 Jul 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbjF8ODy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED124292E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133825; cv=none; b=UcZccF4nRDSuWhHC8f4dg4YmGJqlLTY7SudJrxlrjNBAooyH9VgEPlaFrmUrjuA3IuM56QlN9qJBwlSO29VgjuhP+u4urPhTCRBHvsZCuEObBkfto8qvPRssuXFT4zYREFXH1mX/FFWX4j44i3ryEOOdq9vMBgtPHmEsh0YE8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133825; c=relaxed/simple;
	bh=D0FeaHpo+pm9ei37Ao4W85EkRXPKjX4gHZgocblZB+Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rxogPtaE/ddkYbcdDYVLgxugVrcIHJ+hM8fesAGLGbhhdvOdVkMar6l12lWnFI1C9hlEd2N4Nv74Y4niuieeZKtgX/MKPAzy7BTOhh0pod9CUDzfMQFc5kfIM6Kp2/wuvNQPiNt+Xuo9Ndx2eW+siiY9QQhglGUxvafgD7ojDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbjF8ODy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LG85GT029341
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7abZbcTESodIJ9OoUmT0BUOmr8LOHDjD7rgRNFOCTgo=; b=GbjF8ODyBCI0+lJX
	iTCO53woorPHKXZU6fMUrbk+bMcJWVNcLelAJJojfa9miwJJLHIA9lcIxEU44AJr
	9BgSEEjXv+rW55YT7tdIa22zxiAsTp/K+4nHRIGjnO5ck/pM7Xf3Wgjm/nqW8tI/
	fwX0w0fGniOazwWebxCmEMy18XoRtatJCJIi0J9KNN4csJ+q+b+Qmct4BQSw3xmF
	1gdZlBPSTm4QiftnnsKgv8jrxjOEUlmEZaxCKal5iL0njjHT6PO/9GI3CLfC9Wyp
	gMZH3K2KLo0f+m3vyTzHNOvubWw8iHNb44XsxIxqo8KcEoeVekw31ogGNZ6D1sQs
	hgTq9w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048tf5rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:02 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74ad608d60aso3869728b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133821; x=1753738621;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7abZbcTESodIJ9OoUmT0BUOmr8LOHDjD7rgRNFOCTgo=;
        b=IDgmfhLpLv5HmSX72RmnHjmkxXac+u/9OPITTuLEGsMXsKqYuWdWAajyd/09T7oQvx
         piTB4X45FqXn3ONwQ3q7m0Z7192igBuK+hpVFFAkns3PlANx07XpeHh8iD9ACNfg5E7+
         G65Ys1zyJbKUwNjEcg84hedmmHDCUSMJTaZF0hUe/xxW6wZ1RidAhn/dBh+qFgma1Rnv
         KgXp3HItUySfMne5q2feWVa432TMo0DfgAoGxz8jNnFHh9cG7l5cwwFKCK47ISVTeKEK
         h30PS7a/fWk+KUyhTON/T0M6OmqeDAv5W/h4C3Ei9nopOAb/ROaOzOoUJVWPYhK/BueE
         LVvw==
X-Forwarded-Encrypted: i=1; AJvYcCUfu651NBhfPUZVUZzsL7S/nKrgWysZkpzj7OYaH15z8va97NX4lAwSjhT/Xn7CCKa3zfcMaI2v4gBYg5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4orJUL8IvLZTgohNalqDrDNWA5bmUlqDNKGj3dRQxB2+w+m1
	4lUlvCk+eyGOQ3FnVWWMrWxs9CZnXPT9HWUakTwP5I/ULGAIlBNlgg9vt1vwhy2Azy9gjM+eR6j
	VBXmJDHnB579o80SgePhc5kLm5dOlN2DOr9O01riBeftap7GeVlAPZCoUmcs/hiywFgU=
X-Gm-Gg: ASbGncsbVaNmanL38nMvYZm7mpLyTV68k+kIwPbeRuTrG4LmZog3Dkq73ncdd/Mpihs
	YieV5IhOD/eggDmSLlqq+OCoWcMaw+B6hjW0q+wBOXjN63dKbVheW7uGubeKSmImw4OYiJwgyZS
	T8vnYMlbanL0RHNx5fuEiDIOLlK91fXXM5XW9Q7zTu6DChPF2z7qAuFDPomoT2wn+9WW272mNns
	9DqxFy2GR/GNqewy3nbJHn3Mn6rF+57kUfXN5UNxcC03jTU6xS2nlJckVJkCouWeh5lRzS7Nofm
	LZSyc0dLWRsuftXNbOIF33MeTDklEZelpCRfYp4evD7cbYVLpjMV0ybVoh2BoZ7VlRVs30CnTvb
	H
X-Received: by 2002:a05:6a21:1fc8:b0:215:df90:b298 with SMTP id adf61e73a8af0-2381245779bmr31469575637.26.1753133821485;
        Mon, 21 Jul 2025 14:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGYkw343g7WZUxu1HxpQSVeE9euVt2TTteLrojF1e3zmfB21RbbR6FxS3LgAOr3YIe29EkOQ==
X-Received: by 2002:a05:6a21:1fc8:b0:215:df90:b298 with SMTP id adf61e73a8af0-2381245779bmr31469554637.26.1753133821101;
        Mon, 21 Jul 2025 14:37:01 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mihai Moldovan <ionic@ionic.de>
In-Reply-To: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
References: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: bring DFS support back for
 WCN7850
Message-Id: <175313382031.971667.11294209028477002334.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:37:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfX0bx8W3BsfdGN
 UHmdsjo5eRoS6H+2+7/NPLyG6Qmsb2D9msBRvhBKIToFPUKLiLYN84LT4xVLRtd0p0bohQImE+V
 pBE1eEZun8E087h9b3rFqnxIHvnJPLPvxMRnG62kqZ6174BCpt/ercAfg1fTwkhkwZPOHIdmdOx
 CANM0CRpwQgr7CWNW3XZ7zjFUEuPhUcS+mutFjkk3J6MfTFa1IscXFInZVfclUKG+oLzEYs57qh
 81GynPbIm54CLKphLYGSWFlIyhm0Q1FyRkraqaEUreeN2/PoLU5D04G5LoecVlAyH5zfqYGrKUR
 uxrRjLRTr6PgdoyoKMoEqVDhQZjHiJdei0+BYxZekmqW7e796aZBQYXh17p6dCY2EnA1IQyqHxq
 VzZMlab3ywaYwybe9mFSMv6Y8LcfWAj8T/7XlcAc844n1sgubdRBMl5d4QeBUYOi5Xppf8VU
X-Authority-Analysis: v=2.4 cv=Jb68rVKV c=1 sm=1 tr=0 ts=687eb2fe cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Erv8aaIZ6ZqwiAegtCIA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zbaSWn9WMcQoefNlsNAZBiNrlC4BM1kH
X-Proofpoint-ORIG-GUID: zbaSWn9WMcQoefNlsNAZBiNrlC4BM1kH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=877 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210192


On Mon, 21 Jul 2025 10:27:26 +0800, Baochen Qiang wrote:
> Due to the restrict in MAC80211 that DFS (Dynamic Frequency Selection)
> can't be enabled on multiple channels, commit 176f3009ae59 ("wifi: ath12k:
> support 2 channels for single pdev device") removes DFS support in order
> to support 2 channels concurrently, making AP mode not working on DFS
> channels [1].
> 
> Revert portions of that commit to bring DFS back, and add a new
> combination to support 2-channels concurrency. This is valid because the
> MAC80211 restrict works on each individual combination, but does not care
> about them as a whole, as far as DFS is concerned.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: bring DFS support back for WCN7850
      commit: c4825d540f4beb179d552f3aa1f44f8db5095fb6

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


