Return-Path: <linux-kernel+bounces-800514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20AB4389D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D500A4E4A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDAC2E2F15;
	Thu,  4 Sep 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1bqekUM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FD23BCFD;
	Thu,  4 Sep 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981441; cv=none; b=OGIeukjufPiLwSO9OfJO1p+/OxnWUa3lqKR75JKrjrBIY44rxbRj8pbZgtne+JtBDwwwOEPT/4rJvWPJjflBOkRGuFNZI6+6eMdz1yVlKIESauwNP/6ZpHfrRZEHZgbR6uGyjrY1812q/1yr58Kt2mCCRMOaUmgc0s+8x2l9JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981441; c=relaxed/simple;
	bh=oqcJdUzjWVytxfl4o26Hn7EYZkfW+FE1vLeg2GgGVyg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LBp/FfIRnGId6k1jxgMmKWwDgcy+UTmcjbuQ2Lall5pYxT2mPVLkJ/ieWtsls+kC9oN49invjiMKUBsu/bbvoPhyE96spuZ+AKj5YLvhMgtO87iqpKpkf/u7Bpb7iOpTQIgNP+6eth4wrvwY6+Qq6P7N/5H9aQRbh+yrzVrcWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1bqekUM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24b2de2e427so6777035ad.2;
        Thu, 04 Sep 2025 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756981439; x=1757586239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zC59V6HQwu3oJrxfHjdgBJ2cusgaLQ1faYOyeuXRQXk=;
        b=Y1bqekUM7e6iLuJ0LlDgCBx9q0OYd1C4O7NKk0Woz2qxmKQBGnrbMM9D5e40LKm8gi
         JGPkNxKcAvEx+MRciHsCwhHU+F9w6mF+IM1h1a2oAMZ//0aQOWzBojnENr17XVsOSB62
         /QpmaSAKAdM0Xmz0wh2k1jLgmF/XU6WQc0+e1I2TkqGM+CGfz+/no0HZdn3TchXb2rRf
         i+pKDW9c0nsD79EM9NvxmlmhbXhgPkRxg0NK7A1TBJiNc/UjR4L0rcsSi3oKGYZWd5oA
         kabC/iMmqJEamhbEx+kLGmni/OT7SoP7P8GISbshINw7AYQH5u5OOrZRqvYGExDuF1xt
         1QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981439; x=1757586239;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC59V6HQwu3oJrxfHjdgBJ2cusgaLQ1faYOyeuXRQXk=;
        b=nRF3fAdhP9U4IYjriQe8+5RtaaCMtpowujc2VGaTkgD6PZ+pfW+dBKQlnACwlM2wwu
         Jw56sg+4WnZqd+KrcCB6kAotdq2vsTA4l+UwzbFBj/f7oqUnO9kVuzlcme9pgE0taza3
         3G6tlTWejjtyWL2xgVUzKkq6ZiOqeXjdAl2Pg9LVrKDqA//T9iHgf2IvzYG0VYPg0Bgy
         vMYUopHNg3e+iHf/VZWkZ3bE5J1ySOPWHI50x/kyhCW0LOL6lAPqizJVcGVQzfbQX3eX
         BOGxSqYSPyBYAwMFyl2fV5h9Lvuv8Kb7IYZtGM8tJZDIoq7CWNCfmlzal8SNcUtOl33g
         xsJA==
X-Forwarded-Encrypted: i=1; AJvYcCV5dHOmO/igYgIvGmMPrkWyocrDZkT/d3qgkB17+7/y9YYNmldZ2AP13Md04R2yp4j3Az9dXMj352Y=@vger.kernel.org, AJvYcCX8Hn2/MvwnZ4GKHm8oixgucd6zIBwFDGU/L9qDv+YcPHJSdmcWDunpYGJpNpX76mRmc8YcOlkY1XgajRTv@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVzdCMXmQVluqNZPGdn/puQ8hx+6/Wwy/jDcodBpCv/ZvL3Fr
	W/iWYkroHmSPWZOXMD9WLnyb5Hu1tCggcPLHAyGjNdauPwO7yAilb2Oz6/C4RQ==
X-Gm-Gg: ASbGncugMo25uHNH5OabmSpGxBymHtc+Pksqb8sZ5PEr+xwrB2Jydm6pLOdWhTyFvLW
	LrxJ75Kbg91ARE9W3XmhVZYPZ80VHnLQuv4E/grE7ixqZ5ujrRSp/3DR6OLuAs5tw31Oz1xZa7s
	h1Xv8ghELgiqGdBePcKIoH1FEP4yx6w7vzo3vAVGdTH/wCzpQgaRlIJXJUwGLsRPvpRc9jbEYQV
	KugsRkyvZYM+QSlxtKQT5XwFvHxNgq+GJY1JOoLuq4+TN8FvukykeBbnO1aUYycbycu5ziJQiCB
	UkdQiDIu74pL/GJ09NEGTuykjDBxXLFi1ahsTGlOcnM0Wf4i1SnKgabycd8aFobvonfdXpidjSF
	UBh7SUvBMsNkV26YrXYiXbhcz52DK9Cb5g+sSTiBksU8Os62HLaGgmzNc8KOLFnAEhP4h
