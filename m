Return-Path: <linux-kernel+bounces-842166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D5BB920E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 23:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 420534E6974
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBDE28506A;
	Sat,  4 Oct 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fpMn+OeV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC12222A0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759612798; cv=none; b=fnRIs06UHZYpOuwc6gmKjTDdFqD2qNcFcKnGWoU9CofF2JINwCy5M4IjTChac7NPwZ9/a1fmv6XmdxGteB8M4dUccxCTbBsjtm423gIayu5XUUlSlZoKM8fXbUBNY3wHLClzL4JxbrCXE1O2CGcQ8hpFKgFcmzeUQO+yfg4tzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759612798; c=relaxed/simple;
	bh=eUHZflnSr2TEkpe2XPDQWxvjho7jjLPMAhUmxpQiU80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kralobUY9gOV91EfeDyA0biIFUi5OcZeNObmQQqPfTYwtvB3cvKRyhE7/u6ULnalsBmJRZmOklouyF9V2b0csL6PhZrbz/fzqPw7XmtBcKGTOCrzDQmlva0nNxbTZkNik1fA7J44av0o3b0OYo4+VRJHnE9zKY6v/QQ7oM6V/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fpMn+OeV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e5980471eso16565055e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759612795; x=1760217595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hW7OEaTade5JEeRbSzzr5KXw6Vaivv6pg6suXCwYkOs=;
        b=fpMn+OeVvMkYRFLdi9eGJYfn+stTJ+hdoKuApilDpB5StY3AU6E4Gg794NL8Is1SZq
         MdhFjw2M2ow7x4B5RQRVN+AofXMCsCp05mFCFVk8f+yQVILTtBgDa14dqU9H+TDx8vYE
         G/0Wyiic6F9YA8pbJxJGUT7kI5nU0wDuZg7wwRMDKqNTEhkKaMdlTN88Xzj4gtJV2W1e
         gYpVS1WRDqm9c5JNtU6QMVD3DUusj/K3yyGl9kvJxIWGgM/EPpJ7u6n4a1KZfqjXuhgU
         xurqQQs5XO5egdhAb2Lk313lVcfR6ykgPCGd7Sao55/CEB2v2684M0LDPUGmeeR9k/VJ
         rfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759612795; x=1760217595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hW7OEaTade5JEeRbSzzr5KXw6Vaivv6pg6suXCwYkOs=;
        b=b7bqUz9mgQlXTEWXYt15h89TXM5JAdlVPpVocnyFfWv0z0OazHhAfYREXRdx80ZivE
         tKehTKYA6FHL1FueypocnG1mBIZfzIAfmkXrahjYmb7zNYRjzT2ar3tfv1YI9t1j8t+S
         7a8u+2fMRtoHvgCjflz9WS8rRdH6PnJuLBMuFOYifPYkZgSm1JKv4y2CLzyg9l3aGoVR
         VvCNgbieDkwHWruBbVz3GGPsCN6rAAAi0Ed1viVq1Hu0uHDh/F6vuVP3scuovKDWnCAO
         WVWEc34UHxfzJFgp3V3hhNVuHv2gM6gD+Hdyx72+sw/vTMBHNtAdnuINjbXEu+o8YqVm
         Qwpw==
X-Forwarded-Encrypted: i=1; AJvYcCWLsBgkh8b28zNteDYmM9G9OKlBJRvTAwpxWMKtxxC0NFOWCZ91nlQAczuzTKgQyEydKPJGGCSKsol2EyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8Z0kYJEdsaieBVyVtQL4vvmWFNXGm7sceQyUHzVHMcuSoOFf
	6g0WJom/sicGztYsZvzUoiQvT824ni9YXeBrR2wi/QN+w6KSiONYbOA=
X-Gm-Gg: ASbGncv8WL8D9AcOin4+kXW9Lkh7UuE33YvnlGlcXWDOYAPnEedAI2edju31qPuKGQX
	YwyDWV6Zs/rpxb5tTPrOQ1jA56waryR1EBnIop7q0lCv++dr2dy7Q616uL2FscJXVdffUjjf16z
	TLxFBelqGRGFrYvjCyPtT/6USmRraRrujAE4uuMWwi2jc6daiYrbqKC1m3V3bkzxCQjSOMtdb38
	IqG44tt0/Etuo5ihjf6sEB8Ennj2fMwbMLhaSmhMnw9mKyIH6/dNhEptrzJyDJKvfIt1+oA6sQV
	Rft+rfj2ZxS+2R4lHHbN6VZ/dYOUpIEd71S/R+1lML8767WVvefyLVFwnmeMCaC79qx2bM9G6O8
	V2ezJ4zFzGrzqB5xWebqRJuGnJemSPmIZtImVJCBAXnUAiqF/4uohPQKEDXFg3gMuiOdHmGi91z
	gu4sWFKg2FEWK7BHibidMojP8=
X-Google-Smtp-Source: AGHT+IHfyPEEeoKKPfnxCwwTH4snrR1lqeeMT6o3OP7h3Ocjh70aKmFMr9qutwQp2ziuyduhO8+ugA==
X-Received: by 2002:a05:600c:8b38:b0:46e:6d12:ee4a with SMTP id 5b1f17b1804b1-46e71140cc4mr44684345e9.20.1759612794837;
        Sat, 04 Oct 2025 14:19:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd24.dip0.t-ipconnect.de. [91.42.205.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723614c9sm86798675e9.14.2025.10.04.14.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 14:19:54 -0700 (PDT)
Message-ID: <a5750ce1-a441-4dd5-b9f6-5bc5e88d9723@googlemail.com>
Date: Sat, 4 Oct 2025 23:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160338.463688162@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

