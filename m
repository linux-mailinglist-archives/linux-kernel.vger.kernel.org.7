Return-Path: <linux-kernel+bounces-772461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51F3B292F7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1D3206D89
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422E23956A;
	Sun, 17 Aug 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZhxgf6/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520553176FD;
	Sun, 17 Aug 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755433493; cv=none; b=tpSRv94oRA+65ZjkEYHJRdN2DkUfNJJipx/qyD1iQzPDyb36A/f1R0mbI7b/txXqoi7wb7wC1XKHuJAsiFK9r96wTa+BFe61ynShIZzf9Tgaq1gMKAtcgHkU7kViHqOT7z/lBCKZM3sGGnSB09iugTiVy10Py0rMbg5D+5UXirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755433493; c=relaxed/simple;
	bh=SVcq21UPa657eyiYAkeYF755PdwuJJFxc51Q/KR9rzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKU/LLuyUPIj61f4N1dAtO2PxHdc67/s68wOD3xdLwrWqqoZRiTd6WOGK+8AaLsFEPdXKBA5GqvAxDjNuF7bpuWBjAx/FFpMeYFnaXioPsnTEGnGcw6W48YPLA6UO+fua6m8eEUNdbXpjF/JNHi0fKtXDuQBDlfZtO4hchTkEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZhxgf6/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so3032563b3a.0;
        Sun, 17 Aug 2025 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755433492; x=1756038292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZBFxmP+Hh+MQ+0b+7LVomi/fZ8hndbP6olHzfgNotY=;
        b=BZhxgf6/Za05FTKVnyvTmfhmbIckLukD/kbREi4JkZfY10xaUdRU1JtKDGbqhd0FFY
         LA/fm1RW5JqZK5/Oz8hFsHxG69lrKQvxrCbgA0Sd6LOKgsveADYqpkF1Sw4mwbFc0pik
         Hmh8CFiZ/QNQnwrN/eicghcofPkXE33r659rpBPJW3L5g4KqxYXT70E7maAOvzw9FlQK
         q/chN1vagNrX83nd/6xZRNfg7IvgjhAocy+ABga4M5j99n7NITtP13s/GDN9QtWjO5GT
         sPVILi2hVq/T3PTRf+RmwQ9CFzCTlGPUyJ4ExwWK7Vk17RuOYjXhixgdR6Ih9GESPeFD
         GEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755433492; x=1756038292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZBFxmP+Hh+MQ+0b+7LVomi/fZ8hndbP6olHzfgNotY=;
        b=OOPzq+jxEjaY4se0L0Tyh6AZeh9Y1wtXG4acBanbXTwcFsDV9vQZ6bpz6QcOQORPL0
         29pylrgHP2X2XSYJEVDnnW0WSSIAUkB9TREj/aT5kLYz5LkZ0QJAzae/DsTb8GHo5Im6
         BTvfq5EMIHUSsu9KGqAviPGDKj2CaW/VQlnvlMD8QX+fJUWa+IFwNY2GmvVcpv3Sn3yi
         ankVr2qIBNRt3jcssjV4U7X0qXOTUeTFgOtAmiJNl+Ss4WfHqLB1KZZ7eaOvq4h/KDwj
         4CoXNIPsk71mi2GfkEd6eomSvOfRSDAhsyMha0R0JzuRPv1TMwfrf7m8Mq7z6kmOSG5a
         6M2w==
X-Forwarded-Encrypted: i=1; AJvYcCVOC5ZFEXyDRL8n30fP96Hc4vANcjDn28UOjS11IYHXVwuVb3kF1Hci/2Am11JBKveLEqVye9bPwbQ=@vger.kernel.org, AJvYcCWjR/C+UdWZP4uP1YjHXwvBqq05na5Y54nSiq659Z2pcEizHK7gHk62niO3tbmtkjkwzocZ4AbQvkQB7qG1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7OkbhfFYHnnStxskgbPA0fZHdO+8KDd43GptyPXGSD0Vu4YX
	XKx4ciUIwFXHqcVP+k0bDaneltAVPVMJcEhfckgLO1AU5VtQtl5DaB2D
X-Gm-Gg: ASbGncu404w233k+oilv7MX47JCS4VvgpgjNmpGfUeYLOAxKH8LutxVPWSo+XmnboCJ
	KMkeyI2D+toFDBOaePJjHB4bLjPgzK9W4Zlr02/zc/bjO6UIIvb2UgVZ4C//i3Es4ldfQPpGniY
	zy8BMsmhqnWGGq6JzMXsiyXzR+bzgEzA0SIqlgorRdFkIL2F4B6au0tLF3alPhu8aDx2BfQPfN3
	iwwseDLp4UOrZFpkzCnhlNAdW2i8OIJ0AFIIvY4ayxbm6tOkhTVYx30/oUGrekXZu4hLXM3b0ck
	Khsv+ZpR+CebX2rIlxUWu3NZqdYSwaSyN8eev+2nf5jQWythMsFeJ8/SSc424FbKD7gRbCOMuqC
	JikY2URukZJnYb0SjwHiERrGOzhYn/d3XJy4cSNRaSwSLOgfzQ2u72itorUH3Z9O51gwc
