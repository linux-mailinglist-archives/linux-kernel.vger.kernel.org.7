Return-Path: <linux-kernel+bounces-890710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 713CAC40BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D4C8350376
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1206032ED2C;
	Fri,  7 Nov 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BoADNlRg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9F32C946
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531289; cv=none; b=KAvEhmLJJFU/2j346AOiLYI2RFuGIF29atvw0daiqglEPOQ31XyyWGP4E9X6COb9x6RxkqL8AOqHqTiDXiPfG2nVpIAMsjf6pSz/pCq7bEs3eEa40QwFsYJS9y0TsAo0W/sfs3J++Qp1JznvyDtaHYcqssfeV4E9HkoIPf2wWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531289; c=relaxed/simple;
	bh=k6cchhlSWfUc33DIg2c3qkWnQv2lSK2QA6Jz538Hxfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqheKCATp4EgIVV2vGEirmCGzNcY6b3cGzPHF8kyQpP68v3lJTneh3Yaoz66qls0Nf7RRR/wBUBuXIxii2QyZ2sWlqOOKz3W3ZImf1pvQmwfPwS2ve5qqrMRedEUuCOEZ1R60jBxKeA3rlAbjvYv1dJ4kDcFcOdjshDlU0wXn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BoADNlRg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59390875930so1337497e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762531285; x=1763136085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLsUtv1i6xgtAFAuVQAx3evRcMrsbNGwzUG+2nokBSo=;
        b=BoADNlRgl3CjyjVZnBM9CKSZEg7cHVPH3LxS0/Ig6cp4umaBCK+gWl1ibRQKZGWxgV
         L6AyQ9p3T+CIQ9BPHQiRuLUGkJW2VZkcbYQl3VyFzXhXtBdnPYM51Tw1YPHqG0nrQgZS
         wiX3epP193nf2Lq1IK5vyTMtCHG48mjSf76EEG0HYS13BTJcieQ8vFmKVN5hFfWQK68a
         U07/8hlYQ/tiU+wsHxN4eKNhExPpeM47UN/+24TqNBQBiOgbNxCQH63G/RzjfOJmlleC
         idYNNhbQM+jEBTRCgetBxHo9c4UlzARnJ7G2XIhko680MuiTRAdhBsF4AHZDdVScgWEf
         FAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531285; x=1763136085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cLsUtv1i6xgtAFAuVQAx3evRcMrsbNGwzUG+2nokBSo=;
        b=nJNLkYPSkfhcgsApdxpdHCanAa/6e/1v3/fYhVNDB/HedxigB1XS5LibcWAB9GBmXb
         H8op1QgEjQ6Y5wNOxntkaY98YE3J9HGvRGoiL0rFO/FkFDEdhbeaYra8aiX4sVO02cYD
         31YzoMKnOuiWMRGz71BpejV4A1ggqmXMe7UDufUW/6nQKW89jMH918ww1uowpDBZfd5J
         JMxyrv/V5yCkBUEJMsDVG+fzsefdyuWyNXNuiSkt869vaU+T55EGPaNYO0N0xXFGjdgu
         F9ADZExMJUCabriZeJ5xmmpgWXpEon6qNcyM7ZI/dwPkkF6akT00f3tmTwC/wDJRXwsT
         sfhQ==
X-Gm-Message-State: AOJu0YzZwy7D9jXhZjtg977K0iOjxDqRY7ibQ5mqInGir4o51amaN4D+
	YjaQncgaTaLLQxGd6zrrUAiwF1eWTz6XeR0sTLpyeB9tUnLdWjsneF1nRBIgqngJ6s/JZujWzHZ
	fyau4LJ4wxxN70tXG22bJRpIzs3/APEjo/QlMGblgYA==
X-Gm-Gg: ASbGncuwCuC1DEss5opxRYvNKwj4dEQIecRL6Ns9ZYJU+EWMIfxAQSwehDFRe0/2Tmx
	QBtxIOAc2ew3poxGNTGnRULCAJSZMOjQea9ytbpD7CECO5ICNbJviApOiL4GXSq53p3MNLTblJJ
	V/dI8uix4LgbBm0HIrembEX4r1WJpszOfcTTdS1NFFIcx9ugEiqmuM6exUigumV7A7u6ha6bK7V
	Ln/PN1+MWi8Bz/GUAMoqzfcmrk2HxZFzkkkrTdyJdC4B7VlF6IG8LEKuTVB8EVHtxuENcfbnVhv
	YouUIo5WxrIaOaX+IA==
X-Google-Smtp-Source: AGHT+IELQL7IbkI08AgR+uM3RxJdxPwBOm1wSejiOYcsTOAYuNKPMdY2D1c55i25ReyVSfKA6jDzxjlktmqMqxBZrl4=
X-Received: by 2002:a05:6512:ad1:b0:592:f814:7c8e with SMTP id
 2adb3069b0e04-59456b57562mr1241237e87.24.1762531285431; Fri, 07 Nov 2025
 08:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106142914.227875-1-marco.crivellari@suse.com> <176253117139.2510929.8121904506912995233.b4-ty@kernel.org>
In-Reply-To: <176253117139.2510929.8121904506912995233.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 7 Nov 2025 17:01:14 +0100
X-Gm-Features: AWmQ_bl5sMDZYdt2JEOKK63xFl1yODgwK2Fy-DtfiP1HojPpi5aozB0_EqAroKA
Message-ID: <CAAofZF6Gwj7CTULspPgw0fURyFQnVMRmyqi6W0NyXYsPTakAig@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: irq_helper: replace use of system_wq with system_dfl_wq
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:59=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>[...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git =
for-next
>
> Thanks!
>
> [1/1] regulator: irq_helper: replace use of system_wq with system_dfl_wq
>       commit: b6f4bd64f453183954184ffbc2b89d73ed8fb135

Many thanks, Mark!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

