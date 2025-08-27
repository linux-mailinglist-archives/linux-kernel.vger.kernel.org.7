Return-Path: <linux-kernel+bounces-788522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABACB385C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E915E306C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DDB22DFA8;
	Wed, 27 Aug 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GD54ccNq"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC77194137
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307227; cv=none; b=hWyJzZzw5z1CHQBoCTD8HfoWW9F8fRmtZNuTM6JTrAqEXoiivj13w5DMq356bbQcx5eVIyJp0gtz7n29/isJu5QHE5baamFNdmMKOAgSOHF3+w4zwhWjPRq2/CrJKWuVzIMzyH6vg5S0jSjcbGn8Cfqa++RAKZY6vpW2aXhQktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307227; c=relaxed/simple;
	bh=NVVh/em/NECfuaJjK47EgeL3eDvm5ggGZhamOFCTz7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBwdn4H+vqgsR0rP4LOosCBhXjYj2UJqgV6ymQnIgSLKPeUsKiusThLUXYgRjXaCL0O820whhoBeB6kCd1+69+YjxRV60yHxmadahs9yVbnehQ7WfoZ+9QGbcmKi/ngsTYWHkycyupJ9y01hkpe4rPWtTOcgiah22dqKXSbvF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GD54ccNq; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0caae1so35625965e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756307224; x=1756912024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSqPdnAyxvNw1GymbN3dZ2C0dKLRA4fsaE5CsGKK670=;
        b=GD54ccNqz39P/iPhxE5Rc36pAC8ammlyThJXZbijAW8iBgQ7eSfQe0sBTuHufZtT40
         h4RitaIf6j/tkUCPMoVYD72YrwQ5G3naa7gxt+Qyoen+otO/wL3JXGiC7XuJMbTnHP8I
         /unelEd6dQ0lJ+FQ2mJnO6gNWVflJCcPhCrTJOJ3bqFZgE894RrDC6798VP4oBrDw1Pu
         HNgENcCJrDv2ZKPpe3AP64tj/uZ95JixieOEIIjHP8LBq1FVM8BfoUZ1vzxzt/Cb30Is
         EMCh+NcPkdoZV552qquah1vd2RZld9eu1koulrL4N1czeEZoOBO9nvInyV4X+9VmUyOg
         HpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307224; x=1756912024;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSqPdnAyxvNw1GymbN3dZ2C0dKLRA4fsaE5CsGKK670=;
        b=dPV9u8NEi6Sk8kepNDNJGvJaY7SGBLeRbx+yCgzn3R+SeDZSMCtqvvOZW7yg80UsWl
         SZp//0/Oe+O6F0RDbMWKNY9IVx78ZGA4yBXc4mfP+VtBiQYcqRx5rIA3p8yBNJLdVCE5
         31utVrvZh4m6lXXnXwp1xPK+AdqN4z7m/LmCZINv1eDQCsZVfYYv7wV8EoDRFdRTgziY
         P8yMp+yCgxMez5YUCsACITvvl+KF5O8SBee+VLqFyvnTRMSkqE7nDdzoREfHf43nTnN7
         n8xwQnnfGhFYRxEg0DI72Y1qIptC9rQgEpz7+mUtZmSNr72SzbT2wr7UBQ87sY2In0JG
         Yr0g==
X-Forwarded-Encrypted: i=1; AJvYcCXif4ijK0MhyB11U+XD4V7kRl9g1KhWZgDipejkzw9nvyPPekp4d3uS6TZX3/220rsYnXzrrAleMxbXF1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbLrIeSdPMqm2sPggFYWdH0hjwPTnhswB5vcQViHKpIYAl3+J
	mj5VpsMPVVqcTdjbJHmjU+dnuDbybRh+E1TqP2MWj8/+sGCskhBUK13Bfno4L5l1YpYjNmbOhC1
	w/vbacZ9CdWsNww==
X-Google-Smtp-Source: AGHT+IGRr05GsIRQMcF8EAluB3xZgaBgbSIfWdSJS171uI8/dhBlwR/KmE2p42NGR+iVV+ke1jAdt1Sm0vNRKw==
X-Received: from wmbdy5.prod.google.com ([2002:a05:600c:6585:b0:459:1810:bf51])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a46:b0:456:19be:5e8 with SMTP id 5b1f17b1804b1-45b517d459dmr170501745e9.20.1756307223741;
 Wed, 27 Aug 2025 08:07:03 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:07:02 +0000
