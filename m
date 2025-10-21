Return-Path: <linux-kernel+bounces-862443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D169FBF549F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B623D188DDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0235305042;
	Tue, 21 Oct 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx36LVtm"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533729BDB6
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035866; cv=none; b=qAiMG6mp+CDsP10AD5mdR952DaJJ30ZshniOXIQUMwYosGOnQTs9hz85dggZd+5qTKXS3ptBwYGILaM1B4VaTkkuvLgGh4CQe7cnlAa6mNZxUMdrdhbd+Sy70HVNFtKVu6ed+8M1+G0vte3m0Cf7w1yE480D8f6jABRTUdZJnRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035866; c=relaxed/simple;
	bh=QjyCWM2eaOA0G4njqmL1QXzj7R90sfd0dteSirTsca4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExEqzVYp5QUknQvsmHqXfcZKwPQw8zJlOKfJDLCdntEL8w2cYdc9e4PIdKr6GEnpC64Is14bOlWWgZXQ8YKil8dTzGZbIq96CEGMzS1gjauuDFWGckRIwTRb37sxp1XFY7f5UM9Dp7y+0/xCa53Sm0tzdNPske8VTvz2HXyUUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx36LVtm; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b403bb7843eso984410266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035863; x=1761640663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QjyCWM2eaOA0G4njqmL1QXzj7R90sfd0dteSirTsca4=;
        b=Gx36LVtmNIzqM8hPLu5g2RBt9sKc3Xr8z4YXyajQafsm8z+85hYTIcZUHC4o0qHgzw
         Kmj4C2v6qaauSPZnF1wYOt78WB9dJvsiwmXjHEkLP76V45M/cpZdTyu4wAXkPHR6YJGB
         KQ1Ab2eZp5Pl1oUxuF5xZdR64/uQNax2P4tEs0gM9s9m4wGfUAX9ZQnWzf8G9kIARh/3
         Jmd7yHDN5Ipy5P1irI+lgmGQYYyYwUfZYj2+Vjg9JcD4lBIVMoGlQtYWC4JBfgiu7fUU
         w+hY+fNdmrx3FAr54JWk/0CPr52x3/qktPr6h6nbJf4R2wP+R1pBQrU8wxnuS/1lz28L
         UeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035863; x=1761640663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjyCWM2eaOA0G4njqmL1QXzj7R90sfd0dteSirTsca4=;
        b=UgRKZypX6uw6pv0/GOF3ZyhVbNe26BK/yR1CVxZmEJlaB4YGP0YrOzCayihJDQNrh7
         z7z/UAWOKa3QyIRymAryrWdwf/UwLLAnPYvHhEBnst6w7xA8+3+e+xodvWBSnNnSD0aO
         FwqV+k7JzFsi/HMacElMH+NnwLva1567dotRi9Uptiz+3RBxyN/8GpzXVOJjyxRsDMw1
         Br4UPQWilRjXvrgmUTVgffEUFlCGklC+ndYm5Gm3WbNMRD6PBPQFQIrmDgKDWdoazqsC
         8a8Li7T7fV5LH5zZRTfUyfqIlGdlcvpYjHaxOhnjUJiWTbsTWz+kIWyvRULZfqcp2e9w
         uJJg==
X-Forwarded-Encrypted: i=1; AJvYcCWtv61dahunZP1qpI6PHtJkln3oPJ6+fyPZCgA4JShzdflmA4b6mlTuJe0YUimtO7W6xcfMpnApTN5P4L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKN6ryeZrQPmhnh+Ae/GBmV5fHqi3T/VMNZMThMYhYymf9Ld2J
	qEbzAjXDlitfG8RNFjIO9O6VrdTc245RX0/sbIKjcnEFNjLI1pBU2hU3Xaj5lgE7vw47PuAS4aA
	ZfoPd3IwhmZhGsQGXPNLPTUd0BA+x8Q==
X-Gm-Gg: ASbGncsXJh6qiUH9EEbYFXa41nxxnTdmT64Fw1RyIdvgWezzkF1wWaLQx8JK2suZJv5
	wsM5mNFe3R9/K+TWInKT+4k0Y3DFEUMdYLl7KlVyucFGE1ZkBNX1yK+WLoZls6FrBX0eXUa5uJS
	GCmFmJIoev05lk2S5Wz57tjSmd/lqzj2TOrVzb0p5vkLN1qDARnSg2nUQlelDTW0JHrlahptJnV
	1H4rdHTMrz7ZgfqvjVLgjtk4+62+9bdRUC+VnnZPP1VQTeNHtEQFDe9yw==
X-Google-Smtp-Source: AGHT+IEtZxUVPjSc2WqOyAjA7Fte4RrVXHEh4i2Gbt2zB79A/SDrGDESaIChW2EoFUntYRwCfCiMlt+Yi0KqlqbopSU=
X-Received: by 2002:a17:907:3dac:b0:b45:8370:ef10 with SMTP id
 a640c23a62f3a-b647245845bmr1951550566b.22.1761035862848; Tue, 21 Oct 2025
 01:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016103609.33897-2-bagasdotme@gmail.com> <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
 <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com> <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
In-Reply-To: <6b8e7935-6b80-4f00-9a44-7003071d1a21@infradead.org>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Tue, 21 Oct 2025 10:37:30 +0200
X-Gm-Features: AS18NWAkzMEdIZQ7IEi0fFSxQKz8uPinwHCWF-5cnXsFVeY8YpgVfIMAZOdWQSE
Message-ID: <CAH2-hc+M-CyXL1HtHkD9o_Q_8PP_OkYLvjqhdBiCnHVBQspedQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>, Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Content-Type: text/plain; charset="UTF-8"

In that case, can we use some short form? Something like
"extra characters are ignored for now, which might change in future".

Thing is that i wanted to add handling of extra characters, but
maintainer said it cannot be done because people might currently rely
on characters being ignored as written in documentation.

