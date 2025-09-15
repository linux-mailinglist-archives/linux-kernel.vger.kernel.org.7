Return-Path: <linux-kernel+bounces-816363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8590B572D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3553B3BA9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA642ECE9B;
	Mon, 15 Sep 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7wnF/ts"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463102EBBB9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924842; cv=none; b=MxDQvOSKLiGkKvl60zh/CK/pQ9kq1S5tl06PvaTJFiFrn7F7LcV3EVY7+VPZaa3wqG/C/lgxaDYso3yCu5T986Pj4sKXJk+T0YiODk5DKrYewkTJpmFOj0LuDvJhFsFD2SpUxNGuYfn4s2hopDZTobH9ZqGNVTxNgvkjnf7JTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924842; c=relaxed/simple;
	bh=B5bFwfP2bCr2x5sdWdzgv78M8aq/SuMaso7S0SGdj6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K4d5d25FfoRt3lbj2J/Umroufv5sZEf67Tg6cfO6k4tWKJAb/Uj3KNtpJAJe4Y3zPoFUftjY4UVlzFMR8HqI/nlt6uU2+meFOuX7P4erOJKuCPM4quSfZ7fYmovK1iEdcDO9oyjES2VsAbJd+JlzOw8Svt8T/nGymJP3Gfiv6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7wnF/ts; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77786498b5fso711830b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757924841; x=1758529641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yC5si6Jajc8mcwRGIVQgOpJhXHjTKqr28jgzyeIoy8U=;
        b=H7wnF/tsLwga0mF2+aNGNuGWJinlHyDpIBQcaUxoD6PUWdovKZzri8gmzFthPWDsCM
         i2Nnn/YEBifI0OvR3s2WHjtlV7/AOm1CZiLhs4inwqibLJ/akMhz+vQfsJPhuHETn4Gs
         VkNX+oNfbN1ARkPkhHtrRqaoOWEIHBL6IOw/daJ8pdnAdpEfvAbV4/umyHC5AiNumJyC
         96uCu3PmB5Aie15K9GGN9c2QOkCl4i9j0NJkZKevRZGcRtjsb2oJiBBaMQK1q45HfP84
         V/qo61AW8F+ksy44uo26KWioCff3foILAlgjqYfQe2COoKYF0zmruDm8FDNr6S8fasFA
         29fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757924841; x=1758529641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yC5si6Jajc8mcwRGIVQgOpJhXHjTKqr28jgzyeIoy8U=;
        b=gC7F7nVkFve611nKkyHhJjifvWztlVnlqBG6ReHR8dO/mkcs0HnMrV46jvjkux2Oph
         /ZftGPK6UUBkje37VAETix9o6VBRiTm0z5eR+Pqf7MESwZM/DM+4Fi8fcVWO+JxO9wBX
         4yP3+yK63MnS6mEaK4vteAgX1xe1IXnV2Pf25aw3HsfzqeccOmuMx65U8mo0EjzU9WoG
         7Dov5bujLajamk9dhPvlqtWlg7qON03oyumr3FIvIwTx5ADkkeKNX5YHFAD3fBksZ8I2
         BrZBhgAs6nUOD9qW4PR1NBMoWKRRwj/CAfaKjKNHFb0YJiran/0wFGFHHXrCYro7VxU/
         +Gew==
X-Forwarded-Encrypted: i=1; AJvYcCXc3+TJ7j90ha3hOyaRgIOK29R0C1ElP/cHXlSq8k70uHSwaU0OcV6ORTBTp3ZmSyoRjxMWkO7o4nOlEME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxjX5P+vmoNo6epDSfVoqgmAje3BVE3ShFxf6PBJI3NeBBOl6s
	P5Noce3tW8fqOK65n+ZC9+Sg52AH9IOOksw6pe5BGWrpLbx7CA805kv+
X-Gm-Gg: ASbGncsFIUTj7+TSQI7t2sqQRg2kbsaAZJMI5hx1cCvGn4LlEaM3QO2I2Lzj5SXpBIV
	axLo3cUE8fE+M7LhAERJti4PTw32uBrhQnJBU1Elg//JJDlrSt5HggkcVdpX1n6A6ekjDoXC6li
	6vpS7qa9ELPhZlK2TVeKyAtasxeUS2XfBjZMV2o6TE3+hxoyBiOFWonif4qShfxc7QsE4+qA/3b
	iXZdL+7S6/eocKcuj4kvaAhgSzq1crXhIieCjlCWbQr3kBFmN8zfxhkRtUJYiWGnvkZXw73A6UM
	WpRyn4fD82+wEPrInOX4cLMdUnnSjvCGif+xZFKnSmU7lAAJkp4YRx7IBotsvhCbFBLaJWJEjI5
	FpkJGJNVPxnUwj9GF/nuEOJ0fqQb/HBp1SgmeB7L8Xu6SnOGMyvIW6ng9hur0wS6hHUQb
X-Google-Smtp-Source: AGHT+IGqg7ALC5A0bR8uakJgM3cdHBTYC+r3Djn6vd3EUgDlFtDywvAtxdkq7jMOtcsrZ2AgxgVp6g==
X-Received: by 2002:a05:6a00:1818:b0:76e:885a:c32c with SMTP id d2e1a72fcca58-776121959fbmr12367055b3a.26.1757924840480;
        Mon, 15 Sep 2025 01:27:20 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1a3fesm12749032b3a.56.2025.09.15.01.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:27:20 -0700 (PDT)
Message-ID: <aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
Date: Mon, 15 Sep 2025 17:27:17 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, jani.nikula@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, tmgross@umich.edu,
 Akira Yokosawa <akiyks@gmail.com>
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
 <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
 <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
