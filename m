Return-Path: <linux-kernel+bounces-869371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FAC07B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5041B814A2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A116347BD1;
	Fri, 24 Oct 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am/T2Gqu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457F263889
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329912; cv=none; b=IVV5hd0W81E5GyD720x58OIncbOT8jl2VRIytzFDR2XWiEt6pb52IA1f4diiZ+kl12AnNd3GrhiIC0wMGgzZm3/zRuilMWk3IAdG3uyFaFigQFB9nSbMFSsoAu+srECH5xMPVgRi4iGN/iR1SsbXEAiipM2eSRTBMzEh7B/dE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329912; c=relaxed/simple;
	bh=f9EWuUddQuX6YNL9LEZegSrVPjIgkYAeTAs+Ik6L294=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qI0xilxrnGLNifkHuD2wCReez7qsv1jLa2q+TLn8oJe6392nk+5LCLfJbYDICF7pfJzZQioRqPni9+IoQ0LknjXgtNqUuL/wPcpxcyk5e9l5XDnAtRRNil1mzz6YC5ZwS14MvlgZv6YmVIKfbkTmWJ2W8ZKGq82jX/VXmczRpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am/T2Gqu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ab379d48so23208675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329910; x=1761934710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f9EWuUddQuX6YNL9LEZegSrVPjIgkYAeTAs+Ik6L294=;
        b=Am/T2GquuL34foceuwpJ4lT8PduHc80d8EXu4e2c43/6b8TAMnB0/P2EGnjoaiTILc
         ivEp5pxUjR6f9WIVxvP4nK4Bytlfr+2vY3sAVO5xjBmC9J8moEh2BfTz/bD+97zpRDYq
         YxzZOYPDRpYGb2lxNHECKvOezigtdJWMBte2is+JTKsPBVsT3OciloxKzHKy86LUOmMI
         a7vDq+V3Z58edhmA/a0X2TdkHQdSu57Y833IbNEdOGH1qu62JkK5UBwnEjAFkZZVeHnz
         4tdOVoUe9aE/hkGA1+E7d++aMkGZd6SalM1e7kS9l9i1z5/x7XMb7R/ZYjOuxG7/U9Ie
         7qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329910; x=1761934710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9EWuUddQuX6YNL9LEZegSrVPjIgkYAeTAs+Ik6L294=;
        b=wZQIxgdK87FBokefIyhd5HdzyXGRiqGCGSlEv2Czhm/rVUuE1vIkKFqMLsRJFVTnvC
         ca4Lf8/xHR3Y7qgM8Cf75uGflWrj7rxHkmeATf1ylNWwAn3s3w+sDWc2777sKgdGgF1o
         d5RWMUjqwAwHhtG0jkPwmafbpU5RtmqKxZNwcG9gdg0HYIWOeOHqv+UMFk0A0ZskXMcg
         zv6mS01lSG8CRK1VPQqJF6iJG8vD+1S15Asmt83OG+fHiYikBAQty/uiebxCjUU4PvLC
         /LWWECQfPz3MLSC11T/EmfqFYbx5prcZdEeyFLXQzxAcPJ/a9/JMAJxlztFLP/oB/EEC
         XbVg==
X-Forwarded-Encrypted: i=1; AJvYcCVxlRwOFpjqiiveXYnhuI7bKJOsbiA+lhE8Q09yxcDn9nm46WBGPardHKca1C2NFjKSz++I28ojcWckB7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCbq9Lp+NpIvOcMhlkmspvAvXcvsZu3IsBd/SFfh7LY7yIdUS
	STRCvUZr0vDKcSvGdIAwUadwgo0RdcZd9d/pALfReEL7IyU6R1p4VfWQ
X-Gm-Gg: ASbGnctQN73M6GbWzZbOfFok6eWO0L+ihSpTUh7eZo4C0OPKM+QsJCQWGd86r7lAVkI
	0Hk4iiO4jGaBvK+pGTP6PuSMiLNQKHusH0FlXoteuwtDJUSRcWcl/P8QHE4BXfl/ynQ0YN3bTbJ
	Sp+ikLiS3EHWJvdMzzM/RRZZoOSIKTQnnm+4QIG8Nvm5ddq2CAYBECtCyy+FKaTJs1m6xKRWY8g
	aM4BrRn8/Xxp2R7F7o8Jyf2QXO+HPxyNYpdQ0niEfsbO7Lb0aWIgMW/Djs+doDTEu0vy2Q1uCyE
	ovjlRu13SfCuK18uR+n5lLSW8QfmZjuZm+BzBY+vSDW9e2CQYmOFvpYs1JCJbnXcDLbfzP+ilRZ
	rcRhH6IpY57nDfJ7IcWYyndewDfd0XjjzkH50RrjZUWe5NhsO9BxcmvJrHgn9CnEZKZNStaOJAG
	G7G85MR59eBg3qMLxGCLZAJxwFNmT3cfMNgNNTPv1faLgIRt0R+eKFbooIw7Ia9w==
X-Google-Smtp-Source: AGHT+IF/37Md94bLY6qR/ziv9TViQwjGMpKwmUGK0lvbcCIcjZbOGWnp2GdAMRDeHQgsprf/tPWO5g==
X-Received: by 2002:a17:903:3d0d:b0:24f:8286:9e5d with SMTP id d9443c01a7336-290d14e83ddmr370668455ad.26.1761329910062;
        Fri, 24 Oct 2025 11:18:30 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ded7c8bsm62731145ad.22.2025.10.24.11.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 11:18:29 -0700 (PDT)
Message-ID: <c4278250-4506-45d4-b0df-71247256eecd@gmail.com>
Date: Fri, 24 Oct 2025 23:48:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ethernet: emulex: benet: fix adapter->fw_on_flash
 truncation warning
To: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, khalid@kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linux.dev
References: <20251024180926.3842-1-spyjetfayed@gmail.com>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <20251024180926.3842-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Please ignore [PATCH] and [PATCH v2].

I have send [PATCH v3].

Best Regards,
Ankan Biswas

