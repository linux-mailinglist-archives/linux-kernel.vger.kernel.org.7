Return-Path: <linux-kernel+bounces-842149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F2BB9167
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 21:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7654E5B67
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9909A230BD9;
	Sat,  4 Oct 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ndtO7tNO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB32C9D
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759607568; cv=none; b=BIXSzwjS7mjKGJeZizybwQwdYwJxMkuTEVhqdbwwyyzv7oWrWbu858u5Ek28QIDDJBAB3lf0GEMwpZiik/EmwPYpIGLutSR4hDp529S9Zah7f192/CaIgDD5bunfLZ0SSQPuV2knZ/pm6bIpfalNsSJHWDvQYibG60ar9WDrh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759607568; c=relaxed/simple;
	bh=q3rlMLW/7FdTo+d8ph/RndHkcCcZ+5q6bQTd2SLovSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGaiShLG/M1Q6vQNek/Qgx/AtRWaF5eS1cKYgmdKM3s8mH0oovBYhagaVJqhssf5w2ryZQ0Nx/DsnGLD2BjH7ymUEslk7tEfgPi/WsuCvCj4Gk6xFuxlO0rvAoNXzbiNNG0MFDclVrTkhwVQdVbMvN3iVqQEHKfmwMCFaC437oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ndtO7tNO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-273a0aeed57so57442045ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759607566; x=1760212366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAybQmudTYzSK/tcY3PtMZl0JJzvR+yKSsKri3KtNgc=;
        b=ndtO7tNOrxTjLHQPm0Yoext8CnrE4tfpMIxwc1m73ULUJMhvKQLZxacuTccpE48mWm
         MnS/oDMth4iSJORxGyLeHo+lX/a+GjM3oUJJmJ2nD5glylZPoxNC5N7HK0z2PGeXXNy+
         6k+KXeW12P9t96CKDloYs4CnuIsdtIO8pipxYNglki5ndG8q6UHEmwjOkD3ej5xfvmYs
         Sht14p/y0IQZJdBBQTzQcdbT6wLZ+qSUGoVbY0wLY+uX8RLps8AqTjzEanhnFH+d9zNA
         uKydS/t17a3GnzhIvjuorTztZIdHSee/BOzqpEC5zQu7E3DS9EfLQvL9Rx+O+8ckASVx
         HIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759607566; x=1760212366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAybQmudTYzSK/tcY3PtMZl0JJzvR+yKSsKri3KtNgc=;
        b=WYXlTrWMPb85uaeS5ylRlp2UcmiZYvSY0AYnVn5LCQygNcd8TcXLx5TkKjKDPC27xI
         U6M6weCJH9KGCNjddBq7OyV8K2lL1OOvuprvubM0IZwq9zhQ2XRUsDsVHyrOHq1flbGN
         rBPhQpI2yNQjoUeXJ8ksSk2YLZ6zDWN8TDWxygOvc/NUmbaI0XM0xFDb/yNx/Pw53ggV
         xaDHgSYKhdyaO1Q53upBFPtOsz6KrjmspdZFuXYherdEGzO5mkQoybjvmBQHrj6BxUjB
         0HxHYfK3TCyZRCoNJCg22UyIqfBJnMRq1m7Wammz9H7QIANm5xbEzY7TBb3Fohrwlint
         LAng==
X-Forwarded-Encrypted: i=1; AJvYcCXgljgTnAZmy74CsWQfugZTzSQ8cV8pxZWgXOOloT92p2CzBAMRLyzgd888yFErapap6UwERhMVLjZNUxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H1iqBf8TroQHXOOdmSGg+3zsTlp+KS3/JO4Jlp4jjuwmu/dn
	0L4nVxwdnMSYc5IrkWXHHpzb/vgHRHsUA4dx5v0ue0xXG6QLJ+fDwvhDygt3HNWzGwcIFElNPwo
	d1coeuv2+Bvd2Iy4s7gBwJSVjafmA6vE=
X-Gm-Gg: ASbGncsvVqTThNagU68xQeYrme+27pWvuJRbQ8BFg7nKH2Nc5RBmOiThen/SwSaWFhj
	piSykgf25r2ZICKEkyW//9KJDV0GVY9Em64RV+zNXFxsmaKFBTep29At3B2nCmEMnWpLEicHTp2
	XjtS7YJHzwtcM9de9isQnHdxpQHw55gjPHyfs7NSFLwMQLl0LA4pclsLoCaWKH6RHiQISFkRjbl
	GOUMQvieW3wORAL1MusY/CjqLJGtX3iPCSzjNW0xrq/sSH0UeRr3YVWBXOzPYgapONy2gzln+E=
X-Google-Smtp-Source: AGHT+IHIGZbYkJ1SDHVdfJpS7K+FvOcrEyzv91AIf3qtubIlP9Lr0Nmn46Z8cwprgw4hxPvpGz40imPwq6+ElwKPvrU=
X-Received: by 2002:a17:903:acd:b0:27e:d66e:8729 with SMTP id
 d9443c01a7336-28e99a86748mr101512415ad.0.1759607565713; Sat, 04 Oct 2025
 12:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926142454.5929-1-johan@kernel.org> <20250926142454.5929-2-johan@kernel.org>
In-Reply-To: <20250926142454.5929-2-johan@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 4 Oct 2025 21:52:34 +0200
X-Gm-Features: AS18NWDU8ocZk0ezDCUadLBXAKIcA1Zy54NbZyjlAwDgH18dZXT8OTopz2n03m0
Message-ID: <CAFBinCBT+8aFH68gKja7PS6BtPUBcEfW4KRv8GFyADiK_QB7dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: amlogic: canvas: fix device leak on lookup
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yu Kuai <yukuai3@huawei.com>, Markus.Elfring@web.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:25=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to drop the reference taken to the canvas platform device when
> looking up its driver data.
>
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
>
> Also note that commit 28f851e6afa8 ("soc: amlogic: canvas: add missing
> put_device() call in meson_canvas_get()") fixed the leak in a lookup
> error path, but the reference is still leaking on success.
>
> Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
> Cc: stable@vger.kernel.org      # 4.20: 28f851e6afa8
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I haven't used the scope-based resource management myself as pointed
out by Markus.
That said, as far as I understand it's a feature in newer kernels and
this patch may be backported until 5.4 (oldest -stable kernel still
supported).
So let's go with this simple approach from Johan - we can still
improve this (without having to worry about backports).


Best regards,
Martin

