Return-Path: <linux-kernel+bounces-816807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB8B57886
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E872050EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B72FF166;
	Mon, 15 Sep 2025 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkbYKpaT"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C7278158
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935925; cv=none; b=NypHpur0JUx1W0Um0BBYMlLPcG5XKZ7Q7nXOrgzpfZVsiSfRfkMuFh683PIvPcpoytF+aHFVSSZ7togkCMtfquuIVQonpzVlqR96+/xS8dSDeW+nZ12aRsWBWvCEbUc4F98pOor5oEMb7UoDzi1cxCGRx8AOuINeU+TdI6nRVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935925; c=relaxed/simple;
	bh=lhjJlR0g/usWNJatZv6IWd+4bQ7YOG5GDqfYIhKPOL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4URTchvDW2SOmTLNJFJnvfV+T1mmz/xNPQyjOk8iz75lB9AuTsU7kxg4ZluQYc1ahbz+Ruw2xeJ7VRopmENr32GGNnWNrcGjXEIRx2MoTEVuWDcy3/LSS2lQJDr06/X5NEwE6MFlfwAgL/FZ7KSIkcZ8a/MZcYUWiTvWsI5BPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkbYKpaT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b520539e95bso217750a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757935923; x=1758540723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeeqBjq0kQoqEVGA6Y2CLldAeUXvC4YRAFLGe03vX7Y=;
        b=PkbYKpaTOOLr0AAAI3t8SOjbfbmfUTqodfdEA+zR1f8rA3ZdhQQkOtVyzLZOLjqTKh
         8OrBSwHT+PUo9pBz9TJwY9MC2ySP3+VpACINqlJkiddYpuBsgO988jjQDW4eIxR6SCEq
         +iOxSHN9bN2KJvhwZ4n05N+COdesCdQ7nz6xrxpLGuztn5q+d2cDzJb0EVjb4Rm8BAYN
         JSF+DbPRfHR6g/DlNUhHOu4qG9k1PMRhWRb6yklKBLYtjpl+MPdkl3AHZlYKepKOdq66
         ayJ8l5bqDvWDTobZhp98MFK2OekaaEeRjP2Jb9JPuQ9DyoODezQCTgLxKnuw2HyOxQCK
         83MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935923; x=1758540723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeeqBjq0kQoqEVGA6Y2CLldAeUXvC4YRAFLGe03vX7Y=;
        b=rnlZz6Z2iMD6+GOPsZamvovGz+dTbWcUg0Op+8lzw5fnsvPGmzP/fm2Wa4thILD5D1
         VUy8/nXp2M9s37pevdw0y2gh8u3RB/E1S0F7oGgkLhm2MhQ2cR8L6pE8F9Xv8qlJkhs1
         zBuap6JHPv0h71cd8g47i+VL4qoMnAfxlP1Sa4J0cE06V4BogBiazbD//AYwgrfeV7Jx
         tQKdvu+35I4VgKEzoVOKedVF8x6IgM7TpSJOc+bIm3ep0/K+NnkNq9fkUQLtVZLTriH5
         H4Xv/3/E4u/DOxVbGrJmWYIOTfBGn6Sa+Kp/Rjy+AtsR73vNzzErSRLxYIVCJ7/WjbcQ
         Zf8g==
X-Gm-Message-State: AOJu0Yy+Av58fFgpQDa5tqYNzqkM0AEuAlZ2xYIl+02Obj1e5nU39C1G
	oXzN1kNgLVzKiz16Y0ooMAeDlJEuDlaCZKXoqxBrsHjTo/zwlEr+LC5k37Q44kaOKSpawTUwurN
	kkJZv6z33a9RfRfb1KYeDRtcWb9w8B6Q=
X-Gm-Gg: ASbGncuylQaIQdieacrD6QZl0C0GFyxrBNSnEkS5dSSRFzXUgHFTqzHFYQvOCy6qpUL
	uUA9LV9WLEaTgF/itrU3c/JbdBgdHIjBOn6khStx87V/D1rY6hikxCa24aOvd/KINW6HvF7fz4P
	NSH2Dh0F5mwUxfIb1hzqmUuXEJfFj8B/GiIEmk0UpXAzVdfarHRgD8ZDUSZ9vbJrdrY9LQao2pj
	0pyybvHjXTX3lFHv7a3m+kNhEgqpro1Tq/70QMua8AbSyMbC0AAjwqbo+JmXUBQHsWmMtk9vZCH
	RBdGbWOG6peqmh7/SMxGA8Jn9A==
X-Google-Smtp-Source: AGHT+IFLEChMwTeZv5zuFVulh4BpL4UJn1lGFgnTimd2jNCKBJYG8XZnkCZ7OMd8EBC3LUpilbZ/TDqMDVfAxrtC740=
X-Received: by 2002:a17:902:e552:b0:258:a3a1:9aa5 with SMTP id
 d9443c01a7336-25d21ad61b4mr80648715ad.0.1757935923362; Mon, 15 Sep 2025
 04:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL-mriJXvgyqy+MhoMs7_KSPe9-hOOpyUZbwtRX=_gFJZ3P0NA@mail.gmail.com>
In-Reply-To: <CAL-mriJXvgyqy+MhoMs7_KSPe9-hOOpyUZbwtRX=_gFJZ3P0NA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Sep 2025 13:31:51 +0200
X-Gm-Features: AS18NWBtBXe42q8ymONrppPDdAod42jTCddg3yW5ar0tps4ZuWHC7zJ2DJ9o0kM
Message-ID: <CANiq72mVksRjOs-O-roM0oJVBxNsXyRf_NQhC0QoYB5gdtFuTA@mail.gmail.com>
Subject: Re: [0001-rust-auxiliary-Fix-initialialized-typo.patch] rust:
 auxiliary: Fix 'initialialized' typo
To: Zhaowen Fan <jaimefine6@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:29=E2=80=AFPM Zhaowen Fan <jaimefine6@gmail.com> =
wrote:
>
> This patch fixes a typo in `auxiliary.rs`.

Please see:

    https://docs.kernel.org/process/submitting-patches.html
    https://rust-for-linux.com/contributing

on how to format a patch and who to send it etc.

I would suggest using `git-format-patch` and `git-send-email` or `b4` to do=
 it.

Also, you can take a look at how other patches appear in:

    https://lore.kernel.org/rust-for-linux/

Thanks!

Cheers,
Miguel

