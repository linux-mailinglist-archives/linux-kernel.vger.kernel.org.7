Return-Path: <linux-kernel+bounces-826548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DFB8EC40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC08016B1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89A18DF80;
	Mon, 22 Sep 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAEYAb9+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FAF1BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507652; cv=none; b=TymlGuFgorG6qcMNG2aUsgJwq6AQokoBbMELdzEZc1uHgyxmZINafbOHVoysEGFHDifs3VGk+065MlGaIGLnLtqqhurMdp3pM0xEUekEqaZzMlWE1+Icx/G9px11eQK3unZD5YOSo6xigY2t2kX3rfev6PkFYvjbDI/n/N1E3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507652; c=relaxed/simple;
	bh=rrLtrypaXlkGgPvAMfpNdsjrYX8wXkj56OiYdotmDwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvBt/pea9uOXRadoYEAhMEp7PCpqMNeGEZp/x/h23PRZaxGaLG72EWp/SsaQELfxSe4RKKXIIV7Peg9yEqVqRakFuGp7+duHOVqDTIZZcCbqJNST+UW3BvoXLgokWohACzG0sbb8uF4ddkg4Vs4c3XC/+fGOjluRy9Xr9OqKWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAEYAb9+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so25169015e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758507649; x=1759112449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrLtrypaXlkGgPvAMfpNdsjrYX8wXkj56OiYdotmDwI=;
        b=OAEYAb9+jsSIe+QtJON8Tfku4FlPeSpXo6wBVf7CEjiZrf4/ahjhVtcuLdUWhtpKTi
         RuERI8uVJ2rmbuFjmXW2roRwqrj4UhZrzgmO1GCYYSSyGMvTHcAiQ+4d5jiHbs3bDCTD
         JzkyueD9AZIuPc4/IozKIbh8W2Eji+k01FyYZEbuFiTMoCTw32epEbDc5VnkJKkpqQYd
         nd4n5Wsf/m/Qsz5+chBRLYQeXFZ5f840FyPXDHCYa15TjXFTSSIqSZiBURPgW+YCdnCG
         vLY5oW1vNb1eqH7FG8eEi0UATg+3Ncpy0/wcmUj8FxBOYMnYERGjv9MD92vLI7S32OSu
         xYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758507649; x=1759112449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrLtrypaXlkGgPvAMfpNdsjrYX8wXkj56OiYdotmDwI=;
        b=AM7GQtCu6LmEVl1jCY+Pgal6VlHGKlUn7fhNaDJu6g7SDVAYBqAgyHA8/2CPjLfRQc
         F+YefFTLu9sqkGOGo+5MHYrbORJhI2aBDHbOUCnlf8QfMwvPl+qAT2BRKb9qm/KADhvN
         DUQkDn8RVSGWgvBcVFszvlcqAarvZXte+OyHSBPyq1ZF7dtBnhG7ndW13mz0jLk6igWy
         5kiq6FuRXjdTyfQ7zxJLMr1h9Hiul8Vh2n/ih/ezfSX4GmFtLPVQeI0vGmO3EsWrLnlp
         poN+juuMjHmI0ZgJxFbBuhyolTTR6Er4D6FOYDzj0CJMx7P6HNTkyjET3eXOzMbTeLNR
         P1bw==
X-Forwarded-Encrypted: i=1; AJvYcCUzoi/D8EkYy6icHwtnHvKomv/ke//P0R7h5jWbuAScpAH1KIJrKOcfkRO/q9fYM/+k3qz/Tdu4dZ8lv68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOLeA5yIz4LR3BKJD4jcaj+ZQfeTIeD8TKiRRq/sk5sglZ2UF
	31fA1rcqPxfixGpnsjOYTMreYtnsP5aEBhI7F9UFz5xaaTsWiSOA2dNHKZ07sBoaJlTVwxZHlY+
	N1q/9FncuCnZsnN+7+XBYXAy6zFFg1AhoPw==
X-Gm-Gg: ASbGncvEHK7/fWmsGD1mNA6FvKNAP+HoXPgb+7MEuGvE6n5Sob1i/VYc31v4YfpzKN5
	yVNnUY4aJ//QY/qSh2Dk6gSK2Z3RXF8I8IkWkDZQUhLSQVxSjt1wa+L/o59agiK9897VkquYpBV
	1Ew3JHCyg8WYt5wTg0Sr51p4GbiWT0X0muSwmCIIm5HGD0eTJi5n46yyh8R7/So2yRzn596CyJU
	4reGgnZlrXbnaAhJicQowK8rUgdX4n9pqfG2HlK
X-Google-Smtp-Source: AGHT+IHZAqJ4vVPVEpIZ9GfuvKoBYxciNvoTMSZR0aT1j86n9fimDoVVLI1Xns13lJMyWIb7OpofOrH5AwNCxpbIjrA=
X-Received: by 2002:a05:600c:a4c:b0:45f:2cd5:5086 with SMTP id
 5b1f17b1804b1-467ebe9d9ffmr111065505e9.3.1758507649193; Sun, 21 Sep 2025
 19:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72f0108c-ce6c-4f89-b04d-2398d7c808a5@kernel.org> <tencent_07A006DB31D2CB8040AF8B2C4CBBC25E7D06@qq.com>
In-Reply-To: <tencent_07A006DB31D2CB8040AF8B2C4CBBC25E7D06@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Sep 2025 19:20:37 -0700
X-Gm-Features: AS18NWC7lOc_MsoHN1P-f15QANPwwAtVActQ4l66-mMOwn2bst_ltAkG9yKDHHA
Message-ID: <CAADnVQKZXEsN_SNg+WgOT02hdREM93zyDr=9fhgdJZYVzv2rfw@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix netfilter link comparison to handle unsigned flags
To: Haofeng Li <920484857@qq.com>
Cc: Quentin Monnet <qmo@kernel.org>, 13266079573@163.com, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, lihaofeng@kylinos.cn, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 6:52=E2=80=AFPM Haofeng Li <920484857@qq.com> wrote=
:
>
> Thank you for your review and feedback.
>
> >Did you actually observe an overflow producing an error when sorting,
> >here? Or did you run into some compiler warning?
>
> I did not encounter a runtime error or a compiler warning caused by this =
potential overflow.
> The issue was identified during code review as a potential risk,
> considering the theoretical possibility of wrap-around with unsigned subt=
raction,
> which prompted me to submit this patch for code robustness.
>
> >This being said, I don't mind making the code cleaner for these
> >comparisons, but we should probably treat all three attributes the same,
> >and update the rest of the function as well?
>
> Thank you for pointing this out.
> I will prepare a v2 patch that thoroughly reviews and updates the compari=
son
> logic for all three fields (netfilter.pf, netfilter.hooknum, and netfilte=
r.flags),
> replacing all subtraction-based comparisons with explicit conditional che=
cks.

Don't. We don't fix theoretical issues.

