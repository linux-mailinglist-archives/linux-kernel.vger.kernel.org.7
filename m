Return-Path: <linux-kernel+bounces-879186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 893C2C227BA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E93B834D3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069C33556B;
	Thu, 30 Oct 2025 21:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0gi37Wu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VKnG6liX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3A338592
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861467; cv=none; b=XMgVETviDOqOBil3vATNvyyxhNuKJ0GUkeXK6p8FGHRHA3do6vSBwgVNmbsqzWFsCnKSlXtxL7KC8nPuFMAHnqqzM+sZuhNbhsl6yt4HBVufuCQzMj7C8VTKgA6G2RXHLYsomswWgeVTvOF5Mqe+mMUHKFOHU20kxNs/1NUphUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861467; c=relaxed/simple;
	bh=SmO8WphVJ7qdIcobB+LxFCdmC6Tw/3vwYrEm2jVbpYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FLRch9HsfgK0UxMxA49LgqPxJVq9Ml2Ze8l8f/U8+YjyBZEm0mFNlrMAZYXtb10ZomQzXVzhTsQ7QHExhHzUzYnutTBro6dQDiY3PNXRsh2VjX6GpeDDgZut+Nx9elKKzlTkUbTmqOT9WzX+xN2sIHi+NoouYiT9ZqgSKEPEG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0gi37Wu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VKnG6liX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULrMFD898088
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0YbvCREchJI8qwKRV6FazI6CbTuSXVx8wiILVgQiUY=; b=L0gi37WuTWX/M0DS
	WKeZTDhKeqPTxyhbCh1kKdLj3LUtTKvV85X3Aeclk7kdBFDfxD4wP6wTWACykjxQ
	Lzmuh1d68uhI0eCTGiqkLMz/7hg4WxFW/xObxjHn1dinfhjQe/sVGR/OUCtqgWFH
	xHmri/ehfr3SbJODpCE7k13yPfMB27c8HUchJO/s+hKjkrDy36Dxz3XySJPGL3Wp
	YFPR0av6Cd1SJF1cwIB6oYztZQ015lJHJFA5nmznPdr60XYFpvwn2+LNltrHHh1T
	FO8/TLqFRSW0c1kkedY5cPR6U7cU/M1HLDUYRDpHeV4Aig6b9bH5ZQNdNiefdCR4
	siXPYg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb20078-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:57:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-277f0ea6ee6so14082045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861465; x=1762466265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0YbvCREchJI8qwKRV6FazI6CbTuSXVx8wiILVgQiUY=;
        b=VKnG6liXR/DHrt24Aqa8S9NdSROWZtgcvIBZEbP13l3IoElYxh481qrSn+vMJeisTu
         +rF0gvIeElXv7C88EdERkPfoXlgYi6Dd8NI4FJabxD99vyZ9ELEU1iT6XyuRQIaERaGp
         wEKN/aTL9dJjJYqIPR5lz7QwO8/4KOEWl/gD/qQLKzAiPF6vKiSfh1o8lrdPkJbI40HK
         56Ri7ehanH1/fPi0c9JKt5HZH72f71J7guWHSjDSLP4QQsHv3NMEFiKabT3KPUPBpQby
         UTDqJhU3ZQUV0pBo0MHBFmbp43sOIYD/QHU5bse6D0SSbyiJSM+i3b/oXOF1PgzJzmac
         glOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861465; x=1762466265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0YbvCREchJI8qwKRV6FazI6CbTuSXVx8wiILVgQiUY=;
        b=mYG6u5LF9Ge/WchZRtaHzTv/J3MaqdMwX4pktYHX7EgB/ObLcy6lWdOjHxFp17prTs
         YQDbz6p8k5plPfzna0MGj5FkzWZ7mNMeTEeRosvUPZ6P7okzDXbMDPMe4TLfsGHoberX
         y8eCmSY/B+JI2e2aTLPejaggky7vlzaczgNfya7SasoDWSoIG3O0MSvY1J7NEQrjLTlm
         o3iKPVAIlYFOF0JY19HkSNF4VI2LkOrMEmKXbSPso/btP+JnvDWvNeCUzyoQrQp6nkb0
         4EAmtpz+ZJPgFdPe900B5Nli/biZkhsyoGwc4iHGn/GO9cf1regWURXNGax6pYwdTWxP
         0YmA==
