Return-Path: <linux-kernel+bounces-820654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656ECB7D585
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E710465D60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F265C337EAE;
	Wed, 17 Sep 2025 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BcL+ArUL"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF6337E9E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111719; cv=none; b=r61fZT/qPQxgQo1O/PSiPjpSWUzPx/Bm8Xl0d1MWTOt4uKZt3rc3F0XKJqs15LVC2rGj/2vK9XIlwtVDEXWJ3Xo7EqD/QzgPY8AegY4qT7VC1XvlGqt5rzkYAKsYXU5Cpn4Ei09eNisiwFmLIdZ9FNmTr0dZ0+CJ16a0TLYEPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111719; c=relaxed/simple;
	bh=FR+HlzX5w0JVuT98FAcGc6NuriuQ7L2Nh8CqJXWJCDU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwZp3AlnY01WyUJc8jbNSGQ7GREFh8JmdMyCEdDUxCfe6gsQg4Huc6B8FxNcpbleehtOSfH8UegBaAVfdBSujJecdg7OVj+z1o1xKgzdQePpDxnmOZDaAsguAL09nYRbgDloK2lnTlItEEJVW5aW6AnifTAozce3F758N+Rm7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BcL+ArUL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ea115556b2so2290377f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758111715; x=1758716515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FR+HlzX5w0JVuT98FAcGc6NuriuQ7L2Nh8CqJXWJCDU=;
        b=BcL+ArULAbpswFCDN3y7qqioXCEhL2G5y1BIhQRBmvqCJN4L01qwDjFGcuv5k3kL/w
         wwt1rWUykFihUpn4Z7rFcT+jsaVZ7++AC0H7vuBXHffVsGF4i+wxCXEXX5R89P2YmLfk
         tpnMZ/3JBg8jUtT9HLLW67iVt3K5unLJ7mG544aRea+SjivCJeA9J7wZiUunBXY0YfU+
         bsS9quWXqdB2NFPDOe2rc6zfEM6GiH42wzneEUZAFJfhD8z2YCtp6kzsT9QnZyC77FGz
         JNHn97nNEHHDeLAKE2w4+0TdKP6nj8NtiH7ugifbLzGnwDrUW6fVO4aNjhPq0xSBz99H
         lvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111715; x=1758716515;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR+HlzX5w0JVuT98FAcGc6NuriuQ7L2Nh8CqJXWJCDU=;
        b=EJgAmnPN3cfhS2rR783D/WPH2KfIbMdhLUDQ883TTkTazVanHxeuNYHCVXANX9PyCE
         KLxOgAu7F/NXnHTYHUrScEJvpS3WqIPzu9Z5SooXWyBgYABAPC0wyXaq6M/T+v38uKXh
         yUme6mpx4z8+B/fULsDnLvs7y9mQVoXKgauxqxXVbNPZaKGwu1kAiRWq5U8irHOUwBMG
         XZL4H+JfLzWpiUktpa9kMhSzCxaxjKBMNLD4vQ3yXX1846N9ZHUaVMIBOeqk/E6p1vnN
         8AKNEE90G+pBBMjQMfm3Hrf/sl55CFSXbngEUwkJ7DVDfe0ShhTwKFYNvrSUCcEiogPF
         zpbA==
X-Forwarded-Encrypted: i=1; AJvYcCXgfmL7k9alUzngVoBwEjtJoQ7ghzNWHonJJg63HwIzzHNnk5pry6Wl3WrX1ZNzVC70+gm1h7lWOhhcr50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxErVJ8ZhffRKDuSEohMGD0nmSBXeHNutLz/QkAfanyErv9Fw+s
	m00f4eV590tbbx8p6Bg4sPDLkyvpeq2JD71sDTbD4C5yGRFafOIAeGRjj39u1goYlgA=
X-Gm-Gg: ASbGncuimGNWXZ3ag72QMlQN83u7g9IB5OfJzDgzNKJKfk0uA09deZQA8h/AOR5VzEH
	hygcq1aOY6FZV3wQVSbgzQLR8p9Wf26yzkLEn3FyfgI21/Fvoa/yt7WQmOU3VMx725ajg1cA9Ik
	+uvsHhUBaKJNkD/3EWR27OPzLrm1/+99YSBx258xYjPNA66uE90YU7WMrVdP/R6I3XgwnI+DNGV
	Cci4bTnN5uzs2GoPhCUeeSvtiSFkkUSLgtAJ0bOeYsrNewbCvCpqIkX0FNhLHPoOLn6PMInBMZk
	DzDoBIXmrp+4ZcyR/BpEemnAncv2G9bvTfvfCWM3UdyxC/oFdMyrxKgooYuznn7Z0YGQx/2veje
	JoCAFwd4OwRxJ8qmirR1XVApAVN+AmQqydh4/mqJQUQnBYJ/HLw==
X-Google-Smtp-Source: AGHT+IGL/mwyoavq9oFKckIl7q7VraQ4bXBKOhVmbfQv+8zpowZtptxtAzglCyT3TJ5his3RF1O0hA==
X-Received: by 2002:a05:6000:4028:b0:3ea:80ec:854c with SMTP id ffacd0b85a97d-3ecdf9ffa5amr1772453f8f.19.1758111715545;
        Wed, 17 Sep 2025 05:21:55 -0700 (PDT)
Received: from [192.168.3.33] (88.36.160.45.gramnet.com.br. [45.160.36.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece199ad24sm1012789f8f.50.2025.09.17.05.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:21:54 -0700 (PDT)
Message-ID: <dad15813cfdc3b7c77ba71266e38a137d0015bcd.camel@suse.com>
Subject: Re: [PATCH v4 1/5] printk: nbcon: Export console_is_usable
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson	 <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, 	linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Date: Wed, 17 Sep 2025 09:21:48 -0300
In-Reply-To: <aMp4BrEpqXOW9nam@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
	 <20250915-nbcon-kgdboc-v4-1-e2b6753bb566@suse.com>
	 <aMp4BrEpqXOW9nam@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 10:57 +0200, Petr Mladek wrote:
> On Mon 2025-09-15 08:20:30, Marcos Paulo de Souza wrote:
> > The helper will be used on KDB code in the next commits.
> >=20
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Nit :-)
>=20
> The ordering of the tags is important. It defines the timeline of
> the related actions.
>=20
> The above ordering might be understood as that Petr reviewed
> an older version of patch. But it was later modified by Marcos.
>=20
> The expected ordering is:
>=20
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>=20
> It means that Macros developed a patch and Petr reviewed it.
> The patch was not longer modified.
>=20
> Note the Reviewed-by tag might be preserved even when Marcos
> later did some cosmetic changes, e.g. fixed a typo, formatting,
> or rebased.

Got it. I used b4 prep --update-trailers, and it added the Reviewed-by
before my Sign-off. But still, this patch didn't change since the last
submission, so I thought that it would be ok.

But I'll double check next time.

>=20
> Best Regards,
> Petr
>=20
> PS: There is no need to send v5 just because of this. I could fix
> =C2=A0=C2=A0=C2=A0 it when committing the patch...

