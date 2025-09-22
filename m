Return-Path: <linux-kernel+bounces-826526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5782B8EB99
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F143A627D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7712DA771;
	Mon, 22 Sep 2025 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AmHiXpcz"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A11A294
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505923; cv=none; b=IqNbZBomz1oQguieZ85B2M1G4/tZiVVAdBQBK1CYRUxMfJkpB384ZtW5N+vI2ecsaUfT7LmQa7zOW4BnCtA6HNqO6Oa/m4rfcp0HjX74kv3dvqJWs/Cbt/lteMSdQkqX+dk/thFETzb12P3gEFPAikIj+7RxV3ett8eyemMSOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505923; c=relaxed/simple;
	bh=MtLe/PQr9ETLIvBxqMKRWu1h45Ht06hQpZKfpCJikdw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BcxwqenRUQFaG16pZkKfpzhthUcJtSOl8QZXtx4/RpySBS3cb2fFQrelvFK9MJXIrMeSWoJfdGQ+3E99+a1OqEstqJ5T9N6WgYEJ012hsryd0LSpZHszP4keuK19Qxv61LQXIJk/8eXqFN+B6ETVdhpBjcTI4zIvlHUObRqi6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AmHiXpcz; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758505915; bh=EwFRG8CgRiDk6CdRbt6GS1CF8sXLp89Q+es58nviUow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AmHiXpcz4+l065HYimBvDZ6WyQaUIzsHIhFCRvljL0OCEE3Ea9/MDoHdJr8wJYZwX
	 BnnviYWwYv9Bh+0ZncjTnWSyXk1+4J+snPvCMd2MfkS/xV2/hTYi6vMCvD4icphgzZ
	 1zS+y3RJAMJPaackDVc3+SaZqRu8IDEIvgiT/uM8=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszb20-1.qq.com (NewEsmtp) with SMTP
	id B6110860; Mon, 22 Sep 2025 09:45:33 +0800
X-QQ-mid: xmsmtpt1758505533tv3hij7cx
Message-ID: <tencent_07A006DB31D2CB8040AF8B2C4CBBC25E7D06@qq.com>
X-QQ-XMAILINFO: MJf32pulH481Wr5VX/DDFWWIjjonSZ95/LLAcDbXXi4XrKj34Rw8iXN7k/t7gV
	 2ivXy1GSENg77u8rt5GaTPETGvzdln4l2jtm4iiOXE2nBjH1GrQTyFkEvyZ318nEv0F/kXje0aTB
	 nlnZcxmk6VFj1/BsnDjfp9b+z20HbiCbuDQiY7+p9I1F5P1g/Iid37e48yg1E3he7Lrn++Mq67D+
	 XAFC0ZMz1n/PgVQOvhpUNdlGrC0K7TqkEIZecd+ehNggJy4R/J833Vvc12vKGK/grhsZRpazZLgr
	 e24sihrLcDFRb8YOJF7u2y6dIfhvW44Q9NmKSBZ2Kad+49r4U2ddmJRyvJNpoS5SJHswQ2i3mzSS
	 KbRxOXDsLWrGYQcoVPT+eAMlM0m8O1dMNNCH75JSsf+yIKVzEzCBBWM0nwUruwWgWISz8wvE9rbo
	 uw8E5bBT0R8CBsOPsXTFE02J//P/eVlsS8AL/uvXyGEemm0Hgb7hZi4EIm6y44mJVhf5uq5WU2iD
	 SLklYj6San6I1Em8GwN1OJMjIHH2EDENPPJn9Gsz3Lz01seth/Ka2a/IhzpCmOxa+0yA11ywAd+m
	 FDYsVYYktGEXfTooCk3wbry1DRse7Pkk9bhEahedFLfajHUsMF3gHXBIdg7B688aumZ7uG/3MT1x
	 L9Uyj5k0TEOtpbj+Iacznyz2+TATQccCjlSp4ry9zgyjw0uW+BFS9Yoc/RyoqW3/LK1+ZE4eSCPY
	 RWniJPyUkAhi6N/OhWw+9qsTzzvpd1/OdO2SudJXR0W5PaBHojkCAnfY53iSMqSaAMVmw3wjI1/R
	 cLrqd4/SQL0qtE0Iyi9rs8JdKQdwTlf2ZTNjnB9WWz2O3oHm0MG/WPsRo1ZPLvfGLhfA6sudK/ND
	 bTs5xpVGs6cRwt9t0eKPCLH/u3bjBdBsoheyfXGkztazhxxtoPODQmUk9CbpixGzWsFP/N2SENhN
	 UBXk7xNdxD4nHjVOlW0u3Fq7EV6H4t+j8FrC/UANcrD2zHela43qg2XxypId8twcu/D23KC1QH6v
	 Gkz6olgXkBgBuyaD07Q/QD+qF4FVBFyG+hwLfp+Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Haofeng Li <920484857@qq.com>
To: qmo@kernel.org
Cc: 13266079573@163.com,
	920484857@qq.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	lihaofeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: fix netfilter link comparison to handle unsigned flags
Date: Mon, 22 Sep 2025 09:45:32 +0800
X-OQ-MSGID: <20250922014532.973648-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <72f0108c-ce6c-4f89-b04d-2398d7c808a5@kernel.org>
References: <72f0108c-ce6c-4f89-b04d-2398d7c808a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your review and feedback.

>Did you actually observe an overflow producing an error when sorting, 
>here? Or did you run into some compiler warning?

I did not encounter a runtime error or a compiler warning caused by this potential overflow. 
The issue was identified during code review as a potential risk, 
considering the theoretical possibility of wrap-around with unsigned subtraction, 
which prompted me to submit this patch for code robustness.

>This being said, I don't mind making the code cleaner for these
>comparisons, but we should probably treat all three attributes the same,
>and update the rest of the function as well?

Thank you for pointing this out. 
I will prepare a v2 patch that thoroughly reviews and updates the comparison 
logic for all three fields (netfilter.pf, netfilter.hooknum, and netfilter.flags), 
replacing all subtraction-based comparisons with explicit conditional checks. 
This will ensure the entire comparison function is robust and consistent in its behavior.

Best regards,
	Haofeng Li


