Return-Path: <linux-kernel+bounces-844490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE1BC20CE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFC41895739
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057EF2E718E;
	Tue,  7 Oct 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VfiETrmp"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636811FDE09
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853526; cv=none; b=j4Arc3htMKebqBzta78Lz3uhC1R/NhQK3W6Ph9qb+AEyJb+fVo9BaVn4lAfBEglcaGraAr2tuyLVuAQp/DS/rz/Pi+vP2wz1m/2hg4Jw4Ti/KX64Kv0+kofum0T5WsGtxJ6jWZxAoeNG7kUdN+13e9XvC9PSwjjWWkCOJHWpf7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853526; c=relaxed/simple;
	bh=DKbbE9zhzl8rj8dEiYIYxy/R/PHBFZakQ3bjQJ4fP+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCTgTyC1KRMZ4dGjfAnc3M4OulFxOQd1qNyI129J9ZAA7PypLcQ7cSDSD/A8R2RaL9+2JY/t3O4YCodtW9jzJdznoZoL6/D4U0kcfY6RAUzXmVoV5/he5Jxuru9j3Ac0+xv4CHHEGrUl6iiUt5ZftqZ3OBgTeZbnqVzHppm1Oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VfiETrmp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so7672185e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759853522; x=1760458322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5bhuG10RNnyLT/yO7UzTmBolSEBRqmJJO0H1HbQGO8=;
        b=VfiETrmpVZ8B5wdFA3p8j0Bku6rL20ZXXddxRY2RYplEn7jWUofEIo05rkC9X5V0TB
         AkS9KkjHYyeZS0z6f2Fn9h86dn6jARrw7WgX6XhFoIwU5g60lyHb6Nz0YWDQ5lXnSGOL
         mbMioJYQcg0WgGefPQ4W1gukuUriPkTvQZNeCypo2D9Rsx4zsFRolgcmr7g1ftSsVeEr
         iE+xPkipkA7I0z6keTF53lAf7pxUm2z6VR6rG7sJQhT/zvr5lWg3RdrCTsweJaw+qocV
         NbU0eruuF5LVSh/4p1H0WHRSZnQPm5fB71IvNFltzP2SDqbjF7/zBPOh90TMziXVH8hg
         E/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853522; x=1760458322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5bhuG10RNnyLT/yO7UzTmBolSEBRqmJJO0H1HbQGO8=;
        b=Z7Gqyj2/bJ3kMOu7CmYZ+j8ZH6teF7SL59u0lW8wYqXk8feiXTk5YTsBNzd0AaLl6n
         c0fBSsr1gbxHjvYeYnIe7js6Bmtgi3/VGiEqByBoDvIrHJIsy1yYUv+R+ZrHwf5Is/Du
         T5UI5ZH8rkCgXFdio8WHJR4lEjZWZ0wRnVD06QfP8dOuRzi98W7l75rrcQ136w8ZBIFH
         kTCqS3Ejni+3iuO+HdtX7oZlvmyNcZ1j4/H0ZLOODiX4AN+hy+SakBJOnLPgAmHc2IFL
         vP36oaQ6q2LDJOEcNmggTLhvw8fTK/hvzOaXxoDFk/gdFEuiMnHenOtbyMswas5oZ9vV
         MyKg==
X-Gm-Message-State: AOJu0YyrqhNaGOxbP66rN9cHkxMXuHWH9uaFpaUEVPeF6sVYfslqLCeP
	RXP28jieT6XfH2HZIZBEJJ0c/U74M7XJqcvZTHaGEaPS6bkE4OMCa/NyMRYA4zScRRzIunIJjnh
	BR12AyDz4uw/NtYKaelI3rRNp6eb2fqnOws6tYpL+GRQSNsfjWUA8
X-Gm-Gg: ASbGncuy2pZHvtliDRJExzZxkWdD4hHWjX2huy2yMz5gEByYh7G6DGlDJlUSsu+unq7
	QAUUJ+VZp0JbPHEQVY8DNDPVHiWj5xUWEe9x5cEuz/153tKg7S9kYNmr9SyeBa7dVi95M5HOaU9
	ZqvGFEvJWH0Jy6Rs0oqajCRUbgmuSlgwrvnUDQezBZ3lx5KV638j2eToT673s6EMyWGIKgagw3B
	o/J89USkvLMEttd7ZP76IR6X38uxWfcBSd374lJioVGjswxNjgiEf4sCUSpwAo1
X-Google-Smtp-Source: AGHT+IHX0cFUUS7eRKIKaKVcU7ZmMlwLAYnpxVGC6vvjEjVKU434dsb7KybmLTqBGP/xV7gGB8LzmY7ktetDn1iWCBA=
X-Received: by 2002:ac2:4e0c:0:b0:55f:4926:df1c with SMTP id
 2adb3069b0e04-5906dd78cc8mr82432e87.46.1759853522340; Tue, 07 Oct 2025
 09:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908160224.376634-1-marco.crivellari@suse.com>
In-Reply-To: <20250908160224.376634-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 7 Oct 2025 18:11:50 +0200
X-Gm-Features: AS18NWDsb6wrf3RYNSLoxV9mybukDyVAafddNCj0OceaSnnWCaOwUw7AwfZXpXE
Message-ID: <CAAofZF5qfkib8gGdYnzEUSJv3LCBdNODwQn_Dk9x_zo5-XTWRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: replace use of system_unbound_wq and system_wq
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:02=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> Marco Crivellari (2):
>   rust: replace use of system_unbound_wq with system_dfl_wq
>   rust: replace use of system_wq with system_percpu_wq
>

Gentle ping :-)

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

