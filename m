Return-Path: <linux-kernel+bounces-882666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75FC2B188
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB6784F1E26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1C2FD1DC;
	Mon,  3 Nov 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d2LmdE+w"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B78405C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166009; cv=none; b=c04kS7aqD05O3OZ/dDQ9IAj2I1PBR1ZJC27m6oGuua7eEOcu9ly8Q3epzIKh54F20NqOi1JiEOnf+yoWI4ODgXXuNhXC5beupAimMZNc1HP7mVyzQkAGwn7Xq7rGmbzRdg2F3ugyLTEEHo5Dd8QpS/o8mTPdihqpAHj04idq4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166009; c=relaxed/simple;
	bh=kOJ/IBO3oLNySkAjeUQaEpdFOYftnABdhDgKv6rsMUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=betW2oPgaXC/C4wQkagooQb6Cl6pHoaNd1F68vTCq2lhrCqlkfDTigZLgahsKwudbHc4DQe9K1e6SKcWqmPJxx22N5quqrc3BwMjg0wF3ZVfy78v7fz3cK6TXcRsFGEstdc9Kn8CqI3GHg9lNsykOpvv6FyeGxIV4aG2qoGkg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d2LmdE+w; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso559561766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762166005; x=1762770805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOJ/IBO3oLNySkAjeUQaEpdFOYftnABdhDgKv6rsMUc=;
        b=d2LmdE+w3PoOIOUJqiksFdDaAwZRxCrRTUaGTqDcN4SKnimXmgI6zFSLb8odGVmZzE
         FUUY2idZ1zvSZYoWqUBQgzVzS/0Ek6xkS0zsm0Ar4nMnTBG9pk//jGaGpGellSr30wi0
         73dUH+ZD7hugjoyHePIzRSgtHlNFQISwc6eWH9YVPWe/4va0awlgWB99Nlo7U0N/9syc
         nOTC59DquTUUit623rqshK6NZGIXl+D66N01fvxsCDfM7UqbnKeqmJtduZNkTB3hIt5y
         4B9vAA+ybRoMXLrPolJKDjQDT1uf0WEGeOcDzHXd34bAuL/mRdREk323c55EbIYz7yKf
         zlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166005; x=1762770805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOJ/IBO3oLNySkAjeUQaEpdFOYftnABdhDgKv6rsMUc=;
        b=Ic3TOjxSf6T8QNSm1yXXANuYnIpnqP7G2+0jWvdUTQNyDja8RM4WHDYUhyKjzLNUIm
         ZcjZmrniNHfK6du0jgp+YHi1LXxoGIuGwpY6crxetKGgvlASi30UCCvqaY9niREng67I
         blLeb+0IxCVymXImhCakBpGzTtCjwl0r4ElBd19Es9Xn9Eq7lotmayzniCMWngpN/kyD
         6G8AfkYhg3yqCGO6X146JCpx+Y3K7v8I5Kt08UHI/DZHWL+CU1+gj9gJ4etnJaglllrQ
         rlySqGQYNjW80f55i7HA8k/URBOlPsn6Vzwr4m3tEDFAy7KPyup0DcOA0jkU9uqdYLGJ
         tVug==
X-Gm-Message-State: AOJu0YwGR4k1YJDZ0op2oK1/CtX72J/YklVnVQD8nFmxuKKuFnGV7tif
	z3l8HglCQgf/rpDmMFGWOseJrKohO9xRf+hIg0cmTiIoiBGlJGo47xO5Bq+wOGH2Cm53xRMzxfv
	2LhEpuotn5wkfoowCyFnS3YYjKT6ieOZ335PUpm/tHQ==
X-Gm-Gg: ASbGncuB0xy6G4JO0wzZaA17scTZ8CSG42RjifrAKaf0qUCTQU5JrglHlecnQ54gYMr
	7Uxj2B9NY6UkIFNHA14dq48tBkTMxa36sCbhAhP0jUQnuvdrZvzMnWNKpk7zUROr1sWwn8uZxEL
	DZJAicLpssV6MawpA45/A6bncod/Etec3XcrFXdzT7suqvNHgE6tJClmhJUzhk+t9SxDunsY2P8
	ns0Jv480g+SVyOEreY6SepHF6RIGlSus1MIKxsw98oFdJKG49n9YJ6wI6h1OfeZylmuNf6rHTnc
	L2vf5mttnXLXP+m5QQ==
X-Google-Smtp-Source: AGHT+IHpCT3s3+uBnbx+aIMiSutrxjkGQNeoToq6J0kcvc+HGBKIO6gpJGl7JMeuoPpFA+c6+/i+1zgolV3NiZNm/q4=
X-Received: by 2002:a17:906:6a07:b0:b71:1c98:d270 with SMTP id
 a640c23a62f3a-b711c98ef85mr163236166b.22.1762166005609; Mon, 03 Nov 2025
 02:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031100923.85721-1-marco.crivellari@suse.com>
 <20251031100923.85721-3-marco.crivellari@suse.com> <s7jsq4mbpkpon3stlizr3mc2nnwpvngmzvnqzfbeg252ua6gto@ohb7js3ufmmt>
In-Reply-To: <s7jsq4mbpkpon3stlizr3mc2nnwpvngmzvnqzfbeg252ua6gto@ohb7js3ufmmt>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 3 Nov 2025 11:33:14 +0100
X-Gm-Features: AWmQ_bk_JyhXrMnXA1L70qG_7G1mhPIIkUfgB3eygmui2C_xUmOMiFJJ_9B5MgQ
Message-ID: <CAAofZF43CkrumJ0wy4p197pDzKHGhu7j+Oo5eDghbiwONQNq9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/i915: replace use of system_wq with system_percpu_wq
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof

On Mon, Nov 3, 2025 at 11:30=E2=80=AFAM Krzysztof Karas
<krzysztof.karas@intel.com> wrote:
> you could be a bit more specific with your patch title:
> "replace use of system_wq with system_percpu_wq in the documentation",
> so that it is clear there are no functional changes.

Sure, I will do it.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