X-Google-Smtp-Source: AGHT+IHW8eUTuiCA8KiCFF9W2lPToTBpwvRaHYK/P/Je78WOxoz7bw6wYnHzIORvo9/nsQ3CX9/Lrg==
X-Received: by 2002:a17:903:1a84:b0:24c:bc02:78a4 with SMTP id d9443c01a7336-24cbc029226mr37720885ad.24.1756981439174;
        Thu, 04 Sep 2025 03:23:59 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm81022525ad.115.2025.09.04.03.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 03:23:58 -0700 (PDT)
Message-ID: <1fc5a9fe-3459-4303-a6c4-5cf51d2e49a6@gmail.com>
Date: Thu, 4 Sep 2025 19:23:56 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs: ja_JP: Update SubmittingPatches for 'Fixes:' tag
To: akito5623@gmail.com
Cc: akiyks@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903113552.2010371-1-akito5623@gmail.com>
Content-Language: en-US
In-Reply-To: <20250903113552.2010371-1-akito5623@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Kurita-san,

On Wed,  3 Sep 2025 20:35:04 +0900, kurita <akito5623@gmail.com> wrote:
> The Japanese translation of SubmittingPatches is based on an old
> kernel version (2.6.39) and is missing several new sections.
> 
> This patch adds the missing description for the 'Fixes:' tag to
> bring the document more in line with the current English original
> (Documentation/process/submitting-patches.rst).

Assuming this is the first patch you submitted, I'd like to show you
some background.

In 2022, I did some catch-up work for SubmittingPatches in the hopes
of working with another Japanese-speaker.  Unfortunately, I gave up after
he had moved on to other activities.

howto.rst had a couple of updates worked on at the time.

Please see commits:

    6548e96edb50 ("docs/trans/ja_JP/howto: Don't mention specific kernel versions")
    dc8ab0298028 ("docs/ja_JP/howto: Update for v6.1")

, and/or email threads in the lore archive:

    https://lore.kernel.org/20220501102256.6379-1-fujimotokosuke0@gmail.com/
    https://lore.kernel.org/20221030115209.25924-1-akiyks@gmail.com/

If you think it is worthwhile to spend your time in updating the translation,
please feel free to do so.  I'd be glad to play a reviewer's role.

Comments on this particular patch follow (for your future contributions):

> 
> Signed-off-by:Akiyoshi kurita <akito5623@gmail.com>

Malformed "Signed-off-by".

Also, please set up your Git config so that git-send-email uses
a proper From: field.

This mail has:

    From: kurita <akito5623@gmail.com>

, which does not match your sign off.

Both of them would have been pointed out by ./scripts/checkpatch.pl.

> ---
>  Documentation/translations/ja_JP/SubmittingPatches | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
> index 5334db471744..053468a20841 100644
> --- a/Documentation/translations/ja_JP/SubmittingPatches
> +++ b/Documentation/translations/ja_JP/SubmittingPatches
> @@ -465,6 +465,10 @@ Suggested-by: タグは、パッチのアイデアがその人からの提案に
>  クレジットしていけば、望むらくはその人たちが将来別の機会に再度力を貸す気に
>  なってくれるかもしれません。
>  
> +パッチが特定のコミットのバグを修正するものである場合、
> +（例えば、``git bisect`` を使用して問題を発見した場合など）、
> +SHA-1 ID の最初の 12 文字以上と 1 行の要約を含む「Fixes:」タグを使用してください。
> +

This doesn't look like the right position in the translation.

I see it comes from commit 8401aa1f5997 ("Documentation/SubmittingPatches:
describe the Fixes: tag"). Quoting relevant hunk below:

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 2a8e89e13e45..7e9abb8a276b 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -132,6 +132,20 @@ Example:
>         platform_set_drvdata(), but left the variable "dev" unused,
>         delete it.
>  
> +If your patch fixes a bug in a specific commit, e.g. you found an issue using
> +git-bisect, please use the 'Fixes:' tag with the first 12 characters of the
> +SHA-1 ID, and the one line summary.
> +Example:
> +
> +       Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
> +
> +The following git-config settings can be used to add a pretty format for
> +outputting the above style in the git log or git show commands
> +
> +       [core]
> +               abbrev = 12
> +       [pretty]
> +               fixes = Fixes: %h (\"%s\")

If you'd like to pursue this route, I'd like you to cover all the changes
made in the commit and mention it in the changelog.

Thanks,
Akira


