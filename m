Return-Path: <linux-kernel+bounces-801020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B91B43ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AC558592A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C3321F51;
	Thu,  4 Sep 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNUp/kGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FAA31A565
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996113; cv=none; b=UTiq6llopUAQYJtAJwsmuf5qT755kLo0ccDtysX1wGdRKwdrHRgbyKjdV+SdOHKHOBD3p9hSqQJi0Vkj2lOdDtauDy/QgRnb6sYYb3Kgm337fCw1CKg6mONUHmNkiexaMFCTOMz+9mCvPl1o6GaH3Rb4zknABduIavE5DL/cDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996113; c=relaxed/simple;
	bh=63EyfkQ9uLkqvFiwLzXISEp0rwUsp9Ea/lnRsSv+xzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+qD6VfxcIZvwp+N2FIXG5Mf4eboeLdnP72P73Jt4a5lcdvB2JDtjdsJOpmI8Sc92pEza2unHtXjo1kg1uv8NZr7g1r0/uk8ua03e2wzsA+vNo6RWiWnKT1xLeMp9GjXvawdjx+G4Gu3J0Ai8MVd4+6hY/cmsoJ8w3mVAWhiXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNUp/kGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0679AC4CEF0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996113;
	bh=63EyfkQ9uLkqvFiwLzXISEp0rwUsp9Ea/lnRsSv+xzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UNUp/kGmXFV0RUWtm428XqwVdG91ckW04CxVOzs3Gt34V4menHoNl1eE80tSRbJmB
	 pNKjAWdCpjEHGqRtFbMADeVixEyIY4EIVD+WR4DYm8WwqGKABJmQ/0E2MxkTomJ0eb
	 uSymBYjh4hgbVE3HIvUuh/SyoHDEnBChGUY44Rhlij1NvMtDGj4rkOLMDFqLoMbDG7
	 i3BZRr3+tQTqeQNTtbNDFnrI9GITgM/ZGMXAykyWoK/I094Gz1lODUwzX3toFZMDV+
	 nVgTFEbVYnBhmUhPGZTalZ4Y+BPHwa4SiAkHINs3Zip9bT4CFmpr/c1D3iuhiQfiUf
	 2OUnT7I+shAyw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b04271cfc3eso136390266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:28:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhb12x33CrLP0cI5SM7UobAPe2tUhC3ba8CeA5U8TZXpcp0a2ofkX2FgVoSXkhhOOFUbEK8/Gs1MqBp8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5j05oxeBkDaqOAOGa/N9er8aHeTcRlww7wgw70ssuyaX7+8h
	vuewC2B/rOno9URSojR+mAuHlDHqG2QTjXQxk9yRmvdOtN05POUZllDXXHn2o3HTx2sKj1nZu6y
	SJJOu8FuRCYBEuInaErCLVOYW+nNt5/c=
X-Google-Smtp-Source: AGHT+IG4SRozL+wVVcS2be0dFzI1Wcw/+YQJAtuyFgJHMDJBG1A0zxamLuuwbUDiKROt+aiUKZDd5ZA9Pyr1Nr1RhM4=
X-Received: by 2002:a17:907:9719:b0:b04:6045:f7ed with SMTP id
 a640c23a62f3a-b046045f81cmr847491566b.10.1756996111618; Thu, 04 Sep 2025
 07:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904071732.3513694-1-maobibo@loongson.cn> <20250904071732.3513694-3-maobibo@loongson.cn>
 <aLmd2KlBzFxJc21r@localhost.localdomain>
In-Reply-To: <aLmd2KlBzFxJc21r@localhost.localdomain>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 22:28:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ThTR+r6m-moVpLTLVsV9ozfwaJPBuwZ+VdHDXsamwTQ@mail.gmail.com>
X-Gm-Features: Ac12FXwg_ocMRfomyqjav8jGlObrS3AMIBO8OOryGxf6i8E1-teB9eXyiS-mN60
Message-ID: <CAAhV-H6ThTR+r6m-moVpLTLVsV9ozfwaJPBuwZ+VdHDXsamwTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LoongArch: Remove clockevents shutdown call on offlining
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, Xianglai Li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:10=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Thu, Sep 04, 2025 at 03:17:32PM +0800, Bibo Mao a =C3=A9crit :
> > The clockevents core already detached and unregistered it at this stage=
.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
If I'm right, I should pick this patch after the first one be merged?

Huacai

>
> --
> Frederic Weisbecker
> SUSE Labs
>

