Return-Path: <linux-kernel+bounces-748386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E35B14088
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BFE162A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480A274B2A;
	Mon, 28 Jul 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZGR/f9b"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB9218ABD;
	Mon, 28 Jul 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721004; cv=none; b=sOXlDtCcjyMSiH9reMdhpsxr9m35Z5JNrIt4iirhSzxeQuEqnUIZEBdhzY/BENyPLN5ngtzc7xpZ6CDQvrJ78uyZAAmvjKbvAjy9sGB5UD6po4hJtW5qugPbrlOASrzn2KvByroiZe0eETIi/mWKRcVHcClXdcGheo0aT4GuLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721004; c=relaxed/simple;
	bh=Zx31+4coO2m6uUckV1Kff04UKjomgKAsLQXZUcsNQnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPMmV1ZMFRyRy/RxEPLNwvmaMxFPwamGS2oA4QpCCDua7zCmI5NSzOLj6/lGCkSNj5cxBPuC8qlVqnXnNWVpq6WddgEdwBR/DNm1inxxkI2a4w8M52itp060aD3+OoDxEP3S8QGbrL8rgMNh2KuwCII6C4ln4iKnvM+K/FGdNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZGR/f9b; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b553e33e6so38016151fa.2;
        Mon, 28 Jul 2025 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753720999; x=1754325799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx31+4coO2m6uUckV1Kff04UKjomgKAsLQXZUcsNQnY=;
        b=ZZGR/f9bkcfh6ZI6U7khWRJ1u5xg9C2OXMGdygG/7G/Jtd8jCDFk8H/rBY4cxkW999
         0ddbxU1Abqow91kZ1VyZQELZi8Iogo1C1CvJyEKjZjy/wxlmOZtuvwgeOQxdqncrNu8Z
         G4OqzXDe/gTBlr7gKNrxeZhRc+aK3OmgYhE0hTq1FtLpoEj0Ba5Lzs2hv4xzDEeq+WuT
         k7LhSU+slOXPg3T2eB3hRPW6Y71W+EStSppEjNrI3aPe1453DXccvRZuUPiA/o8by1gb
         8wvqbzDOloP0Si9ZqMg2b6ivzALKc/tgSMYqZBvgDgz6tmLY8Mecj0KWZsomjTcJp2k0
         9nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720999; x=1754325799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx31+4coO2m6uUckV1Kff04UKjomgKAsLQXZUcsNQnY=;
        b=PkLFcgyE6nNzm1bUTY0/JTMFHKMJkP2o3XeEK2Xd4BJ7imX9xu2QGrOOG+n7vNSfFw
         qKiGzEpffxz1lpWj/MiydJaddRmoydQkNql2CfmRAQL4ZZ0FlNKODDkVJPg4Gyosfoj9
         v08LML0bDRTnVD9KzNJG5693RiUkHxcMntWfS0NFEBunUB7hq8L4rf7KtKycEPJ7cVqF
         yJxGCirF8g8OaAW5N1Syk2VsHFvX7l+as6jkMm6Cb8GtPp2GpehPRyHzw309u4kKINOj
         ymtTn+89/Wfub4Tiuq2FT0WpOB11F38jHHhGE9OjHVzCTfA3dRqxVNjolqPWDDPTIbyq
         FW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCODXVkBMQWHqtQ07eHFi88PNBwmuY+jUWkNx4htnJCAk1s8xvmdJaoiUYT6Ujndh4538JuaK8m2vUS5qc@vger.kernel.org, AJvYcCX9ZOqpXCB0NonJGanFNjb/1MQ1mrv39cYpntFt4CeBOBeoxDbbFMPUuNtjkelr57ivJCbyDxqBSLPS@vger.kernel.org, AJvYcCXB59myGnkoEPO3Z32Wi5+lQ2fQKNIH7F+s6+OkHl/x+GSLhJDD/g+4ERMxqPBvc1ZypfsnKpT6cS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvpLaekqwdHtQsCNFNkQZspeXsW/zJoxY/1sgc7z9FhOyaiAR
	118BZTnYq1HSdXFV3B3r+pnFGRwaDNloV677XZ0ytNN+jknD2imIenY1niBAWyrelY1vPseNbZz
	Rv2lBuEsx26Wd0ohqO7CtnO4x2gSQsp8=
