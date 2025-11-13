Return-Path: <linux-kernel+bounces-899057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C03CC56A52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA92734A283
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD91330B0B;
	Thu, 13 Nov 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="l3AYlvul"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7432255D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026735; cv=none; b=DyfM1s+C3qzJY+l6RbCp6snVAxOg4/RSc+hhsz/h39PLnqtKdBbjd0mwbQbmx0ouqRSLHcOmhjWHV04wTwLE6qf8QlrtJ1xMCxdvi6fua+yi1HB4t3BJ2vcO4Wr7r0OYVyjP4ZMZjPUvkRGwzPxYnLcuuQXSONhghRyiSlvwP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026735; c=relaxed/simple;
	bh=EdPs4juy62ccnbqwisb9WZ/DrX2JL18pTQunI2hiDLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCGpwmCvqzH2SItXA/byhtYHPn40ViBgiMIZZ7grWrfhYvCkCoDI7Opm6FTCX5Q2Sp8S2QBdeCLwcBZ3V5LwDSJAFppk51X5wqxbu+81Zo9lTYOlXa/1iD9+HsyX7n7ce158TF5LokjLvPs4ZhD7eN4zDWNDLkStl43RCWkAv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=l3AYlvul; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ede6b5cad7so2694471cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763026733; x=1763631533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP5WgxtbS89E28gAoqSP0cIIjeJeCmahXVnlmty8cBU=;
        b=l3AYlvulAIbwKljzbmh9+9dS2jgRudxl1y/fDQOvVRkVhYb/7YmAyQNH9sPgpGHFff
         C/e4NtvFMIgC8YhFW9pqeF7cbb3GkicWnL8TVX/7dhjaSdhpOUB8IvMHqcghSFUNnK9a
         nPcBaRIlv2nd5JDE4s5UexH7kHw74vWaehdRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026733; x=1763631533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nP5WgxtbS89E28gAoqSP0cIIjeJeCmahXVnlmty8cBU=;
        b=bkHUb6JvSYFVDwAa11SVMgLmKBZ7sjCLpLFi60vzU0FaNkPxps8xcLKaVmMZkb2NgM
         480RWLdL8dLrZBH9reN/hLbHrvt3rwcblOZCbQQfr+IzjiBEYsihmP0wFj7r5VHB7ywb
         dbmBQDS798VrN+yEnurHJpLu/aW7NvWsyScB7F0ulcFRZ7eJwz+sa1DsogPPeYlV+0Ip
         BxweGQBqPP6aEbuewrqslQrFovzxGHcJSso61zCmjL7QuKmqgsmJVOWFvoP/z9TS9RqC
         qo+TpsB5yVzgE1aADThTJfo0+WNPRSLux6vMuzGSL0nleFt6J5tZtiuIlnvCq4/VAH51
         Myrg==
X-Forwarded-Encrypted: i=1; AJvYcCUzLWZvMLugLpiN2VlMyLQvdGbjr8puDv47f/cRm1R+8kesHyF++J3x0I5bjk0Y67rqtDU7vE8k0VUnKig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitbPphm8jA8mSpp/kEEd30oVu3iaQS+hrChtMdKR/ZyIcXFUN
	ecVSnrJLY119rhN6NnqVVJAmwunnUSpAtlSAc9JAZd2patJ0OzVOAxmF666sMrEwlu2MSCIW/z7
	KZXXztlp7D/CbRXTWWxxrNOllurZTNQU97lPfE7+osw==
X-Gm-Gg: ASbGnctnFWJLN5hHcsBwliV8/xNlUyQ6zbTw/aNdIv2x49Wi/hUrMkRd0s+6YMzLhnN
	0EdKhyrhAdxSEhoRex2hSCdLkjXnIPkm549De7/6nrr3OqfZ8QhlNmRgDf+PYb9Rf/KAxqhgDrx
	O1jAXBD78jtfxvdw0FKJlhNItqVt1sGywDV7OyGTGRci45hf/XprmKONsvMl1zCf8Agpuzm1tx6
	ag1vEsWe4gyOZKG9dR6x+ixdxqDzr4sRlHkqtkJPSlCsBVnxpfczqJCje8i
X-Google-Smtp-Source: AGHT+IFLA6qK67emnI3r/+0K97kMNI5gwxD1/rhmSygkn8geJv98fYFwYjHwP7mxFNoiS+2kmbVw/huQnP93tRr0CCQ=
X-Received: by 2002:ac8:5d0f:0:b0:4ed:b83f:7896 with SMTP id
 d75a77b69052e-4eddbd77352mr74696081cf.49.1763026732674; Thu, 13 Nov 2025
 01:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929130246.107478-1-mssola@mssola.com>
In-Reply-To: <20250929130246.107478-1-mssola@mssola.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 10:38:41 +0100
X-Gm-Features: AWmQ_blm3OU1lrWKh6moqo6AjuEBiygoCRZ2c9tWVqcvk8C0yMuYS2IyumsP348
Message-ID: <CAJfpegtOMPM1ewvySr8d15rCCWVXGPYhSutF7_UGfE++6D7QWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fs: fuse: use strscpy instead of strcpy
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Sept 2025 at 15:03, Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.=
com> wrote:
>
> Changes in v2:
>   - Add a commit to rename 'namelen' to 'namesize', as suggested by Miklo=
s
>     Szeredi.

Applied, thanks.

Miklos

