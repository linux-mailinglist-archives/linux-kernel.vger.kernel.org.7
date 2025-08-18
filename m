Return-Path: <linux-kernel+bounces-773955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22CB2ACD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C65B18944EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C735950;
	Mon, 18 Aug 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDj51jWc"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09689259C9A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531083; cv=none; b=jPY9+OX+nkZs5sEJUzt9Gt6XRnsmloAnN8GNzXUSFVoJshCLOvlfmSzn39oQJKbqJlXZNMctWMzRBszaeTbAVNiv4Zcb49hl4SIii+UxAicW9HDxM1YmGviWwjSlQNEHB6J43NEGXflRl+jlfCUnGtKFDMWo1yJUaSjhJRT7KH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531083; c=relaxed/simple;
	bh=+6VqLVKyv05yN0VjgFO41/0HRC8AqQkg4NrOglzZNEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKT5KEwqqCL3jPyUSc6nlJeHiEgJQD/x1g+NwBzFncMD9QSxufWUzYjQEUF6OCcQcrM1gVTU1xfcg0VVwOLYgYKaV4RybFADHZ9PK2jV7tFCSwx19SscEM7UFjX/bR8u1479WMNZxCRgsf/2ow1PdaWGjV371Bz20TCE49ttAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDj51jWc; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce52ab898so5215943e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755531080; x=1756135880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KCWYcyoQfVDDPCaibHrt6HfGNhIf9FB+HrFqr1TEMY=;
        b=HDj51jWcZPySdCrZLpQgNeKs3PgI7cCfT+Q8XVFWMlCT82eycYZC6JqgrQ3GORQYE+
         MZZfZjnHQJAg3YzNRJfbfH6mROVdretcL1R8qkx3PYKtnNplPERcU8spdTIdhFSIxKKD
         /iyoCm7i4H05gF8c8d4ZTXVaABuhB6nR3T0t+UDb0NhtFusyD1mYAvWbZEXx6mc4OG6R
         ENlyXoUnTpikkrJQIizYBqr+6OaKC1wLiPMhtMZ9/BhUhOL6vb+ENn2Aywp7r0rPSOID
         8xgU2QGpGOH28pDKSxg+LtPm3YPO/0aTbcYRtK5OvtkPg9qRRbnXCiO6sFv+5VuGdEp0
         75aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755531080; x=1756135880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KCWYcyoQfVDDPCaibHrt6HfGNhIf9FB+HrFqr1TEMY=;
        b=F/h1QMsvgTpB0sHIeziFjVsRUoDJDJjBwiHMBFe1rewPTYt8undyJuv9JfNsqrhUcj
         snl3IIm33bLusHRB0l4baupriK4Vj7EFkUCP1vAAY9OPqOE1HZJvrHG9snKMXMPlm6sG
         W4XJOtncF+r/elD7vyxECcRrpi6dB0riKd51C6aFCA+NlnsHaEjOMeiAZwqSAgPnhS9m
         WxkUQuIXEGHXGZbNPOsBQrDss1VA0VzZ4gWOsZopuPDfGczt7VD71FwqQRdNi9Dn1VdE
         j5a7PFKhkf1q8GdokGIntVsK+pSWuF2MMwvzEqnoE8wawsmZ9jYE4Wdx4Aoo8FeWoMUh
         HGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa+YJtqAfnV9wm0Pyrz/camnirbEjb7VlM6/zcDGD6EBi6vl9ORQp6i4e7x+88QtAyvsdmQAFZyfjmnYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHse6K6tJTJmzrIo4QduqVMOzcZ4TQ2pMvU5UglzYnxAkuhjM
	wQvEge6zqnzvFWzkDGtQSBg9Ij9kQzDRXOti18kb5yHokRJ8hzTsQcpe4WDt266RDDyZ7cQNl7j
	XI6w3S4FHf/zB4uTz/dWVUXuAMxWgU73J92wpMKR+XA==
X-Gm-Gg: ASbGncueJkPLmZ7/3xcXuvfC8z29u5PLEU7HSXdYhFQmP4ca6vh4etpuWhtXXUZ07T3
	HI9uVeNeYANNcReFuunaxGQXRkKlqjZ/EdG1tpYAd78jHgd54KwRVnXfcnlW7h8pe+3wI8zTjWl
	jlAZTzZLvc+A5J+V66kVwQoQqnVVognN+m1VPFyAaOehOYDNXoNm1pEBuqyB5S2iqKTpPqLXsLX
	oNwh6E62Kp/
X-Google-Smtp-Source: AGHT+IELpJnaXx7GhevpidzXIkKTwIAXCmVMgW9kYcw7FaocEXBHltXdb8h9Lt/Brd2z5aHr05TbcwdYLSE7e6xBYFY=
X-Received: by 2002:a05:6512:31cb:b0:55c:cb6d:a45a with SMTP id
 2adb3069b0e04-55ceeb2d2f8mr3584495e87.26.1755531079971; Mon, 18 Aug 2025
 08:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813081139.93201-1-christian.bruel@foss.st.com> <20250813081139.93201-3-christian.bruel@foss.st.com>
In-Reply-To: <20250813081139.93201-3-christian.bruel@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:31:08 +0200
X-Gm-Features: Ac12FXxa8EDDTp4GkHqlafMLuMBYVjtHPVlM15dMmsTqEHuJ1r-eg9GR22h9qAU
Message-ID: <CACRpkdafM9-0DYumrwuZZ5S2_CbabdP6joK1bGiAvm897Ng89Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: Add pinctrl_pm_select_init_state helper function
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: corbet@lwn.net, bhelgaas@google.com, mani@kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:13=E2=80=AFAM Christian Bruel
<christian.bruel@foss.st.com> wrote:

> If a platformm requires an initial pinctrl state during probing, this
> helper function provides the client with access to the same initial
> state.
>
> eg:
>  xxx_suspend_noirq
>     ...
>     pinctrl_pm_select_sleep_state
>
>  xxx resume_noirq
>     pinctrl_pm_select_init_state
>     ...
>     pinctrl_pm_select_default_state
>
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bj=C3=B6rn, just apply this with the other patch so all works fine
in your tree, I don't think it will conflict anything.

Yours,
Linus Walleij

