Return-Path: <linux-kernel+bounces-841251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D1CBB6A39
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A3B19C0954
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F12EFDAB;
	Fri,  3 Oct 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoBYS/LH"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690D2EF646
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493879; cv=none; b=So6iZJ2McpF4dGorhckFOMmjvxhWuXtbTuvwX1zbqxGrcKNXWDrSiLIP+KZcxCFT7k/pALZRy1U4Hj85swVbMxr56AHTo/4sl5FsvSOxuieE9O79vyolysWwIUID46alk9CkmCcTiTA49qBmDnWHR8Zq6JWxw4+IM7RK0Bsajr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493879; c=relaxed/simple;
	bh=+Snt76doWFSgZXIi2iokf3aOziww8Z3E/0aceKrfcao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3maOAGsaI35AG9mcxhrItV5QoHUKlkCyCGrjnJsPMt2eLFqNvHsx2myw4Z2Pxdnz1NPCjtWB8sb1SC2sS42T94dStG1kw8fNlnXHX3WkcCvQulou8iG0UezcX2Ygzj8xbjHJArJt9b7KbgQXsQ5l9Pg9fenceJLVJL79aELOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoBYS/LH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5ca0345de8so63083a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759493877; x=1760098677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Snt76doWFSgZXIi2iokf3aOziww8Z3E/0aceKrfcao=;
        b=BoBYS/LHxye7V1HaD2qV4F/+tS7pIRnf/0Yqxz5s++vT0KiLzi7sv/jMa24V2+Mutw
         t3vQkDVmQR5NRYKbUGkfJjAJThCJm07yHi7ZQofF8+le0Y8k/d3yQClnYVeuSIyx9suU
         liB6bHdQx1Y4qVDxj1VeJngeFlEAi50DraOIXlXsKkxvgNY7DGOG1I8NZCDceb13xYsj
         thtdDObu9a4CmajJRbSb1t9zFWN9o8yJ34zCVwN7fnBU5ScMva3s0IxdknFi9rASQGwo
         +C4j3mC9YwiFJlL1W7O/fAAn4LsCUNstZtqHstXUEHlBHJ6/6n1SfcvlIp7W1gvOtyqZ
         G+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493877; x=1760098677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Snt76doWFSgZXIi2iokf3aOziww8Z3E/0aceKrfcao=;
        b=wKx9lhwUrKP1tq/AsYsWsjPCdKkMEKYWyKvjfIzg5LwBv7aZPjBGIaoJYveEbTyZGu
         iFTQte9tILQGrITsqNSLfqxt7O3OKY9mijim6N7PvPzqKlnO0GVTRsPNFupcM9A8k6dm
         dw4wvbBrxQeQH5U7fX5Q6avXxOWloMJoQ62sITi3zlFOfUXCx5QN2eBo72/Jb5YatY2J
         HfA6oultmJpdhamS39r/NZyTQwMBZJ4KpdthECwM6srdd5tOaSnBT2HRPDoleq4XOI7a
         crBkugO6J/86fJ7hRbZ2a49KHTRWftCpmefcALc+c7jIu+OgGJFjucZsgO6Y2suNNnKQ
         8UlA==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZvyM4qSErPaN42CKXI8dPZfevBY83DjC6g3zJRlM15q7JDS45wPbG9gmNOQNQta6ArO/9jigGRjLmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81wnRidJ9ZrUFBxvlTBuirRgCSXK2Erj3riMxEKKxEs1ImVFp
	smdRr0M8ffm4hovX27lQtFpyL6UP14iHMRu/voqE35qlvYFARi9uOsgn7rSVwLY7gfzgB2ObECC
	/bpj5PZDrN1BKgQEA4qKBUj+ApJT9u5Q=
X-Gm-Gg: ASbGnctBLRqS+LFbji2cy207OSYVxtnIm/B6SdG3Frl8U9KecHFD/gbu9pff8ePnik0
	tR+uoyl0uT3y0jcPUi/yWlYvvf4DVPWszgTKkew2U1ibdgFCrmUGEFmplxFz+bQyQ8Jn4UgrRhQ
	WifzrHlznyXuVFYtw1V5TRkMWmiNITYYzVpMXqFq051n5BDO+TvAeB+Wiq7RcDjCftyefz4kAXb
	BwzqzG06Zg20SUmljgD3C6b1Amz/Gab4R+8sKyVl/tLVXVfi6oiYjAKMqeCSApz40sZ9oSBnIDz
	JkIHrfK3pS+7X72YuKCChKfPdACZjjR9it5toY4vqbI0fdjJgdaDK/KqCESTlDX/b7etyjE=
X-Google-Smtp-Source: AGHT+IGk9cSxGm0BGzdwFCCO/DKuyQBht69QJq0J1pfK+OI+/sNOGnF/SLBrETGQ930FwNDtwBkptP9IjGNbEMhvX+M=
X-Received: by 2002:a17:902:ea06:b0:261:500a:5742 with SMTP id
 d9443c01a7336-28e9a6d2779mr20951685ad.10.1759493877006; Fri, 03 Oct 2025
 05:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN-0kfb7trsHUoVS@sirena.org.uk>
In-Reply-To: <aN-0kfb7trsHUoVS@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Oct 2025 14:17:43 +0200
X-Gm-Features: AS18NWDe2FuMclk-0TqZZ2NCKh26uw--IOmdBKdvjXlNAi6DqPTeDQ0Ce1wQxNw
Message-ID: <CANiq72keJ54v_qTm7TxoBhM8X=1xzN1nopkfG27G6ZQC=1C3-g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 mm-hotfixes tree
To: Mark Brown <broonie@kernel.org>
Cc: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Matt Gilbride <mattgilbride@google.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:33=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> [Sorry, forgot to grab the diff - was a trivial add/add conflict]

Yeah, accepting both sides is of course good -- I see it in
07586604e097 ("Merge branch 'char-misc-next' of
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git").

Thanks!

Cheers,
Miguel

