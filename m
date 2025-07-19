Return-Path: <linux-kernel+bounces-737762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF0B0B045
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F67A61BD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4572874EB;
	Sat, 19 Jul 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="I7cnITWw"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120DB235345
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752931797; cv=none; b=bDUJOSy7hmQ38lMtj5z5XHjWIVRnaeOYohV5JVKuKrelGuk4Ptl3F8pPq1jykR9hbT3Mk4If20JMZxkBRkCoCmIUTlsIkWAucVYfJuMNwvP+yL2Nft3nvEN1bZp4eEBqlDeqEBf2ymH65FexuhDb8iJER+t75kITA9tXvmRTiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752931797; c=relaxed/simple;
	bh=whJVn6VSMC2cD2DwHewKa7SpgnwQzzGtDP72KQTJahM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAstUco21MsfkspmruBgW24Wr8mpf1G+NmiVkdoih/0z+/r6oDkvaLOZP1nuBAuH8p0qAhAXGs/W+Og3R3sPQpfUm8GD5oevzeWHil1BV0cJfGraV8PUA6x+gH9/CMkDufVPSEcwJ6NjkWx2ko3HyvERUJcWVnw8Me7ZIKfUVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=I7cnITWw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso2288838a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1752931794; x=1753536594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZOOflxBKdTH5b7sIlGbxa3QYBsytIH9IOezkOXa6OE=;
        b=I7cnITWwD3XHvsOets6aUl0LdkqNK2GUJcSTFRuDUJ1uS3fx74Qx64dEyANyEwHfD8
         AdtWde5dWb8tXSwxteV1Uz3z8zxlDdCmR5rTHk0nuVNYBuQwDb4DdOtrgGMyQLF22zKT
         QDltqkliKID0aAbzckRzQeP7QnbcVtRArOdo24GXZbtPfRJRWdY4QdnquP0QZPN0UjXB
         JVGFsXJexGzrSHpoxtiFVoadVR0Rfjb+LOU8240ihj2mxZkQ3JK5z0EOSyftQmz1JxW+
         AkaelU+vBkX5qkYQxxZl88hYJCizHkz6eHIPkkZzISrH+lALhgjYhQlWQslUTs94jAD2
         7RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752931794; x=1753536594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZOOflxBKdTH5b7sIlGbxa3QYBsytIH9IOezkOXa6OE=;
        b=DaelYS797xyDzwDwksTr9VW+97kN++cmLChea+36zzL/IfyXbX6hdOzewciR1pTkKh
         JF0EN10/hocahSK2tZ0qeYZzq0ytJBe+jrkKdkq3BjnzF5vS1/lFSUe6F0kWAME8xKcV
         Y68DpnTWhlTdB6iwwMt105jrPP/zIY4NOALillYJu02Rf3YVq1g+YPSeRixmd0DmZsYl
         pI6VBwccDg15N5Dmn0qa0+pMEnbbhzwI2ST1i7/zJoGKDCxTaqpO9/bp0tTtwZFjc2Da
         f37BBbVxMNzAvMlscOZ23oKwXP2/ufb6vxoKrqcxXAR4ql3s/kuX/GgEDjrEtG9x9Ril
         rcrg==
X-Forwarded-Encrypted: i=1; AJvYcCWbROEfQzGsW0f9l1ez8kskPuHeMfbWo4zoZWtWF/pSzPMs5D3DGddK3uPEhARu0ZcKL/7QujNHcsHc+vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYV9PaX7CPeKUf8vazOTXd85hVtl7XwBtok4zWyR9RFls89lF
	IhNKfMnUhvg1OJWQ5qJdvmAHxGnwsAQkYORjUmmanZwuiiucMtYij+sxNN1DiGl38EZnRv6LNl4
	JrftB6sLEBxFmdBdN0q0H+1ei+CnPRWwT6CRVQ+yy4weWpWeRVYj3Dw==
