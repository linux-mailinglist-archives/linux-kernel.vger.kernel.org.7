Return-Path: <linux-kernel+bounces-805524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721FB489A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626EB3A6D69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127D2F7468;
	Mon,  8 Sep 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCPGrtxc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBD29A32D;
	Mon,  8 Sep 2025 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326233; cv=none; b=YoFvSIy7s5qo+QTpcWbhEokEOoDbq0IPC44UpNuvIS9pPn5eGiyuHkBnEHKFrfisDusB/4HrtaJqlEikQujDGeD967jNE0ORwzG8Z1eMnPbe3PVCguYc27JbUqjfFdLM+iBAkuyt3bpETY+tG9CNh8meqffMEfOiuah+TkNeRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326233; c=relaxed/simple;
	bh=mFuFOvwPmJwAbN9qPHGvdRcN3HHHjEi7sF6DmlckDMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+PWPRmTy7U8M9akPPp+DJMwy9ydHCVlYSin7qfHkMVBxq4tU9zElj44G1DFXNvnG4E6OECFwL4IaCqxKdShZjR8OXyKNbPd55K0u39jC6IHW64etfkZ8Tb4cK0AzX4r+69SMT/u9OxtzUGodmFTM8yQ/+OBZoVAWttZulYYOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCPGrtxc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ddcf50e95so15016795e9.0;
        Mon, 08 Sep 2025 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757326230; x=1757931030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:references:in-reply-to:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEz+Em4KcFOihPHl7+oJJANOhPUPqUcx/sA2JXEHLYw=;
        b=MCPGrtxcZOuvRMCWXgmznh4n6pvVq+V3nKPUGbV26V8dpIorJOE73y9JKGZJc8M1P6
         3PvZ+SpfB8dY3fguc2DE1jKP6Y4KQenZJBscxuhwOTtFo2aetm/Gsh3EdzASBHTPT+Dy
         fn7EGXtOqSx7IZpOhLbXFz3Wxbc92WMP5uWKMl42uqPO/C4pt6S5T/3hma5VJqkGQeTX
         Pj084JwWbtrFIGMKm7B6YDe38Njd5WZSIwISkrccTMYWV7YVCcwfojMjurV4LI9O9Wjn
         JEq6WWEOlrJAY2HJFlnH8gZ+RfqRpe246LUXLlUDsQ+6AuyUA8fZyhSSMO4yj7l70Nne
         DcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757326230; x=1757931030;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:references:in-reply-to:message-id
         :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEz+Em4KcFOihPHl7+oJJANOhPUPqUcx/sA2JXEHLYw=;
        b=ijTOQJ3rDE9BhCDgulxEyzQKKn3kaTkkGE9fZT9JN9+bYIL08M4gBriMC81RE+JDmg
         Ykok1ssm8uqAXhxerTYTnhlF1yYedoR7OHm5EZs7UtlQqW+ZfoswsERdfSOqVbStehfc
         e12oW0pZqILZNZ/smS83HIFaEl8CAIpOWPjr/K3lUtHErVOcrFVihi3cV4hsnFQH3hhF
         DgNfxnIQxHLGG5Ld/2G9DWPMsAK6XC76RDllFw5nmhTxodwdj8HhoMnJtL605i7b8RDa
         fJCT4XlWz//1oXGm7GRSAZcghBuRYfwyPrrkunfBwkQZB+230bNFy7WecSFX5jKkh7m4
         kGRA==
X-Forwarded-Encrypted: i=1; AJvYcCUowJLTGcWkERYz8vKXW1UzWjRI/Q698MlltNpkcCw2kXSZyujgWSCJwaCMSvL9/o8yARXlQT+95+o=@vger.kernel.org, AJvYcCWbodMVqdL6NnOj/xPMyEMhMQEji/s3qKuxe7JL+MC0VvRhuX7atb653e4Mrbo6F/pEJ9Xb233h5hyON8M3@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxFmpX3RfmmM13/A8ALYdSc5w07qrhwb3jvD2JpQnCs4HaxqD
	oZQ6ScbCdT10MniTN0vIraCSEI643ezUSx6HT+Jrjlq6hGjUWp3xVnzW
X-Gm-Gg: ASbGncv3zGxPjtS5emPwpjvuFMMDe9Ks2zDlAafq7mPUh33sYadAtuxD5rvz4JBSend
	BcSS7O+IQJujL1T4AJ4DtHzOEr9a0LxE9KJZfBRUmlCK5zsj5rNxVNpjAiRVPQGuHV3mlpUM/RN
	VCH0NE052sn+nm9R8oLNcH+mR6wqHE5aie8b0HQ+tgRTxWAr+8nD6vgCo83BWg4jgY+kvPQFYsR
	0xh7r3kjvY4ezwxaGLaudEPGno7vXAjwA1xBt6n2sBd0iEYCS2Lc+0gSNLoPXl/Jt9phNCmfi2r
	AbCmUdcFLYlkwLE9bsEmAjhZrAsRBLzeRBATOS+oGlvE+CE331lQX5NrYm9mlezxNaPg4EcYSev
	EnKDQvijo9RcSKypg6tWxwaLt
X-Google-Smtp-Source: AGHT+IEXq7zsbLWoeBLVjjDgNCg06cJkPK+gGZDWWxQKZCTOtFGDmBRwiKg70/ycWnZxMXLglLDO8Q==
X-Received: by 2002:a05:600c:1c0d:b0:45b:9961:9c01 with SMTP id 5b1f17b1804b1-45ddde832ebmr76690925e9.16.1757326229742;
        Mon, 08 Sep 2025 03:10:29 -0700 (PDT)
Received: from gmail.com ([147.161.145.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm439408275e9.24.2025.09.08.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:10:29 -0700 (PDT)
From: hariconscious@gmail.com
To: corbet@lwn.net
Cc: catalin.marinas@arm.com,
	hariconscious@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	will@kernel.org
Subject: Re: [PATCH] documentation/arm64 : kdump fixed typo errors
Date: Mon,  8 Sep 2025 15:39:01 +0530
Message-ID: <871pp8a9ze.fsf@trenco.lwn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250816120731.24508-1-hariconscious@gmail.com>
References: <20250816120731.24508-1-hariconscious@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

hariconscious@gmail.com writes:

> From: HariKrishna <hariconscious@gmail.com>
>
> kdump.rst documentation typos corrected
>
> Signed-off-by: HariKrishna <hariconscious@gmail.com>
> ---
>  Documentation/arch/arm64/kdump.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
> index 56a89f45df28..d3195a93a066 100644
> --- a/Documentation/arch/arm64/kdump.rst
> +++ b/Documentation/arch/arm64/kdump.rst
> @@ -5,7 +5,7 @@ crashkernel memory reservation on arm64
>  Author: Baoquan He <bhe@redhat.com>
>  
>  Kdump mechanism is used to capture a corrupted kernel vmcore so that
> -it can be subsequently analyzed. In order to do this, a preliminarily
> +it can be subsequently analyzed. In order to do this, a preliminary
>  reserved memory is needed to pre-load the kdump kernel and boot such
>  kernel if corruption happens.

I don't think this is right.  While reserving judgment on
"preliminarily" as a word, the intended use is adverbial, so this change
does not make things better.  The better fix, perhaps, is to say
"previously" instead.

Should you choose to resubmit this, we'll need your real name in the
Signed-off-by tag, please.

Thanks,

jon

Hi Jon,

Good day.
Thanks for the suggestion, will correct and send the patch again.
And my real name is "HariKrishna" and see that it is mentioned in Signed-off-by tag.
Do I need to add surname as well ? Please let me know.

Thank you.
HariKrishna.


