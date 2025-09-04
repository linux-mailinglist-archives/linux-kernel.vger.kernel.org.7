Return-Path: <linux-kernel+bounces-801554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E687B4468A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AB584891
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF71277035;
	Thu,  4 Sep 2025 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYcAXvCa"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E3272816
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014653; cv=none; b=jvxifn/6rIYVdgDivVz/wjt54DQWS/KjmK4XAse2pn+YGYQQshVipdqXFxZ2SMrVlmVsf2/41sNzo1wQ80olqLJILeRV5zjqITH5XatEKeGW0b/EjmEAhcdKid17B7cG8a8RIukFtj5GakUuC57+TAsi6nExltvejNt/F9GujJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014653; c=relaxed/simple;
	bh=b71mBa4+CgOQozq8su9h0GwymINkcoGVGaHXRDgYI7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlAwAxLXfpEtr6Bdh2x26+XVFr628EIbx1IaU16ABkLVTa0NT9kNIcrzdfqL830avjMw3Iu/Cg3DknC+FDqnMU70GlHRH2r4/1dlY6MPA0t+4hcVZakZyWlNWeFAluSaRb3Pf07ib9ieYgMBKxNl5J/97gDYv4A8eAkAuuwiCWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYcAXvCa; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-336d84b58edso15443341fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757014649; x=1757619449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AJ6DtMOF3y4OJW8/5WYqkSHHcxXo8CUAVBKpGx+P1k=;
        b=JYcAXvCa3oYT9bKK9TdTArz+3Hk84wC/WowFikdApkO0gl8lVjYMVnYmw1t1x8dIIf
         gVexotT3ogWMSxUVOoUbnSxAV6Enr3hhIREsp29oKmHgzH1bIeKhqGut7LSHqaS3YT4r
         /FHP3o49+pNJMhnpHgU7Ug9rgJql+ysTBedoQiusUSfWFYwBVdgp3jPe8T0jNhRp0ZgD
         vPieqEw0ajZv8eUhvi/VYSUi3/OQY2GI2lMuv8u+OiyTz3rRhE5nefW+Y72Y3pht3XsD
         5LRW6vzIsxNnsgzbi3KC/Y2bg/XDPatLL9jYdNw43MnqQ95JF8KkLZ7RiN5j6WVZn3Ry
         jXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014649; x=1757619449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AJ6DtMOF3y4OJW8/5WYqkSHHcxXo8CUAVBKpGx+P1k=;
        b=JHp6ANEhYFYdz395NFRigtM6F3H7+KS8lG448qa7sa1Wko9UuJ1qkYgrzNFDYqgPBu
         J5gipy8PdQEjaXA6WxF3KMCNas6NiSxR+cM7htjkKPsLbTulXgMz1i22H3UEcLn6MUJD
         MfuOvP0Ma7qATN9/ErFUw4CWD/w2Huci1SXaTA7faypBMBRXunyLh497hg99PTVwXQCO
         zwUx6FhBAuU2zVPXlyKQphtQTSXucCKQ6W6C4P7HnlKviB5lFjRqkAp2CripxcRCRTeb
         eyQN8tod3CLxj46b3eCJ+9A69+ZLiGKalf/KRR/v7IjtGLtKTtdCQCwCg0Mu7Tl9KZYf
         oS3w==
X-Forwarded-Encrypted: i=1; AJvYcCVLRbaKhNlqSlwoCEgoo1QRLgSF9/Zgbl1BlxdANaT2FMqfxDHvnJ+V2iaGyc3KZpxkCDcL4rROLpcWuEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfp5jZsWw6aucuBjY5gD73Ktztb04hKbtVH3s3cUEkFZTaCtDZ
	2DyS0co3cpJY2UgUgg/85lu26c4IfqIffHGn+LBZsR7TF/0r8dtTsvbg4Yn4eWq/zD0EklJcqx4
	OoEAglVG/g/ekcKctVKnPXHV//OaX+hwjgvif3E/9Tg==
X-Gm-Gg: ASbGncvfjOCuJf0UynTdP+vbNpFbI5r8Oy5UfSfjx9lHdFw8Fllll8RrM+1IM5+3qF8
	zOblEEF4NftP/UOG9s+u12Mh2GgwV1F1yHaCjXMYsYJbAm36D9aDuBrQTdBKCz+48fkuoWfPMdy
	5ravmLfk1C45buSdw4g4vQ5i6TQRNrg5iBk0CdKILsqOL/LWz+QXwDU531ab2b2qEURJmeoT3gg
	Qc83eu2Mes0mviR9g==
X-Google-Smtp-Source: AGHT+IHcxZXWcQcGpLSD+vSozPC/BlwJwc3PxIluTYmSvDgzHTW8BmhbS+tPWNA+mMMfD1/Pl6uPG6IqMUkocmLUfrY=
X-Received: by 2002:a05:651c:1501:b0:337:e3e0:39fc with SMTP id
 38308e7fff4ca-337e3e04b6bmr41778151fa.21.1757014648753; Thu, 04 Sep 2025
 12:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aLnhbpfeweBI1H4N@stanley.mountain>
In-Reply-To: <aLnhbpfeweBI1H4N@stanley.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Sep 2025 21:37:17 +0200
X-Gm-Features: Ac12FXwwpWbvmfNMOzJViHg9lMWnmNonsNEwaek3gjtIoQRyh6dIvrGKZ4b12vc
Message-ID: <CACRpkdb4RjOSFwmao_LD0GM_+BSc5Ei2RmcXFPV_fBGRhB0DgA@mail.gmail.com>
Subject: Re: [PATCH next] pinctrl: keembay: fix double free in keembay_build_functions()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 8:58=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:

> This kfree() was accidentally left over when we converted to devm_
> and it would lead to a double free.  Delete it.
>
> Fixes: 995bc9f4826e ("pinctrl: keembay: release allocated memory in detac=
h path")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Patch applied!

Yours,
Linus Walleij

