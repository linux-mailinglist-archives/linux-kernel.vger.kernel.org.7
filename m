Return-Path: <linux-kernel+bounces-883700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF26CC2E244
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677743BBF2F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCED2D0637;
	Mon,  3 Nov 2025 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVLhLsnJ"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDEE2D322F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204950; cv=none; b=MarIkV9m+mbTmMBxXZVz95T7ms1N9W5FpCZYpZ/ZWrp2yTlhhm//XE+TgraBmGrCPI6Y7MNMZNQUn/mS6m1+zUwbb6zxvt0444gNRccKF+Y4sraQVQWFOeXi6zug9wl4umRPoczPtGUxsHOZyfPLJqpPJx/F65uo1GuhVFcE4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204950; c=relaxed/simple;
	bh=MDGzFe54Gf7s2MG+FUe+jE9KA0+XPARryXnFLSlJ02c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs/zwK2arLxQ1szfqUR0lsXxKrcsq+eZjRGY+d2fVDsl7P0n+ZsZ5lVKVcqpZn1YGSQiMH+L4mChoeBVgi7CSY4ybKAPBvh+kFegYSBotN+36iMm5YYC3gbHErx5vC3SSpRLqAACXChGGBxbp3EsVo43ABrnGDedPZutdlu9SfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVLhLsnJ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4332381ba9bso27815145ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762204948; x=1762809748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDGzFe54Gf7s2MG+FUe+jE9KA0+XPARryXnFLSlJ02c=;
        b=lVLhLsnJseDX6NwBvIqiOW/ywaJ5+T+3IIA1wkXRP03KRcBfMzJkH0soLT/t6fNZTT
         LmFY7YeNWKyKkYqN7+T3xNWYiJfMwzvyJ7DJKTsXrSU0x89DVHeBBAegpGdXxSsZNF4Z
         g8WO9fp/cR1XW2QEegD9X7hYGZSwdjTkD3WmbEr3SL5XeB44wvTFl6K9oNX18eZQDjcv
         HkJPsRg61ueZiJh1ockEhM+T4pl8yxmtYgDXz9UirPT6A0a+UehEsHnw3xvmQCDDiNAi
         GTLj/FCyyrAiib+bjpfdSl8F3Stm/E/iPDTq+KMW5MCBsyaIwpWeCbZb+Ce31WjhkCGt
         cTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204948; x=1762809748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDGzFe54Gf7s2MG+FUe+jE9KA0+XPARryXnFLSlJ02c=;
        b=O8MBb1CIkQTP2DHlYKn82Mk/rsV1Gapcw0lD5iTCaHQ0V305D+L3V/LGaAapXS36oY
         XXFI6ivWFsenNEbTdzBfCXPvj6jRGjJgmIRAh8gZ/Pgy6LjXjADu6yTgEXW5TRKw52ji
         Kpv1MV5Dxs4qER4cF7uXdkNpS51C17CnL6jNHe5qLPv+hDJnP50x3xaa8OioQYiUfdJT
         xM+AHSrMWb1rKb94Ua+3LSFixfcaJcmP4jw9iqfcwPwQNqxP+vU7zPmzs8114resWFm/
         03a6c8vMmk+kp9ZhQBXFKzBmn1L6ECMY3C7wehVpTm1XZrBGpxUu7CHrDAfd9b9rzlzY
         LZyw==
X-Forwarded-Encrypted: i=1; AJvYcCVAJAE5xloXD0aJ3Ki8mebtcSoU4WhjMyEivCzBsynkLtoPrEoWcybO0c7zw/HUzYtAjBWaRf9bpUCyOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFyibNkzf5wxGe9OatxEP+DVOkCAojwsOwlb5Kg2DRctTWtRg
	gMnsMyw4AylPdh3gXXRMf9hVbWz2/9WOAI4nLhGb2t7NO+gESvzit0Xw7B+k1m2nglZYFfSlIuK
	NwPPB0AGxZkme2TDgfkWJ77WI10gbU8Kp5Q==
X-Gm-Gg: ASbGncsE7gFQWmISz86TQ6Mn/3J4zipZmLhyd3yFyHD9StUMCpMs2/95PNZImqHNL38
	VpCMosl7jzWB3n9BdPRkkT7RE/0yS/+T5ej1BFAuNYc0FgaFQUn+2MhRWNElKoGYpZptTzs9MGN
	krsuxR+RmouBH1u2dIq9u7IRS7J/AawKpvTOWdRXIiVPYoLSdupCdrKNN0wT61O67NxZEH7icxy
	r6iBi1XVvsxmnzWweqRYjIXOB8YRZ9+4e5QeEsQKSD/GKaPZp2WJBwge5kiEy2dhtFxIRqFQTeX
	Syd9TvzW8Y3kWhwyIA==
X-Google-Smtp-Source: AGHT+IFNixYKjoLnJqH323AyrsTEoDvRF2ugn1rI/mmb0i5ScQXnNIFTHq2Er0DrsAsDpn74uL01br5L9UmGuFUIpM0=
X-Received: by 2002:a05:6e02:2701:b0:433:377:abd with SMTP id
 e9e14a558f8ab-4330d1c8c26mr194809215ab.22.1762204948334; Mon, 03 Nov 2025
 13:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB95QARfqSUNJCCgyPcTPu0-hk10e-sOVVMrnpKd6OdV_PHrGA@mail.gmail.com>
 <20251026211334.GA1659905@ax162> <CAB95QASG1pZJT7HyqxM90_FExhSVjoHmPqYHeQWXnrAzCNErmA@mail.gmail.com>
 <CAB95QARmr9b-jVdgDLpA4Qq=3WN7CYS46YEH4Ok4gpSdZHpq5A@mail.gmail.com>
 <20251028174541.GA1548965@ax162> <CAB95QARtzDWensRzui3d-7+jhymcFBOBi78ev9LMy=ZFJMDCTA@mail.gmail.com>
 <20251031220732.GA2254630@ax162> <CAMj1kXF2kKyEOc6KSBfbdUMf5m4o=DLZXk4++C3q-utA_9g4DA@mail.gmail.com>
In-Reply-To: <CAMj1kXF2kKyEOc6KSBfbdUMf5m4o=DLZXk4++C3q-utA_9g4DA@mail.gmail.com>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Mon, 3 Nov 2025 22:22:16 +0100
X-Gm-Features: AWmQ_bk0dpU7PhYOJirlksCIv-nx_HbB1gVQh-PAcie412xHSU9WGYGYvI7q3YY
Message-ID: <CAB95QARrcOc6h9=YTzLKkNE0dEaivtiLfK0kEQ1jNp+v1w4yzA@mail.gmail.com>
Subject: Re: Can't boot kernel 6.17.4+ via rEFInd
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ard and Nathan,

On Mon, 3 Nov 2025 at 16:00, Ard Biesheuvel <ardb@kernel.org> wrote:
> Eugene, can you try whether the image can be loaded by the EFI shell
> directly? You may have to rename the file and give it a .efi
> extension, but otherwise, you should be able to boot it using

Did that with the kernel file and it loaded up until the non syncing
VFS error, but I suppose that is enough to state that the firmware can
boot the kernel image which rEFInd is unable to, and I should look for
answers with rEFInd author?

Cheers,
Eugene

