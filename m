Return-Path: <linux-kernel+bounces-832636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC5B9FF99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A22E6419
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7429B8DD;
	Thu, 25 Sep 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P10p1Bol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267929ACF0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809949; cv=none; b=e4RYFQYK/qLEvhFyMCzIervfTDa9n+iu+7bbzGmin2YtKL1JhdNnLtrBxLFOrxc6B27gGtT7zauae+DMcG69zzusPQJyANwbCmLSv2u+07krXqPIThK63IUR4fk3UiQ+x+OZo1cbocA7TdhA4M2dDIIAp+LLSyXh3WFsOdzh7C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809949; c=relaxed/simple;
	bh=xZ7S3nqF/uCv7oKg/+aOeVioeR4Vef53GYe13Yz0v1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLGosjYu3JqVA6F19fFeSPSLRzStdAumbeyEnGWGYORJ6NF2atcPtYoYuFL+F7kjDJNlTjT5gUbALWjJ0dKd9gXYmr+SCgxdGGJ2NxhloJ33wsM+lKXyf9fzJuPIeui/6DD4UmOXgTzOXsPvi7bx8D6bCl1bRhGRYFg1NcAay70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P10p1Bol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4847C4CEF5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758809948;
	bh=xZ7S3nqF/uCv7oKg/+aOeVioeR4Vef53GYe13Yz0v1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P10p1BolWutB0LVlMyvMODDuCxyD/Pu6k9no/ZD/BJNPRQhEG7O9vr82jvmg9lQPd
	 ALiDPQOWiNsnV1nyRCjFuA65gfHKzRjjXB3SHrBqx5CCchbrUzvGSQcAmFwMfKPtRd
	 RNEV65/DMsjyhY012z27Nt+69VDqZh3oaPnnjipDj2Aks/VLS2B5jaTn4jYTWfS90u
	 tC9drAOOQBVWjVC/HWLgR8DZJv57zgkqxG842Ln0H4YJoY5BLl/7QfXvZE8Z9VET7k
	 BegRQa3k4F4AAvwrPrMLDvVD7HCwAkq4gXuBJxx/+LdASzC1d2yOXyhLxCICtEuyEK
	 HJKkNT8u7Czrw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso2188482a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:19:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSqGmwgW7Kz9gvuXwadn43rC/z09uL9o2/2+aWRTVT1lmZP0sJR1xJiyeFOO3oFmKbRnfuZw3wzLiuhAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq21KKJYNHvi4T7FGqEV1XcK21zDTgKwK12uE+uTI0QdlhzZ7R
	97hf+bUxMFegqJxhSqpCCTjO2poo5N4kImbPsC8AMm/OcGr/d8OsarCPKhBNw7leneXYHeMoQUE
	ZFlIF2uwRA6MeQBcIxZwkatgDEH4RRH8=
X-Google-Smtp-Source: AGHT+IG1C5McH1X+RCLkE8po2jvWdRMzSMQxrOvQPYKmhz5XMUtco3ArvNGBTdwn8fhYoF/Sb3lma/uLmunxVdu/mIY=
X-Received: by 2002:a05:6402:184e:b0:626:8e29:8d42 with SMTP id
 4fb4d7f45d1cf-6349fa9e8f4mr2392469a12.37.1758809947384; Thu, 25 Sep 2025
 07:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925121255.1407-1-matvey.kovalev@ispras.ru>
In-Reply-To: <20250925121255.1407-1-matvey.kovalev@ispras.ru>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 25 Sep 2025 23:18:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-+wag9SD0XJ4YujHKkwj=ZcEZnvi2YN=JVuwSQL2MTTg@mail.gmail.com>
X-Gm-Features: AS18NWCMhJ4GUO15qHIbUjXm3H20fAomj3nx4Dd8QGtgtrrR5JjlY4ePbqe2aOE
Message-ID: <CAKYAXd-+wag9SD0XJ4YujHKkwj=ZcEZnvi2YN=JVuwSQL2MTTg@mail.gmail.com>
Subject: Re: [PATCH] fix error code overwriting in smb2_get_info_filesystem()
To: Matvey Kovalev <matvey.kovalev@ispras.ru>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 9:14=E2=80=AFPM Matvey Kovalev <matvey.kovalev@ispr=
as.ru> wrote:
>
> If client doesn't negotiate with SMB3.1.1 POSIX Extensions,
> then proper error code won't be returned due to overwriting.
>
> Return error immediately.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
Applied it to #ksmbd-for-next-next.
Thanks!