X-Gm-Gg: ASbGncujkG67LYXKuJu+AXoRjJ/j1tWAJcoY+nYc14IBAIHzBSQ3cY8Zv1Eems4EUYT
	k77GdmJ32Op7GpbVCOabo6WELAZPbMDrE1FZHHR4ja0Nt4o+rVrtsGapDVhpVVMBxjNAIE/v4NX
	kk77Er1zxAOVPcpWlz3qRJ/qIdIU84U6W7WKzRqgBlqgOmbjEL6e7YooMDwE0ZF8ING0laqad9m
	atd2i2bsPxov4Bt3sf+xZWWOoWUxw==
X-Google-Smtp-Source: AGHT+IGTMsKtP2G3Wisl71duPg2R8F8xhT5SbykvwIvTBfZDhFArqc4cu/N0+DDO+BgZ49g18kmBZYIKUOKMHB/tIAs=
X-Received: by 2002:a17:90b:3d8c:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-31c9e5fcacfmr22074724a91.0.1752931794326; Sat, 19 Jul 2025
 06:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c4eef67-7bbc-4a4d-ba10-ccf30c6afcdb@sabinyo.mountain>
In-Reply-To: <7c4eef67-7bbc-4a4d-ba10-ccf30c6afcdb@sabinyo.mountain>
From: Mike Marshall <hubcap@omnibond.com>
Date: Sat, 19 Jul 2025 09:29:43 -0400
X-Gm-Features: Ac12FXwk323ZxD0gV07N4nak0N32Rmf-A61cgZKPwrhzUMCykchXRr8i91VBpZ4
Message-ID: <CAOg9mSSnnLf_uoM1pQp4yMjd4e=q07PjBWw62ch3P+V1c--+Dw@mail.gmail.com>
Subject: Re: [PATCH next] fs/orangefs: Use scnprintf() instead of snprintf()
To: Dan Carpenter <dan.carpenter@linaro.org>, Mike Marshall <hubcap@omnibond.com>
Cc: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>, Martin Brandenburg <martin@omnibond.com>, 
	devel@lists.orangefs.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. I noticed the "returns the number of bytes
which *would* have been copied" issue when I read the
snprintf man page while looking at the patch. I'll see
about making this change in my "next" before the
rc period is over...

Also, while looking at this patch, I made
an xfstest that includes buffer overflow attempts
and other bogus input. It would be, of course,
an orangefs specific xfstest... I wonder if I
should try to get it pulled into the main xfstests
repo?

-Mike

On Fri, Jul 18, 2025 at 5:24=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> We recently changed this code from using sprintf() to using snprintf()
> as a kernel hardening measure.  However, that's still not ideal.  The
> snprintf() function returns the number of bytes which *would* have been
> copied if we had enough space while the snprintf() function returns the
> number of bytes which are *actually* copied.
>
> So if there were an overflow, the conversion to snprintf() would prevent
> memory corruption but it would still leave an information leak where we
> would read beyond the end of "buf".  Use scnprintf() to fix both the
> write overflow and the read overflow.
>
> Fixes: fc08e0b8f099 ("fs/orangefs: use snprintf() instead of sprintf()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/orangefs/orangefs-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugf=
s.c
> index a5fad515815e..e463d3c73533 100644
> --- a/fs/orangefs/orangefs-debugfs.c
> +++ b/fs/orangefs/orangefs-debugfs.c
> @@ -396,7 +396,7 @@ static ssize_t orangefs_debug_read(struct file *file,
>                 goto out;
>
>         mutex_lock(&orangefs_debug_lock);
> -       sprintf_ret =3D snprintf(buf, ORANGEFS_MAX_DEBUG_STRING_LEN, "%s"=
, (char *)file->private_data);
> +       sprintf_ret =3D scnprintf(buf, ORANGEFS_MAX_DEBUG_STRING_LEN, "%s=
", (char *)file->private_data);
>         mutex_unlock(&orangefs_debug_lock);
>
>         read_ret =3D simple_read_from_buffer(ubuf, count, ppos, buf, spri=
ntf_ret);
> --
> 2.47.2
>

