Return-Path: <linux-kernel+bounces-755225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B4B1A340
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D250161024
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3725B26B747;
	Mon,  4 Aug 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T4ML8oWn"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141A25F78F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314243; cv=none; b=Zu17UYO3lPtqq8mUZtgclJfKLwMnysbBncZ5inHuL9Ukz/1WzFEq8jbt1E7maROx76yznbrM/t6ohz0VMrLgotJl9/glrJqspigUOSDBH+Ja/NXMWeNlJxzPQ+9pGy8G83B/K6hxOsXMhCWW9hs+sgtteMbXN60LK6ajK7w+buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314243; c=relaxed/simple;
	bh=bFoOwfkzpdGbVKg/8VjkthkcsGob+US83lQ5IAa++NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgB3rEJWxS8cXZeUlUDRe96qn4hBi0MAoePDh3VqftkmuvaGJ3O/ngEx6Pyq9Z19VFBqGw2URV2PsEbp8WSL4P0ePM5geDGWtwZUgiIK+d6adAw642hWgzybde+FqTVYBPR3kyB6A3k9IBvllNmrU5y+H3kgQ+HQ7fjOIqmMbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T4ML8oWn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4af14096b9eso29317291cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754314240; x=1754919040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0DEJm4ykl78MCkCCnUIUGLbm0eW648bU8lzZM6Zg7k=;
        b=T4ML8oWnUOXuDeBLEJvjW4iRG+zgzlVQq8m/43KFn4jcCQPPtpRKhNNHh88UZfprJ5
         UYxtX/49E4azbMn+TG4EVCZwYch2V/cAyiFsFs0k+O2OGJXrMMwS2NFBoZ+HIofXA9kT
         QDxGRC8IMsDw+KNsMc49kEvHOzJCZKxkwBrCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754314240; x=1754919040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0DEJm4ykl78MCkCCnUIUGLbm0eW648bU8lzZM6Zg7k=;
        b=meza1Wm8AMpTJcivIhRSpN3vMy/r/BHeiSmomrJCW0yFTmbMZ4kTRI1Zfz48ZjTx5U
         F+G+Ts+ZBHqwVfB+JUQk43W1QXzr6lEOu4eyNJQ4auEF7/zK9Wbuaehq2v7kx6401v1j
         yYrpi6zBh+RFotidXigFp8f/DcDGpK3I3Smt6XyfUo2XRrZjrjOl9Reh7XKqETqPYys6
         JuwZG4UOicec+8lFy1wq8jwwmx8oeCpcYPUgcA6J3er5qwFAkISXa+uhClpVAO0lfTqi
         XHVMeaW0pvn1ZKfrVMIFrZt17bsUqEMXLdC2W5I8ffBllUT0Jvguy+ZBZwGXXRoh9vub
         Se2A==
X-Forwarded-Encrypted: i=1; AJvYcCU5yNqXs70jdhWugtcc2jHrsk3rkrC6xFAkjZTVbQ4NVyKrPwworgPa0Efl5OdmFBFJkC+XligRO+BT7FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoUZFupi+g17WjTAhq+YAKWSGarlvEX2PocW/koM+xujimJJoF
	rb8ZcyG4T6KzMepW1XOMZPaIIBogfUjnmbxb4Pzk8fVaJ6Y3AGK6qA/V3EXp7s+q+dALSwm4hSv
	nFUrsaWLxu9PKFFEfl1HA3Pwgsf2P2rO9f4SCUDYw7w==
X-Gm-Gg: ASbGncvT8iLFLKe7F/gPKGo1t+y0W5nrnYudFxj++TutlM0eUx6u9Zz1km5iQLVt/yA
	+mxlnFrnuSehumZE7p18aSGzf/Z29TI9PXDEa7N3ZWwZAd3FD60dvIAAdnQuZ6GSsg5wPaDxf6o
	0xQ9bunkGJ9dda2IDNnb66ZsX6rz6jgtM7CbOJGIWslFhJt+brb9MiW0yvAAEK4swom/Gz7EA8e
	eAAhCUzzX5QrCWHaaDXK2+5NfXv
X-Google-Smtp-Source: AGHT+IGFrVNf0V7c35xNID5UvjWNSDTvtM1F6flQzsxXN+EbCJT+kclZAdeU8ofwKhqzMcWnT5Zz1M5pXcp9/xFZqw8=
X-Received: by 2002:ac8:5a54:0:b0:4ae:cc29:82a2 with SMTP id
 d75a77b69052e-4af10d54f0amr117404121cf.59.1754314239974; Mon, 04 Aug 2025
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Aug 2025 15:30:27 +0200
X-Gm-Features: Ac12FXycZviWqMr6BQfOqXkebdWsgz_PSGKdoF2vPFms50tzfoPTnlZ48Ky1plk
Message-ID: <CAJfpegur9fUQ8MaOqrE-XrGUDK40+PGQeMZ+AzzpX6hNV_BKsw@mail.gmail.com>
Subject: Re: [fuse-devel] copy_file_range return value on FUSE
To: Florian Weimer <fweimer@redhat.com>
Cc: fuse-devel@lists.sourceforge.net, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 11:42, Florian Weimer via fuse-devel
<fuse-devel@lists.sourceforge.net> wrote:
>
> The FUSE protocol uses struct fuse_write_out to convey the return value
> of copy_file_range, which is restricted to uint32_t.  But the
> copy_file_range interface supports a 64-bit copy operation.  Given that
> copy_file_range is expected to clone huge files, large copies are not
> unexpected, so this appears to be a real limitation.

That's a nasty oversight.  Fixing with a new FUSE_COPY_FILE_RANGE_64
op, fallback to the legacy FUSE_COPY_FILE_RANGE.

> There is another wrinkle: we'd need to check if the process runs in
> 32-bit compat mode, and reject size_t arguments larger than INT_MAX in
> this case (with EOVERFLOW presumably).  But perhaps this should be
> handled on the kernel side?  Currently, this doesn't seem to happen, and
> we can get copy_file_range results in the in-band error range.
> Applications have no way to disambiguate this.

That's not fuse specific, right?

Thanks,
Miklos