In-Reply-To: <j2vfxy4sr6wmuovlynvljvmy6as7esevp57hyqkhofxnxnjldf@ul6befrh7eqy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827-b4-vma-no-atomic-h-v1-0-5d3a94ae670f@google.com>
 <20250827-b4-vma-no-atomic-h-v1-1-5d3a94ae670f@google.com> <j2vfxy4sr6wmuovlynvljvmy6as7esevp57hyqkhofxnxnjldf@ul6befrh7eqy>
X-Mailer: aerc 0.20.1
Message-ID: <DCDAY7MCS3CS.2QJ54F8Z86WN6@google.com>
Subject: Re: [PATCH 1/3] tools: testing: Allow importing arch headers in shared.mk
From: Brendan Jackman <jackmanb@google.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, <linux-kernel@vger.kernel.org>, 
	<maple-tree@lists.infradead.org>, <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed Aug 27, 2025 at 12:50 PM UTC, Pedro Falcato wrote:
> On Wed, Aug 27, 2025 at 11:04:41AM +0000, Brendan Jackman wrote:
>> There is an arch/ tree under tools. This contains some useful stuff, to
>> make that available, import the necessary Make helper file and then add
>> it to the -I flags.
>>=20
>> There still aren't that many headers so also just smush all of them into
>> SHARED_DEPS instead of starting to do any header dependency hocus pocus.
>>
>
> I was a little confused as to why this patchset was safe, and - yeah - i =
missed
> the arch/ under tools/.
>
> There are asm-generic headers so hopefully those fully take care of !x86?=
=20

[Confidently but wihout evidence] yep, without a doubt!

> Did you check?

Um, OK that's fair question. This doesn't support cross-compilation so
you actually need a non-x86 environment.

<begin verbose notes, tl;dr: yeah seems to work for arm64>

I have Nix set up to build aarch64 binaries via binfmt_misc though so I
tried using that...

=E2=9D=AF=E2=9D=AF  cat /etc/nix/nix.conf
# see https://nixos.org/manual/nix/stable/command-ref/conf-file

sandbox =3D true

max-jobs =3D 96

extra-platforms =3D aarch64-linux

So I dropped this into the root of the kernel repo (and `git add`ed it
otherwise Nix pretends it's not there):

=E2=9D=AF=E2=9D=AF  cat flake.nix=20
{
  inputs =3D {
    nixpkgs.url =3D "github:nixos/nixpkgs?ref=3Dnixos-25.05";
  };

  outputs =3D
    {
      self,
      nixpkgs,
    }:
    let
      system =3D "aarch64-linux";
      pkgs =3D import nixpkgs { inherit system; };
    in
    {
      formatter."${system}" =3D pkgs.nixfmt-tree;

      packages."${system}".vma-tests =3D pkgs.stdenv.mkDerivation {
        name =3D "vma-tests";
        src =3D ./.;
        # (Pretty sure this is not the correct way to do this, there must b=
e
        # some mkDerivation arg that's equivalent to make's -C flag)
        buildPhase =3D "make -C tools/testing/vma";
        nativeBuildInputs =3D [ pkgs.liburcu ];

        installPhase =3D ''
          mkdir $out
          cp tools/testing/vma/vma $out
        '';

	checkPhase =3D ''./tools/testing/vma'';
      };
    };
}

And, yeah at least it compiles, and that checkPhase should have run the
VMA tests:

=E2=9D=AF=E2=9D=AF  nix build .#packages.aarch64-linux.vma-tests
warning: Git tree '/usr/local/google/home/jackmanb/src/linux/linux' is dirt=
y

=E2=9D=AF=E2=9D=AF  file ./result/vma=20
./result/vma: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), dyn=
amically linked, interpreter /nix/store/r0pjdp81mmd7dvk5pv1ch75hrbbw60xb-gl=
ibc-2.40-66/lib/ld-linux-aarch64.so.1, for GNU/Linux 3.10.0, with debug_inf=
o, not stripped

So... that was easier than expected :)


