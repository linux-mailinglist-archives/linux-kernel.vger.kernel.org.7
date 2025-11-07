Return-Path: <linux-kernel+bounces-890961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A2C41764
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5453B4E564C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5765302CCA;
	Fri,  7 Nov 2025 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3Jfz4cv"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75462D7394
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544780; cv=none; b=B0biHcM7mEHrjg8d315+49r6qYTdqSGKAmVwgYP/a5dwrDic6cdxPvkfQeJpVG15oEq7iEzUfrOQMc+4eUj+NkfvBe7QZZ1/FHqvtAJ7I6ClXIi/YaCYBmyi5w4mnpI4acNLkHn7lFMo0jlXn5e8szrdF5G7wACuEnhse7P/S9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544780; c=relaxed/simple;
	bh=xlbuM6n2MymirkUEI4+i0kiqs8WPB7VoMaWqQpvy9Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXQVH2O23PMhkEFrruGH7LB3YmKXBE1pF+xeXg/n96D14ko1Bw5akUXI2NslfiHVT3QH0fVITLRUq7b6yBsY+hp2eHylKs284F8DjbiwAgFmwx1pOQyEQ4JtH7IIn2of2OykL5umvHayROrHHriHm8U18x/f97rLoy282IXFvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3Jfz4cv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297d6c0fe27so697365ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762544778; x=1763149578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlbuM6n2MymirkUEI4+i0kiqs8WPB7VoMaWqQpvy9Qk=;
        b=h3Jfz4cvjm5DwyZTJpUwFTjJInCvfdOSiriDg+60tYpaz9xbK8SuGQx9kekf9z8o8O
         jXelQGHiKD3qRaNQb6Y3/EXIDAn6YG3g6vL2Xq+Bhcm57c4ed8tb5bfHombDgUYDjJaR
         cJZV0BV1BEt9i6QLftegKL/Q2MrWV2L6ozMEVkk2QJcin3xOuNWjmr2rASoMSb6GRQiR
         91+KpCslnxEhbmG3bsvi3UR93j1khTCJi9LF9lk516Zpgp72m2PbGH1lmqVuVOFCXxoh
         MlHxUGcmpWu0joZPymhiARL2GnUauA15VaHspyXLwhfk+TcveRL6nqbP1oJWxgstZ4Mq
         Q6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762544778; x=1763149578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xlbuM6n2MymirkUEI4+i0kiqs8WPB7VoMaWqQpvy9Qk=;
        b=bkHfDlZ3lHpwhYcOAc+ZuOa0DeXUZ6UCXWb8vB1BOZbYBy5QKQes8DbLpluUpzIeSq
         FMyBcINov7ph5Js0obeui+0jqfF0+kwV2/r51/fc7S+2MywZa8Y88pW/0xoOdfzdGuJu
         QzG2GT1cvNZbaTnlzL5HNHXLGmJwax7MBWkbUFp9BW39HrVn8CyiNcdkk7Cc6yIKcWcf
         qRb0dBREq8O8OXMFYPGUXc1bDWVrGp+rEa1CsSxL2Ra3pivc5NTtzFHdtu7CdlXesghd
         +LRvr02AXJkZ44QnjUVgUh/D45TPMFsk/Jv6nIz45fINaJ6rJgwOhQtMNtQJ8o+FYdQc
         IvLg==
X-Forwarded-Encrypted: i=1; AJvYcCURFUtTNwhI+M9AIRz5oVYa87bFmR029NfSA2Pna58UdXyaVgkQrHlyxWzwOXLfCwMRjj2ehryv/bov5oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/LNi++8JyZzJ6tyw9r9Tm8GPCVbNeIFosGu9Ay8i8gk00bh5
	sR+WnNfsDOhuLK5wlVrD4oGzUzmBycCUbEdjggvp750NssEEYqpVHPlrJfHFoG3xNbRoV27r0du
	nmFso78+/ANRXUu8ljoWNtCbvqmbikMoL96ur
X-Gm-Gg: ASbGncvDo3C0h0hgwc7oV7WAvNySWERfFI7BygPzznQ8JLQT0BErWYOwU72+SQHDU2l
	exFhGfbsaayKrB/ThbToyMSJ9QsS+VgFh2lsBlU0uDceSL5wxCJPxx3PjHeAMEftr+Dh6qksfkZ
	o7UdfCbwFmFpJRhQO9zoMUkuc4c8yUdvAu9KMzLTaq9kaWWZCHoUxCyZCCvupW3kY1CsuPmW7Q0
	gdd+hKAXBVVXOBaCc95+lgpO0Qw0olGu4+SMVYzDUe2/vRir3k5FDKPUqdFqLORLESbpokfLHW3
	8GXg6TYx+POAArZRjxZpdRvuUe13cf5ZorTD68zHn0PKTlOGfQHT69X006SE8QF6kNjQVZEDXw/
	EosE=
X-Google-Smtp-Source: AGHT+IE7GGqiPMYJY69OvQG1tXrUrVynmdFgHO9eQgrcVeyOxAYAmEo6aaWBKd95h2Y7en2cXbh78NdxU/R3ZyPuRy8=
X-Received: by 2002:a17:902:f683:b0:297:d825:bf22 with SMTP id
 d9443c01a7336-297e56831acmr1668265ad.5.1762544778161; Fri, 07 Nov 2025
 11:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105062723.GA2341496@ax162> <CANiq72k3WuXTyk-X1ye+7JThf2pNcgdKnqOrFieHqxOMZD2oZQ@mail.gmail.com>
 <20251107193252.GA3606140@ax162>
In-Reply-To: <20251107193252.GA3606140@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Nov 2025 20:46:06 +0100
X-Gm-Features: AWmQ_bkFFxAHKXpnyt_DOx5JnE1cyhg5MaZF3Q49FcBJ-_O8h6HQrHup1Xi97io
Message-ID: <CANiq72=3aPM08LvtRpizzYZ6EPw+dsy7sdSWZj5Q5Tkgv64zaQ@mail.gmail.com>
Subject: Re: Prebuilt LLVM 21.1.5 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:32=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> If 1.91.1 is coming soon, I will wait to fix this until then.

Yeah, no worries at all, it should be out soon -- thanks a lot for the
quick reply!

Cheers,
Miguel

