Return-Path: <linux-kernel+bounces-819022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA02B59A38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B7217ECAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4415280A56;
	Tue, 16 Sep 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5qR3kuQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7E1C8632
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032770; cv=none; b=YmsvjQN0xB1zvqmtrHdhCYgtMsapAi8uq9+caG8P64uBGYziFnr3zQBhMP1gGTw8NFNiSkRD2X0YJVdPLxYzX01p5xmkZQrA1w0C+HnQdXPVCx6PDY78ZsQKYtAdZOLPffzaEGShPXHZ8I5X6lRrrmrpkGixUVNSDEvKmHEQsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032770; c=relaxed/simple;
	bh=uMcNijcnMhNAb21qUVKzkgNAFVxzUGHz23fC60dNeIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCHqzvQQ0CCbElK3c9AxhmC5Lg+qPuVrQ0R8y/lrgMXxzNjI8kqLJFmtAvcm7/mClVwCTa9qM5eVBIAaS26qN/830fc8yH9S4XKlmzcMDucdzU6mfLDM8gY+vk4Ia1C9JqoAaxxZUG04bp7X357tv0UvRJVU0DfZngJZNyeOPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5qR3kuQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77616dce48cso3057247b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032768; x=1758637568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMcNijcnMhNAb21qUVKzkgNAFVxzUGHz23fC60dNeIw=;
        b=i5qR3kuQul7ReRtJ1G689EkiiLGo4VjWuui5IT8xFrpYrkc6PTtOIk0m4yzjYJojCj
         je0uJOYIKVPyOsOToWRO0SnwhV+nDJo+EolO0Pfwc7TkUAskgpQ4MS0IJSQFfsWBonW+
         lcfeSHFOaZW+DzSDbvb94tXc+GF6t6pnzwvwWApUYDiCCT/zTvrE4alKa6FKDgml63BL
         StXy9hvUlJRrOPlg8KMZec5BPca6SRcNCBc7SMjrG8EZA7vsYzIpIUiNw8rkieCcri16
         T4Hb/YjYnOcRCnueAmAdXTixYVmDKQekNAvapwQiEFL2HZE3p+1HgfTZ/FKggc/wSx+Z
         eDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032768; x=1758637568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMcNijcnMhNAb21qUVKzkgNAFVxzUGHz23fC60dNeIw=;
        b=mXa36JSZWBVMgc9fws943y3ahx8SGdhMISexOv59TaRxCN+b8l/CHsui8rzIUebsEm
         1oYZWAYBkXcfYfdQYcOwlraDf5fNHsnFUA/V58fX0XZk7V/b4ix9/vXi05iMmtKM/yA8
         UuZtqGVV4pVyBDIY6JbUyIr+69vj5/bK9jx0YZTAaHPNa8BiFw3SyR/zgAFBI+kR6e68
         nrBM+gX4c6Tv6/xuwWVqWtUkjPDj55fLoEoti+5DJ0CjvWGGY/PYPsCLLlxEFCABxsae
         24PbuUdaAc7IjwwRxZd4QgsjreTuyp7ljSdvq5Hwdo7uLZqcK4iV5qBzmuW75oZ5u3pg
         CSBg==
X-Forwarded-Encrypted: i=1; AJvYcCU1j+VOL76yAWkwBKm7Oks102OXE7WOiUw5TDMyKNDIMTo1P5ZsHfxqm5+bvvfqHxKKGoIplq/j64H5+44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43/EyNOnZJI/RXD6WYZlCFUUnD3jyCR/zyUNCNiiEpFgi6n4s
	fZEZjGe/7LoBoVfhAxfB4J17fhgjROaqmbodr1iDlHOS8VzN7ynwN9QN
X-Gm-Gg: ASbGncsihi/ZpKvB/Y1ujVVhiXqxhiq/63zBic3a9Eox7qR5pFSUFD5sUfrjr3+xrVX
	F77s9vshqdQv/+yYe7gIa22pub92CopG9/6eblHltvZLSbFJL4ggEPOSzz0Uzsx+mQ5X5pQTZJq
	inXfAAG9BB1L+xkBqO8xtpJEYQU+7vGuWL2WQ7346ef82PxRo7EbjzZFXBv/ED1RNsckVZhOZt3
	ozJ1UfBKO+pt2K7Mwzguq6Q/2A2p1PqNLba7Bjt4TNDzPoyjRr+nYftQ0T6+2cop9HfBrGcXTkX
	rSIKOPhIwFcQbH7Vp+QcjPjOPxnQArFE7NorE8rFM4gLSnhhYt1DIEdcIUIBvmQXd3Ycnje3onG
	lVfkptA7dibib0JMy3sDw3C8BPYwmWDN00hg4
X-Google-Smtp-Source: AGHT+IGvai1R9UV5qW0JLRvwDFGRIhjqqVqH1mBx2L0LjYmLE/VS4NAz9iq4LkE/Qr5K0/uaq6wsQw==
X-Received: by 2002:a05:6a20:1590:b0:263:52cb:bc49 with SMTP id adf61e73a8af0-26352cbbd14mr11711099637.35.1758032767863;
        Tue, 16 Sep 2025 07:26:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ac02de2bsm12128980a12.17.2025.09.16.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9679A41F4135; Tue, 16 Sep 2025 21:26:03 +0700 (WIB)
Date: Tue, 16 Sep 2025 21:26:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Message-ID: <aMlzeyu5Apwfp-1j@archie.me>
References: <20250916073244.590483-1-bagasdotme@gmail.com>
 <b629ff7e-a223-467f-8e32-78f825bd31ac@app.fastmail.com>
 <87zfaufrcq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pXurbY7g+wD8W3os"
Content-Disposition: inline
In-Reply-To: <87zfaufrcq.fsf@trenco.lwn.net>


--pXurbY7g+wD8W3os
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 07:40:21AM -0600, Jonathan Corbet wrote:
> "Hugo Osvaldo Barrera" <hugo@whynothugo.nl> writes:
>=20
> >> +When compiled with ``CONFIG_EFI_STUB=3Dy``, the kernel can be execute=
d=20
> >> as a
> >> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> >> +implementation details.
> >
> > I must insist that it's a terrible idea to replace an actual link with =
the
> > name of the source file.
> >
> > This might be (marginally) more convenient for somebody who's editing t=
he
> > documentation, but it becomes completely useless for somebody who's REA=
DING
> > the documentation. Documentation needs to target readers.
> >
> > For someone reading https://www.kernel.org/doc/html/latest/arch/x86/boo=
t.html,
> > the above filename conveys no useful information.
>=20
> When the documentation is rendered into HTML, that file reference will
> be turned into a link automatically, and people reading it on kernel.org
> will not notice the difference.

That's why I keep the file cross-reference...

--=20
An old man doll... just what I always wanted! - Clara

--pXurbY7g+wD8W3os
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMlzdgAKCRD2uYlJVVFO
o+8YAQCQPDGTVdHgN6kNhi8fzWdgDD87slM6RKRQ2aBrU7sBWgD/arfkPpsyhNCy
ne5Fs6gwrSn7y2ClBkaa/KtkpD7cGQs=
=bvi7
-----END PGP SIGNATURE-----

--pXurbY7g+wD8W3os--

