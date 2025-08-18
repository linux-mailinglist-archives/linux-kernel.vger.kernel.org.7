Return-Path: <linux-kernel+bounces-773357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D55B29ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAFA3A986C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B153101CC;
	Mon, 18 Aug 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDqe6vpe"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23626FD9D;
	Mon, 18 Aug 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511569; cv=none; b=Al5YEtQxCixxWC+nO9ssHQZAJRBkGmIvKekkalowFTIUvvivtkxSCdspvegO1vVtprazMZMO4wAu2NH2yP1BFpOdr4ix4wG+cBVRUWDpyrKBB0pOKrHCNDEY6t2gFW/iCn+p+b2TmgnwSs3/dy7PmkTiJlYiKTvqmRhBgKKy41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511569; c=relaxed/simple;
	bh=MlfKA80csAtyMekKy0tuKaDg/8XwAoP1D+tkBCBVi5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbCj0EirOaGepngShUY2ZkN9BwFz/y94VzNhWefJR0XYVboWJwZ6hZagehRf8gXeVWveeCawLUUOTDtUR5TltRJTtZENCuBWNL4Wanv7hWc0dBI3zF73bmkQp7VutTXVyyoDO4hEzmrGcL2k1xqnVZxHJRKbD1sZmGMoKRGl7Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDqe6vpe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-321cf75482fso4408907a91.0;
        Mon, 18 Aug 2025 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755511567; x=1756116367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaCO6brQwzjW+TX1R3UQhbjIaIZFQtHR+ZTT3gImHsE=;
        b=cDqe6vpeTU99qPzPp66jRgObSOFEjepQOMltIOz+/R7DIRLVyNFeWiluF5Rn+lvW/8
         DJPTvNaAJ5bWmCAt5O6dPyOXcRx+BXsSLN1S0jI2xrwKog6nF4UqDm5MryADNQQwi8XP
         7TwAFJ/y09XfmmeT+pLLYYqUYfq0kX7hf1qDyUyEUU0w+ZEHQR1tycDKZ4f+/K4E+bXg
         +sf0kuJN70R+WeU52hpqCnMiAvztfPcgd2V+Qij4em5XOCfPtq5cqLUya17eETtivTOM
         kBUG25hct/+9d//VSXlfDdqul016XPo7zT3bcW7VPiawd7cO+Y+k+mF7NZ6PqFDz2iOt
         I/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755511567; x=1756116367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaCO6brQwzjW+TX1R3UQhbjIaIZFQtHR+ZTT3gImHsE=;
        b=WSFgZooz78gXWs5ZW46h+Cucccxh6RjN5iUK86CeUdVXj+PZnZ5bzlgWEi6TNbiVhP
         YbPlbTPZiBPoiTLKFW8Hn3dnx4JNFStLYaHPZl/axElMNXf4Rnbcec7cFcH79TI6oqKn
         R+f8GAFDlk+OtVfXiYgmh/nUUoI+ne9YFTRHIZ1NYA0h7ojSUms6SBc0AfAHI2f3R+rq
         +ElnMA/6zD0oaIQwhl2/2+kB/T6Kid6piH7oUpE59NtDkShfcdHpyMfEqLBnkBJiRD74
         JWsOI8bdjvOj30rdP0jCHuBPeabYW1Y1sXk9Z2UE2r2FKq1f6rx2U7snqsa61WFxaW33
         Unng==
X-Forwarded-Encrypted: i=1; AJvYcCUwvZVzL5dtA6LjZfXV3eWYTs8Y+zIR9j1Op8JOJeQBOKDkeazQluQnFmE7tt1abrzS3EoFiAi6hMvce36N@vger.kernel.org, AJvYcCX/Rp+ohNHYZ2jrHW0jbAGBmLpbVqNKMBg6rXPfH1Q4S/rIlKBU1Xm81R0e47rEb4X/OSjnB59Aulo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBfD16yC/DFb/yj2aPNUK69ZCIVtXG9JIvIe//dDTZg9xKcTx
	viwCzW3rGCxjc0jxTmwpepix++Q1uEPQrxVciBUkJo7Q2CcxhoB9QZ7TK2bv8Q==
X-Gm-Gg: ASbGncsn7nxLU/YissLDJ1eYdpt9qG1vAFWX+HJNT/y7MD4dtwfFJpRMjW6g3E7mtc6
	EwqCQAKX7NdPWB4Q9XBeOFO7+ISWKPDPYM92lLQS1lyjJOYdJlJcdiYe2SS1RtavVfiTd8jwubp
	aiGLoChtYbNvCR4zHKczKQmNoGQbtZOneP0IszKeLtJ4X1JUoWsvU/hQPOHirAXayXgbDj2680+
	gv7A/xcVHADkGSO3u2sAfMp9dMAfgYaFHaPSFANnPZY4q3U48RvH1Xf3uejBmJddzMCfTOlEu0M
	TsRS6qOcxHFBC1r5KJTP1GtZqoh3Ynf1JIp0a9xkoAIL2ilKPlSZ5qs/FUvhOWwFaZ93rK84cva
	z49dtl3iE0jwB/FKevbIEXlKP1m6tlWGP4E79N+5XN+fzQfPa6ic3c2hpdPxIjN21o/0cEc8dhO
	q2xKI=
X-Google-Smtp-Source: AGHT+IGkbOz08ZGFXiD0osQcGU8ix6vtUqdWI+23FywJ19dangUDVmkUnIBgZ67NTN05rMbZeikEgQ==
X-Received: by 2002:a17:90b:53c8:b0:2fa:42f3:e3e4 with SMTP id 98e67ed59e1d1-3232969ad44mr20566918a91.3.1755511566941;
        Mon, 18 Aug 2025 03:06:06 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3234396471dsm7679447a91.5.2025.08.18.03.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 03:06:06 -0700 (PDT)
Message-ID: <fc93e36f-7503-430d-a611-983f0325ab1b@gmail.com>
Date: Mon, 18 Aug 2025 19:06:03 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <816ec5d2-33ea-4399-86e6-51ddc20ead28@gmail.com>
 <20250818114220.7f82d2f7@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250818114220.7f82d2f7@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 11:42:20 +0200, Mauro Carvalho Chehab wrote:
> Em Mon, 18 Aug 2025 09:44:39 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
>> Sidenote:
>>
>> It looks like texlive-xindy is not available for RHEL based distros.
> 
> On several rpm-based distros, extra repositories are needed.
> 
> So, if you take a look at rpmfind:
> 	https://rpmfind.net/linux/rpm2html/search.php?query=python3-sphinx

No, I'm talking about texlive-xindy.

     https://rpmfind.net/linux/rpm2html/search.php?query=texlive-xindy

has RPMs for fedora 41/42/rawhide only.

How do you install xindy under AlmaLinux release 9.6 (Sage Margay),
Amazon Linux release 2023 (Amazon Linux), CentOS Stream release 9,
and the likes?

Thanks,
Akira


