Return-Path: <linux-kernel+bounces-873895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7472C15062
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9728D504966
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2E1305946;
	Tue, 28 Oct 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1P5+oPl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713B257459
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659862; cv=none; b=Yui4CTTG6fKJt+A57HTFDhqlVuyUlLr3L2xx004M+UX9zffW67jKxjhrL0dzWOlB8bXN9PZAveELtcBgmXxLSLr/EjaDW1cg9uYZFbkBo8C8AZpLpgXGwSxBV4Gig9H6fRWEwBiSVmEX9BI3mt/Miwwm7pqe0qLJ8wsx8t/IW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659862; c=relaxed/simple;
	bh=nV8aVqNOJAIyIjO/EUdFBuENKUMJmFxkUUBjy1ynmIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leQgydCg3wFMlnAI01qoSDqHkwPMt/d8VS+gII2xvgaSqKNVcEaN6mmRNDwbbO2vdfHmonJpFAKX24tvbQ1Lqz7BquAIH5U9X8STfecfp6gAuxdxRnavcV8eMCBJkARzyJ5bEUxkql6UaODYNW6DRxFIiOpuU8XP9QHy7/hJTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1P5+oPl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-591b99cb0c4so700822e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761659859; x=1762264659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C2XMyUgu0EHbkLApoQMoHRbeyl5zqyqZMRCLgfDJEo=;
        b=g1P5+oPlWgZ9CxUj11nsE68Y7kuCvnhAWJiZMttzVN+7SGSh1Hi3Wi2ycPRVAZv/OB
         /3UNZcd2zyl5im3c6Y9MpMX3t2wtioTB9B32myg1d5GoBhmk7JxTDguhODygf2Oyfcat
         azxfXaoSzj0YsHU59cYdLOlHRahrUAlQuoLaQ1g/Qz0On0ojDGGQbgeiEuccz0ltQd6Y
         AI/EdR+7wLRzUlVX/YuPgk31POyP/lzQpZiDEr9phBCNXUgI/phu0TI6not+bZF6fw8r
         Yjwf1EZmkBdrUOJKItEeH9YrvOnxPi6OSetlJsv/zGPqe9IHEXR7wWK4IRBMgx5XM2Wy
         ZhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659859; x=1762264659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C2XMyUgu0EHbkLApoQMoHRbeyl5zqyqZMRCLgfDJEo=;
        b=YGbJl+g7IN9EYvBOKieLlv/VVb35e/UWS+YUnI32RW89D1hCz1zZoPd2B6kXTwJcuz
         8l76rxu3y2jqkWtKM+yhxmV8mpPh17Spm71C4ouaRwq1UA8qk4vCqeNsAu9btFKfPKei
         r/7BUI9X2M1GFS4ajHjgfNnkIGD0yu9eqzJZGVPOF36xsyI96hso+cMGzkuhBiAilrhT
         lqwIFaVWM2Ud/Jorc6jkE/f+JyacIH8vyoNGRfhzhP0iiS6KDhEokQRyR1G6iwAmMrks
         BVzRH7MVS+AULrvBKcS4/J0vqYRlSvlsXz8ij84XQaOsGm8GIU2CkJLRghXny7r6zDwY
         TfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRkfmOREx4qBq8IdtGRqIuKoFPkDuChFs8QEcsDNSxyogkwyIgd7FBD4nyD4n8944IR6nhYhfBcuI0CxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sNNw+n9JVxp+mtjioRK5mur3PjCpf/qLS/p8brgaFAdVagSL
	Eg983x8mrKu0oqkL0oj/jMTUNRCCSdS9FKf8tgy6UhgSZUnR1L1sb3hXIzDp6xmPVVhvsdJagur
	bXSrUtFu8HrkpA98BnRvk8/n28pt/Lh8=
X-Gm-Gg: ASbGncsUpyk+1Y3mFuSlbW25u8IWAkKap4TK5YD4uSkc4JmygSfV5Zy7Y/HftxBDM5/
	uzwwAm44ZMIgiCKnTGgyZoJJr5nyPfMnBrzxwwx0P/iU43zM7iXyqO3cTMbmgB7M8Ev5UrR2LDN
	gq4TlxYTfDcZcMG+n9mYfJBisP21OEkeqzjzRqFipqqzYLcZ4tI0IidSOM1qKnIKb5SgR7l3l8T
	njZwAihTnmkrQwviHn+Rr1YZi95ZJITCHve4pAOmNJteWA0WL91uUR7llxU3NI2HQYr4BW26kJA
	b6IfH3zEahmFGoAhjMtd46PF3fbCZSK910URvRZjwEu7A8MuV0886scuzlWxnBwG2akzjwhGump
	q/LlS2EBmlSNQZw==
X-Google-Smtp-Source: AGHT+IFS57SRzyAyh1eA0T/y//nY2/lPuyiomWpmCMnvcaMsoEebfDQSxTVSOlnauCaDmOiZN5PfiOLQuY4tBm0ugog=
X-Received: by 2002:a05:6512:a90:b0:57a:8bb8:2a26 with SMTP id
 2adb3069b0e04-5930e9c8d1dmr707784e87.6.1761659858839; Tue, 28 Oct 2025
 06:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-5-dakr@kernel.org>
 <aPnoTV4kPz5NHGBE@google.com>
In-Reply-To: <aPnoTV4kPz5NHGBE@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 14:57:23 +0100
X-Gm-Features: AWmQ_bnk18uRC3GZJw-yqZUBJTaPq1ujFmD1FsVkdoikw4byHiqEGaMJE2xDXoI
Message-ID: <CANiq72nSugiQhNU++HYGi=N6hUN815copxgXnfW7fXt6pWhkjw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] rust: uaccess: add UserSliceWriter::write_slice_partial()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:33=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Isn't it more readable to write it like this?
>
>         let Some(src) =3D data.get(offset..end) else {
>             return Ok(0);
>         };
>
>         self.write_slice(src)?;
>         Ok(src.len())

Yeah, I also tend to prefer that style for things like this, because
the "main" operation (like forwarding to `write_slice()`) is at the
top-level. rather than deep in a closure. Plus early returns look
closer to C.

Cheers,
Miguel

