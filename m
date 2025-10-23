Return-Path: <linux-kernel+bounces-867477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C1C02BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A54E9C16
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FED934A3CE;
	Thu, 23 Oct 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F1MerIhR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185F3101AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240899; cv=none; b=Ak73jSPHRWfuKI+QIc6+3lX1dLCMwk4qcX1zcYkpywGSu9USByvaVAqFfY/zUlYGZAVbnCvgawiGN1NLt70zKfA5Fr9rwDUht7nNA+Wsvwfi/0p7CPkFiRYDOeRxo30SattsVTMstnGkPE9g+zZO+n1HLhdhrDn+4YGFyuG3+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240899; c=relaxed/simple;
	bh=ShcS3JhxHmVF1aAh3VkCJGIlsU2iKRTmbYx6fHe3PJs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nS0Hw/k620wj6plNPBjGaPGpHx/fSiI0xvDRGlP6nyQjGp++7S9ldWWUXhlor/4fnlo+GSrmA3v4JarEgHRN8F/MSEgHpIvvcz134cS5y9gWKrRPQ1D4xgCewMQHatnX/FZIRrM2PvqX6CmbSTSNM0gX5fQGnRDBhwmxnnAnicY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F1MerIhR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEBYu7026940
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRq1ugaT90FNBOZl/OCD7yyFwBcTZ9ecupEzJ/5yXAA=; b=F1MerIhRYX/nFUpP
	bhHAettHN6rjCJZejqzrgRdMSpzWKNJv7tiGIep2Oi11MiDOuD580WapfD/Qjxfa
	7rbcRz0eUHXBFYy2bc2ADFp1jh7XKQYkRPtyPsJzDnvdM75DPi37Bq4/sokQE4WA
	tPF+z6J6fHaGz53YwK0HEt+/Ctu1lilw4HMm7rE33CjkTn4VqYJ4XQqZNcaTRxcq
	Z54D8XUQv3amWhOvlcvwbPgtC9RfpiR6gQc3CRWMreLCmjBZpeLYeM+oxs/KbkgU
	VuP5uX++EA4S7CXXN2dRnAzGY2PoCJSEP0JMXelFuF5LNNFyLL7Q6uwCVKXhk7fp
	mucTYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8kgdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:34:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2930e2e8e7fso9339925ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240896; x=1761845696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRq1ugaT90FNBOZl/OCD7yyFwBcTZ9ecupEzJ/5yXAA=;
        b=DKOaRyTT+ECRr0KESOhFmGcsHrxSvcQa23TB8RL3xTuQzmfRxGQEAmJNh8fbMdBjUe
         NlLON9iN/pYGgtMJmXIU5wK4BvcBMJrBzjP//vVHzveOoyXeJ60TJkeCbAdQWzc5TMX+
         rqdEX8puPhX55/rpppberTHRafjYhX7AZgNNwSQ9gxvTxwqenmCcAy1qWVeBszacL1z9
         yAf4fLTGNcjOnjzl0l0DhMC4Wwo4GdBZ6+CjgYqV9vfkWi+kir3mNVToTbGvOJlNgAvi
         LL3bKjb693zUBcxMkiZCiCOoKUmrEy6nx+icDQ6s+xz00St75PQIrzNZShwhX1hpSlDh
         rfjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU4/UqDao5vmyJ3sQnYai/ohwmUnboSP5YY0L5EgYqF6d5sqkdhmBp+g71EQmtc7dZSVuaju8v7LhzfhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8bBAWFKMQYGUEptjmO+kEUTAakDbvCBhbgCRFAsCRXGVFujz8
	5sZf2cyAY7PufIvnaPpoF6RB1hqXkNFOtfNL9iQ58Upnapa4NZap5FnqvWMSskvrLwxbof56z4Q
	yuDO0larP2A8k18Q/U5z9ZxSUhnE/Hv3fK9xKvUwxEu0wQdxVCMEureB2wTElJQqCMmtGNRVQA7
	0=