Content-Language: en-US
In-Reply-To: <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 16:50:36 +0200, Mauro Carvalho Chehab wrote:
> On Fri, Sep 12, 2025 at 11:03:43PM +0900, Akira Yokosawa wrote:
>> On Fri, 12 Sep 2025 13:04:20 +0200, Mauro Carvalho Chehab wrote:
[...]

>>> I saw it here on multiple distros including Fedora (which is the one
>>> I use on my desktop). Media jenkins CI running on Debian always suffered
>>> from such issues, up to the point I started ignoring pdf build results.
>>>
>>
>> So please provide exact steps for me to see such errors.
>
> Sorry, but I don't have enough time to try reproducing it again
> (plus, I'm ran out of disk space on my /var partition forcing me to
> reclaim the space used by my test containers).

There is no urgency on my side.  Please take your time.

>
>>
>> I don't have any issues after strictly following the suggestions from
>> sphinx-pre-install under Fedora.
>>
>> I even invoked [...]/output/latex/Makefile manually after running
>> "make latexdocs" by:
>>
>>   - cd [...]/output/latex/
>>   - make PDFLATEX="latexmk -xelatex" LATEXOPTS="-interaction=batchmode -no-shell-escape" -j6 -O all
>>
>> , and all the PDFs were built without any issues.
>>
>> Quite puzzling ...
>>
>> Or does your Fedora have some Noto CJK variable fonts installed?
>
> On my main desktop, yes, that's the case: it currently has some
> Noto CJK fonts installed. I wasn't aware about such issues
> with Fedora until today, when I noticed your check script.
>

Good. That should be a step forward, I guess.

I know you have repeatedly said it is not the purpose of this series
to fix those issues in your images, but I have an impression that it is
closely related to testing sphinx-pre-install, and the objective of this
series is to make the testing/debugging of sphinx-pre-install easier for
you.

But, at least for me, the behavior you want for "pdfdocs" is not
ideal for regular testing of .rst and kernel-doc changes in kernel
source side.  I want "make pdfdocs" to give up earlier rather than later.
It should leave relevant info near the bottom of terminal log.

Now, here are my responses to your arguments:

> In any case, this changeset fix it on several ways:
> 
> - A failure while building one pdf doesn't prevent building other
>   files. With make, it may stop before building them all (if we drop
>   the "|| exit");

Didn't you mean "(if we keep the "|| exit"); ???

If you drop the "|| exit", which will cause false-negatives.

And you are going to test every PDFs at the final stage of pdfdocs
to catch such false-positives.

Sounds like a plan.

> - It prints a summary reporting what PDF files were actually built,
>   so it is easy for the developer to know what broke (and it is
>   also easily parsed by a CI);
> - The return code is zero only if all docs were built.

I agree this is an improvement, but if we get rid of the loop construct
in the Makefile, we can forget about said false-negatives, can't we? 


How about something like the following approach?

Let's think of SPHINXDIRS="admin-guide core-api driver-api userspace-api"

In this case "make latexdocs" will generate

    output/admin-guide/latex/
    output/core-api/latex/
    output/driver-api/latex/
    output/userspace-api/latex/

They will have identical boiler-plate files latex builder would emit,
and subdir-specific files such as:

    output/admin-guide/latex/admin-guide.tex
                             c3-isp.dot
                             c3-isp.pdf
                             c3-isp.svg
                             conn-states-8.dot
                             conn-states-8.pdf
                             conn-states-8.svg
                             disk-states-8.dot
                             disk-states-8.pdf
                             disk-states-8.svg
                             ...
    output/core-api/latex/core-api.tex
    output/driver-api/latex/driver-api.tex
                            DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.dot
                            DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf
                            DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.svg
                            DOT-289c17ebc0291f90ccaf431961707504464a78d4.dot
                            DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf
                            DOT-289c17ebc0291f90ccaf431961707504464a78d4.svg
                            ...
    output/userspace-api/latex/userspace-api.tex
                               DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.dot
                               DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf
                               DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.svg
                               DOT-289c17ebc0291f90ccaf431961707504464a78d4.dot
                               DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf
                               DOT-289c17ebc0291f90ccaf431961707504464a78d4.svg
                               ...
                          

At a pre-processing stage of pdfdocs, you create output/latex/ and
symlink subdir-specific files needed for latexmk/xelatex into there.
(Copying them should work too.)

    output/latex/admin-guide.tex --> ../admin-guide/latex/
                 c3-isp.pdf      --> ../admin-guide/latex/
                 conn-states-8.pdf --> ../admin-guide/latex/
                 disk-states-8.pdf --> ../admin-guide/latex/
                 ...
                 core-api.tex --> ../core-api/latex/
                 driver-api.tex --> ../driver-api/latex/
                 DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf --> ../driver-api/latex/
                 DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf --> ../driver-api/latex/
                 ...
                 userspace-api.tex --> ../userspace-api/
                 DOT-1e98886fceca6e25a115532f5efebb44c09dc98b.pdf --> ../userspace-api/latex/
                 DOT-289c17ebc0291f90ccaf431961707504464a78d4.pdf --> ../userspace-api/latex/
                 ...

The latexmk stage would now be identical to the SPHINXDIRS="." case,
meaning it won't need the loop in the recipe.
Furthermore, post-processing would be almost the same as the default
case.
 
As a bonus, "make -j -O" will work as the same as full pdfdocs build.

If you are interested, I think I can prepare a PoC patch, probably
after v6.18-rc1.

If your sphinx-build-wrapper's latexdocs stage can be adjusted so that
said pre-processing of pdfdocs can be made unnecessary, that would be
even better.

Regards,
Akira

