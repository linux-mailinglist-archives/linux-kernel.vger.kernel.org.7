Return-Path: <linux-kernel+bounces-764542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D11B2244D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9657C17EC75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961E2EBB87;
	Tue, 12 Aug 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0QsGoKY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C920D4E1;
	Tue, 12 Aug 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993395; cv=none; b=jAg3o2C5nc4cJDEbpK5w2mESO+yyb7yP1Mgi27IZ7f42oDno99SBE+8aVeLlPH28XE/cqoMELX74hp550T6VW1guuYBQ+w9+LvcZSK+EslLNmsya6e0hUq+flEAlfj09ovnXggZbR6Ry/NBWphw+Eec+civbZf6ctL1+dES8l9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993395; c=relaxed/simple;
	bh=6P/aKqG7fY1LNdU4jwyXEd4Urbpceh+qKNGedxVIFJc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WnCFeESetBYKrXWZVS4EXusCvyiMsY/a8+7DCIGpCc3NsRHiQYaKIdJqQxfE97Ssh46uoHXOiLwyiTWwHdJx/S27tB3HrT45YfVQh1WCxwV170QzgH4B1S5H7pcP5rB+dYvkXql1yuRcX0Ch9E2QhjwnhD1+augwtTGbzLqh0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0QsGoKY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so4926998b3a.0;
        Tue, 12 Aug 2025 03:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754993393; x=1755598193; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P/aKqG7fY1LNdU4jwyXEd4Urbpceh+qKNGedxVIFJc=;
        b=f0QsGoKYgTTr2YtjTyb6X0E3f0iTe6HzK5XQRvYbgNavVTkPwdsIziVDR4idg9xE1d
         Q58gHLiL+0lfanvhjji+r6+dlW3qzdGHBkXlgmA60lfv2WHLekWVwCg+oCTBaRQdMG5A
         6ZjZr7sVVeurtEQIdzijfOP5cowIeSEO8pGmipo7lgZQMR0XEAVXD4FzLXMtCgzQyNwI
         IFgW0imux+W4dUEv67td0IRA55Wvxc9CGeCML2AANtZ6gh92fTaLkpKpnqXGFRc5prwm
         54Sw7MmfS8tPR26YW8xSZszv3j8XDwLyJ5Sc71KXQvgWd8vHHrtt9ZjQqvk0qzywQUtY
         JWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754993393; x=1755598193;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P/aKqG7fY1LNdU4jwyXEd4Urbpceh+qKNGedxVIFJc=;
        b=lh9+RcoFwJlQHbFkbTDWbHiJ4CT17r9hG76q2XDbV109I1WBkfbR2Mm6VNn80erN/R
         FKLrEG0tGLnlNZwQCiXDGf7ITEdnTaTY9BwelhHx1VXNVdFy88SaGGMPbyd0T/LuJba5
         LipSQtHY3PjRC4xOj6NlwbHJu+lIbcGrez/k0lxzUm1Uyr3QSFi1KZkHtXF5E4mEVF9+
         skeEW3Vq4838V+QSDcsUv0Xi7ybNwSYRjsAHtKN6vZZMFgQ/AWXT4GNF9UgS6lqtag2V
         1CBWBkdTUkfmlyWPB5UfMumiDxMqEclF27DQi6ZA2ye/BLfpgNFioSqeoNFUPYayO7Vu
         55Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWrNPEC7mJ1kf+ebigSpTPnmz0on1MAOpNCoZQ9FEVbxQbV/IxHr6FsRmDbnfrSsRggeM7JcVOlpF0=@vger.kernel.org, AJvYcCXiu2IOfjkuivRYC0bXmDlaSOHxFW7sKU+9t2h2gpPXZ5W4awTjBymQdSZrKvPnN4UXIoi1oS8zL9iEfDrz@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHSFfTKgsgcZVoj2EebzD5bRteKv+qmlOBFhA8WaHFwRUzbxe
	i74YhraAQeT++jiNllaSRIHvTwlTEG74daa4nCtqXe82QblRJKa+TD+z
