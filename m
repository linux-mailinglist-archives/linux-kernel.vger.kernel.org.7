Return-Path: <linux-kernel+bounces-876356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6BC1B4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99C31C2114C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAE288530;
	Wed, 29 Oct 2025 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWJ6W16a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhglOcBM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBC283683
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748103; cv=none; b=KfiUvmbFpVcYxJm/WRK1AUauz6O9F6ZGBkKc5bJTTTuSjrx3fvMVN3ADkychkaDUdZ6IEB5HttuPy+gHynOF8+XKcyd6k4c3BS050LKOq4e/b1q5Achl44IwKbA/Z+eLBl1Q0pD52O+rig1f8TZifq/aXfQAU27Rsv3Gf8J4l30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748103; c=relaxed/simple;
	bh=64Y1ODfA9sc3u5fAvb0/IWvzX3U5L+Tn76zCFX6s5mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W2CZU1vPBfhEA2PipyFGPKoQGA1JCPVzdqIIQ+HiRLKz8x4d1qIxRjUxn8ZJiAP3W7Xoaod/3AOrZ+e+owPsC8g2idChYMOz5J0RTpvidWfJ+LQlWW5W8v0QuxenL9+PdJaRPTN+y0QNRJEfjqUGrdnrpRK/BcZsMhDp/q/3iYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWJ6W16a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhglOcBM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T931dm4155141
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vggPJY16TqzMi/evuM1V0ydgNwJL8MMswUJoiRHlisk=; b=YWJ6W16a7/7YaezD
	QwvfYSbq6m5asUI6VsLRiwCZoKSYZSGCn4Lx4aH1VZau+heT9PmeGC4R8jQAQZ2I
	fi2Z+51yiYILwilFcNqNhpf1pfiafA1ihZYvSGcw+n+jMXv6C+VO+aRvIG3VtioE
	ZlUcbNb0YlnpB4VH8AX154Fwfojh4ENWdaTN5JAuwViOGDKebmTCOzE8HpldXaqn
	HN4bdxP7zdhHfWKiYyj/Vp54Pn6v2wadaw+0l0l5xKqatIz6cw5TNUxNcRhTaeSG
	3KDiXbbDLZ9seZfUU46pyS7y411iRnrWzcheXy7iUivX4tLamE9eQeVpzfxW63Ek
	N/D4mA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3fy0ryf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:28:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28eb14e3cafso140689885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761748100; x=1762352900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vggPJY16TqzMi/evuM1V0ydgNwJL8MMswUJoiRHlisk=;
        b=YhglOcBMmdSt1FH554GSyG+kF+VwqXVDd6nKudEjqHfSNQF+xw7BuQChkSVEjyKKCj
         wf0Eu70lqbbz5pT/jjBeANMoinNkuOepC1yn1UVCRe6gh2gsDGjW3rpnsiDMn2M6Aqrn
         eT0fY+55nr8rBJoXH7Cc8+YN+8ZUCwnAHkJ8Dh5T2w618y+Jm/07o9YRMZ2sREc3MZi9
         HrgE34t9mx+UTIxm6cvzd3awCqw6fhc2WWf+8K5pIZMgsO+v//WF4m1xx5rwszM8RNK/
         yOHG8ikLV4xW1yG6QVvKPvIt6/IIkrSl/xbPsBs1Q9g1TmSyotpGTPdoKvNmoi62a+YP
         YsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748100; x=1762352900;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vggPJY16TqzMi/evuM1V0ydgNwJL8MMswUJoiRHlisk=;
        b=bQTY7dg7QbGu3eiVOWjJfpAGCPGF0MQZUkdp8ToCn+k36PTxKy14nOoKXKqC1KyGGp
         TF568OUkX5ex+9LiUBWD14mJYvQCrhphvzvybelnyNxPyrG7m7wA/cS5MDn4GyCKIwmg
         O0YhgJVTjEECZdbwar8FedL3aZhriJBbOQ/42OYQUEeaxa/alxOrLVl+D4yAliNKZcvx
         fMSkuOY8gDMb6HUP1hS7dNzYWJM7viS31lwBL4QGHeM2b676M7rLFrFQJJ5UFaacKTIZ
         a3Rz6BnpOlTKrfuVqEV26jLGO8DbpSE+xHzyQlYCAeaEZTKEYcNxtGIqZxDsl/vzsRBY
         04Og==
