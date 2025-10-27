Return-Path: <linux-kernel+bounces-872293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B8DC0FD4B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88E21350714
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B33164BC;
	Mon, 27 Oct 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0f12F+W"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD02D8368
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588202; cv=none; b=CFOseNXIdVNmh9stci9aljLxgvmoCpBcFBDoXcWsaIcwnbewEiDGMmTlKd11hBHlMEUz6ak+4lrearfhiFgKkVZpHvvnlQQnIfcmH+tdVkxtcjfUYPZVVZqB9Ar/snboMlCUdIMvwMN+X0TGUU6+RVp2yoYh+rIRqZMRRSYrfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588202; c=relaxed/simple;
	bh=z83AXuvcweGfzJ1YzykNAVHCd4v5jqaWPkQKxlN5fdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJ1vbxpU/1FgDG79KTUA3mmbRvfSeWs6wr5pEg5kfwPFbPITlaPgmO9vEQY77hiQ/sPHlYtg7+TWz67MtQjiykCtPDKleNcOZ78I9fh9ZrtxKIh9E90PkQ/w7wZGHM8Y2UHUlsRnJxpbqnR5J/KGeKdoxkHFUe4+KW4c6QXIksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0f12F+W; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-783fa3af3bdso57458167b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588200; x=1762193000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z83AXuvcweGfzJ1YzykNAVHCd4v5jqaWPkQKxlN5fdk=;
        b=c0f12F+WW0vGS4nnwmN0CAqpGqsYPbcNoXMYqtY6tayUXPn+w9w1Z7+TvQ9TJHMIaZ
         e/oLYIc2o3HBdvrDLSTORpq2S9NYZfE0n0raZs89Cvetx52IY92qjlb8LIZo8QREKQcp
         w8Z7WB3QQ32NfMfYYINjaNqA9RMW59deUJGNEiqIdr+wI+BTsPanrMhYvO5bAbkw3fDD
         uYkIN0Hn10UwhwKzoE5X3XKW3eFwkk5w2j/OkdlaGEqEMq8kPOBmCSAk8Xlfmo4D5BZp
         SsatJCpkubkrNhEa8qlNH+LcKovXN5wnD7DCF1DvWWnvT9+XwBAVynn5xuClkcmzS24m
         pMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588200; x=1762193000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z83AXuvcweGfzJ1YzykNAVHCd4v5jqaWPkQKxlN5fdk=;
        b=lOaqUFQoNXQSKCmC3LNDmHggibzsUkv1fkOplbraO1KIADFJFYt3bmS6H05Z0jLfOg
         o4y5/1UJR0j915Sb6C/SsR5BjcJCO6kbnTWWSNjjMInurHj6y5a5CHCkRc3d+YoURkr/
         idiLGL2MVEJrXabqVnWFvwdm2IzEdpxnARjzh2ORWF3lUgbFOzrb907VHQXvqlax4e6V
         2njFvczRZ/cwq1GSvUt6wkrj3Dm3btUGeXQlK2w+/8x2BYTamHVZOFKVRWCu+oLsXF3Y
         7msrVFS+VQaNLCuz3p6XD37z+uvA1RqV+c1sQ8Maw1UR1WRENALLh5WVu5kI0H1bNlUI
         Nz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz4XpaECL8g12yxCRXzsOyBE+Ubxy+AXDJNIvkpnlfDNgkrESrCUQJqFMit2CdlBTwnNoDJ0BeHcDkDK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7PfmdGzQgY1YDJREt9eC0Gez2ADaG28gdxWNk/i3hyAwvL5A
	Zv1fPduA7DdWMnLcfxny+nPKL60/TYd/xnhZHGWtsxp3gl5wJsaX3R0lcCPv4W0J/i2HnRZq5eN
	wGehGymRf7/WWPD2n/hsqObWcUV0CZjM=
X-Gm-Gg: ASbGncs7n7u0+7ULa4C/8qwAGmtaSDBa8GQZLo4yhDHIcwLKIqo0Z8q7LgCS9SCoSIs
	boK/l3Tq24eKbEEv0RHYDZiqnIT4XCZB0GeskesWNW65NPdIj+ehnEclWTn0X7waZlJLICDD4aL
	vDIatPzus0cwccyL/GN+OAti9yqbmtJSxljZSOOqFyBf02UJRlymu3ih3nphisYpJBoygnsQOlp
	N/6JxPKYQUw9MVx7GY6NN/D7PKqxqRrnKeWWEge+4NKkR43Qagzznxhkx2P2D6nEREVJX3y8H2E
	pQWscu69
X-Google-Smtp-Source: AGHT+IHEjGHWDboqhwqSgR5zzYygFRWXIgKKmRw5b5ajo6pajcH8E9/Do3d86XVr5QyKBXnYP/5zxJVt23CEn2AWdc8=
X-Received: by 2002:a05:690c:74c2:b0:784:8b01:c21e with SMTP id
 00721157ae682-78617f34811mr7129517b3.45.1761588199733; Mon, 27 Oct 2025
 11:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024203046.42275-1-rosenp@gmail.com> <b725672aab8c5a006603110b46e6e15495acccbc.camel@sipsolutions.net>
In-Reply-To: <b725672aab8c5a006603110b46e6e15495acccbc.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 27 Oct 2025 11:03:08 -0700
X-Gm-Features: AWmQ_bkES62pMCkmUYcvxmud3HMsqvB9OnJHmQIGlhxldOaEtBshd7JdM20rGJI
Message-ID: <CAKxU2N_zzZX7RWMWqRfa8PwiDC=gZtqOZkSPWdcUKrd9eLSrVg@mail.gmail.com>
Subject: Re: [PATCH] wifi: rt2x00: add nvmem eeprom support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:13=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> Please always tag patches with the tree they should apply to (e.g.
> '[PATCH wireless-next]') and make sure they actually _do_ apply.
That's embarrassing. Will resend with both issues fixed.
>
> johannes