X-Gm-Gg: ASbGncvaEwsXGlBGTR1vyeowuzdDfj+eiDLk9HYyqY5biGdocD7UHhvTXgBHjxDGNti
	ceyYrUL0TW9JQ2zhKj1FeR+wfH9t6bPyf+Q6tXRvluhhFOSJGnNELqYY0qU0f0uvyR/EZ6gF1JO
	KWsx60ep+ivvuzFKpRsyPAn7jjlQp4F+G/qIVh4mAM23sabOOq84+gMNeUoo5ebAhQ3UQLSovZn
	j7zLyHXdhbqqUpVv63Zu3liChbUHQy5FewlbvnSQQ2OLYeOESzJ+RSeptzxurqfGXkdXFsUJ+HM
	voKNUfYRase87FeFbRtfQW6CkmIPp8YeKFgsQemkT28vmn+mqhYG4mcPTaO3UL4WhXwyDSPTTHL
	ycfGNQ4QX7SFnuFhB+5wECWBR+/DUpeNFojY=
X-Received: by 2002:a17:902:f605:b0:24c:b39f:baaa with SMTP id d9443c01a7336-290cb183b74mr328998395ad.49.1761240895687;
        Thu, 23 Oct 2025 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe1gNXGtcwmAY4vl7c21IrIBT/QHrguMJXJlGUhi5RMDu1zGJDn3KX9oBfiWJOjRr5Q+ZP2Q==
X-Received: by 2002:a17:902:f605:b0:24c:b39f:baaa with SMTP id d9443c01a7336-290cb183b74mr328998165ad.49.1761240895162;
        Thu, 23 Oct 2025 10:34:55 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e158fdsm2631407a12.19.2025.10.23.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:34:54 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251022-ath11k-bad-macro-arg-v1-1-93a8eadb6191@oss.qualcomm.com>
References: <20251022-ath11k-bad-macro-arg-v1-1-93a8eadb6191@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: Correctly use "ab" macro
 parameter
Message-Id: <176124089446.3626081.12835571659447806961.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:34:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Qmoiig6NkuF36COZ637Ixcl0_KrJaJ_6
X-Proofpoint-GUID: Qmoiig6NkuF36COZ637Ixcl0_KrJaJ_6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX4NNjuAZ/QOd+
 CAOANjrZKu7gR2sTybZsixiXmdo4E/zvXvfkDiFzWLO1Z+fWz9M97TpQi+qHd+vFn/A436xe4b5
 D9+8JebsbBgfjonYSP4Oqn50NDJ+HZUV0aBuq8nudgW5c2XxLZ7ospQxc98dV2uKyIQJUZdjUEg
 Xp8CuDZ0yR8mEh7hTeRIKsn/MYXChpHkp6BzSGfEERiDYpyUCSIi0YvE29v5nh7J3g27BrFsMRq
 USzzB4lMyNoz+fNqxvB6NfKWspYPUqPzfNBumLIZvuwvI5Xni8DAZ0e5rGLpXFTh9YgoSVVrJtj
 JvyvXBxW6D1n/Ixc17rpvXKqPivdzJ8jXEQJypW8kfhGFZrR4wcC1RsvbTSx+nZzYjPaH+SvK2P
 2e9XYChVral9mpphQun0AITZRQmLuw==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fa6741 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6fyoW-0bdveP3ZPMVTgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164


On Wed, 22 Oct 2025 08:24:46 -0700, Jeff Johnson wrote:
> The checkpatch script is reporting multiple instances of:
> 	Argument 'x' is not used in function-like macro
> 
> Fix these by renaming the argument to match the usage. In the process,
> also add parenthesis to the usage to avoid MACRO_ARG_PRECEDENCE
> issues.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Correctly use "ab" macro parameter
      commit: 50cb7ccab8176cbce4e32420f9fc2d6d80e69a09

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


