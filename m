Return-Path: <linux-kernel+bounces-830454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D862B99B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86A73255E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C712FF67C;
	Wed, 24 Sep 2025 11:58:45 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F82FF16E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715124; cv=none; b=aZ8myM8ExrkbB/ticFKJOif+D3TUHVRCfGNLkwjfa20yciF4Fz59UjTiKGWREpKjC+nUhZSJFOV1v88l9I37WpRQo02k8gd+uwgnCRTuhZOm7VtamIA5pUScuDjQDHJtEBnLUaG7aLRiLf3+1FZs55iuM5MPDQ6cDn0PPutC5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715124; c=relaxed/simple;
	bh=CH80Zg8QJziib3a9s+6lE/c7RM05j9no03yn3eyIRBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZUgl8wgbe+VoHt6OnVSfmAb6ETyhgy+l2bd7jCOU1k/ddpV2Z6hBfkzgWDe+rutVIRlp+E6dkX6HVV/AWHf3ruhjoMJALreQV37wJIHVLoyuDWJToK2UOamTFA0k2zgXGpVY44K1MU9SVIHWhR9mRtcCuBegENu+O6lWgt8VnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54bc08ef45dso965899e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715118; x=1759319918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F+3NjRjW7oCcKmojh3L12WB2Mn5ermgaswG3WtQQkE=;
        b=lIDg99M9SDQB5Ua/xkzhCmgNCqjllFw5jzvLrVmKan2o6k6FBpmQeS2HqfGOxdBTkn
         WTA4cQayXt9c8D9KlrO/4oA8fSAB5Yb+HhTINaCrt0hkXo8nEFtqZWX5XUXtnNRaom6x
         +CWtxxlt6meVYgD+7A0IxVSpC0jTehj0aswYhbWyJ3xWdkhljqU3wuzUMNPqeFOCp6A0
         U+OryKH+apjwv5hkTPMgV8XtoSwBOhUwJWKyWfHVGmCsuiTZ/Az1mecFA6UHrSpD8OBI
         sIAAevb5A+Ge3S9lSUFBs6n8Mvch0VQcQtuGRSuZLNgjQ7QQsqPOlioEoq0VkJYDUc+x
         mciw==
X-Forwarded-Encrypted: i=1; AJvYcCVgynlQSmVDUdvrZHJ5Tqi8ddiXNup+4ypLLu374Woqb5cEZqMN6QCSm8fHan+RoY8vueVLSEiLV/1/81A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFqiD25bPCQYcFf4WwzcxXYNgwMBIiyoKAG6Goh6l6UCr+uuz3
	qKaEjCGF7pPgZCawHcC91cbheCaL/CIp/r3KhuMsCp08IPg3WpcirGIe+CJ9enz4
X-Gm-Gg: ASbGncv1yplZrkTuso+rF829xC2V6pfAFJiEmkYg3NtgX7UNUxUWX3QfkcrsQTcK7W8
	K/r8IXb/OeC7zNgcR6jsnyJNu55B23GdCEYq31u7FqubSDnqv5bkhZbCoiAVuuMdPFd8mFXJgMP
	0MyTyai6d4KVEPaZVFUbxhqOYuzVm86+cnJULSIGfnS8kJV45hdOlXHUEpUhNeyIOyzQp5teXOz
	6UJDtL9rU2l9McezKVxZo5IwBJUT4g4bnsEYFp6rqx0PRDlrjEg6OyMcrwcgHRl+nuesFNp7Unp
	G00L9SRNW+jvuaoY5V8mxuPdjpHb4oGbbjP4LEZHIYZhv02Z9DKTSPx/QTrVUWemo1o2f4Ylwcy
	Lh/Lt8Nc7Nd0RXzkC9eIWD7jdPG+dsybkVGPyy9QGpd7CCmt6XJfUJt3CYVSc
X-Google-Smtp-Source: AGHT+IGzfKbVkZfZ6cqCX7wMhAlEVGzBR+VyoYvv3ZDU+sEsbU5jtJ/qXSbEh1HhElcNGKPs8+MKIA==
X-Received: by 2002:a05:6122:1daa:b0:544:9f73:9b46 with SMTP id 71dfb90a1353d-54bcb1c1485mr2154125e0c.16.1758715118457;
        Wed, 24 Sep 2025 04:58:38 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a91edb1f0sm2725836e0c.10.2025.09.24.04.58.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:58:38 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so5681356241.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:58:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz0nK9OBV5MbEYNAPIqXbTIhBB2fsBV1JUCdBiNYvPk7wA+IL5ufFhYgeG1BcCZBSpUNmF1Gysve4ixB0=@vger.kernel.org
X-Received: by 2002:a05:6102:32d0:b0:515:a84d:45a8 with SMTP id
 ada2fe7eead31-5a5800da2bemr2283926137.20.1758715117607; Wed, 24 Sep 2025
 04:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923174951.1136259-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923174951.1136259-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 13:58:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVdoJsr_zopj511gx3Gb8e3NmLyG4ge1ReZJG9A2SOXew@mail.gmail.com>
X-Gm-Features: AS18NWCEqlWzRSEZwc-etvpzN2cuJ6XqdlAjQdzvmM1IviyM4O9XNmvx6ad4ciE
Message-ID: <CAMuHMdVdoJsr_zopj511gx3Gb8e3NmLyG4ge1ReZJG9A2SOXew@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: remove extra semicolons
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 19:50, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Semicolons after end of function braces are unnecessary, remove them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

