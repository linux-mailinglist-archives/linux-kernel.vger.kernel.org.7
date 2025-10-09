Return-Path: <linux-kernel+bounces-846202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D4BC744C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 202E64EF4CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7282153D2;
	Thu,  9 Oct 2025 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMpYlN+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156971925BC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979233; cv=none; b=B+X3wxM7duxVcHpRdA14RSWTe2+3lH0CqlQp/VlYNLdYkxYFMkw5bXbN3k2jOLhkhFIC3d/W42B9G407FYlx9hRRfPtank6xs11mvIAYMx2PBhycGAgNHo7+5YqfY+tw1aoA0n/8F5SoSYSrCfl5FsoAmzIvmpWpb9bjZxBPQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979233; c=relaxed/simple;
	bh=l6/QlNk1koJ4Ly2vwORRfIsejJwgCenfdKE/TobxbjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFgjkzmouYE6jX2/MAemKbjNnUrUHYOIjKvBNzpIJt7Ih8BAjaPh8XgYCYeE/5f14xYJGI7xutiYsRtAnfqVwqz967rqbtIkzZOnScuQpm4Ae7GdLvbZF1IwPLPtdsZF8uYHO7YkZmANjX8rECT0Hz47r1ypiOkPlJ7GMsZthDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMpYlN+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E15C4CEF5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759979231;
	bh=l6/QlNk1koJ4Ly2vwORRfIsejJwgCenfdKE/TobxbjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rMpYlN+yJml5C+VAtFHlRCOPePwcYFPQaPv1GtVXKsGG5apLuSQHvEmljrrKJz+vw
	 DTDedRbRP5xJ8q//2m+Q0iJFjnzR64jVzDo4lg5+QVE+JvSaD7YfL2aSVpeaWcwdNF
	 Btz63An5DXVR6xDtfLmATUbi1TwUeeeqPfc9qIQcNvKQ0a7bJ+lG8JjeW7adE3wjiw
	 yAnhB61oLxBoLVyuYFLnx+PlZExCp/Yy3Keljwlt47Q8xEnN/hRcNWn3OpUx9q98k5
	 u6kFZCkCbdtY3oa6i1a6Y6QkiOkrJQBh3Vi5FJIAoUKIUtkaWw6G4bTu9QXMzvR3eM
	 Lw3BEArdMMIIw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so673341a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 20:07:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlau7SYcgkjgWzy5vnZy8941s3d91S0ELtssd23sAzcbXZrbRIon0irwAXnqEPEbBsJfHg1ITISkWqwZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyexq7AL4wBhdmzpITQ9GSOnwZ4VuIP23s+bd2xzV+TPerm1WTf
	fc/5+qZJnGxRXo27skeMQa5vQBJY9CDi0KF1WSWqIZ1WNSGVHDiNBW1eUuQlxhUeVPUZ/ZQwmJ+
	AMHFWHAYLqAfnfNc/XnRkvj1quwGiURY=
X-Google-Smtp-Source: AGHT+IFc8umF4spJGAquAd9G/hzMwu6C6pw1b+7LAkWABlQ0iMFfcdl67R0hJKF5Y90s9IMk0qQuXm/bl00Gn1A76uw=
X-Received: by 2002:a05:6402:26c9:b0:639:dab5:d5e8 with SMTP id
 4fb4d7f45d1cf-639dab5da69mr5050180a12.12.1759979230133; Wed, 08 Oct 2025
 20:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759478975.git.dan.carpenter@linaro.org>
In-Reply-To: <cover.1759478975.git.dan.carpenter@linaro.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 9 Oct 2025 11:07:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4_O=qoF9q+si59_L3bzo_8qZ4cdmXOwMtLSDxtdeg3Xg@mail.gmail.com>
X-Gm-Features: AS18NWCnKzxbXN0cnTO10iCNPoFw_Y9uEf0pFv7HxaZCZargsD1SGVjZqsMUkT8
Message-ID: <CAAhV-H4_O=qoF9q+si59_L3bzo_8qZ4cdmXOwMtLSDxtdeg3Xg@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: ls2kbmc: Fix a couple Smatch warnings
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Chong Qiao <qiaochong@loongson.cn>, 
	Corey Minyard <corey@minyard.net>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 5:29=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> These are two issues which were detected by Smatch.  They're not really
> going to happen in real life.  Small kmalloc()s can't fail.
> The devm_mfd_add_devices() function isn't going to fail either...
>
> But still, they're worth fixing just for correctness sake.
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Dan Carpenter (2):
>   mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
>   mfd: ls2kbmc: check for devm_mfd_add_devices() failure
>
>  drivers/mfd/ls2k-bmc-core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> --
> 2.51.0
>

