Return-Path: <linux-kernel+bounces-840136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA7BB3AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9956818961F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08F30AD15;
	Thu,  2 Oct 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmPEFMSO"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7452F4A0A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401599; cv=none; b=ReVtvBHwLcl2qgysHQ5WBSM1fj4uY8c8ZhFE21h8yjjR+uArBSqKtcT6M2saLaxATo/0Y7Q/ntwbBQ2bubVwAL8+LVts8QPtURwyffYys8cFFW3jsPlKehtf43m+ufHgECm86h7RO9onDz4wUEHVkClOzrEy/fCbZEPLQ77XaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401599; c=relaxed/simple;
	bh=5zqSShRm39AvEZ2mdKxWsxXrw2ZA/BSSQMCMwPSXcG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7jNLBAAPP36NL4lBcTNOSzVu/xFzK0A4vBR7Obm1v/THxqe6KoOoO3/gUhQlu0S6hnqqQ+4ZTHPPs1o7nAL9BoP/qtxIQKDfwshp93Ql/OtNsQQ/zGTjD51SIqZgEDMiefziW1u/tZFXH0eLoTtk/6N1L9Bcwdq4yFMgS5//F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmPEFMSO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2698d47e6e7so1465305ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759401597; x=1760006397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zqSShRm39AvEZ2mdKxWsxXrw2ZA/BSSQMCMwPSXcG4=;
        b=CmPEFMSOnGGiEyaf93xOVryqjDnjYQJfZj+A2BDJszUDRQwG1OEKqCLgyWRiOd5PW9
         5XuC70qYAP21pjCQQQxCX12yLMOwmEf9BoCqNwKtZCL21wgSKx3L56ee7vSTWLZ6DNy2
         p0uDGvz9IiQr1YR+6rwfQVWMXTbL1doYWcOjDP/z7B1In4EfPWM8qW8fYey4iKbExKYX
         Ai9fVsXc+6rGeqS+lWEFcKZe5m/PrnmLEiCB/7C7HDd9lAPfieB8xhY829psSPxc/MTB
         ViHq8pjawgoNz98/GsBcl1JNt3QtbwH8Pdu7/4MWEoSx0GQVMwdyFCmJjZq61K68I7Up
         Sdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759401597; x=1760006397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zqSShRm39AvEZ2mdKxWsxXrw2ZA/BSSQMCMwPSXcG4=;
        b=BriGpW6l7S1OuIVqGlqYAD7keYC0PHDjgCMLYNlf+DklvdfYa9y00TzXgcWYIClc/j
         5YQ9tlmzp3pVBKWeRrB60P6A4d3HawXHPyKP7sr0Wgszi8yzYnNdOv2MR9FSA4ORTneq
         paD9NSN9xMDW43k9vIMepbMbPObSXo22Wt55fD5I3J6irami6IeCkwYIqdbfr1piyATY
         vozWIBk8tN6c2oxGPXsRmX5vuH3jmMo8HkwALcPlqzYpW/DxAn5xJo1Nqo8FE2kXVxdl
         n/nClGe29EKXx5LojpOptWL1+mtFfbu++rjSZbub/gD81E8NxtwouTMxvezIKvpUBOij
         49GA==
X-Forwarded-Encrypted: i=1; AJvYcCXDbIF9vOOEXjfxOFaFv+WJkXHOVTfVMYbrIEA1QPkNjACSLAEWUtM5Its0g3jr1qF108A+ZmrMeXHUc20=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtMMmJklxifEqQprLLFxxmj9zmJw4+SA8ShfDH01OzwnrzgE0Z
	bb4it0cDpVvoNILz+prmXF20o8XQyevOiJte4t0uYumisdUMSSkbcENt979RW5oBQuJLKN7KuLi
	wt/KhwnrsHrXS0dXbAwRm/ZhKM0fVKjw=
X-Gm-Gg: ASbGncs6GlF3GM3WPSnGF+LdVpZrwyqvlG2Rf6kbHaSmWoB1kyB56ODEPYtKWypgr5N
	5RA1lLYbKDJERanWmLaLKrFuWUvhbL4pdK/YkyXGfEYL3FkuoBXCuujzCFCi1CST3V00TFdaiZb
	n7yV9RgqcItUqE9l4Xv5gcIT1Qi3F6shM4+hxsUhTyzneQC1baQM7NowvP+pjQtzz5J1LDQW9ca
	x2b2U3JHJuen0vNEVHNdOwsrwuEa609VtIOsRA0k87yplO2yC+vvyRADbNEgOi27gIMtcsYKsUU
	3MlXyVP132v9WE5hkd35+eoJxLzhLacopiAU5LmdvBQZop5HRw==
X-Google-Smtp-Source: AGHT+IHFLND1P6O8TdHjmnKikosiXvhXOIfnx1PV0ljjYUmm/N/aJM7ueeeJ1F4XTf3eavFywQQD7J67z/yFzofBPI0=
X-Received: by 2002:a17:903:2f83:b0:24e:af92:70de with SMTP id
 d9443c01a7336-28e7f33482dmr45430085ad.7.1759401597241; Thu, 02 Oct 2025
 03:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002081247.51255-37-byungchul@sk.com> <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
In-Reply-To: <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 2 Oct 2025 12:39:44 +0200
X-Gm-Features: AS18NWBvN_Cs7ivtqpv2OaNBhg_Klbjg_5caE3pe8g8RPQqJWvaoaACfChLj4F8
Message-ID: <CANiq72ngvZSL72GQ+CwFoaE4ZfakZSPcZk1zrXqyaKEZLWDf-g@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: add `rust_helper_wait_for_completion`
 helper function
To: Guangbo Cui <2407018371@qq.com>
Cc: byungchul@sk.com, Liam.Howlett@oracle.com, amir73il@gmail.com, 
	andi.shyti@kernel.org, andrii@kernel.org, boqun.feng@gmail.com, 
	bsegall@google.com, gregkh@linuxfoundation.org, 
	linaro-mm-sig@lists.linaro.org, link@vivo.com, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, masahiroy@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, max.byungchul.park@gmail.com, mcgrof@kernel.org, 
	melissa.srw@gmail.com, mgorman@suse.de, mhocko@kernel.org, minchan@kernel.org, 
	oleg@redhat.com, paulmck@kernel.org, penberg@kernel.org, peterz@infradead.org, 
	petr.pavlu@suse.com, torvalds@linux-foundation.org, 
	vincent.guittot@linaro.org, will@kernel.org, yeoreum.yun@arm.com, 
	ysk@kzalloc.com, rust-for-linux@vger.kernel.org, ojeda@kernel.org, 
	gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, dakr@kernel.org, alex.gaynor@gmail.com, 
	bjorn3_gh@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 12:12=E2=80=AFPM Guangbo Cui <2407018371@qq.com> wro=
te:
>
> The DEPT patch series changed `wait_for_completion` into a macro.

Thanks!

In general, it is useful to provide a Link: to Lore to the right patch
(i.e. context is good), and please clarify in which tree you found the
issue if any -- I don't see it in linux-next, so I imagine it is not
applied, but "changed" sounds like it was? If it was actually applied,
please also provide a Fixes: tag.

Cheers,
Miguel