X-Google-Smtp-Source: AGHT+IFk4xIVVSMdqFYPl/d72CZObFQ9KunMx5c4SIGE62mZAcfN7lMTZC7e/nBZpfVDH+3L0o+Tnw==
X-Received: by 2002:a17:902:e843:b0:23f:c760:fe02 with SMTP id d9443c01a7336-244594ccd76mr209664135ad.9.1755433491423;
        Sun, 17 Aug 2025 05:24:51 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d548e59sm54598685ad.122.2025.08.17.05.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 05:24:50 -0700 (PDT)
Message-ID: <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
Date: Sun, 17 Aug 2025 21:24:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250817133606.79d968ed@sal.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 13:36:06 +0200, Mauro Carvalho Chehab wrote:
> Em Sun, 17 Aug 2025 18:46:35 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> [-CC: bpf@vger]
>>

[...]

>> I couldn't see what you are talking about at first, because there
>> have not been any such issues reported.
> 
> Heh, as you reported, you had troubles building pdf on Debian/Ubuntu. 
> That's mainly why I took some time finding issues and writing this
> series. Basically, just fixing ImageMagick permissions didn't fix
> everything, as, at least with the Sphinx versions used at the tests
> got troubles with Sphinx hyphernation, which required a Polish font.
> 
> Debian LaTeX packages seem to have issues with that. Fedora and
> other rpm-based distros built it fine.
> 
> Now, reproducing such bugs could be tricky, specially with LaTeX,
> which is a complex tool with lots of system-specific stuff.
> 
> Eventually, this could be related to LANG/LANGUAGE/LC_ALL/...
> env vars. Here, I'm using lxc-attach to bind to the container.
> It doesn't run .bashrc nor set locale vars, and it seems to keep
> some env vars from the host. In the specific case of LANG,
> it doesn't set anything. So, my test script sets LANG and LC_ALL
> to "C". The host has it set to LANG=pt_BR.UTF-8.
> 
>> Also, after applying 1/11 ... 4/11 on top of current docs-next
>> (commit 0bbc2548ea85 ("Merge branch 'pre-install' into docs-mw"),
>> despite the changelog of 5/11 which claims to fix an issue under
>> debian, I couldn't reproduce the "! Corrupted NFSS tables" error
>> under Ubuntu 24.04 (noble).
> 
> Maybe you could try set LANG/LC_ALL to "C".
> 
> I tested it on the following lxc containers (picked from lxc
> download repositories):
> 
>   # APT-based (Debian/Ubuntu-like)
>   debian:
>     release: "bookworm"
>     pre_setup_cmds: *apt_pkg_cmd
>     post_setup_cmds:
>       - "systemctl enable ssh"
>     pkg_cmd: *apt_pkg_cmd
> 
>   devuan:
>     release: "daedalus"
>     pkg_cmd: *apt_pkg_cmd
> 
>   kali:
>     release: "current"
>     pkg_cmd: *apt_pkg_cmd
> 
>   mint:
>     release: "wilma"
>     pkg_cmd: *apt_pkg_cmd
> 
>   ubuntu:
>     release: "plucky"
>     pkg_cmd: *apt_pkg_cmd
> 
>   ubuntu-lts:
>     dist: "ubuntu"
>     release: "noble"
>     pkg_cmd: *apt_pkg_cmd
> 
> apt_pkg_cmd: &apt_pkg_cmd
>   - "sudo locale-gen"
>   - "sudo dpkg-reconfigure --frontend=noninteractive locales"
>   - "apt-get update && apt-get install -y openssh-server git python3 make"
>   - |
>     if [ -f /etc/ImageMagick-6/policy.xml ]; then
>       # Remove any existing restrictive policies for PDF/PS/EPS/XPS
>       sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-6/policy.xml
>       # Allow PDF patterns at the end </policymap>
>       sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-6/policy.xml
>     fi
>   - |
>     if [ -f /etc/ImageMagick-7/policy.xml ]; then
>       # Remove any existing restrictive policies for PDF/PS/EPS/XPS
>       sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-7/policy.xml
>       # Allow PDF patterns at the end </policymap>
>       sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-7/policy.xml
>     fi
> 
> Packages are installed according using sphinx-pre-install
> instructions.
> 
> I don't remember what of those got the corrupted tables LaTeX warning,
> but I got it on more than one Debian-based distro. When I wrote the
> fix, I guess I logged at the Debian container.
> 

That explains!  I've stopped using ImageMagick all together.

So it sounds to me like there is some issue in debian/ubuntu/...'s
ImageMagick packaging, probably its build config disables some
aspect of SVG --> PDF support for security concerns (???).
I'm not sure at all.

I think it has nothing to do with XeLaTeX font discovery and I don't
see any reason to apply 5/11, at least for the time being.

My suggestion would be to give up ImageMagick and install Inkscape
instead.  It is provided as a deb package for debian and its derivatives.

Thanks, Akira


