Return-Path: <linux-kernel+bounces-843974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6DBC0BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8BE84F602C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952662DC346;
	Tue,  7 Oct 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYJO9vu/"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6D2D5940
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826132; cv=none; b=mmm+wGI5wmiCxjI8DDY1Qu5GS70LdNw7TMzbcTtaH4OFP7qnZj+uIT4QqCemJxol6VmFBESl0rCpgDFNou5FNj8QPg0YL6kazzlZ3YXuWNsR8AXS2KcqBs9vysZWUzOMi6DpRYs56RUrwqz7EXWsXFTcBqd4LUuBwunemE/iMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826132; c=relaxed/simple;
	bh=oolnhmzp0phxU0SJgt+ZTKmKtIqlWNaICASfkcDvAXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXzVmPDjnpJUBMQmtwFMQDhiYZ9rfleuDJrYQCZQ1w0K7gB3q01tHwgiZUbP36J+ubaMi4bnxMjM/V2bOlHB+iEsTJGQcLodY8aEUgF5e1KWWeycngo3yfh2m8lVa48brwf8AoHnSeqQ1uYjVYrqTsZnr5Zpj7gs3rbWskRtvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYJO9vu/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso574968a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826129; x=1760430929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oolnhmzp0phxU0SJgt+ZTKmKtIqlWNaICASfkcDvAXg=;
        b=JYJO9vu/5BfQtw/EHJ/7J8ZR5ce5NSgqACEHHixK5nAbfBkWiosi76+Zy2VlHLYwwl
         p1YzjoJz74ukxhhclhxWAbgm7M08T2X9tY6lzSNlo9LkXVCsEbW8i64m0+Kk4VcLu2Mw
         ZgcMBJjX37zgCLZbW8GdGspZkmDI8NTCQNDZPpgjpy0fRLFQltiDgyixSLihFbJnXE0S
         sOLfAMQg888fstIC1El6BZaRtTDMZlnj+PIKOsRHaUY+9uMRjFmGG7Egm/6vDEE1bdeL
         oLEwKEPVJRXrxxmK90ToG3mYM0sVWYnCVb9Ly2S6/x/ZywIKCjA7ZkWXk1tcESiQp9/x
         DLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826129; x=1760430929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oolnhmzp0phxU0SJgt+ZTKmKtIqlWNaICASfkcDvAXg=;
        b=R5FLEILDfmWysQv4sD7jNSdNa8tdIiDw8ota26oQqklk4RzlNW1Mw0FQLWZSJJU7Ma
         gH38Kllq0LbbSi6FQXMbao2oiN84fCGtpGMtmLoO/mJaJhHuwPz43O/yC38NumeOPfkL
         0JyFMKRi5G3XARRFdhs8w7FYaIPjcddP/vftXoKPuyn+zk2oIHv15c2tfzmOj1cSS/4B
         U6DM2atrOSN2Q/Y3/XZIsr7KupEJcoiIa8wqj6TAvfUWMljVU6KMUT3a2xJ19aQe2kdn
         BaTbJcUU9jLdMBgHkyY20z0YtGAZU1ys3zrmqARR9zdufybAOb6dWMNuXLp0dzyAbPx8
         ZqYA==
X-Forwarded-Encrypted: i=1; AJvYcCX5xMLC3qp2KK3tIVmyGwFZRfOuaKVQExKkwfQpUomYe5UBRMJxXXU2iYsxIyHekdJAqFgmXYfAOAwsrXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiHW40djVA1W6Rhiid2Ue0LpcvKO7rAIWZtWnQHLgskQpRsNF
	MzNEuYfnseqD4s61F8VD8mcI1VYdTJPdvXnh7/K7aCNP1QGf2G+eWP8Z6960ULTEfsCyOvpu6/r
	+k5H4ge6xMn1ttM/1gzezDRlmCTa3v5o=
X-Gm-Gg: ASbGnctBb95oyDpX4UQk5OwzvaUS7LxdfC1gcXE9mCDlvQDMuiUtP+oNPxq052nLd+Q
	M+4ld9xJ3b/dDZS/XJLcCqAHTxBLfzu7PcEWfp3CSvoiybl9kbFbP0OL8Mn6GNJCOfWif5i19Gr
	r3hvAFnpNA7PhskRvy2d+/BQx7cAhDiKZEhu8UGlXG4T+golbRt91JxHn1Ki1pAgWvCJ9NzVUoT
	RG/agfPKNhOOsKp26MH2h5MZL46xlqSUjLatuFxqEJmwbO6cUQTFs6+0HqiaaZE1sgT3DePUBx0
	vg==
X-Google-Smtp-Source: AGHT+IGGUtmjqlLFO7DiLm+f7ClYBfwyRmx5vn+CRzV63l76mmNZeJM8Zill3iy7if7XHgjFS3vA81VNOf3LznbQNyo=
X-Received: by 2002:a05:6402:4402:b0:634:a23e:df26 with SMTP id
 4fb4d7f45d1cf-639baf1c977mr3450695a12.6.1759826128502; Tue, 07 Oct 2025
 01:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001131409.155650-1-viswanathiyyappan@gmail.com> <4124e1a5-fcd9-4ce3-9d97-5ebe8018207e@gmail.com>
In-Reply-To: <4124e1a5-fcd9-4ce3-9d97-5ebe8018207e@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 7 Oct 2025 14:05:16 +0530
X-Gm-Features: AS18NWDAJv8Y2QJ0ase6hOWvYmv9Zfznp100Rlegb03D_vdoVYNFwHyKoTaLkY0
Message-ID: <CAPrAcgMny0eujytjZ9M+LZoQzzbFRtsDsYFQj8=i37wSLC+6NQ@mail.gmail.com>
Subject: Re: [PATCH net] net: usb: lan78xx: fix use of improperly initialized
 dev->chipid in lan78xx_reset
To: David Hunter <david.hunter.linux@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, khalid@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 06:52, David Hunter <david.hunter.linux@gmail.com> wrote:
>
> Please describe the testing you performed.

I used the reproducer provided at
https://syzkaller.appspot.com/bug?extid=62ec8226f01cb4ca19d9 and QEMU
to verify my patch.

I applied the fix patch for the bug before my testing.

For testing, I set a hardware breakpoint at lan78xx_init_mac_address,
triggered the reproducer, and inspected the value of dev->chipid at
that point.

Without my patch, dev->chipid was always 0. With my patch, it matched
the upper 16 bits of the value read from the ID_REV register

Thanks
I Viswanath

