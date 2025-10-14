Return-Path: <linux-kernel+bounces-852377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D91BD8CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE0D19222B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895992FB629;
	Tue, 14 Oct 2025 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP2GU09j"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4D2FABF5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439025; cv=none; b=F+6uACBpo6WOh6ybzYcTtHQI4LzXjsQGFFcHreipSAGRi1M2PUgJTKvbNYBqQN4Rw7ilk6of2M/U5Kj8Hmbkj4Cj8lwG9LOpYovDLk0l1w79Q2e0YqfDchHwAKDFj8N+8it/qN1PnKNyL9MXTcRx1+nwOCKKySfDZQvbTUNuzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439025; c=relaxed/simple;
	bh=OsAT+//A7xxrcqc3BwTPqIQEwFp06t38UryCM1+xuf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZh1cpLrJeiYCkD1RQEODjZXIpBoipxen7VB+yM1sjqUq9UBgBWklVvR6YBUHZabHlmVClgPs7+xOCrZTxX0Dicsp4c9CI70Pu9119iJdfnH0Ypmo1ABu3CFmXA8Cyn8YAqO0yh3nEqIvSifUF/2U80ydE4d4CbfklNaTrAmQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP2GU09j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so41815665e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760439022; x=1761043822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oi5CZpumOfRO5UxrA3d1k5hJRdlXZM8E6FYaZHFNcA=;
        b=SP2GU09jaGj+QUgC0bNK6tbdQSQwOqXxJdTDq/Omm1Q3feuAsVold8AwjWLUri3eTq
         h3bGtZkpJrBi+1LSg+tUfG/Qy6Bo2r+e229A9ti1iq74NzawjkbRtGv4NDiMumbJwcEG
         7iKrfOtlk2an8TgL7jJZ4Jo+/IOdzjkatmH0fVLFgm+vlSIZc7eKB9qiz1AUXeEZu5wI
         rlSyuJuVK4PsZFTyEeN4aN2mf7EDSQaJR0bg7pUtY1Oo9/rWSVRW3tUqCOLM0qpcSJj1
         UTXhhMXXscGegWB6N9C+62kh2TS3oO6aCDWe+B/2uYhaaPr43H2P8bGbyOFVJzIjgztJ
         zhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439022; x=1761043822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oi5CZpumOfRO5UxrA3d1k5hJRdlXZM8E6FYaZHFNcA=;
        b=c6RRnPG6eQrMamUDn0vlZuiz7+NMdXLCJaww0O/f0Eli2bV22RLBHkm7uc3VPHF5iQ
         ptaz6/wkvEuV6eNtwh2hV6533QJUXZFXRYFdqBYEc2GAfJ3P+3b3fa+m/zzmRCMMHXra
         QR8t/48NmOQCfguN1yXS25A8tdA1427m5jeg1sionjzuVROqE3CdOCn335tkGRqfkjJy
         Ar35hniT/xYN0GLigATo+c7u+m7HOK2U0MCfTJjJPbXvIeJfy/tiWfmalzqlgG+WIQg+
         MPEH6ZX5eGcnG4mCFCblNJvTjU+BNIJu195h/5ceAyajpPt7cyg65ic0h2T1GWvL9r1Y
         A4Vg==
X-Forwarded-Encrypted: i=1; AJvYcCU5a5v2Gux1jEFh1f6CngjAObyw9iEQ10rKRIYHGBHPQ8rUqWIRCGTmCulIlpY7LP1mlGesMf9CcypvVAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqOeG5Kilcg6H3najOFuH3PhjBbJgMkY4rnBdCY6spnrcRArk
	H4xaq67UEWfRsZZg8kkHHKH4trlCC8nYBHrQpo0aQ+6Ws1Ayr2ARjNpy
X-Gm-Gg: ASbGncvARPbIUwjIk3rJ5L7s8mNxbHCmVz1mFzwnqVKQ6CaOSN4Obg+HdwpVw46MUhV
	2IJnP4sbHmU7pK0jBvgt/2F9XPQHAipMMYJKXzFXzQZYAv+KXx284gGCJaVO8cTY5vQG9qzeijb
	NhAr1+XmMDryMzzEIolLCTGS4AuYWtkcE5N0QmOf+gxyEH817D1CvBOSH26CVwmoCrJ6kar1riL
	Qwu/nGPRPNRIqMKz5TP732mks3+Ceg1Bff3vWOth9EGgyifzSUNgzUr0pAtOaHD2ZHE+6L9R+O1
	NxYEVldRw9xzwlGIRupNXLmHC09eSmThYjz8JnQjZhuidIGJmmFxRMurEYXSvnZ9m4maui66sij
	BH6lnDaEDJzE2dfk6szyFakYn9hxp3kGNdhnO5jr8qClyPbwy4KrRehkb/sAgVq87jgxjY4hfz3
	sQK2FmN3QNKM19KNQUmK2U+7b5lSqkY9jTMJrXtqE=
X-Google-Smtp-Source: AGHT+IHvthsh5d4gJ2f4pjbU+SaIy+7Qg5DdE7atHEiRKh31T49BVgFbO+XVGKpTwhTDtvlqb5L5oQ==
X-Received: by 2002:a05:600c:4e01:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-46fa9b090d0mr198199315e9.30.1760439021936;
        Tue, 14 Oct 2025 03:50:21 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49be017sm230015965e9.13.2025.10.14.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:50:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:50:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: IRQ thread timeouts and affinity
