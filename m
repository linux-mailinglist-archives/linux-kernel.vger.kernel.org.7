Return-Path: <linux-kernel+bounces-819814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED0B7EB59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9711C0391E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C76920F08E;
	Wed, 17 Sep 2025 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unar2SXg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6C21CC68
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071350; cv=none; b=UmN4sNPt1TmH5iDS3OERYRTSFZdpdHiFPtUtNIWaBrWCGk0D/wY8eUDqJGtjELRi5AxEgW+1ECQ5xo5kWvFfKIUWZiROpVnUug3TsxGSo7Y1UBFqs5T1y1ly+VriuLFaCtEgmK3uxkXdAaSY9Vu1AMEMuMH8GOECXNHfGgX+hSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071350; c=relaxed/simple;
	bh=8iy6YFiMxYbnPM1Dh+uja0UiONhMccJeOfORlYkOyIs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Z0oICYGhSbeyPfs4vVg2snIIES3s4r6eQ0xD3skhb5lETcrjmtJanNIaoCZSJBZ34j2orpGrGB24JdUofHGzen/U7lwtDeOAGpQGbS5Bd9oiOtWkVnB/vqk4/E9YbXUXcqNZcatsiMi7y473qrWahpV93jhi3mIhESMXTMgzD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unar2SXg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77b0a93e067so1079742b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071348; x=1758676148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef1jPHXRXlSyQcsCWb/rEyZIu3SGLb3odWcJ1kdair4=;
        b=Unar2SXgzSUEx0wr24FmcBWnA5JppBUwuyT62CLGJihOapX1TQqQBu5AoPjrQYPPns
         g5s/AR3vYJBlhYh4C+I6kPvTs0bXtnt6gQ7z0NjGuErjm8faXS3Pvi9813eQl5MN7Rl8
         7E3v4YViZ1rbQ5cgPC85RGtBX4mD2OCMWr/Du7+AOchWV7vimYZjZ3A3lGrvih+4RVt/
         LDYQPivshyIK0FoK/kMPnDw461h7pfwpcVERgCct9lZOA2J/acmerAMOZgnv8PhIRApC
         rcU3XOqXMF7b2iRmoWYQBsr5Lz/mVWDc4qNGXi8Si6nVRN6AVk9TZmeCmFeu8NIE/Mrz
         ULFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071348; x=1758676148;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef1jPHXRXlSyQcsCWb/rEyZIu3SGLb3odWcJ1kdair4=;
        b=HLJWW7a1Bm+NCY0ylvTgsbUPPXv7f+S43G8M1QQfCiWsYyKQ18Xx3PQ2HEbD6TvpKA
         Fy1+iOkhcUu8z7lw5ZcaIj62JgYfA5mXAqYc5ibUNE7KocIBvAA6X1fAGBW+RzygtM6f
         lcSiHLUuE0yHVsM/gg4iuK5/u505wBikmMpy9gpZFyCD6urTEQ9x9zFKOEOKXHXU1i33
         y67D7mcf3uYqf5PB1EaGulH5J5UQJxPpoZ1tWkeXzy2Hx4c+G4OlDJasEbgGZejRX92z
         /ZOPbvTliFYZM3r9FHjUAZI1YmkAEg5xAmq0no288jVBRAyujYKCGeHMc2H97u1w85d3
         gjQw==
X-Forwarded-Encrypted: i=1; AJvYcCVqGG148bikoSQWjg6yBvnpcmPtp6SHsv56U+nEhW7oBBTe+lweIL2iFwWfrJE6X/HsqEtIysL4KVpIWmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhkvttqUG6UvwgItd4x3iihRmE9A1wWGIQGNHQZ0MBsRG1nDx
	zDMCZKb49zu0W8dfGX/0sqkM4UH6CcshXl6oroYXgzz9xSwjt9dODW/x
X-Gm-Gg: ASbGncvuQ4uePWTzOSinNKBaz5+EISW35Gzm9nspARJViDSnRB1jDvDKFazRhnNXgAU
	sAI5Tc9JgsRJhubL3xmSuX4SSfzmADWYd8vkzFA/X4gbLaA831/Lom7+CP+Xx0uATot9uF7TA2J
	+F+NeBWxprxYQ69VcP+5NevQf0hza2G1WPvHnOlSL6yCNAiUZ0w1zJhvTDNMEJIw209CxHyyRWA
	7e2c036AamjwjzuTQxTi0hjQ2Ecv1aVrEMQys2NZ5IgIUimAnXsMeANpshZangJxPAO9ULZdXm9
	rPFHocTsTZKz3/LdpRmz3pW1jkKAyMt/QADrRB/j+Uo86BaKGL/X/btva5Z6wqrNRPMaCsTnaX2
	u6XrAQuXK6Yl0s2YPxDcNqfj8iVPeplvqrJnUD1RTFmpQcv6rMsuYrOW7tvkYeMuzesad
X-Google-Smtp-Source: AGHT+IEkeWcnuAAqrcdSXAM4DGEipqHMYe63kvODT4I36ORImDYKQTXkHaAIEz84039vOsF1h25Hsg==
X-Received: by 2002:a05:6a20:394b:b0:24b:bae4:9c67 with SMTP id adf61e73a8af0-27a9303f03emr318222637.7.1758071348500;
        Tue, 16 Sep 2025 18:09:08 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed266eed7sm789472a91.3.2025.09.16.18.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 18:09:08 -0700 (PDT)
Message-ID: <52932ede-eb04-4275-a051-952bc2859cf6@gmail.com>
Date: Wed, 17 Sep 2025 10:09:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <8a77212d5459eac2a98db442691930425a2cbefd.1758018030.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v6 04/21] scripts: check-variable-fonts.sh: convert to
 Python
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <8a77212d5459eac2a98db442691930425a2cbefd.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 12:22:40 +0200, Mauro Carvalho Chehab wrote:
> This script handle errors when trying to build translations
> with make pdfdocs.
> 
> As part of our cleanup work to remove hacks from docs Makefile,
> convert this to python, preparing it to be part of a library
> to be called by sphinx-build-wrapper.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I could apply up to 05/21 of v6 and did some quick tests under
Fedora (where Noto CJK VF fonts are installed).

At 3/21, "./scripts/check-variable-fonts.sh" doesn't say a word.

At 4/21, "./scripts/check-variable-fonts.py" complains:

=============================================================================
XeTeX is confused by "variable font" files listed below:
    /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
    /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
    /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc

For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
Or, CJK pages can be skipped by uninstalling texlive-xecjk.

For more info on denylisting, other options, and variable font, see header
comments of scripts/check-variable-fonts.py.
=============================================================================

Of course, I have followed the suggestions in the header comments.

So I have to NAK on 4/21.

Regards,
Akira


