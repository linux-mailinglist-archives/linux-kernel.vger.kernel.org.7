Return-Path: <linux-kernel+bounces-893113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1ADC468D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1871887AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6423223DF9;
	Mon, 10 Nov 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSUZI9ts"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442C2F690D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776988; cv=none; b=YB80AmPwzeEnfrlLitEKMtMwQ1XGi0Y63dBbnDlTS9/00JxxbTDnoqM9WF0775m1wtSy4cvkqh3uWxb7GsrTuVmKKMaXK8JRYr95oV8GUldmCInk6Oqg30OwxoFVxRxGmv2+PXeh1tP0/Jg5KBHiSYWWyy6OORAtR/Ch1wLl1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776988; c=relaxed/simple;
	bh=65nKoDUoFIUiAg1myvM8LtWnuiNkl0O1D9IGuidRscg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jy6S24n9Vay97e3umJ9bzV0cITKo+jWNQXALWmN3WSQxCM3Grt9swb8jxVySGtaI+2UZvqWqFy9M6CP9AZVtYc8IIBYOYMN3TuliGns/9Hxv9tAY28iJpQYfzJdQHCpUPrpfS0ruBEZiA522NlnToVscXGhlXMu0ZtVslftCKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSUZI9ts; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775638d819so16615585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762776985; x=1763381785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ4pWNj+5DYuWusiU6JflUXLx4iUaUawZwWl6Dd89c4=;
        b=eSUZI9tsnqkm5UgmLZwmSfKRK/Hh5eEflLQ6cXXpjR/NN4VDblYUuw6C0geI5+Quhs
         i9IfPl8Eo5AP9klWWBoQNLVJRBMPVvSxeqOiBFfnXiSmu8wzFyRLbdOG/IvZnuV8ED9h
         73lj+K5rKFtA2KUHjggbtPWqqIH02/xq/c3eHj7FC1qeg/tE3TxFgVGNlewofWpbbsVW
         xYNK6sA6TmxIbLvNLf2plsQtR8lEsB8ksj2KlkSU+HUX5A8yD993stGGg0mYl4s87y23
         W1vff2cB+bYlsHR9G1BYU7I/TD6xPEvm9AaYgBzemwmyOY3Menh5dmJfSSZgNFmQUl+y
         jS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776985; x=1763381785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQ4pWNj+5DYuWusiU6JflUXLx4iUaUawZwWl6Dd89c4=;
        b=v+Xx7DbfFv+TzDnD7YxS90cX0zEmvqnk6NH1RjtES3a5j8gXh00UIc6LtqP/M4uS87
         uwjTkeTqOGqwxwtYst1xudhJh/mJ28KmHgp1YIeNkILX+nPhY4O+HmF2B9UeUCSyShD4
         S0Amjut6S9qd8EDzyjmnIDN0y2ax4GA1t1LhtRwN21Lw4L7P4iiDmfjmn5N8FWueYqXv
         xaXYbssBOlvre8cvPoZvBqvoUhPWzInYjRTYFfH8DvNWZpaJ1xlNFCmUICSN+5rNEes1
         LzL4+cxGZme2S3ervzw+2637Ghatk9wMGjpYQyR8A4ihtvzHcl/EEqlA30UAL+wAo71+
         mRyw==
X-Forwarded-Encrypted: i=1; AJvYcCVBghsSjXaN4xSJiKogR6XgtAsNvPyQ6ZLffEhok8uBDohDuQHvC/MdLsV0HuxyZtEAux6IaL32AHqWgUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXb4jiBe4fHJ5SmUxA00uiw5jku+E57kl1xGU+QWMcsMvIiXn
	zt2jDCerWByxiv0na22wkD7Sx0brfilIJQRjjnM/eig5fC4Uz0ZwboGV4iVfzA==
X-Gm-Gg: ASbGnctNBa+G7x9w/Dau8xbCh6hLq1v17PTib2wdD8EYzxerp6TPniSV7+wELcIah64
	Aau+ybY4FwL860Hb8ZhCIgzeAoWncqXeMQHu2XXOewsHQ0B/MNF/X34mU8x6sSHngyonXrIoO3m
	Gs83T6hP72/UlOgWM8/mwi1Fu5XI0c0FZ+a9oznkfFc2bTNet/GJjunnRrEaK5C0JGRyMkVGGzs
	xKp/ggm4taLVsuK9rq4VprWXceqLU5KIBmJ3zNxSTe4hSvUan3TShOHFbL27NEWNNqUgY2UjuvT
	GFR2/T6G+KoJ65blqIN5W7cUX23tPlwDmqMAbRJJRxDoFTPnb5CjpnVkVMOO+p4jTBOi1nAkH7w
	RuU+9XVxyDkJE2/A6iNUfkTwKKpyiXU21aoeL8jU0G33sR6g/bP7qIwjIFENi02ORVzKcRvkPuK
	6H8WkOx823qBaEH9Gy6sgOv/D6YXOu/EPfhP6FcldXPyjYOz9wckhh
X-Google-Smtp-Source: AGHT+IHX98LBMovhSaAmEHq01WKy8RWXFKKoQWco+RI+gpz9ggdDIRjzYZmzG5GCfce4+jqQZjgRMw==
X-Received: by 2002:a05:600c:314a:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-4777b567f0amr30545285e9.9.1762776984599;
        Mon, 10 Nov 2025 04:16:24 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce20ee3sm316469945e9.9.2025.11.10.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:16:24 -0800 (PST)
Date: Mon, 10 Nov 2025 12:16:22 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tools/nolibc: avoid using plain integer as NULL pointer
Message-ID: <20251110121622.3a8e4a40@pumpkin>
In-Reply-To: <20251109195754.GB20023@1wt.eu>
References: <20251109-nolibc-sparse-v1-1-02256638a99c@weissschuh.net>
	<20251109195754.GB20023@1wt.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Nov 2025 20:57:54 +0100
Willy Tarreau <w@1wt.eu> wrote:

> Hi Thomas,
>=20
> On Sun, Nov 09, 2025 at 08:27:29PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > The integer zero should not be used as NULL pointer.
> > It is invalid and sparse will complain about it.
> >=20
> > Use proper NULL pointers instead. =20
>=20
> Huh ? I've been using that for decades and seeing it everywhere. That's
> quite bizarre, 0 is perfectly valid as a pointer. Ah, here it is, in
> C99:6.3.2.3:
>=20
>   An integer constant expression with the value 0, or such an expression
>   cast to type void *, is called a null pointer constant.

Note also that the above is true even if the value stored in memory for
a NULL point isn't the 'all zero' bit pattern.

The only time it actually matters whether you use 0 or NULL is in varargs
function calls.
Even that is dependant on the calling convention (when NULL is zero).

	David

