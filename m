Return-Path: <linux-kernel+bounces-814575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D032BB555CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE6F1CC3C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B308329F31;
	Fri, 12 Sep 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xw+CDHx9"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7A31C570
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757700335; cv=none; b=aSmuwwpiqCuNgC7xztvZcWV9UlAV1NYF1i6LU6txD5rcQZE0updR+XUGk6KIajMhoaAdjBjdbvz9ew0qcdQI3X1xA/SZDMW0wwfAkrWy3OcJpQeVVdDPfV2QuN0OnkMSBnc3InnFtj6RZmvvGmvyf0G2wRyfiPLnyoJ6lprYLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757700335; c=relaxed/simple;
	bh=N/wqAgrO/zhmnFI1nBfWgzHwsyg/LF9jTsJtR4dZsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoVIa6rW/DD07A7lG4oZ45TSIfixCezGH4wr8kZOJAEwMy/iaUtt2rAXaO4F1UqW+ub43xdQsNzYCwPeAQ9VQcvUHB+sSPe+1FjEqD9/CmJ2Q5sqLyJUbC3eah/nVPbZsM1SIjDvWIKaqP4LgzbYsrnr7VdKUCBMk9ZYlNxifRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xw+CDHx9; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-417661eccb2so20174385ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757700333; x=1758305133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcFeJ72WbA74ff5cvPiISFqof9IGfX60h7xEGQwxob0=;
        b=xw+CDHx9lfX/c9sPgkJ8vT2/2jJBIOgxTKLQzE4uLHCr2+MUa91gFgUY5x+8z/KrwI
         596uQ9w0zBj48zHff6+o0dLqpYaIZzj6B08w7sToYgGWWRCHnA6ZmB/7FLeZcq0TsXMN
         Wkl4M2XQeJFmf4SGF08o3blV0AxBWTn+kYK8MhSziCwJLXfWg7rqC/PcTERSWh5OVneB
         C+8MjbbMUPjJpwX7uQHIhTnWxWaaJZeIvHcXLOl3CYSQqMuu0XjIhnx3FbmYQM3slDw0
         oQ4IKm6f+aa3c8lWSO6YdmjK43pIOxbo9W38as7kK4Dw5Y3Xc3AIYDRnDvuOBHlwSwLc
         VzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757700333; x=1758305133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcFeJ72WbA74ff5cvPiISFqof9IGfX60h7xEGQwxob0=;
        b=EXyxtAhs1uLtmEKKoIZdJmUW5OD8I6RflNzVlrb+6KFE7Vt6s3qs8Ci63J/a7Ggxb3
         ddxITfJqeEx3t9jlRoZfu3dzKFwGU08kWXcUaYpwVKo6iIpsz8c7jkXcq7Pay5rGfADx
         SBwrn3qv9gu327K3xs6ZqUA/JjQ0PvONoZNERjNLV0OVZ4ZajoV41o4N4Q9abk1H91sM
         7RWRVFHJ3rJPwoAQACF+5ilhwWgbsRZ/otUvPRM+Z7g91awyXpjUo8vnQh6T1KceOhcI
         yE8bztdON9HIP7vbfUg3BXa63ybjM4nVQRFj1kmD6JONB3ZhIFnHo3gs9xt7flu0Mk7X
         fT4w==
X-Forwarded-Encrypted: i=1; AJvYcCWWoqUiZemIJnOpUflLPkmk62UTUs6FvJXscV6d0AYELopuHIdMvB2zqlpQMeiHePQd2NKP8qN+T+tL76c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hn+Tvwx5cN1hizj8MVlCjEtzEJ1W0pg9JXJnRf130mQAH90A
	J4UVnbSmCYqBHV3THJyL7qsK1Yrc/b3aQYG/x8qQ/rX2d8kGBwG/fQM3h0j2KOEv2A==
X-Gm-Gg: ASbGncuXo5a7MrlYdXnk5uuJlRQ+aBjXUARmc/127qx9VVCnFXpF9eG6atr2ufzdytD
	l/wpJJXzLd/lXsuk+l4d3Yc/8mJJ5m29jegmaJtN6J/Dy7vsuLmsbwOpx1eM73zIjSV4zL2Dw9V
	nevyhHdb5cRwwzs0gSGD9fcG764Y3SnhnRiwYijl5DI4sWv10BMqhLQ7P78lbSTCS0193mm0vyC
	KJdTuUhwBufxv41TIEnoHPtIcoQW6sOaBnZsy+hQXnDnCcWHQTrHkESXhE4zWfTOQz4BcLvgg4d
	xxVwuJKID5S0bYfLwnl9WqgYV9jBS5bUXFuzYtIQveANFgDy096vv/GdvcEMFA1KOMRd2TDnq+6
	Uzt1/vgwS272zj1McymIkwzuy8406nxQxqdY8dAQjceSHznNnWDyykvVP9QatE1qkMcHYSUcCbg
	==
X-Google-Smtp-Source: AGHT+IGJCURFvMxoZWZd20cUZQaAwt7BOfCiB9UePZcFNpGBu6mZoPeVrn4XW3nB4SQJl2xpLBtXNA==
X-Received: by 2002:a05:6e02:e11:b0:421:bb6:fc6a with SMTP id e9e14a558f8ab-4210bc6491cmr47318185ab.2.1757700333029;
        Fri, 12 Sep 2025 11:05:33 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067bb9sm1854661173.39.2025.09.12.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:05:32 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:05:28 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Replace strcpy() with strscpy() in find_link()
Message-ID: <mv6ck735oa4ix7emkjtgt3cwrbhyizina4tady26nzx6otbvi2@ngewjjf6ahdf>
References: <20250912064724.1485947-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912064724.1485947-1-thorsten.blum@linux.dev>

Hi,

On Fri, Sep 12, 2025 at 08:47:24AM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  init/initramfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 097673b97784..6745e3fbc7ab 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -108,7 +108,7 @@ static char __init *find_link(int major, int minor, int ino,
>  	q->minor = minor;
>  	q->ino = ino;
>  	q->mode = mode;
> -	strcpy(q->name, name);
> +	strscpy(q->name, name);
>  	q->next = NULL;
>  	*p = q;
>  	hardlink_seen = true;
> -- 
> 2.51.0
> 
>

Thanks
Justin