X-Gm-Gg: ASbGncsB4JvZr+oN7JGr9FH96o9hPQ61c+DQo+LB1rOsa+4QadrxxeFMOC69gr28MDk
	hvgIJwYmAgYBxQc+7kqrp6QU33fL/XJfpw0MFNh2FLgDZD9KD2sK1H0BLTC73tjw+COzgvlqnQO
	zuv4vnDx6hB0Hy+/N37YCqWgLfgnlqLZvPXoRqm3AyK7ghULDcg/mrTbHZSfbyoh39Zl64uHh9K
	RxmRK33LhGCDPD85AhaqHVrFXeSvdLswak8B+l3HsuLSTdJ6/QFD6HS1pKCp+v83VXnEJUunFxl
	kPmdixNPwS1yxuFittUP70CtvdTRCbkHw2Ad8ujUmViaf8hDJZrMZufN5SiVwwH2CTRxOGA2VXa
	ecT3HCG5JsxYr17JS8swUBBZpn1qBT8Jf8ymuDHBbbF/fG8FCbpX135qIDGw=
X-Google-Smtp-Source: AGHT+IGhpjBlFVCtqKifefIW582qoUXW/+MuMV6QaAxlQhCOTK745+twCA/BAAXtV9H+RzFvQWkZMg==
X-Received: by 2002:a17:902:e547:b0:242:9bc5:31a1 with SMTP id d9443c01a7336-242fc3d395emr36043155ad.57.1754993393248;
        Tue, 12 Aug 2025 03:09:53 -0700 (PDT)
Received: from smtpclient.apple (wf122-104.ust.hk. [175.159.122.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3216128ce35sm16962338a91.29.2025.08.12.03.09.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:09:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH V2] scripts/checktransupdate.py: add support for scanning
 directory
From: Haoyang LIU <tttturtleruss@gmail.com>
In-Reply-To: <20250811212446.GA924610@ax162>
Date: Tue, 12 Aug 2025 18:09:38 +0800
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
 Yanteng Si <si.yanteng@linux.dev>,
 Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>,
 hust-os-kernel-patches@googlegroups.com,
 linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev,
 linux-doc@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <31217D41-748F-4528-B3C0-60CC5EB6833F@gmail.com>
References: <20250811170050.94997-1-tttturtleruss@gmail.com>
 <20250811212446.GA924610@ax162>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)



> On 12 Aug 2025, at 05:24, Nathan Chancellor <nathan@kernel.org> wrote:
>=20
> Hi Haoyang,
>=20
> On Tue, Aug 12, 2025 at 01:00:50AM +0800, Haoyang LIU wrote:
>> Origin script can only accept a file as parameter, this commit =
enables
>> it to scan a directory.
>>=20
>> Usage example:
>> ./scripts/checktransupdate.py =
Documentation/translations/zh_CN/dev-tools
>>=20
>> Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
>> ---
>>=20
>> V1 -> V2: remove the fix of missing "f" in f-string and make it a new =
patch
>>=20
>> scripts/checktransupdate.py | 24 ++++++++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>=20
> Thanks for the update. While this seems reasonable to me from a purely
> surface level glance over the actual Python, I have added the
> Documentation folks that Dongliang added from the previous thread, who
> really own and maintain this file (the original patch is at [1]). =
Please
> include them in future revisions should they be necessary. It would
> probably be good for something like this to be applied?
Hi Nathan
That makes sense. My V1 patch also missed Dongliang Mu and the other =
maintainers. Thanks for pointing it out.

Sincerely,
Haoyang
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..b7e3a8c8832e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,6 +7302,7 @@ P: =
Documentation/doc-guide/maintainer-profile.rst
> T: git git://git.lwn.net/linux.git docs-next
> F: Documentation/
> F: scripts/check-variable-fonts.sh
> +F: scripts/checktransupdate.py
> F: scripts/documentation-file-ref-check
> F: scripts/get_abi.py
> F: scripts/kernel-doc*
>=20
> [1]: =
https://lore.kernel.org/20250811170050.94997-1-tttturtleruss@gmail.com/
>=20
> Cheers,
> Nathan


