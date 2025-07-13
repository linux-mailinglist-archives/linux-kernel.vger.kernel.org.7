Return-Path: <linux-kernel+bounces-729141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB86B0325B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB952189C47E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B02853F8;
	Sun, 13 Jul 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhfNZzJA"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675471DED5F
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752428319; cv=none; b=Gmm3lSiZIoCzV9OSKxrtU3AHqFRueMDTOXhbhb4B9V01RPjYQOfsjzqVQjSJIr164PvN3Spb3S/ZIrUPtJuB5/u9B+6gYVvlKbRZXdwnq5bYLp/E0z3Bd5Nx8P0y9WB3hCRi4Rzz0ATT8lzHCKTHj0KSI9RByailkRZyKebhWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752428319; c=relaxed/simple;
	bh=J9bYEcw4WqOgjR7eIs5y5uFTipDrXKanpPspWJakxuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7S2cIrAKSncqOei4/cR+3ux5Kq8MV6YjoL3YCalv5L8BhEM0dQ6bbzPr+GUptdBDOlgw4+CYClN5Vv439GZgOr7l/pKmkEiQpUbHG+x3h/y11OkybgO2ge+FeRkCRhM5VwPBjjVqIM2tSqtG/DQCOsMpjS4lUSMWlvByv8ctz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhfNZzJA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313756c602fso673696a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752428315; x=1753033115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9bYEcw4WqOgjR7eIs5y5uFTipDrXKanpPspWJakxuA=;
        b=GhfNZzJA42oGxp7kEARhcN2LPGihDsANMF4pO4JlugnHCG4eCd7ds3wLk7hwAGjOkY
         hX4+GwN4SISLUPmK436iPDe4i3TxZghk39SFjD5jfQGbCRThd8JU93wy7ttd2sadc9XL
         2ek/f2vRIm5CvKIGDMywFMWf+RmwKhlDN+W3VSTbGmTMYq+fiAsPFlvIE0VFsK8OZQjX
         mR3HG2KcKd68SWOY+JNE9GeNQe+ZPQbZ2b2/9BySHgoEh3QhQk53iU65+TuhQjmR3WqO
         nHep8iXJmT0rF6llGcI9Pbw7Hlv719/Jdwu3F9VjmPXmltIsQpYQZNVmvOWA5WfgnSFB
         yDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752428315; x=1753033115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9bYEcw4WqOgjR7eIs5y5uFTipDrXKanpPspWJakxuA=;
        b=YBoBxlbRM1rq/LsZX+T1PJek6fXkJeUpE7/cpD+FS3tLefyaZ6Vl0d/ER0/3BzQad+
         cg6aGE56vrmxszGpJcz5JajBZ1q2zdx9PT9/V5396zW8phPKpbxsMDw7oaOXiHgjI+Xv
         9NlgEbVJX3QvYaqhfbS1fbnSAnYqpMuz2yjKUVqUmorz+t9paunIItAlmNTgobKpuoVV
         qYjkMsOlO9cghj4ObU/E23xE6CbJdre2fj2zGa6UTbzGk6tMZZQbx15VKAYco38p/68V
         O4vczB4bK5KfonJKBTjhMo9atVqKuJZ0N5bMfFMa4K+UXoPD/U6ZH8xG+dI+yV1LmDy+
         KwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVndVbFfbpqU593ymDE8BtEOwuW390iiVSPV1IDjgMKzyMVVgbtGJMgV1bH6PBXKVEpAdh+/gl3OF2QjYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJTiLgAq8dQNrAyiPf4fCK/pdXJTEDcHgXWDybPZgH7Qcru7p
	FLGj0Zo9Dm/ZTi86UvvUuQ3F7135xCFwpe7fT+pQeSk2i1APdfQw3+H39j5mTBt1G5M/Yt1rwV9
	QPnR839ghuCMV7Nhe/++Mbm1OupW2X7Q=
X-Gm-Gg: ASbGncuio8TRE5JTXBYH/CeizxL0xz2xlHhwLJaECpTiBZdK3NzL3Xz44mNrOg4oUEI
	rULxY8O+ofxPTM2Q9FaDNzzxocSvLqTY+S/Bn7QG/pSdzQzPOfuVLAmkpSLZsRM0d9FsxND0fGV
	YUaUuRgDo6r+hVqPkY2CfGs0I7iZFbhYZ05nH5XWGBhk4mdNTMlKt+iDCkFA25YYMyJC9qBKq94
	OUO2jKM
X-Google-Smtp-Source: AGHT+IEWEVF1OC2oUwD8umY5waQf51HdKGPJVMy2wQNwjrmHrbTafnX8z5+pEmS46puO7Q0K6dVT9uc+zLXWAZjkKYg=
X-Received: by 2002:a17:903:1106:b0:234:cb4a:bc1c with SMTP id
 d9443c01a7336-23defb22a52mr60353745ad.6.1752428315128; Sun, 13 Jul 2025
 10:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710165801.GA4073042@ax162>
In-Reply-To: <20250710165801.GA4073042@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Jul 2025 19:38:21 +0200
X-Gm-Features: Ac12FXw6vowHTS14knzR56B_R98nepXyZ-xDtlJK7OPEYb9id-rdVO_UGFoEXK8
Message-ID: <CANiq72k_tDfVWynEiwd4NAQKQTuEMpxNzGiBxZHsCij_XWXgFw@mail.gmail.com>
Subject: Re: Prebuilt LLVM 20.1.8 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 6:58=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I have built and uploaded LLVM 20.1.8 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> This is expected to be the last 20.x release. As always, if there are
> any issues found, please let us know via email or
> https://github.com/ClangBuiltLinux/linux/issues/new, so that we can
> ensure they are fixed in main before the 21.x branch cut on Tuesday.

Thanks as usual!

For Rust:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

