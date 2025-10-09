Return-Path: <linux-kernel+bounces-847535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8AABCB205
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC943A9312
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83651286D45;
	Thu,  9 Oct 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaJv1RVS"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F7283CB0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049628; cv=none; b=RNMqSalMAYB4fR/4OAMzig3w/Y8Ekq45cbkQ2UvZDtj9hl1uTUvsum/ADwqurk0pXf5rVqXsAsDS9nVDncc4vtRNocGzVKuDcd807AhuiacG6+VovYtrlO/n4p2G5TzhHeFDQdBDNRJMGV4RKG85SlE6tVhmJ9m9N9PaCsdQWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049628; c=relaxed/simple;
	bh=M6e0lLo2ewKkd/kQqJgHVGQHIBCAr1kn4xh0t6SXKO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axMFwLCJq5R+dTOkwGHmz+MZ7njxln0R/VKFW9GcNqlnu7TX+iAikhX21lcCAqNXXzVc1p5Z740BavEiHP/FjWZwGj9zaoCqi8VB5wclaL58Z5PZyY5sBSh9C8+jqpuiDkuyguQRd9AqeFnvmYL6i4TljFscO70mzyyheOh8t8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaJv1RVS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-375eff817a3so15263481fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760049625; x=1760654425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6e0lLo2ewKkd/kQqJgHVGQHIBCAr1kn4xh0t6SXKO8=;
        b=UaJv1RVS0X4Sp8PyxHJ8e3y/jhTiRr1tMcgFAW6xN1Ft4Dd3w8+0LotW61XHEUNW1+
         xmMnXXESpGaqSxNrr7uC4Vul1olvCNgnqdWTrev5cE8YY61t/5Em2QkR5QVQxv9J3vNa
         FP0NHvys7X87ASOoUfQ1yljAmz47Xv9D51iUF17aHrnJ4f70L6VKkzSgXTv6OxxK/dWD
         IeJN9RTHkqR7KyPvd7mp7ZUMJdgHYgyoto4wfaxTZMANAzoU3riTMyqbcxGmKrY79kDd
         2BgJm67a4++bMkLU3qfsjAgQk6fTp4j0rObBj0bVmvP8vsWY93sstdPcBy9eQJIrUJd1
         OLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049625; x=1760654425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6e0lLo2ewKkd/kQqJgHVGQHIBCAr1kn4xh0t6SXKO8=;
        b=UGuwKLlVR90vyzsTfjjYY5UfqgZPsYm00w2lyfyQASiuFgRJWeQphh9SEH9zuQe6jN
         O//9qqM3c1RjbeHiOFv1mUVKDOY2or4OYO+sLDq0j5ZaaSdmJu355AtoGCfl1Q/kjg3o
         clHJZNL5yxRIN0ejrXI8iQwdtDLuSqThzi14JLlRg6YrvxDH20kT1ShqsoWnfHufHUds
         WCWHwwjfzD+W5cwPE2/hlnoQXRRxCcSTnk9jxe+5AwdktgynNsm57o9wIDS+MJWf+ueq
         NmSTZlpYfmhmU+xDselG/KzId+ElqEsClxziaraEI8g+GLXiMv9TR9Q3pXHRgE1mA0Zk
         gokQ==
X-Gm-Message-State: AOJu0YyPPKYJ/OnyUt7Dt6wZ+xd47nVhAuVxP0IaAgP39bdsNuJdZFZo
	7IqAcWbMuxjmnNF+oQA/8acZ11mWN3ob8l1m2yJmyZ1LdEpKeJwgakr4bnjMdh31H6JqLPlBszF
	vtG5C3a2gBoAEKXba6yn2kn2ZVi7eYPE=
X-Gm-Gg: ASbGncvrLgFbQqKeqDtJFle/MYjiSMEH/zCT15e1fgK4wjbPd7F93Umeb/2TNG4C3qd
	kb/5rDFeKp8zoK6cO5eFJHnD4CoH7bmn9CcsWLoq7ho5rYCHPgTfBIQ9JDG0HoM6ff1gw0ROfN4
	avG6/53wZCMsC86QksckyqHLB53kP+ghrj5/X/9fydR5R3lw6At1FiX2vseh0P0b8/AFT9t2KEd
	3+5pTUVnT6L6+ee3uhmci1rF/gvKTgU1lf5lXvt4Xo/8bLdNghbU8SBTdoZ25w=
X-Google-Smtp-Source: AGHT+IGEW2alBWkjzDiYpgPpc/pGsbXu591PKEt5s3hg72/TqO9rtjwluxnWVjQhTZiPDkhtNCE1uF0d5x4jRBfipp4=
X-Received: by 2002:a05:651c:2122:b0:36b:1a89:36b0 with SMTP id
 38308e7fff4ca-37609cf0b08mr24925021fa.10.1760049625034; Thu, 09 Oct 2025
 15:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <87zfa016bd.fsf@osv.gnss.ru> <CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
 <87v7ko11iw.fsf@osv.gnss.ru> <CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
 <87plav2186.fsf@osv.gnss.ru>
In-Reply-To: <87plav2186.fsf@osv.gnss.ru>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 19:40:13 -0300
X-Gm-Features: AS18NWDjHwXil3ph_UNaumFxGYtEb_LFDe39C72IGkbQ0FqKmX4_8lofBvm8bo8
Message-ID: <CAOMZO5CsY-zRPE4hm=1kdTVquY24Y4T3evQrn9E792xZ434vBA@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Angelo Dureghello <angelo@kernel-space.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 6:51=E2=80=AFPM Sergey Organov <sorganov@gmail.com> =
wrote:

> What defconfig did you use?

mx6sxsabresd_defconfig

