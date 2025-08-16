Return-Path: <linux-kernel+bounces-771621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D00B28999
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0B71C86E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3441482E7;
	Sat, 16 Aug 2025 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnNX8cE6"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF41311AC;
	Sat, 16 Aug 2025 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755307714; cv=none; b=PrtUi2svk1ze783bwNrBVwJMGk3nYewTQAtMLwS1S/2HXpIxA0pY7qCma/kolR7mRh9quN5i/JKIS2pXxI9M8ajUkEwSpXvOr34KFEs0c2P1z/cKL29QQAVskgrjNPkcixlg0+AQQWEPdHb9olir1Ma2pU/VEmMZZtDfwRM3LiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755307714; c=relaxed/simple;
	bh=cL68yKgFih+YoDzXuN2geWynULDzFGUjryO4X7D/qn0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Bh1wuWAfHXXk3WDF6IRamfwFlrJ7tIbX9OBq4AV7rMR1XVEcqMjtvshfbY4iyTNUudvI3TGdSiHMpgTUaP52hbKwx1xYkyI1GFl0qg2WaCSYHUns04o3ATSPegLL1lOmB6LummUbrpNEjJI/IVANNMisXLP+/5NJIxt+9JcJLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnNX8cE6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso1756422a12.0;
        Fri, 15 Aug 2025 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755307711; x=1755912511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcLbTgkOJ/gVwg1vh3eVTe4SEaylBKg4H4V6ioMpdtQ=;
        b=JnNX8cE6hbJXRUOkGhoA0Tpqb1dgc2Mkp29J5TX6/e/ncKvj3oTBxpSRbI5bHTCpVe
         kdiUOY9dzFnDJpDKx46LxyWVPSlfKGmVB6bcLTtAmkRsvIk6Je5w7KRA5nBU1qO3YJXt
         g2PEOaw6NbA0aIUQ/A/UwsPEWmIOZe5RFzjpWNLe4CShU6Q6bGvzySphed7n/hZjJIdU
         gYU6goKeUTGnlr20Lk5nA7ON8llyjyUBSoeX5q+jKCkmaSBaUNRmY5YvE/hAlUlZRUHp
         4h4YsQEVLB/vOUmqpx4vfj/qtrTdc6Efb4aMutT5dQJrI8KbBj6m7pLxUtThNyVbgRVu
         N4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755307711; x=1755912511;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcLbTgkOJ/gVwg1vh3eVTe4SEaylBKg4H4V6ioMpdtQ=;
        b=CxwImTEaBkl3mqmEW/jBDZEdC9Tl9xJmMQ45Jvswv9dOG5xaPqLqYdPRU/C1suzs4E
         PyT5BILbEZ5doX6A23MxyFqNQARI49Fh+VUG78y1iIJPueLueTRF7q7jyltlsEV+8lxc
         /+FJJ3RAsohnVxECP7WOZqp+/zECjxIQgjZrPaHmUPOOzNv4hBijfog/ZeuKEjT+i5NO
         tC+l5vHQUySZSLxhkL4pDe8q1ZNljXVL5jkOXZz/XDjm31BB+sKYHA9u3jUOBQIDY9LX
         MNpK4GjBSHrfkn33KxHEux432XK5cyEX/8Shwr43O5E7+Fp+E8IJBMuPgQ3pUbKHfdES
         Aojg==
X-Forwarded-Encrypted: i=1; AJvYcCV4jL+GdieYoZ3K08Q86fg3RKAh8bkwu+k0akJFBdOHQOm1Q+cnzjjad0JQA/SAhkZ72iuIJGk+Q1IEB7rW@vger.kernel.org, AJvYcCVlqVdIA7Rr25bA+KembH5BOTNYBYfffepIhMRJ9PP5anf7C/jo6G1YKHJM6rbnU8atF7VxShsDmJ8=@vger.kernel.org, AJvYcCWZALBr7xHcbALL2dKX10tnrrBqdqE+gBb00F0bIoEsoQQOYOjbu7BThtRstLrRUR2Ce1C5+h44z4sNO0tQNiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAvGbe93TJCkErEQ7Bc4o6U2oPjxGGzt7Yg/MQrhcBY/uy4DgU
	nd7ZaSvwucCE765Wp4zAFmn9BVuughNC5UCRf2kzU18ppdCzS6fP+w/h
X-Gm-Gg: ASbGncsYebFp9Nz3Mi83SV5WbqCIw2/JPRBeEMz7bsORxtZCSsU4xecgIuhyVN8Odte
	nrvIvUVqBLC+XmmnWhiqq8LmMOXWOXZH1y2nePQLqLB44Eq7zEKcW32hW8+cJSu9FbTYKLVl9rc
	GAz1eWCSTn4ev4s8uRkeUcuQQg/DD8sKbIO5XU28URzrn57kjVq0+7OjqXhQDSU1IDSn4SUV95K
	/FlcMsvNyyqm75UCSMuWW9p+bwqY36n5flqxYc6vLr8Csaq8otSnWL5/2h8NYA4dGJ0Ddp7Slg2
	S//97CLdw2vkHTV+EAnVS4rMCAIh9RV0XrDD46nfygOXQGHV+dvIk2GR+xPNQ6mFCk6lrpRKLWS
	rfYN13hjEYvG8T+i/GJnEn2au81hc8nhzDN6YrnV5PzeZymZq4tSXRQwD1U0UWCBSnHM2