X-Gm-Gg: ASbGnctVF6i26nzoEhftu/FuUdlacK0UpCr8GVTFtjeSQTE2AV6mivEJAuuX/O2TDd0
	/f7ENo1o+5GcwkESb/N2qy5F+HFIeP/f57RUsiMDY3RmiaQm6igjlorhYAVXw8EqLNK5ARpTKes
	zp5xfJQRMduwHmhn9k1VmhNr/3ECzcPmkjeKc80igI/SoTDic5wmIUUUd65T0s+WuYV5BWE/Qaa
	y4Ea+7yCp9MunQw8g==
X-Google-Smtp-Source: AGHT+IGPKRGvsHpq2Jf1lM/Z/8McaMDqRbCdLz1swgbmyzmDJETY1raPzZK1qOUN7yul4oaUTpaFJYYS1h056oOQEhQ=
X-Received: by 2002:a2e:ab0f:0:b0:32a:62a2:f726 with SMTP id
 38308e7fff4ca-331ee6bad59mr25734841fa.4.1753720998943; Mon, 28 Jul 2025
 09:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzwLxg=vQeQKA1mPiYV9biu=swo7QDmjB3i=UhYmv+fGRBA4Q@mail.gmail.com>
 <053939E0-5BAB-483A-9FE4-92BF35201A4C@kernel.org> <aIZJppabYBCDBhYJ@gallifrey>
 <202507272336.E17C3032D@keescook>
In-Reply-To: <202507272336.E17C3032D@keescook>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Mon, 28 Jul 2025 21:43:01 +0500
X-Gm-Features: Ac12FXwQZS5YS79wmfk_Tvfw5S3pk0pacDVAu5rPlN7xdXBoh9Am-TiWLX2y0W4
Message-ID: <CACzwLxga0scmSg-MQZ2Joo4Z39he27r0UGpUCvKC4iOk12CkaA@mail.gmail.com>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
To: Kees Cook <kees@kernel.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Sasha Levin <sashal@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rostedt@goodmis.org, 
	konstantin@linuxfoundation.org, corbet@lwn.net, josh@joshtriplett.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:40=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Jul 27, 2025 at 03:45:42PM +0000, Dr. David Alan Gilbert wrote:
> > When doing qemu dev, I frequently run it in a tmux, and start it with
> > '-nographic' which gets you a single stream with both serial and monito=
r in it;
> > alternatively you can get one pane with the serial output and one with =
the
> > monitor, that takes a little more setup;
>
> Yeah, I haven't played with it yet, but I expect I'll need to try several
> approaches and see which the agent can best deal with. It's better with
> non-interactive stuff, so I'm thinking that giving it tooling that will
> run a script at boot or have the image bring up ssh for the agent to run
> individual commands via ssh... it all depends on what the agent can wrap
> its logic around.

FWIW,

If we ask LLM to produce the code, then LLM replies with some description
and the code section within the paragraph. So in this pipeline, we need to
pre-process the LLM output. But there's another way, I believe.

We explain the MCP agent its role with the instruction, tell it to
save the code output
to the designated directory. This should be possible using MCP
filesystem servers
with RW access of the directory, so we're ready to test the generated
git diffs or C code.

Testing can be also orchestrated by the separate MCP agent who is instructe=
d to
take the code from the output directory and run the QEMU on specific
arch, config etc.

Code generator and testing agents can optimize by themselves.
There's a MCP agent framework with "Evaluator-Optimizer" workflow [1]
to optimize the output
to some EXCELLENT quality, which is a vague description for me.

[1] https://github.com/lastmile-ai/mcp-agent/blob/main/examples/workflows/w=
orkflow_evaluator_optimizer/main.py#L57

The downside is that all of this works via LLM APIs which are not free.
But this is some orchestrated way of verifying LLM code generation, I guess=
.

In local development, we could grep the LLM's git diff and run the
QEMU via script for the test,
and evaluate the correctness of the code ourselves. The only money
charging here will be the LLM model,
if it's from the vendor. If Linux kernel has its own trained
Ollama-like free models to download, then it's even better.

>
> --
> Kees Cook

