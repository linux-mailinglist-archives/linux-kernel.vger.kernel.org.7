Return-Path: <linux-kernel+bounces-727419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B978B019F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2730064868D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86C2877FD;
	Fri, 11 Jul 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGdyN0ZF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90625287505;
	Fri, 11 Jul 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230985; cv=none; b=UKztmf0SsyBQ+XX0LNUAgno4RGbA1JHV6zU6OhVZg253WSe7FFqSf7NW8mEcIexAyUblq+1sb0i02RbCxwqPU2WEIwcz0NnlS54gz3r8EUv/EO94u3tqvj7BwmDu+ZKRpFBqE5ppxmZoLz/IHP50dJz3FtqTWwE4JtbRoAGd6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230985; c=relaxed/simple;
	bh=ZCmp2y9vEpZVS4cIXgvF3AzXPjNLh/Vfk0rICgQmpHs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cGtXs1TJN845n2UAt3Q0VGFS97EfOK5CEExBZDOi348gt9rG+bGgQv4IL/7OTrbrl1ndaw7pEhDx0YxgSUguZQuN/ZOI+8/WWZC8UkqWMvIMZe/cTad/FHx1qrfrUxNazxL7UuCrGyggt9yyY2Q4ylF53yVesLUd2K42aPYOhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGdyN0ZF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1766687b3a.3;
        Fri, 11 Jul 2025 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752230984; x=1752835784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xGhu+6CIOA/HEtwA0o6mES1UdmqcKpfui7kGcHRlM14=;
        b=HGdyN0ZFS2fq03FWsn5pvP2uDlH4OOAMx2IoBscY02dUcGUyZ29OTgWqG/1/gblPEQ
         /DpM+g7PKh8TU4C/6BitYQdZ0yHYt1ZVEhN8IGJZmo0oYmGNRQggeNWfnQS/TCheXYc4
         thMuZPR8M32RoItqcgap0sNY+ueBKFoReQev955aYanO61kily9W5Wg6i9HB0iwo24qr
         cD6E6Bs0XK+MmuI3lIF3TrmSYdp6XRvc390UuYIIx2gKtY8/3I3c6gc104IypNFrW9zc
         57KjBYQcbh5vIaiklsMI62EHnywvZ+3XSSK0EN21Y8lvwq53x8T9PSbUBBue79B9kW6Z
         nMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752230984; x=1752835784;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGhu+6CIOA/HEtwA0o6mES1UdmqcKpfui7kGcHRlM14=;
        b=OhuTvshA2AVsHRuITIqhTW5ENX2QxTHY7tqrDkJyNBZr8mftM0OMcCg1LDKr+RAy0w
         fbLQHmglDzWPDMaBdbFPcaxoyDWWb+r0lVpsHq9Ys7KIEn1yqgobarUa6DzE/TssHaFM
         9pfWJKYOIT3nO3MNSF7RUuh8ghp/y97qG1QLBDddjZcBfPiLGCebgRp0V94i74GNIxx9
         shjy2iUXgg6hQ514uriTSqF4dH2y9hsUdTEpj7zUclBxa5TMk5mp3m8tz5Vb+/nu44Tj
         KI/SK5d7cG6tGP8uKz08uRvwLRnW+Tcf2wYvh3SjbZMNQvD1lQxFbLFCA1cJjR77wgU/
         K4FA==
X-Forwarded-Encrypted: i=1; AJvYcCXsUSAqXfPshtL3MY7DlhJMzxIvnFq0/JbPaKt2cBfY1mGxCYllTzxC7ObrXaasxSYkv6t3dRrGL8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3l46WcjQX66CRs5rFFhIxGVLStE60fwdrVnbaAk0hUw1Rs6Eo
	FRbKgu1IJpCZWGnK90rR1+DDKXS15Cd+5sKU1GWrntnE4X/cUddZCygU
X-Gm-Gg: ASbGncsHtb1pbGNy1lLzNbN3BLxsGonwtuL5aMIvZ9n0xdIBouXZ+OgWoTmU+HpiXN9
	XLwokzNEYhAhwkUw2iDtZ9eqHp87x3Kqh9vB9G1ofBRjZl8Jl+vJCXuSFuqFZSD9e5z5oAP42Qp
	HacFzsGz11hqhJZXJLm+780CZdv5K51K0QXTvt/n9jCxzjWBgSml1PfRzFwNPqN1/yIBoBhYj93
	4yerCr9YZPrh5AJXABlsm8ft2icGXRYHaWLIVrMrzYlm2/OXFdM2HxqQiy5xl0ljO8gtGwanFPC
	677xEj2/4boMoES5MdSOK+p+i9tPAmqPqMKQHGF2s6bZ4u51A1juoakSMoYVtGy5MAtSuivvV+H
	Ezh7dwyn5Wre3Ika3Lli+o4iUJKKj3UxhHzK/gmuNtyIpWd6TyagLNVYQWtXKBzrIilD0
X-Google-Smtp-Source: AGHT+IGq87520KVGx4Gxpfete9yL2oHciATq4ejBWv/79AX3T0VanB0Muhk84gTIhUYu1hsSFrWxoA==
X-Received: by 2002:a05:6a20:3d06:b0:222:ff12:6e26 with SMTP id adf61e73a8af0-23120f147e9mr4280419637.41.1752230983794;
        Fri, 11 Jul 2025 03:49:43 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06b19sm5517493b3a.64.2025.07.11.03.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:49:43 -0700 (PDT)
Message-ID: <d12fb63e-b346-4094-b9d6-aa6823aea541@gmail.com>
Date: Fri, 11 Jul 2025 19:49:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 00/39] Translate sphinx-pre-install to Python
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Content-Language: en-US
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[most CCs dropped]

On Wed,  9 Jul 2025 15:51:32 +0200, Mauro Carvalho Chehab wrote:
[...]

> Please notice that my goal here is to test just this tool.
> I didn't try to actually build the docs on every distro.

I tested the docs build against opensuse/leap:15.6 for you, and
the install completed. One step forward.

However, running "make latexdocs" ended up with the following error:

-----------------------------------------------------------------------------
Exception occurred:
  File "/usr/lib/python3.11/site-packages/sphinx/builders/latex/__init__.py", line 405, in copy_support_files
    for filename in os.listdir(staticdirname):
                    ^^^^^^^^^^^^^^^^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: '/usr/lib/python3.11/site-packages/sphinx/texinputs'
-----------------------------------------------------------------------------

That "texinputs" directory is supposed to hold files to be copied along
with latex sources Sphinx will generate.

openSUSE is unique in that those files don't belong to its base Sphinx
package.  They are provided in "python3-Sphinx-latex" (or
"python311-Sphinx-latex", or any appropriate one for your base Sphinx
package).

Is this news to you?

By the way, 33/39 contains diff of test_script.py and can't be applied.
I needed to remove the hunk manually and apply the remaining patches.

Anyway, your translation of sphinx-pre-install into python is now at
the bottom of my to-test/review list.  So no need to respin this.

As a matter of fact, I'm seeing weird performance regression of empty
documentation builds when the O=<somedir> option is used.

It appeared in v6.15, which has your conversion of get_abi.pl into
get_abi.py.  Will send a report once the time-consuming bisection
completes.

Akira