X-Google-Smtp-Source: AGHT+IFmuoEaAgmc+b55KXKn0mWdwufV7rUOybmN9i6VMPi1iQ0K4+L67TRNxK1sXLqxq/P0faU7dg==
X-Received: by 2002:a17:903:1a43:b0:240:41a3:8e0d with SMTP id d9443c01a7336-2446d8b51f4mr49260615ad.36.1755307710724;
        Fri, 15 Aug 2025 18:28:30 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5a7a40sm2354708a12.9.2025.08.15.18.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 18:28:30 -0700 (PDT)
Message-ID: <9b3b0430-066f-486e-89cc-00e6f1f3b096@gmail.com>
Date: Sat, 16 Aug 2025 10:16:01 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mchehab+huawei@kernel.org
Cc: alex.gaynor@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, corbet@lwn.net, gary@garyguo.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 Akira Yokosawa <akiyks@gmail.com>
References: <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for
 sphinx-build
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mauro,

On Fri, 15 Aug 2025 13:50:32 +0200, Mauro Carvalho Chehab wrote:
> There are too much magic inside docs Makefile to properly run
> sphinx-build. Create an ancillary script that contains all
> kernel-related sphinx-build call logic currently at Makefile.
> 
> Such script is designed to work both as an standalone command
> and as part of a Makefile. As such, it properly handles POSIX
> jobserver used by GNU make.
> 
> It should be noticed that, when running the script alone,
> it will only take care of sphinx-build and cleandocs target.
> As such:
> 
> - it won't run "make rustdoc";
> - no extra checks.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .pylintrc                    |   2 +-
>  scripts/sphinx-build-wrapper | 627 +++++++++++++++++++++++++++++++++++
>  2 files changed, 628 insertions(+), 1 deletion(-)
>  create mode 100755 scripts/sphinx-build-wrapper
> 

[...]

> diff --git a/scripts/sphinx-build-wrapper b/scripts/sphinx-build-wrapper
> new file mode 100755
> index 000000000000..5c728956b53c
> --- /dev/null
> +++ b/scripts/sphinx-build-wrapper
> @@ -0,0 +1,627 @@

[...]

> +    def handle_pdf(self, output_dirs):
> +        """
> +        Extra steps for PDF output.
> +
> +        As PDF is handled via a LaTeX output, after building the .tex file,
> +        a new build is needed to create the PDF output from the latex
> +        directory.
> +        """
> +        builds = {}
> +        max_len = 0
> +
> +        for from_dir in output_dirs:
> +            pdf_dir = os.path.join(from_dir, "../pdf")
> +            os.makedirs(pdf_dir, exist_ok=True)
> +
> +            if self.latexmk_cmd:
> +                latex_cmd = [self.latexmk_cmd, f"-{self.pdflatex}"]
> +            else:
> +                latex_cmd = [self.pdflatex]
> +
> +            latex_cmd.extend(shlex.split(self.latexopts))
> +
> +            tex_suffix = ".tex"
> +
> +            # Process each .tex file
> +            has_tex = False
> +            build_failed = False
> +            with os.scandir(from_dir) as it:
> +                for entry in it:
> +                    if not entry.name.endswith(tex_suffix):
> +                        continue
> +
> +                    name = entry.name[:-len(tex_suffix)]
> +                    has_tex = True
> +
> +                    try:
> +                        subprocess.run(latex_cmd + [entry.path],
> +                                       cwd=from_dir, check=True)

So, runs of latexmk (or xelatex) would be serialized, wouldn't they?
That would be a *huge* performance regression when I say:

    "make -j10 -O pdfdocs"

Current Makefile delegates .tex --> .pdf part of pdfdocs to sub make
of .../output/Makefile, which is generated on-the-fly by Sphinx's
latex builder.  That "-j10 -O" flag is passed to the sub make.

Another issue is that you are not deny-listing variable Noto CJK
fonts for latexmk/xelatex.  So this version of wrapper won't be able
to build translations.pdf if you have such variable fonts installed.
That failuer is not caught by your ad-hoc logic below.

> +                    except subprocess.CalledProcessError:
> +                        # LaTeX PDF error code is almost useless: it returns
> +                        # error codes even when build succeeds but has warnings.
> +                        pass
> +
> +                    # Instead of checking errors, let's do the next best thing:
> +                    # check if the PDF file was actually created.

I've seen cases where a corrupt .pdf file is left after premature crashes
of xdvipdfmx.  So, checking .pdf is not good enough for determining
success/failure.

One way to see if a .pdf file is properly formatted would be to run
"pdffonts" against the resulting .pdf.

For example, if I run "pdffonts translations.pdf" against the corrupted
one, I get:

   Syntax Error: Couldn't find trailer dictionary
   Syntax Error: Couldn't find trailer dictionary
   Syntax Error: Couldn't read xref table

, with the exit code of 1.
Against a successfully built translations.pdf, I get something like:

name                                 type              encoding         emb sub uni object ID
------------------------------------ ----------------- ---------------- --- --- --- ---------
JPRCQB+DejaVuSans-Bold               CID TrueType      Identity-H       yes yes yes      4  0
QFNXFP+DejaVuSerif-Bold              CID TrueType      Identity-H       yes yes yes     13  0
NMFBZR+NotoSerifCJKjp-Bold-Identity-H CID Type 0C       Identity-H       yes yes yes     15  0
WYMCYC+NotoSansCJKjp-Black-Identity-H CID Type 0C       Identity-H       yes yes yes     32  0
[...]

So I have to say this version of your wrapper does not look quite
ready to replace what you call "too much magic inside docs Makefile".

Regards,
Akira