X-Forwarded-Encrypted: i=1; AJvYcCWTv+r5vlIz8LMvo1DB9V7UN3PBEJioCL35/4lTlvi9BEXu5HJDJeoB5i7GZjMVYQiNUHxI8dwWsL5AeOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6fa+G+6hBv+2T1MYFSiVgK4SSSChEoMW4+92WPZzGlOXjZ62
	7N3KIBrm3CRWHKL/4p7/RZd0Y4hW9k7cJkcZt5GqnI83R23YhJ9ENVpC5NXgkeSv2750XjrPYmi
	rYI9gpyqydVooAT+CRic5Q/LoQOpiU0MC6sGqBpIXIRb4ZeOzpdrbtQaCTKChMVqw1i8=
X-Gm-Gg: ASbGncsN6G5SsVw+WXDP+j5r/Ov6QExGtLjyq9z15qawi/qw4l3lJUxvOm2cBpU9hjj
	GflupOy9x1unAfu71pVGiWnnCNqNaB2Kp7KCWVGRbeFomHLzhTlIMCsbUt3oISqJIChMEF5xAXA
	FRO0pxR9Wcm3/OmoZvaaTm6ALpyeTU7Jy4qwZI+vg1mihkY4TIJ13487bJNCMVyDLxh3BTk6aB0
	GPiKFB+ve/HtOUHYOl5hw4dbrcqO1GzC4npkBuqTDGmtCvDkbZHYPCaFFyK4nxsJUk6GhhbH+9P
	zy0K5Xo1AD2Zi/RndT2bQXARyMeI4L6gq8kGJFIe2s7GwaUNH8xsZ3flzq3YkM4AsGRgJpuJE07
	qrg38m46184W72f+JLBfphpZrpI6Udxksp9o=
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id d9443c01a7336-2951a4976f9mr17416245ad.23.1761861464670;
        Thu, 30 Oct 2025 14:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3QS9ZHlD/2JfJsKFJfl78n9pTNSfLsEEv+V2BKfr8XOEJAWn3kAqkmxy7fqEgwCK0M3sJPA==
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id d9443c01a7336-2951a4976f9mr17415995ad.23.1761861464081;
        Thu, 30 Oct 2025 14:57:44 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] wifi: ath10k: clean up structure initialization
Message-Id: <176186146337.3489476.10061776463232373681.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=6903df59 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cMOJL1K5Z7ST7ju7w8YA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfXxx6X5ipXihlJ
 7PRtQ1WHxvdekHT4IQsYk6fdjPV9JuNIjy9MueS0XgsRDfc5grupbNsp5Mn1qUlOCEX1QPydtTc
 4v1flDyOXUaD9vWwVO7uPYd6nCowYiqoKhfqcGQ3vzRqaoJ9X73awNB2MLWuZzxyogCARpiR+U/
 L0/Sd9se5aGrqwWhMeGqJjEtXSsfeQlHng6W02oSH3jj1e7/Y5/HG6Izc0SMEtLt8TmOD0MMFcB
 b+qDjfMQM5esgVii4vMnjfjbxyf4JpJ1Bb0XddPdjWTXcDALhDob1NcN1bp6DFDBStxVwwK5rlB
 AWlDOXg3+LzKSNjrAegEaWd+ipiUECu8IoEFLwUez86RjSzZWrBAA7b16FRaB6nfujs6aKlp48w
 j8CKCMjosmOVai6H097RhvMgTRZjvw==
X-Proofpoint-GUID: EMr9MDCMrEKmTdAogLUh-UulPiY2e7PQ
X-Proofpoint-ORIG-GUID: EMr9MDCMrEKmTdAogLUh-UulPiY2e7PQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300186


On Thu, 30 Oct 2025 21:00:21 +0800, Zhongqiu Han wrote:
> This patchset simplifies structure initialization in ath10k by replacing
> explicit memset() calls with zero initializers (`= {}`) for local
> variables.
> 
> Patch 1 updates the initialization of `pm_qos_request` in
> ath10k_download_fw().
> 
> [...]

Applied, thanks!

[1/2] wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
      commit: 877f9c22fdf424c657de757bfe8543cf77461324
[2/2] wifi: ath10k: use = {} to initialize bmi_target_info instead of memset
      commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


