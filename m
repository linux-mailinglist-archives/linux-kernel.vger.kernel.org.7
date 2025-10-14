Return-Path: <linux-kernel+bounces-852046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F5BD8083
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475BD189A17A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8C330EF9C;
	Tue, 14 Oct 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T99IveZq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B230E85D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428574; cv=none; b=Ocs85/PDb8g0afGv11d/R6lwHWO1CH7P9lBAsc4zztt0KJcNzxkquRZ1idx9DkKqeQf8XKHHLmJvHQZqwB9lJVqOVEfmelv+Ace79XHVYVFlVvvfPffqGLMdTPrksjks5eojfcpfZ6uk+Xn4XzmoO40Zt4Z+XL7BTx1YKAylw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428574; c=relaxed/simple;
	bh=Fg0KefGTsKQ+6tIoTbH22ID1I91XIBFCEl0WxK9MFcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFvaraScKShktQF3hhHDCWOHdPmpuE/cnk2yseZFs+3KmhL7qySuuBUaLNPX9kTyeYRiBo6qinQOqA3K1/FbdXdTMeut1pHd7flRIpkG+CMTn3CApB3cB7afULbdQv8NYJKnxnApO1hoSz4KTY8RoZjds+S6QJpob9tQ3Z5K7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T99IveZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D66DC19423
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760428574;
	bh=Fg0KefGTsKQ+6tIoTbH22ID1I91XIBFCEl0WxK9MFcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T99IveZqabiGk8YjtsAxJ6lSipFDYQPWaqciK6JCKaFYL558faaQOsQ7E2FuDGnYv
	 nkaVLgbk10VDYhreW1ITRQHvlLFBRA/mDTMpzWqWbpllMmNE2I0CbM2Hof7ZbIZoId
	 +SV5Cp41Jqg2zO808MuJdS2N31a1TJAuNC6NcS7kZRjdjGqa6ucrgkBSlMb6qV+q2y
	 J2z3s/aYtWpXuG27L29f4i/PaIZ1L5aIXLpXpO9ybDADLcPerfqlybJHJuxYzwvbQp
	 61OGMxAVfZBT0ANxwUD5uAHj9QztVPC15XnXGqPBxwh0sKDmYj1eGlej+gPo9uLQO/
	 QJmBHRSrL//xw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3c715955a8cso3515267fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNpOdw8yyyQnxt2PWOY0vW5edBNE4NYh5SuU5TRqS4kTHMv+KySnPzScBh47M/1fMAqssLGOynXtFnUWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh60CmskNmWUbZZ5mQ4UOgdSf4FeAWlsWzZK0vovMyOsAnvqkx
	lQPZ1NozZDExdJsH2+M2NtFY4ALDbfZAwDy+bLaeVyxUUmqoB1wyeNwKQqP+ih/xTbEcy6QDX9W
	7mytfKJNDvo4mJCLeVvrEKgV8vFkt5nQ=
X-Google-Smtp-Source: AGHT+IHSAc+OjR5octuQQvvDHv3jPU8iyCGUYA7/pNJhyWG1qYoOvFxiMuATOX0mdFk9ovT5xLnZy85PcJh9GvaQrNo=
X-Received: by 2002:a05:6871:808:b0:3a6:6753:3991 with SMTP id
 586e51a60fabf-3be69f05f7dmr11716752fac.5.1760428573630; Tue, 14 Oct 2025
 00:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012015738.244315-1-ebiggers@kernel.org>
In-Reply-To: <20251012015738.244315-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Oct 2025 09:55:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHGnR942BG9W=hA6GPDa2FZML+OkiO5eExTm=NcezuqLw@mail.gmail.com>
X-Gm-Features: AS18NWCCRGT7ibQWh6pBgwwwcADLeSZR6NuenFNpC5OdGVDW56i3wIEZwrUnews
Message-ID: <CAMj1kXHGnR942BG9W=hA6GPDa2FZML+OkiO5eExTm=NcezuqLw@mail.gmail.com>
Subject: Re: [PATCH 0/8] smb: client: More crypto library conversions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>, 
	samba-technical@lists.samba.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Oct 2025 at 03:59, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series converts fs/smb/client/ to access SHA-512, HMAC-SHA256, MD5,
> and HMAC-MD5 using the library APIs instead of crypto_shash.
>
> This simplifies the code significantly.  It also slightly improves
> performance, as it eliminates unnecessary overhead.
>
> Tested with Samba with all SMB versions, with mfsymlinks in the mount
> options, 'server min protocol = NT1' and 'server signing = required' in
> smb.conf, and doing a simple file data and symlink verification test.
> That seems to cover all the modified code paths.
>
> However, with SMB 1.0 I get "CIFS: VFS: SMB signature verification
> returned error = -13", regardless of whether this series is applied or
> not.  Presumably, testing that case requires some other setting I
> couldn't find.
>
> Regardless, these are straightforward conversions and all the actual
> crypto is exactly the same as before, as far as I can tell.
>
> Eric Biggers (8):
>   smb: client: Use SHA-512 library for SMB3.1.1 preauth hash
>   smb: client: Use HMAC-SHA256 library for key generation
>   smb: client: Use HMAC-SHA256 library for SMB2 signature calculation
>   smb: client: Use MD5 library for M-F symlink hashing
>   smb: client: Use MD5 library for SMB1 signature calculation
>   smb: client: Use HMAC-MD5 library for NTLMv2
>   smb: client: Remove obsolete crypto_shash allocations
>   smb: client: Consolidate cmac(aes) shash allocation
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