X-Forwarded-Encrypted: i=1; AJvYcCXDphFa+XC0y65VqtOHqnmKYf3cFAiebShgl+4tQN1ieKHVbItH1683zspB3jftuoCltWo5BtiN0bmslCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1qM0ZaGjEuBIqTEJWHjsPkTv+m8eqVDYrLyD+8HKDaCaMswi
	2DHImNAUOWoysIHCqyhF6Udfektp3MX+V1Efecihf4Y1QU81cydHScD/puvLFAAm2EFHqdRYlNB
	C8qYfPWOMp2STx/9BDMRkkDLDrZvLyTI9hlB1mYuAEr6Vcgv6Izv8UE8now8DbGza8K0=
X-Gm-Gg: ASbGncsHgqx+LERXN48ADzvMY+VQRSt2dtwDVaIL7uo68lnjg+5pOZVk5b1cBhoPGfl
	789VG7QpkJaKxY9ee+hWF6fKT6XX69TqKN6nBm1ONNz9mw5b1y5+9kNFgtdfprF+5dzZFdDbP8b
	cWfZc6+JUc5Re/bMa2fe7ewMV5Dwo5VeOr91/5ynDTU4aeLJfICBK9xLUfnlwMiQwatta5+4tgY
	I2HbrwMtf0n++DfkTnsrPHZUjvq5rSsCRIXl3Vfm23K3iMQSyyITo9tRfHM7W2xF+j2isqzB84a
	enM8I/sexWTs7b3KSZtdmOMiuZ3ji+WCf2d4GSBhUNrDQ06zdCvcHIKCIDQYAmDR4qgMRA+3eQy
	rYU9F5CnxvscMgASza2MHk4jjZfudXk4PkU0=
X-Received: by 2002:a17:903:ac3:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-294def4840dmr33515355ad.61.1761748099398;
        Wed, 29 Oct 2025 07:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXSG/iIAfbNKQsaW5cMe90cddH0fAKzPWthKI8ur+hYnd6C2vR441AKTqe3jtSdiOkoukbHQ==
X-Received: by 2002:a17:903:ac3:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-294def4840dmr33514865ad.61.1761748098745;
        Wed, 29 Oct 2025 07:28:18 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm154236885ad.44.2025.10.29.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:28:18 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ross Brown <true.robot.ross@gmail.com>
In-Reply-To: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
References: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station
 power save configuration"
Message-Id: <176174809787.67078.9723142274217890219.b4-ty@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 07:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=VJLQXtPX c=1 sm=1 tr=0 ts=69022484 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=QZKgdDJMxHbNcH4R8hkA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: bvpXNeRyDC0ytpbdyzrv-jsri18LoxO6
X-Proofpoint-ORIG-GUID: bvpXNeRyDC0ytpbdyzrv-jsri18LoxO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDExMiBTYWx0ZWRfX7FmHeIEz9X6I
 jLDn1NpfnjjmGo73PmTeEdhREVFYjPL/bz6XeG7QCa4QIc9sR7irrWnCJpqmucEZQGpZebgndOO
 h+gXaCt79JZETJDaXl/YTlfw5iTPUZ9gvFT1KR7YrExxrMQuCBRODOWuDQTkWhuYraL4ZsPyUK8
 c7zSnQ5xEb4ugJI5tB6HHFsvAr3yc9uZXE+Z5ugSJIIJZilM8DBx5GwrhIGmUSDYr5lQdIJZx0g
 xHrzfGYNP5HixnL/JBDEXF5ZhrxptUYQw8jQuX0fCmquAa1gB/+1TPU9F235flrrQlY9Gu/IsDq
 3GDHZW5WszYhlLdFpKjKjLB3RW+fML7cvcrXyIQ0QSrRUNu/cXUNYi+u6JxY26X/wTSVz82KxRu
 5eBEtlnht6K1k/tSWFGN2LSS7lwYkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290112


On Tue, 28 Oct 2025 14:07:44 +0800, Miaoqing Pan wrote:
> This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.
> 
> In [1], Ross Brown reports poor performance of WCN7850 after enabling
> power save. Temporarily revert the fix; it will be re-enabled once
> the issue is resolved.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> [...]

Applied, thanks!

[1/1] Revert "wifi: ath12k: Fix missing station power save configuration"
      commit: a7716c9d922d6245b308e92824b95831bde44553

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


