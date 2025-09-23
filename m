Return-Path: <linux-kernel+bounces-828507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C7FB94BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4471484AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A17431158D;
	Tue, 23 Sep 2025 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eYsCUfki"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E931077A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612075; cv=none; b=ojSitBflJiqI/7BQgeK0R2Noh553XUbTJVYmNv4oDTGziuOdeMEy+ZBwX9tg/WqrN5MjPvPBcvPiXdt0D4D2QWHHSJil9Xs2nR3Mk7xXPIdp0RXmUXsEu4DQctGMvFi/btZuLP0I7+ij5nL1+L+Kdkw2HBFqn6pGTQDeAO68yCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612075; c=relaxed/simple;
	bh=I0Zqp3aLmoFnbeKGX9RUVxOmba0uAJjiVPrKJLO0FsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIp5MHY1cNoTp8TkRjjBvcRLe6Af4NdQW9w6IRChpgWDHGXOSpbDMNlyJBY8oqXPyxRqZmSbhEd0DVyaecvyzatyHhFKvXfYQfz6Nu38zyPAsws3y48UNzaFujC4ZwXyh1QC/Nb05tasjzmPywis4rzULOurFa2/ZEnJ6su2V30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eYsCUfki; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so31617425e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758612072; x=1759216872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0vHNZoddHXA/3i7ivpnsJevwTi0Ys5SuR8VWS3aVs4=;
        b=eYsCUfkiF9Wa4oaKv4bh2MBISE6Hdvcc42rcTGNgsKyOtRGyYV9eRNKb0X5NjHZHT+
         z5Xto8YMVfbuA5MOpr2h8xxPZPLc+BTOi2ZDbRuwUi7ZDjy+gKjtRTTcdE9O/4U5XHtu
         FL/ayo9wAuvNikmMb0kx5QPK/A322CMaW9fNH+MWT7hoYsUykxWmnFbbp2FS7NNEqV8i
         NcEWDRMmWMXRSBGZUxiCY3P8I3v2T+wkzCedWf/AZR0FrpFh8AmZOejsoVP//6JZlWzr
         /ksBTyQrAkVd890TKlMFl4wKTRdAayEQ3dnNKu0Xyk1MREe+ob/CMBlmkkbWmSH9NBZ1
         kVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758612072; x=1759216872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0vHNZoddHXA/3i7ivpnsJevwTi0Ys5SuR8VWS3aVs4=;
        b=TP8fAYy+7iYZvRhtAMjnpPRAvFobR8VY1w2fkWYz6eteNWhaIfc9UNAxFd3Np+7SRE
         46Y6UGDY+UQM/ZqGrTmLkmJNZXzx1ylEkU8sr4TugXOJaivSL418ZyXDiDMdtxKqjQJj
         tw/CqzEOi85VTfvGfcppZHL4sD6+e8BMpkG5TLt7aCcw0H20qzZR2SUgz1nJsTv1TUta
         cB0Cwp6w+hn5riHFQ7ZF3uxkJsAgr2RXQtLiuOXGLLyb+7xcj2J8CPVS/je4wYaJOzfQ
         sk/Wz5FzHGt1LqLiI15U2WPeXFyKoJ28Qoj1ri8GIjPlPpWnguQW26SPhYgq0IY2GELG
         Mcow==
X-Forwarded-Encrypted: i=1; AJvYcCXY4qNH71tFasURIkamH53JBKzqbCYQpwU4uu7Igu9o1RvgLHCAPID0WLZLINfqduPuBUIHSK4v1aG1Dd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7HZ9/TjBj66uZx95GTmr38N8mq6vpnhQRNdK2JKEE75izD+q
	cYUjHAqwxuVqu84oYO861oyiwAaXygBAsrxbSJTz0G9ZeozEoWatLlu/7oBqo18Xifc=
X-Gm-Gg: ASbGncv48boyaI+g3BkzadupTNR7PfBWRL5gwdlsIOyNpOLQSKPhB1f+r228gPFHc8/
	3Je7HJL4Dlp5sDAwk5876Fj0aAFESU2JyiOvHTlm7wivxQ6EAY8bt/Q+8LIw/YZCTpKFzbZOOkR
	xlH1kwh3CZVwPmWTc04bLjLl0lu9e7bTb0hZjiDaKW34GqaSu/2Y0b7n6tMfBH7+s31wtHaBMSZ
	t/AbqLyGhZhSDzTJHAi9F2kn1CL1LDzvY0IE3L9AMQSYWvFXEkq+gFNbp3jCP8NtdB+yo+ye6Jo
	vEBsPHKjNLlv5dNxxisL/vLeFNHpxsd4tWi2gEoEphAFtyvhIpC3Xn8QsgX5Vg1mM6BjefZmBNF
	lgTx3L2AWsssOz3LB5QPrHDqGm0VgxFkLTZ/rX1cGbRQ=
X-Google-Smtp-Source: AGHT+IGPgcr7IZ/cHgNios+dXUo/2nI5H1IxnpZDpH+seBhbwldJOO4fgAuZy0CsstZyEwUeIBIkUA==
X-Received: by 2002:a05:600c:1906:b0:45c:b56c:4183 with SMTP id 5b1f17b1804b1-46e1dab6235mr16271435e9.18.1758612071858;
        Tue, 23 Sep 2025 00:21:11 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ceaa012sm10119455e9.1.2025.09.23.00.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 00:21:11 -0700 (PDT)
Message-ID: <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
Date: Tue, 23 Sep 2025 09:21:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: julian-lagattuta <julian.lagattuta@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 10:11 PM, julian-lagattuta wrote:
> Running a module that encounters a fatal error during the initcall leaves
> the module in a state where it cannot be forcefully unloaded since it is 
> "being used" despite there being no reason it couldn't be unloaded. 
> This means that unloading the crashed module requires rebooting.
> 
> This patch allows modules that have crashed during initialization to be
> forcefully unloaded with CONFIG_MODULE_FORCE_UNLOAD enabled.

Could you please explain the motivation for doing this in more detail?

I think we shouldn't attempt to do anything clever with modules that
crashed during initialization. Such a module can already leave the
system in an unstable state and trying to recover can cause even more
problems. For instance, I don't see how it is safe to call the module's
exit function.

-- 
Thanks,
Petr

