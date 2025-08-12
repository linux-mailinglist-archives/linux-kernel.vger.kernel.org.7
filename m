Return-Path: <linux-kernel+bounces-765335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C22B22EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AED3B6F37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA432FD1C7;
	Tue, 12 Aug 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mpk57Cja"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53D2E8895
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019097; cv=none; b=mhqipIqJs8EwSRHt3v0IUyApdZuheDcsHSV7qXD/upp+uT2jw3E34w+6mageO9DHjFVKOv/q9TjkoDSoxxI5ZW/XxXVNDomBOwt7OBMo+ZV6S0sZhfWjrmpOJtBYNXirr1o0lAlbpJPQvyTrgeJIG7lBwzTGSmX1c/jKJHxlktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019097; c=relaxed/simple;
	bh=/1/AcIXKW6qI9qQKGtUvf0EaTv0IPP0cBe2w8dCxcXM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ixO+BUPnTI8FSau+xqMqHKbjGldZ0PqKGIhbJS8MSHNMkJ9F3/rfU9v1sUJF0xgqtpuL6rGcyabIJ8xWgMv73QdpqAuAOFQUl+WEMR+l0oMHJJUZh68Kzj5XML5Y+blTNa9Bk6Qumi2489TvEv/veV5q5qqkEXb+fRFrIBDUc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mpk57Cja; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70739d1f07bso68049616d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755019093; x=1755623893; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZI90C2tnuaKIdrwdu0WyqnSd0Q2d8pZCzdJupkSfts=;
        b=Mpk57CjaoyPYJM6sRl1tWus/CaIVyZEaVym19ZsytqPyB2f8d7j73dBPci3tjHYvRz
         RaQAOn0BTi+53cutgDTmGO5SNlYumN8gl5MMdXUkwXCL9SBDZ5t82ShQvK+g8dzkRK43
         jUGeI8ygJGAIKreqKGCe8BZoyITnPhUfg8dwaha6JsB6vAOkP6rdHtSIgUjLrivdOSmn
         8A87cQ/PMankbRaZZxDWBQ4hb7c7YCoDn8H/q39YQ2s/ZBdtWU3BLK8tgZ8k89xp32d5
         /eFapMIjsbQ67viT2TRel27kMw5Nq1P955uYvuC4Yj9+A2R8XPOEK7CZXahPBgEfPO8V
         KkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019093; x=1755623893;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ZI90C2tnuaKIdrwdu0WyqnSd0Q2d8pZCzdJupkSfts=;
        b=sfGB2lWT4/EMEjQDzn2W7DqAICNbgfn33TE6IjSKy2/8+Xc1SENsU6a8y88syrH9s/
         uwOfRqCqQ2aB2qjcZ0xJS868bcX5EafMF1M/torBwKo29+L4afpLj+7taeF/fN01T814
         n1iz6PITZSmaN72RRTeALO2XIVHK3RBCzA76pTIey0wl187Fe4FX59rw+px+iXzVMolb
         OVpcptqYJamt5001BLrMhnYWpmm6WmhWqqUSUOuLeNi5/f1DUSHjG4O5lmVk51goXXAZ
         3jqCGvGp5xu2+m1TkQoHzQfbAJ5glRdpCm1DqMWVQCXURWzig4Oyrg2kbP2vdwXCI3pr
         /Zog==
X-Forwarded-Encrypted: i=1; AJvYcCVphBTZRezvqQ7mjZP7QiXHyBa8y3HEdgRJ1xp9BaQ4ariHZZFkTg4sgxgLiU+G02W6lSh67/jDmax8Log=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2zDNclVpdqhuBy6PtfqBvexv1BldCQlKLMye+aqINWhNKkW4
	+Pcx1toHcnMZ+AmniCfzxnmE5Snf+gv9xMSP+/OPWc1deLT5TmDrMyNdVCW8txi9RA==
X-Gm-Gg: ASbGncv1LRCHslDvaZKiRGketHWK4qC5R1LUMxKtnNTJsnbghh/Kz7SQ4q3unnZmhu9
	Qia4PiDtr7J5ueR/CspgVAk5QDF2mUPyNTpuzmuIsy30ItZNPqNeWCZ1n1JAaAbRSNMimj0C9q/
	0QqZ0RRu6ms6TRqXEffkyHsq9rXQnZ5CcygLRX5q2GmZPrp9v5W+T/Vfp4sJhLS2ThKqjov0jb+
	qiOdmrHZ/mmZdCzVXHW1eORIGX+u6Cz1EMskWdEY4hpw1WKPS31x9TEtVCVv/fP2W9AaRiyBLn7
	1yyW3mSfnDoDx9af53NgD7sIjjchmJ3YNnbmyDE6EseAeXR+3P/El6G+eM4PXTV/Ka7zHt5vYbv
	RdBUUyNrlbvA+IgXap5MjAZCuNdSpkdwKzp4iDniGp9oq99zYQXGSSI+HnCcF3YtHPF4=
X-Google-Smtp-Source: AGHT+IFFxlzYtv9/lJGBE1NR5KyO4C9Gn0dlEhp7e0IyW62FroGzl6MnQ1bI7Yv0CgoeIIwr0ShuyA==
X-Received: by 2002:a05:6214:ac3:b0:707:5759:8464 with SMTP id 6a1803df08f44-709e6d486b2mr6084496d6.44.1755019093063;
        Tue, 12 Aug 2025 10:18:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca1dc91sm179342506d6.27.2025.08.12.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:18:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:18:11 -0400
Message-ID: <c673760d9f02f494f06ea7df9ee6128a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250812_1310/pstg-lib:20250812_1218/pstg-pwork:20250812_1310
From: Paul Moore <paul@paul-moore.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH] selinux: Remove redundant __GFP_NOWARN
References: <20250807140545.566615-1-rongqianfeng@vivo.com>
In-Reply-To: <20250807140545.566615-1-rongqianfeng@vivo.com>

On Aug  7, 2025 Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> 
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Merged into selinux/dev with some minor tweaks to line wrapping and
horizontal alignment, thanks.

--
paul-moore.com