Message-ID: <6hb5vyl5xxsxfcwk4v3xpq277wusj5jq4tubdpjocpjc5smj3w@wx574kluhedj>
References: <j7ikmaazu6hjzsagqqk4o4nnxl5wupsmpcaruoyytsn2ogolyx@mtmhqrkm4gbv>
 <86qzvcxi3j.wl-maz@kernel.org>
 <loeliplxuvek4nh4plt4hup3ibqorpiv4eljiiwltgmyqa4nki@xpzymugslcvf>
 <86o6qgxayt.wl-maz@kernel.org>
 <86ms60x7w7.wl-maz@kernel.org>
 <us2hfdn7jpfepdmwk2p62w64p7xagaeoemg3hdt2vm54emtwlv@m6fkuti7hvfa>
 <86bjmeyh5m.wl-maz@kernel.org>
 <graeplkpsgbolpnnq2pndpdb7fymyy7zvm37osbdtre347tns2@mjbgzwterefv>
 <87sefpoj10.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2s53ukplucxdxja3"
Content-Disposition: inline
In-Reply-To: <87sefpoj10.wl-maz@kernel.org>


--2s53ukplucxdxja3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: IRQ thread timeouts and affinity
MIME-Version: 1.0

On Sat, Oct 11, 2025 at 11:00:11AM +0100, Marc Zyngier wrote:
> On Fri, 10 Oct 2025 16:03:01 +0100,
> Thierry Reding <thierry.reding@gmail.com> wrote:
> >=20
> > On Fri, Oct 10, 2025 at 03:18:13PM +0100, Marc Zyngier wrote:
> > >=20
> > > CPU hotplug is the main area of concern, and I'm pretty sure it breaks
> > > this distribution mechanism (or the other way around). Another thing
> > > is that if firmware isn't aware that 1:N interrupts can (or should)
> > > wake-up a CPU from sleep, bad things will happen. Given that nobody
> > > uses 1:N, you can bet that any bit of privileged SW (TF-A,
> > > hypervisors) is likely to be buggy (I've already spotted bugs in KVM
> > > around this).
> >=20
> > Okay, I can find out if CPU hotplug is a common use-case on these
> > devices, or if we can run some tests with that.
>=20
> It's not so much whether CPU hotplug is of any use to your particular
> box, but whether this has any detrimental impact on *any* machine
> doing CPU hotplug.
>=20
> To be clear, this stuff doesn't go in if something breaks, no matter
> how small.

Of course. I do want to find a way to move forward with this, so I'm
trying to find ways to check what impact this would have in conjunction
with CPU hotplug.

I've done some minimal testing on a Tegra264 device where we have less
CPUs. With your patch applied, I see that most interrupts are nicely
distributed across CPUs. I'm going to use the serial interrupt as an
example since it reliably triggers when I test on a system. Here's an
extract after boot:

	# cat /proc/interrupts
	           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5    =
   CPU6       CPU7
	 25:         42         44         41         29         37         36    =
     39         36    GICv3 547 Level     c4e0000.serial

I then took CPU 1 offline:

	# echo 0 > /sys/devices/system/cpu/cpu1/online

After that it looks like the GIC automatically reverts to using the
first CPU, since after a little while:

	# cat /proc/interrupts
	           CPU0       CPU2       CPU3       CPU4       CPU5       CPU6    =
   CPU7
	 25:        186         66         52         64         58         67    =
     62    GICv3 547 Level     c4e0000.serial

The interrupt count for CPUs 2-7 no longer increments after taking CPU 1
offline. Interestingly, bringing CPU 1 back online doesn't have an
impact, so it doesn't go back to enabling 1:N mode.

Nothing did seem to break. Obviously this doesn't show anything about
the performance yet, but it looks like at least things don't crash and
burn.

Anything else that you think I can test? Do we have a way of restoring
1:N when all CPUs are back online?

Thierry

--2s53ukplucxdxja3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjuKuYACgkQ3SOs138+
s6GjZxAAh0EtrqoNH2ELSK/goEd24inBc3Eoe37rgmkFvxq4QmjXZaEktcd2MVKQ
PpYu00CutOwfzM202AXfZRem5KI2hg8pOLu9ZE/Y0GLaZsMyY9KmefuYNbRpuFFY
ls/pYtncY0xRPfzF1KpSg/y3UhIt9l67KXjrTLcIgem/RXFhhIVGBbuabbcA0b8N
+3SD9lEqdVWByEB0skf4okYqSZK0aXN4gxBrm8G03fYDuuVtM/w5nvYLJTUMgTJh
qMS0kNvVX3JOjaXvYt4HGZIcIi6cHLgK3PHAydGQ0A+rBdSRbSycXBF6hGpOViuY
Cna1CRTsu1X/CPwmKyVRyxx+jfWMV25WEs4wr+LKMePNvcQswJep6jc3eTUEBGCV
bD10EcJUNKz7jUs+Du7fc5zMY5NNzYmI7PGFGpfOIRr/Fjzwq3KbWIQNfBca5QBr
aixPjI57v4Z9y58nPt1IDY4mk6jlMzB9p6FfhzRY5VyBChrjS8gnukhs7Heq7l5H
uwhfVeYjB74NRns+V0Pcb3fKtt8xd6vx3w5U0oZQmhezfs9TITmJc7U3JQkgRNp2
wApK8ECbCcA56N07U1jB5ihAsS3u/bbqWONgIAg6ldIBOYmBjuGvkNF02E9xNEu/
SVcGFetyr9+PkcKbDfpVaKfxZPMtUxune9hno2u3QO9bylAQw/0=
=QFps
-----END PGP SIGNATURE-----

--2s53ukplucxdxja3--

